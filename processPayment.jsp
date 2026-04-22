<%@ page import="java.net.*,java.io.*" %>

<%
String method = request.getParameter("method");
String total = request.getParameter("total");

if(total == null) total = "10.00"; // default fallback

// =========================
// 1. CASH PAYMENT
// =========================
if("cash".equals(method)){
    session.setAttribute("orderStatus","Pending (Cash)");
    response.sendRedirect("paymentSuccess.jsp");
    return;
}

// =========================
// 2. DEBIT / ONLINE SIMULATION
// =========================
if("debit".equals(method)){
    session.setAttribute("orderStatus","Paid (Debit Card)");
    response.sendRedirect("paymentSuccess.jsp");
    return;
}

// =========================
// 3. TOYYIBPAY (REAL FLOW)
// =========================
if("toyyib".equals(method)){

    String secretKey = "YOUR_SECRET_KEY";
    String categoryCode = "YOUR_CATEGORY_CODE";

    String data =
        "userSecretKey=" + secretKey +
        "&categoryCode=" + categoryCode +
        "&billName=Little Pour Order" +
        "&billDescription=Food Order Payment" +
        "&billPriceSetting=1" +
        "&billPayorInfo=1" +
        "&billAmount=" + (int)(Double.parseDouble(total) * 100) +
        "&billReturnUrl=http://localhost:8080/YourProject/paymentSuccess.jsp" +
        "&billCallbackUrl=http://localhost:8080/YourProject/callback.jsp" +
        "&billExternalReferenceNo=ORDER001" +
        "&billTo=Customer";

    URL url = new URL("https://dev.toyyibpay.com/index.php/api/createBill");
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

    conn.setRequestMethod("POST");
    conn.setDoOutput(true);
    conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

    OutputStream os = conn.getOutputStream();
    os.write(data.getBytes());
    os.flush();
    os.close();

    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

    String responseLine = "";
    StringBuilder responseText = new StringBuilder();

    while((responseLine = br.readLine()) != null){
        responseText.append(responseLine);
    }

    br.close();

    // extract bill code
    String res = responseText.toString();
    String billCode = res.split("\"")[3];

    // redirect to payment page
    response.sendRedirect("https://dev.toyyibpay.com/" + billCode);

    return;
}
%>
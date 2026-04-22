<%@ page import="java.net.*,java.io.*,java.net.URLEncoder" %>

<%
String method = request.getParameter("method");
String total = request.getParameter("total");

if(total == null || total.equals("")){
    total = "10.00";
}

/* =========================
   1. CASH PAYMENT
========================= */
if("cash".equals(method)){
    session.setAttribute("paymentMethod", "Cash");
    session.setAttribute("orderStatus", "Pending (Cash)");
    session.setAttribute("paymentAmount", total);

    response.sendRedirect("paymentSuccess.jsp");
    return;
}

/* =========================
   2. DEBIT CARD
========================= */
if("debit".equals(method)){
    session.setAttribute("paymentMethod", "Debit Card");
    session.setAttribute("payTotal", total);

    response.sendRedirect("debitPayment.jsp");
    return;
}

/* =========================
   3. CREDIT CARD
========================= */
if("credit".equals(method)){
    session.setAttribute("paymentMethod", "Credit Card");
    session.setAttribute("payTotal", total);

    response.sendRedirect("creditPayment.jsp");
    return;
}

/* =========================
   4. TOYYIBPAY
========================= */
if("toyyib".equals(method)){

    String secretKey = "YOUR_SECRET_KEY";
    String categoryCode = "YOUR_CATEGORY_CODE";

    double amount = 0;
    try {
        amount = Double.parseDouble(total);
    } catch(Exception e){
        amount = 10.00;
    }

    int amountInCent = (int)(amount * 100);

    String data =
        "userSecretKey=" + URLEncoder.encode(secretKey, "UTF-8") +
        "&categoryCode=" + URLEncoder.encode(categoryCode, "UTF-8") +
        "&billName=" + URLEncoder.encode("Little Pour Order", "UTF-8") +
        "&billDescription=" + URLEncoder.encode("Food Order Payment", "UTF-8") +
        "&billPriceSetting=1" +
        "&billPayorInfo=1" +
        "&billAmount=" + amountInCent +
        "&billReturnUrl=" + URLEncoder.encode("http://localhost:8080/YourProject/paymentSuccess.jsp", "UTF-8") +
        "&billCallbackUrl=" + URLEncoder.encode("http://localhost:8080/YourProject/callback.jsp", "UTF-8") +
        "&billExternalReferenceNo=ORDER001" +
        "&billTo=" + URLEncoder.encode("Customer", "UTF-8");

    URL url = new URL("https://dev.toyyibpay.com/index.php/api/createBill");
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

    conn.setRequestMethod("POST");
    conn.setDoOutput(true);
    conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

    OutputStream os = conn.getOutputStream();
    os.write(data.getBytes("UTF-8"));
    os.flush();
    os.close();

    BufferedReader br = new BufferedReader(
        new InputStreamReader(conn.getInputStream(), "UTF-8")
    );

    String line;
    StringBuilder result = new StringBuilder();

    while((line = br.readLine()) != null){
        result.append(line);
    }

    br.close();

    String res = result.toString();

    // safer extraction of billCode
    String billCode = res.replaceAll(".*\"BillCode\":\"(.*?)\".*", "$1");

    response.sendRedirect("https://dev.toyyibpay.com/" + billCode);
    return;
}
%>
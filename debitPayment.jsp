<%-- 
    Document   : debitPayment
    Created on : 22 Apr 2026, 3:04:09 pm
    Author     : alessa
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
String total = (String) session.getAttribute("payTotal");

if(total == null){
    total = "0.00";
}

String submit = request.getParameter("submit");

if(submit != null){

    String cardName   = request.getParameter("cardName");
    String cardNumber = request.getParameter("cardNumber");
    String expiry     = request.getParameter("expiry");
    String cvv        = request.getParameter("cvv");

    if(cardName != null && cardNumber != null &&
       expiry != null && cvv != null &&
       !cardName.equals("") &&
       !cardNumber.equals("") &&
       !expiry.equals("") &&
       !cvv.equals("")){

        session.setAttribute("cardHolder", cardName);
        session.setAttribute("paymentMethod", "Debit Card");
        session.setAttribute("orderStatus", "Paid (Debit Card)");
        session.setAttribute("paymentAmount", total);

        response.sendRedirect("paymentSuccess.jsp");
        return;
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Debit Card Payment</title>

<style>
body{
    margin:0;
    font-family:Arial, sans-serif;
    background:#f5f2ea;
}

.container{
    width:420px;
    margin:50px auto;
    background:white;
    padding:30px;
    border-radius:14px;
    box-shadow:0 4px 14px rgba(0,0,0,0.10);
}

h2{
    text-align:center;
    color:#8b5e34;
    margin-bottom:25px;
}

.total{
    background:#f3eee8;
    padding:12px;
    border-radius:8px;
    text-align:center;
    font-size:18px;
    font-weight:bold;
    margin-bottom:20px;
    color:#6b3f14;
}

label{
    display:block;
    margin-top:12px;
    margin-bottom:6px;
    font-weight:bold;
    color:#444;
}

input{
    width:100%;
    padding:12px;
    border:1px solid #ccc;
    border-radius:8px;
    box-sizing:border-box;
}

.row{
    display:flex;
    gap:10px;
}

.row div{
    flex:1;
}

button{
    width:100%;
    margin-top:20px;
    padding:13px;
    border:none;
    background:#8b5e34;
    color:white;
    font-size:16px;
    font-weight:bold;
    border-radius:8px;
    cursor:pointer;
}

button:hover{
    background:#6f4725;
}

.back{
    display:block;
    text-align:center;
    margin-top:15px;
    color:#8b5e34;
    text-decoration:none;
    font-weight:bold;
}
</style>

</head>
<body>

<jsp:include page="header.jsp" />

<div class="container">

    <h2>Debit Card Payment</h2>

    <div class="total">
        Total Amount: RM <%= total %>
    </div>

    <form method="post" action="debitPayment.jsp">

        <label>Card Holder Name</label>
        <input type="text" name="cardName" required>

        <label>Card Number</label>
        <input type="text" name="cardNumber" maxlength="16" placeholder="1234123412341234" required>

        <div class="row">

            <div>
                <label>Expiry Date</label>
                <input type="text" name="expiry" placeholder="MM/YY" required>
            </div>

            <div>
                <label>CVV</label>
                <input type="password" name="cvv" maxlength="3" required>
            </div>

        </div>

        <button type="submit" name="submit">Pay Now</button>

    </form>

    <a href="checkout.jsp" class="back">← Back to Checkout</a>

</div>

</body>
</html>
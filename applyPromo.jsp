<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
String code = request.getParameter("promo");
Double total = (Double) session.getAttribute("total");

if(total == null){
    total = 0.0;
}

double discount = 0;
String message = "";

if(code != null){

    if("SAVE10".equalsIgnoreCase(code)){
        discount = total * 0.10;
        message = "Promo SAVE10 applied successfully!";
    }
    else if("FOOD5".equalsIgnoreCase(code)){
        discount = 5.00;
        message = "Promo FOOD5 applied successfully!";
    }
    else{
        discount = 0;
        message = "Invalid promo code!";
    }

    double finalTotal = total - discount;

    if(finalTotal < 0){
        finalTotal = 0;
    }

    session.setAttribute("discount", discount);
    session.setAttribute("finalTotal", finalTotal);
    session.setAttribute("promoMessage", message);

    response.sendRedirect("checkout.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Promo Code</title>
<link rel="stylesheet" href="style.css">

<style>
body{
    margin:0;
    padding:0;
    font-family:Arial, sans-serif;
    background:#f5f2ea;
}

.container{
    width:92%;
    max-width:1200px;
    margin:25px auto;
    background:#efefef;
    border-radius:14px;
    padding:35px;
    box-shadow:0 4px 12px rgba(0,0,0,0.10);
}

h2{
    margin-top:0;
    color:#6b3f14;
    font-size:34px;
    margin-bottom:25px;
}

.promo-box{
    background:white;
    border-left:6px solid #8b5e34;
    padding:18px 22px;
    margin-bottom:18px;
    border-radius:10px;
    font-size:18px;
    box-shadow:0 2px 6px rgba(0,0,0,0.05);
}

.promo-box b{
    color:#8b5e34;
    font-size:22px;
}

form{
    margin-top:25px;
}

input[type=text]{
    width:100%;
    padding:14px;
    border:1px solid #c8b39d;
    border-radius:8px;
    font-size:16px;
    box-sizing:border-box;
}

button{
    margin-top:15px;
    background:#8b5e34;
    color:white;
    border:none;
    padding:12px 24px;
    border-radius:8px;
    font-size:16px;
    font-weight:bold;
    cursor:pointer;
}

button:hover{
    background:#6f4725;
}

.back-btn{
    display:inline-block;
    margin-top:15px;
    text-decoration:none;
    background:#8b5e34;
    color:white;
    padding:12px 24px;
    border-radius:8px;
    font-weight:bold;
}

.back-btn:hover{
    background:#6f4725;
}

.footer{
    background:#8b5e34;
    color:white;
    text-align:center;
    padding:22px;
    margin-top:40px;
}
</style>

</head>

<body>

<jsp:include page="header.jsp" />

<div class="container">

    <h2>Available Promo Codes</h2>

    <div class="promo-box">
        <b>SAVE10</b><br>
        Get 10% discount on your total payment.
    </div>

    <div class="promo-box">
        <b>FOOD5</b><br>
        Get RM5 off instantly.
    </div>

    <form method="post" action="applyPromo.jsp">
        <input type="text" name="promo" placeholder="Enter promo code here" required>
        <button type="submit">Apply Promo</button>
    </form>

    <a href="checkout.jsp" class="back-btn">Back to Checkout</a>

</div>

<div class="footer">
    © 2026 Little Pour Co. All rights reserved.
</div>

</body>
</html>
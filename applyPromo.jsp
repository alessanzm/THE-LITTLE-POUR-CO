<%-- 
    Document   : applyPromo
    Created on : 22 Apr 2026, 1:06:49?pm
    Author     : Acer
--%>

<%
String code = request.getParameter("promo");
Double total = (Double) session.getAttribute("total");

if(total == null) total = 0.0;

double discount = 0;

if("SAVE10".equalsIgnoreCase(code)){
    discount = total * 0.10;
}
else if("FOOD5".equalsIgnoreCase(code)){
    discount = 5;
}
else{
    discount = 0;
}

double finalTotal = total - discount;

session.setAttribute("finalTotal", finalTotal);
session.setAttribute("discount", discount);

response.sendRedirect("checkout.jsp");
%>
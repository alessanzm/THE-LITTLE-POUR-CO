<%-- 
    Document   : orderHistory
    Created on : 22 Apr 2026, 12:27:40?pm
    Author     : Acer
--%>

<link rel="stylesheet" href="style.css">

<%@ include file="header.jsp" %>
<div class="card">
<h2>Order Tracking</h2>

<%
String s=(String)session.getAttribute("orderStatus");

if(s==null){
out.println("No order");
}else{
out.println("Status: "+s);
}
%>

<%@ include file="footer.jsp" %>
</div>

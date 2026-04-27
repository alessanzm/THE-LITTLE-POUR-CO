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
}<%@ page import="java.util.*" %>

<link rel="stylesheet" href="style.css">

<%@ include file="header.jsp" %>

<div class="content">

<div class="card">

    <h2>Order Tracking</h2>

    <%
    String s = (String) session.getAttribute("orderStatus");

    if (s == null) {
        out.println("No order");
    } else {
        out.println("Status: " + s);
    }
    %>

</div>

</div> <!-- end content -->

<%@ include file="footer.jsp" %>
%>
</div>
<%@ include file="footer.jsp" %>
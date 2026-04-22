<%-- 
    Document   : logout
    Created on : 22 Apr 2026, 12:25:19?pm
    Author     : Acer
--%>
<%
session.invalidate();
response.sendRedirect("login.jsp");
%>
<%@ include file="footer.jsp" %>
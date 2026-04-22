<%-- 
    Document   : db
    Created on : 22 Apr 2026, 12:17:41?pm
    Author     : Acer
--%>
<link rel="stylesheet" href="style.css">
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/foodapp","root",""
);
%>
<%@ include file="footer.jsp" %>
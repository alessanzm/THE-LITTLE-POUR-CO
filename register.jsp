<%-- 
    Document   : register
    Created on : 22 Apr 2026, 12:24:58?pm
    Author     : Acer
--%>

<%@ page import="java.util.*" %>
<link rel="stylesheet" href="style.css">
<%@ include file="header.jsp" %>

<div class="content">

<div class="card">

<h2>Register</h2>

<%
String u = request.getParameter("username");
String p = request.getParameter("password");

Map<String, String> users = (Map<String, String>) session.getAttribute("users");

if(users == null){
    users = new HashMap<>();
    session.setAttribute("users", users);
}

if(u != null && p != null){

    u = u.trim();

    if(users.containsKey(u)){
%>
        <p style="color:red;">User already exists</p>
<%
    } else {
        users.put(u, p);
        session.setAttribute("users", users);
%>
        <p style="color:green;">Register successful</p>
        <a href="login.jsp">Go to Login</a>
<%
    }
}
%>

<form method="post">

    <input name="username" placeholder="Username" required>
    <input name="password" type="password" placeholder="Password" required>

    <button class="btn" type="submit">Register</button>

</form>

</div>

</div>

<%@ include file="footer.jsp" %>
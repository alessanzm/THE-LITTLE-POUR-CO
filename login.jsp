<%@ page import="java.util.*" %>
<link rel="stylesheet" href="style.css">

<%
String input = request.getParameter("username");
String p = request.getParameter("password");

if(input != null && p != null){

    input = input.trim();

    /* =========================
       ADMIN ONLY (HARDCODE ALLOWED)
    ========================= */
    if(input.equalsIgnoreCase("admin@gmail.com") && "1234".equals(p)){
        session.setAttribute("role","admin");
        session.setAttribute("user","Admin");
        response.sendRedirect("admin.jsp");
        return;
    }

    /* =========================
       CUSTOMER (FROM SESSION ONLY)
    ========================= */
    Map<String, String> users = (Map<String, String>) session.getAttribute("users");

    if(users != null && users.containsKey(input)){

        if(users.get(input).equals(p)){
            session.setAttribute("role","user");
            session.setAttribute("user", input);
            response.sendRedirect("menu.jsp");
            return;
        }
    }

    out.println("<p style='color:red;text-align:center;'>Invalid login</p>");
}
%>

<div class="card login-card">

    <h2>Login</h2>

    <form method="post">

        <input name="username" placeholder="Username or Email" required>
        <input type="password" name="password" required>

        <button class="btn">Login</button>

    </form>

    <p>
        <a href="register.jsp">Create Account</a> |
        <a href="forgotPassword.jsp">Forgot Password</a>
    </p>

</div>
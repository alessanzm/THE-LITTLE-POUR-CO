<link rel="stylesheet" href="style.css">

<%
String input = request.getParameter("username"); // boleh jadi username atau email
String p = request.getParameter("password");

if(input != null){

    input = input.trim();

    /* =========================
       ADMIN (EMAIL ONLY)
    ========================= */
    if(input.equalsIgnoreCase("admin@gmail.com") && p.equals("1234")){
        session.setAttribute("role","admin");
        session.setAttribute("user","Admin");
        response.sendRedirect("admin.jsp");
        return;
    }

    /* =========================
       USER (USERNAME / EMAIL)
    ========================= */
    if(p != null && !p.isEmpty()){
        session.setAttribute("role","user");
        session.setAttribute("user", input);
        response.sendRedirect("menu.jsp");
        return;
    }
}
%>


<div class="card login-card">

    <h2>Login</h2>
    <p>Login using username or email</p>

    <form method="get">

        <input name="username" placeholder="Username or Email" required>

        <input type="password" name="password" placeholder="Password" required>

        <button class="btn">Login</button>

    </form>

    <p style="margin-top:10px; font-size:13px; color:#888;">
        Admin: admin@gmail.com / 1234
    </p>

</div>

<%@ include file="footer.jsp" %>
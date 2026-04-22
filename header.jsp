<%-- 
    Document   : header
    Created on : 22 Apr 2026, 12:30:42?pm
    Author     : Acer
--%>

<link rel="stylesheet" href="style.css">

<div class="navbar">

    <div class="logo">Little Pour Co.</div>

    <div class="nav-center">
        <a href="index.jsp">Home</a>
        <a href="menu.jsp">Menu</a>
        <a href="cart.jsp">Cart</a>
        <a href="orderHistory.jsp">Order</a>
        <a href="applyPromo.jsp">Promo</a>
    </div>

    <div class="nav-right">
        <%
        String role = (String) session.getAttribute("role");
        %>

        <% if(role == null){ %>
            <a href="login.jsp">Login</a>
        <% } else { %>
            <a href="logout.jsp">Logout</a>
        <% } %>

        <% if("admin".equals(role)){ %>
            <a href="admin.jsp">Admin</a>
        <% } %>
    </div>

</div>
<link rel="stylesheet" href="style.css">

<div class="page-wrapper">

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

        <%-- LOGIN / LOGOUT --%>
        <% if(session.getAttribute("role") == null){ %>
            <a href="login.jsp">Login</a>
        <% } else { %>
            <a href="logout.jsp">Logout</a>
        <% } %>

        <%-- ADMIN ONLY --%>
        <% if("admin".equals(session.getAttribute("role"))){ %>
            <a href="admin.jsp">Admin</a>
        <% } %>

    </div>

</div>
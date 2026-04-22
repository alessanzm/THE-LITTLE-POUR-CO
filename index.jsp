<%@ include file="header.jsp" %>

<!-- HERO SECTION -->
<div class="hero">

    <div class="hero-content">
        <h1>Welcome to Little Pour Co.</h1>
        <p>Fresh food ? Premium coffee ? Cozy experience</p>

        <a href="menu.jsp">
            <button class="btn">Order Now</button>
        </a>
    </div>

</div>

<!-- INFO SECTION -->
<div class="card">

<%
int hour = java.time.LocalTime.now().getHour();
boolean open = hour >= 8 && hour <= 22;
%>

<h2>Operational Hours</h2>
<p>8:00 AM - 10:00 PM</p>

<% if(open){ %>
    <p style="color:green;">We are OPEN now </p>
<% } else { %>
    <p style="color:red;">Sorry, we are CLOSED ?</p>
<% } %>

</div>

<!-- ABOUT SECTION -->
<div class="card">
    <h2>About Us</h2>
    <p>
        Little Pour Co. is a modern café offering delicious meals and drinks.
        Enjoy your food in a cozy and relaxing environment.
    </p>
</div>

<%@ include file="footer.jsp" %>
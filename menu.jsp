<%@ include file="header.jsp" %>

<div class="card">
    <h2> Our Menu</h2>
    <p>Choose your favourite food & drinks</p>
</div>

<div class="menu-container">

<%
String[] items = {
    "Chicken Burger:10:images/burger.jpg",
    "Cheese Burger:12:images/cheese_burger.jpg",
    "Fried Chicken:15:images/fried_chicken.jpg",
    "Carbonara Pasta:14:images/pasta.jpg",
    "Cheese Pizza:18:images/pizza.jpg",
    "Hot Coffee:8:images/coffee.jpg",
    "Iced Coffee:9:images/iced_coffee.jpg",
    "Milk Tea:7:images/tea.jpg",
    "Mango Juice:6:images/mango_juice.jpg",
    "Chocolate Drink:9:images/chocolate.jpg"
};

for(int i=0;i<items.length;i++){

    String[] data = items[i].split(":");
    String name = data[0];
    String price = data[1];
    String img = data[2];
%>

    <div class="menu-card">

        <img src="<%=img%>">

        <h3><%=name%></h3>

        <p>RM <%=price%></p>

        <!-- ONLY ADD TO CART -->
        <a href="cart.jsp?item=<%=name%>&price=<%=price%>">
            <button class="btn">Add to Cart</button>
        </a>

    </div>

<%
}
%>

</div>

<%@ include file="footer.jsp" %>
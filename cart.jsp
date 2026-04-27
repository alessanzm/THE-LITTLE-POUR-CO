<%@ page import="java.util.*" %>
<%@ include file="header.jsp" %>

<link rel="stylesheet" href="style.css">

<div class="content">

<%
List<String> cart = (List<String>) session.getAttribute("cart");
if (cart == null) {
    cart = new ArrayList<>();
}

/* =========================
   ADD ITEM
========================= */
String item = request.getParameter("item");
String price = request.getParameter("price");

if (item != null && price != null) {

    boolean found = false;

    for (int i = 0; i < cart.size(); i++) {

        String[] data = cart.get(i).split(":");

        String name = data[0];
        String priceVal = data[1];
        int qty = (data.length > 2) ? Integer.parseInt(data[2]) : 1;

        if (name.equals(item)) {
            qty++;
            cart.set(i, name + ":" + priceVal + ":" + qty);
            found = true;
            break;
        }
    }

    if (!found) {
        cart.add(item + ":" + price + ":1");
    }
}

/* =========================
   DELETE ITEM
========================= */
String remove = request.getParameter("remove");

if (remove != null) {
    try {
        int index = Integer.parseInt(remove);

        if (index >= 0 && index < cart.size()) {
            cart.remove(index);
        }
    } catch (Exception e) {
        // ignore
    }
}

/* =========================
   UPDATE QUANTITY
========================= */
String action = request.getParameter("action");
String indexStr = request.getParameter("index");

if (action != null && indexStr != null) {

    try {
        int index = Integer.parseInt(indexStr);

        if (index >= 0 && index < cart.size()) {

            String[] data = cart.get(index).split(":");

            String name = data[0];
            String priceVal = data[1];
            int qty = (data.length > 2) ? Integer.parseInt(data[2]) : 1;

            if (action.equals("add")) {
                qty++;
            } else if (action.equals("minus")) {
                qty--;
            }

            if (qty <= 0) {
                cart.remove(index);
            } else {
                cart.set(index, name + ":" + priceVal + ":" + qty);
            }
        }

    } catch (Exception e) {
        // ignore
    }
}

session.setAttribute("cart", cart);
%>

<div class="card">

    <h2>Your Cart</h2>
    <p>Review your selected items</p>

    <hr>

<%
if (cart.isEmpty()) {
%>

    <p>Your cart is empty</p>

<%
} else {
%>

<table>

<tr>
    <th>Item</th>
    <th>Price</th>
    <th>Quantity</th>
    <th>Action</th>
</tr>

<%
for (int i = 0; i < cart.size(); i++) {

    String[] data = cart.get(i).split(":");

    String name = data[0];
    String priceVal = data[1];
    int qty = (data.length > 2) ? Integer.parseInt(data[2]) : 1;
%>

<tr>
    <td><%= name %></td>
    <td>RM <%= priceVal %></td>

    <td>
        <a href="cart.jsp?action=minus&index=<%= i %>">
            <button class="qty-btn">-</button>
        </a>

        <span class="qty"><%= qty %></span>

        <a href="cart.jsp?action=add&index=<%= i %>">
            <button class="qty-btn">+</button>
        </a>
    </td>

    <td>
        <a href="cart.jsp?remove=<%= i %>">
            <button class="btn delete">Delete</button>
        </a>
    </td>
</tr>

<% } %>

</table>

<% } %>

<br>

<a href="checkout.jsp">
    <button class="btn">Proceed to Checkout</button>
</a>

</div> <!-- end card -->

</div> <!-- end content -->

<%@ include file="footer.jsp" %>
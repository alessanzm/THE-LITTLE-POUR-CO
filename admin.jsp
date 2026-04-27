<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<link rel="stylesheet" href="style.css">

<%@ include file="header.jsp" %>

<%
if(!"admin".equals(session.getAttribute("role"))){
    response.sendRedirect("login.jsp");
    return;
}

/* =========================
   DUMMY DATA (SESSION)
========================= */
List<String> menu = (List<String>) session.getAttribute("menuList");
if(menu == null){
    menu = new ArrayList<>();
    menu.add("Coffee:8");
    menu.add("Chicken:15");
}

List<String> orders = (List<String>) session.getAttribute("orderList");
if(orders == null){
    orders = new ArrayList<>();
    orders.add("Order #1:Pending");
}

/* =========================
   ADD MENU
========================= */
String newItem = request.getParameter("newItem");
String newPrice = request.getParameter("newPrice");

if(newItem != null && newPrice != null){
    menu.add(newItem + ":" + newPrice);
}

/* =========================
   DELETE MENU
========================= */
String delMenu = request.getParameter("delMenu");
if(delMenu != null){
    int i = Integer.parseInt(delMenu);
    if(i < menu.size()) menu.remove(i);
}

/* =========================
   UPDATE ORDER STATUS
========================= */
String action = request.getParameter("action");
String indexStr = request.getParameter("index");

if(action != null && indexStr != null){
    int i = Integer.parseInt(indexStr);

    if(i < orders.size()){
        String[] data = orders.get(i).split(":");

        if(action.equals("cancel")){
            orders.remove(i);
        } else {
            orders.set(i, data[0] + ":" + action);
        }
    }
}

session.setAttribute("menuList", menu);
session.setAttribute("orderList", orders);
%>

<div class="admin-container">

    <!-- MAIN CONTENT -->
    <div class="admin-content">

        <div class="card">
            <h2>Manage Menu</h2>

            <!-- ADD MENU -->
            <form>
                <input name="newItem" placeholder="Item Name" required>
                <input name="newPrice" placeholder="Price" required>
                <button class="btn">Add Item</button>
            </form>

            <table>
                <tr>
                    <th>Item</th>
                    <th>Price</th>
                    <th>Action</th>
                </tr>

                <%
                for(int i=0;i<menu.size();i++){
                    String[] data = menu.get(i).split(":");
                %>

                <tr>
                    <td><%= data[0] %></td>
                    <td>RM <%= data[1] %></td>
                    <td>
                        <a href="admin.jsp?delMenu=<%=i%>">
                            <button class="btn delete">Delete</button>
                        </a>
                    </td>
                </tr>

                <% } %>
            </table>
        </div>

        <div class="card">
            <h2>Manage Orders</h2>

            <table>
                <tr>
                    <th>Order</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>

                <%
                for(int i=0;i<orders.size();i++){
                    String[] data = orders.get(i).split(":");
                %>

                <tr>
                    <td><%= data[0] %></td>
                    <td><%= data[1] %></td>
                    <td>

    <!-- STATUS DROPDOWN -->
    <form method="get" style="display:inline-block; margin:0;">

        <input type="hidden" name="index" value="<%=i%>">

        <select name="action" onchange="this.form.submit()">

            <option value="Pending"
                <%= "Pending".equals(data[1]) ? "selected" : "" %>>
                Pending
            </option>

            <option value="Preparing"
                <%= "Preparing".equals(data[1]) ? "selected" : "" %>>
                Preparing
            </option>

            <option value="Ready to Pickup"
                <%= "Ready to Pickup".equals(data[1]) ? "selected" : "" %>>
                Ready
            </option>

            <option value="Complete"
                <%= "Complete".equals(data[1]) ? "selected" : "" %>>
                Complete
            </option>

        </select>

    </form>

    <!-- CANCEL BUTTON -->
    <a href="admin.jsp?action=cancel&index=<%=i%>"
       onclick="return confirm('Cancel this order?')">

        <button class="btn delete" type="button">
            Cancel
        </button>

    </a>

</td>
                </tr>

                <% } %>
            </table>
        </div>

    </div>
</div>

<%@ include file="footer.jsp" %>
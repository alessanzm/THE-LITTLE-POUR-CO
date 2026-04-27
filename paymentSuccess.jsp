<%-- 
    Document   : paymentSuccess
    Created on : 22 Apr 2026, 12:27:02?pm
    Author     : Acer
--%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ include file="header.jsp" %>

<link rel="stylesheet" href="style.css">

<%
List<String[]> receiptData = (List<String[]>) session.getAttribute("receiptData");
Double total = (Double) session.getAttribute("finalTotal");

if (total == null) total = 0.0;

Date now = new Date();
SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
SimpleDateFormat tf = new SimpleDateFormat("HH:mm:ss");
%>

<div class="card no-print">
    <h2>Payment Success</h2>
</div>

<div class="receipt" id="receiptArea">

    <h3 style="text-align:center;">Little Pour Co.</h3>
    <p style="text-align:center;">
        Date: <%= df.format(now) %><br>
        Time: <%= tf.format(now) %>
    </p>

    <hr>

    <%
    if (receiptData != null && !receiptData.isEmpty()) {
        for (String[] item : receiptData) {
            String name = item[0];
            int qty = Integer.parseInt(item[1]);
            double price = Double.parseDouble(item[2]);
            double amount = qty * price;
    %>

    <div class="receipt-item">
        <p><b><%= name %></b></p>
        <p>
            <%= qty %> x RM <%= String.format("%.2f", price) %>
            <span style="float:right;">
                RM <%= String.format("%.2f", amount) %>
            </span>
        </p>
    </div>

    <%
        }
    } else {
    %>
        <p style="text-align:center;">No items found</p>
    <%
    }
    %>

    <hr>

    <p>
        <b>Total:</b>
        <span style="float:right;">
            RM <%= String.format("%.2f", total) %>
        </span>
    </p>

    <div style="clear:both;"></div>

    <hr>

    <p style="text-align:center;">Thank you</p>

</div>

<div class="no-print" style="text-align:center; margin:10px;">
    <button class="btn" onclick="window.print()">Print / Save PDF</button>
</div>

<%@ include file="footer.jsp" %>
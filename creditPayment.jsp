<%@ page import="java.util.*" %>
<%@ include file="header.jsp" %>

<link rel="stylesheet" href="style.css">

<%
List<String> cart = (List<String>) session.getAttribute("cart");
if (cart == null) cart = new ArrayList<>();

double total = 0.0;

for (String item : cart) {
    String[] data = item.split(":");
    if (data.length > 1) {
        total += Double.parseDouble(data[1]);
    }
}

session.setAttribute("total", total);

Double discount = (Double) session.getAttribute("discount");
if (discount == null) discount = 0.0;

Double finalTotal = (Double) session.getAttribute("finalTotal");
if (finalTotal == null) {
    finalTotal = total;
}
%>

<style>
    body {
        background-color: #fdfaf5; /* Matches the warm tone in your screenshot */
        margin: 0;
        padding: 0;
    }

    .card {
        width: 450px;
        margin: 60px auto;
        background: #fff;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #4a3421;
    }

    h2 {
        text-align: center;
        margin-bottom: 25px;
        font-weight: 700;
    }

    p {
        display: flex;
        justify-content: space-between;
        margin: 10px 0;
        font-size: 1.05rem;
    }

    hr {
        border: 0;
        border-top: 1px solid #eee;
        margin: 20px 0;
    }

 
.payment-option {
    margin-bottom: 12px;
    width: 100%; /* Ensures it takes the full card width */
}

.payment-option label {
    display: flex;
    align-items: center; /* This forces the radio and text to share the same center line */
    padding: 12px 15px;
    border: 1px solid #ddd;
    border-radius: 8px;
    cursor: pointer;
    gap: 12px; /* Controlled spacing between the dot and the text */
}

.payment-option input[type="radio"] {
    margin: 0; /* CRITICAL: Browsers often add a 3px bottom margin by default */
    padding: 0;
    width: 18px; /* Set a fixed size so it doesn't jump around */
    height: 18px;
    cursor: pointer;
    flex-shrink: 0; /* Prevents the circle from squishing if text is long */
}

/* This targets the text specifically */
.payment-option span {
    margin-left: 15px; /* Creates a fixed space after the radio button */
    font-size: 16px;
    color: #333;
    text-align: left;
}

.payment-option input[type="radio"] {
    margin: 0; /* Removes default browser margins */
    transform: scale(1.2);
    accent-color: #8b5e34; /* Colors the radio button brown */
    cursor: pointer;
}

    /* FORM ELEMENTS */
    .btn {
        width: 100%;
        padding: 14px;
        background: #8b5e34;
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: bold;
        font-size: 1rem;
        cursor: pointer;
        transition: background 0.3s;
        margin-top: 10px;
    }

    .btn:hover {
        background: #6f4725;
    }

    label {
        font-weight: bold;
        font-size: 0.9rem;
    }

    input[type="text"] {
        width: 100%;
        box-sizing: border-box; /* Prevents input from overflowing the card */
        padding: 12px;
        margin-top: 8px;
        margin-bottom: 15px;
        border-radius: 8px;
        border: 1px solid #ddd;
        outline-color: #8b5e34;
    }
</style>

<div class="card">

    <h2>Checkout</h2>

    <p><b>Subtotal:</b> RM <%= total %></p>
    <p><b>Discount:</b> RM <%= discount %></p>
    <p><b>Total:</b> RM <%= finalTotal %></p>

    <hr>

    <!-- PROMO CODE -->
    <form action="applyPromo.jsp" method="post">
        <label>Promo Code:</label>
        <input type="text" name="promo" placeholder="Enter code (SAVE10)">
        <button class="btn" type="submit">Apply</button>
    </form>

    <hr>

    <!-- PAYMENT FORM -->
    <form action="processPayment.jsp" method="post">

        <input type="hidden" name="total" value="<%= finalTotal %>">

        <div class="payment-option">
            <label>
                <input type="radio" name="method" value="cash" required>
                Cash Payment
            </label>
        </div>

        <div class="payment-option">
            <label>
                <input type="radio" name="method" value="debit">
                Debit Card
            </label>
        </div>

        <div class="payment-option">
            <label>
                <input type="radio" name="method" value="credit">
                Credit Card
            </label>
        </div>

        <div class="payment-option">
            <label>
                <input type="radio" name="method" value="toyyib">
                Online Banking (ToyyibPay)
            </label>
        </div>

        <br>

        <button class="btn" type="submit">Pay Now</button>
    </form>

</div>

<%@ include file="footer.jsp" %>
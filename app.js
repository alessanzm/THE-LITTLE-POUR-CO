// Data Store
let menu = [
    { id: 1, name: "Iced Spanish Latte", price: 12.00, img: "🥤" },
    { id: 2, name: "Velvet Crème Mocha", price: 15.00, img: "☕" },
    { id: 3, name: "Buttercream Latte", price: 13.00, img: "🍯" }
];

let cart = JSON.parse(localStorage.getItem("cart")) || [];

// Initialize Cart Count
function updateCartUI() {
    const count = document.getElementById("cartCount");
    if(count) count.innerText = cart.length;
}

// Add to Cart with "Pop" effect
function addToCart(id) {
    const item = menu.find(m => m.id === id);
    cart.push(item);
    localStorage.setItem("cart", JSON.stringify(cart));
    updateCartUI();
    
    // Simple Interactive Feedback
    const btn = event.target;
    btn.innerText = "Added! ✨";
    setTimeout(() => btn.innerText = "Add to Cart", 1000);
}

// Checkout Logic
function checkout() {
    if (cart.length === 0) return alert("Your cart is empty! 🥺");
    
    let orders = JSON.parse(localStorage.getItem("orders")) || [];
    let newOrder = {
        id: Date.now(),
        items: cart,
        status: "Pending",
        total: cart.reduce((sum, item) => sum + item.price, 0)
    };
    
    orders.push(newOrder);
    localStorage.setItem("orders", JSON.stringify(orders));
    
    // Clear cart
    cart = [];
    localStorage.setItem("cart", JSON.stringify(cart));
    alert("Order sent to the barista! 🧸");
    window.location.href = "track.html";
}

let selectedMethod = "E-Wallet"; // Default

function loadCart() {
    let list = document.getElementById("cartList");
    if (!list) return;

    list.innerHTML = "";
    let subtotal = 0;

    cart.forEach((item, index) => {
        subtotal += item.price;
        list.innerHTML += `
            <div class="cart-item">
                <span>${item.img} ${item.name}</span>
                <span>RM ${item.price.toFixed(2)}</span>
            </div>
        `;
    });

    // Calculations
    let tax = subtotal * 0.06;
    let total = subtotal + tax;

    document.getElementById("subtotal").innerText = `RM ${subtotal.toFixed(2)}`;
    document.getElementById("tax").innerText = `RM ${tax.toFixed(2)}`;
    document.getElementById("grandTotal").innerText = `RM ${total.toFixed(2)}`;
}

// Visual selection for payment
function selectPay(element, method) {
    document.querySelectorAll('.pay-option').forEach(opt => opt.classList.remove('active'));
    element.classList.add('active');
    selectedMethod = method;
}

function processOrder() {
    if (cart.length === 0) return alert("Add some coffee first! 🧸");

    const totalAmount = document.getElementById("grandTotal").innerText;

    const newOrder = {
        id: Math.floor(1000 + Math.random() * 9000), // Random 4-digit ID
        items: cart,
        status: "Preparing", // Skip pending for "Paid" orders
        payment: selectedMethod,
        total: totalAmount,
        time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
    };

    let orders = JSON.parse(localStorage.getItem("orders")) || [];
    orders.push(newOrder);
    localStorage.setItem("orders", JSON.stringify(orders));

    // Clear and redirect
    localStorage.setItem("cart", JSON.stringify([]));
    
    // Aesthetic redirect delay
    const btn = document.querySelector(".btn-checkout");
    btn.innerText = "Processing Payment... ⌛";
    
    setTimeout(() => {
        window.location.href = "track.html";
    }, 1500);
}

// Initial Load
if (window.location.href.includes("cart.html")) {
    loadCart();
}

// Run on load
document.addEventListener("DOMContentLoaded", updateCartUI);
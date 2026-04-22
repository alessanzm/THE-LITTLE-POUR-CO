let menu = JSON.parse(localStorage.getItem("menu")) || [
  {id:1,name:"Latte",price:10},
  {id:2,name:"Mocha",price:12}
];

let cart=[];
let orders=JSON.parse(localStorage.getItem("orders"))||[];

const OPEN=9,CLOSE=22;

function isOpen(){
  let h=new Date().getHours();
  return h>=OPEN && h<CLOSE;
}

function show(id){
  document.querySelectorAll("section").forEach(s=>s.style.display="none");
  document.getElementById(id).style.display=
    id==="menu"?"grid":"block";

  if(id==="menu") renderMenu();
  if(id==="orders") renderOrders();
}

function renderMenu(){
  let c=document.getElementById("menu");
  c.innerHTML="";

  menu.forEach(m=>{
    c.innerHTML+=`
      <div class="card ${isOpen()?"":"closed"}">
        <h3>${m.name}</h3>
        <p>RM${m.price}</p>
        <button ${isOpen()?"":"disabled"} onclick="add(${m.id})">Add</button>
      </div>`;
  });
}

function add(id){
  cart.push(menu.find(m=>m.id===id));
  alert("Added");
}

function checkout(){
  let user = JSON.parse(sessionStorage.getItem("user"));

  if(!user) return alert("Login required");
  if(!isOpen()) return alert("Closed");

  orders.push({
    id:Date.now(),
    user:user.username,
    items:cart,
    status:"Pending",
    total:cart.reduce((a,b)=>a+b.price,0)
  });

  localStorage.setItem("orders",JSON.stringify(orders));
  cart=[];
  alert("Order placed");
}

function renderOrders(){
  let user = JSON.parse(sessionStorage.getItem("user"));
  let c=document.getElementById("orders");

  c.innerHTML="";

  orders.filter(o=>o.user===user.username)
  .forEach(o=>{
    c.innerHTML+=`
      <div class="card">
        Order #${o.id}<br>
        ${o.status}<br>
        RM${o.total}
      </div>`;
  });
}

show("home");
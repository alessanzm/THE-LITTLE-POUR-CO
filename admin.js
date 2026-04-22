let menu=JSON.parse(localStorage.getItem("menu"))||[];
let orders=JSON.parse(localStorage.getItem("orders"))||[];
let promos=JSON.parse(localStorage.getItem("promos"))||[];

function addMenu(){
  menu.push({
    id:Date.now(),
    name:name.value,
    price:parseFloat(price.value)
  });

  localStorage.setItem("menu",JSON.stringify(menu));
}

function renderOrders(){
  let c=document.getElementById("orderList");
  c.innerHTML="";

  orders.forEach(o=>{
    c.innerHTML+=`
      <div class="card">
        #${o.id} - ${o.status}
        <button onclick="update(${o.id},'Preparing')">Prep</button>
        <button onclick="update(${o.id},'Ready')">Ready</button>
        <button onclick="update(${o.id},'Completed')">Done</button>
      </div>`;
  });
}

function update(id,s){
  orders=orders.map(o=>{
    if(o.id===id) o.status=s;
    return o;
  });

  localStorage.setItem("orders",JSON.stringify(orders));
  renderOrders();
}

function addPromo(){
  promos.push({
    code:code.value,
    discount:parseFloat(disc.value)
  });

  localStorage.setItem("promos",JSON.stringify(promos));
}

renderOrders();
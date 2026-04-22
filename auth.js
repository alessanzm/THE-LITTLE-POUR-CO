function register(){
  let users = JSON.parse(localStorage.getItem("users")) || [];

  let ans = prompt("Security Q: Favourite drink?");

  users.push({
    username:username.value,
    password:password.value,
    answer:ans,
    role:"user"
  });

  localStorage.setItem("users",JSON.stringify(users));
  alert("Registered");
}

function login(){
  let users = JSON.parse(localStorage.getItem("users")) || [];

  let u = users.find(x =>
    x.username===username.value &&
    x.password===password.value
  );

  if(!u) return alert("Wrong login");

  sessionStorage.setItem("user",JSON.stringify(u));

  window.location = u.role==="admin"?"admin.html":"index.html";
}

function toggleRecover(){
  document.getElementById("recover").style.display="block";
}

function recover(){
  let users = JSON.parse(localStorage.getItem("users")) || [];

  users = users.map(u=>{
    if(u.username===recUser.value && u.answer===recAns.value){
      u.password=newPass.value;
      alert("Password reset");
    }
    return u;
  });

  localStorage.setItem("users",JSON.stringify(users));
}
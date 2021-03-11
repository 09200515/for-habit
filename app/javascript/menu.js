function menu (){
  const menuLists = document.getElementById("menu-lists");
  menuLists.addEventListener("click", () => {
    const lists = document.getElementById("lists");
    if (lists.getAttribute("style") == "display:block;") {
      lists.removeAttribute("style", "display:block;");
    } else {
      lists.setAttribute("style", "display:block;")
    };
  });
};
window.addEventListener("load", menu);
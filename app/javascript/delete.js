function check (){
  var btns = document.getElementsByClassName("delete-btn");
  for(var i = 0; i < btns.length; i++){
    btns[i].addEventListener("click", () => {
      if(window.confirm('本当に削除してもよろしいですか？')){
        alert('削除しました');
      } else {
        return false;
      };
    });
  };
};

window.addEventListener("load", check);

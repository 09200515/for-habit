function time() {
  var time1;

  const startBtn = document.getElementById("start-btn");
  startBtn.addEventListener("click", function cntStart() {
    document.timer.elements[2].disabled = true;
    timer1 = setInterval("countDown()", 1000);
  });

  const finBtn = document.getElementById("fin-btn");
  finBtn.addEventListener("click", function cntStop() {
    document.timer.elements[2].disabled = false;
    crearInterval(timer1);
  });

  setInterval("",function countDown() {
    var min = document.timer.elements[0].value;
    var sec = document.timer.elements[1].value;

    if((min == "")&&(sec == "")) {
      alert("時間を設定してください!");
      reSet();
    }
    else {
      if(min == "")min = 0;
      min = parseInt(min);

      if(sec == "")sec = 0;
      sec = parseInt(sec);

      tmWrite(min * 60 + sec -1);
    }
  }

  function tmWrite(int) {
    int = parseInt(int);

    if(int <= 0) {
      reSet();
      alert("終了です!");
    }
    else {
      document.timer.elements[0].value = Math.floor(int/60);
      document.timer.elements[1].value = int % 60;
    }
  }
  function reSet() {
    document.timer.elements[0].value = "0";
    document.timer.elements[1].value = "0";
    document.timer.elements[2].disabled = false;
    clearInterval(timer1);

  }

}

window.addEvebtListener("load", time);
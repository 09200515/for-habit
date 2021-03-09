function time (){
  const times = document.getElementById("times")
  times.addEventListener("keyup", () => {
    var timer1 = Number(times.value * 60);

    var to_timeup = timer1;
    var max = timer1;
    var intervalid;
    var start_flag = false;

    var startbutton = document.getElementById("startbutton");
    startbutton.addEventListener("click", () => {
      if(start_flag === false){
        intervalid = setInterval(count_down, 1000);
        start_flag = true;
      };
    })

    function count_down (){
      var timer = document.getElementById("timer");
      if(to_timeup === 0){
        timer.innerHTML = "Time up!"
        timer.style.color = "red"
        count_stop();
      } else {
        to_timeup--;
        padding();
      };
    }

    function count_stop (){
      console.log(count_stop);
      clearInterval(intervalid);
      start_flag = false;
      alert("終了しました！お疲れ様でした!");
    };

    function padding (){
      var timer = document.getElementById("timer");
      var min = 0;
      var sec = 0;
      min = Math.floor(to_timeup/60);
      sec = (to_timeup % 60);
      min = ("0"+min).slice(-2);
      sec = ("0"+sec).slice(-2);
      timer.innerHTML = min + ":" + sec;
    }
    
    var stopbutton = document.getElementById("stopbutton");
    stopbutton.addEventListener("click", () => {
      console.log("count_stop");
      clearInterval(intervalid);
      start_flag = false;
    });

    var resetbutton = document.getElementById("resetbutton");
    resetbutton.addEventListener("click", () => {
      console.log("count_reset");
      var timer = document.getElementById("timer");
      clearInterval(intervalid);
      start_flag = false;
      to_timeup = max;
      padding();
      timer.style.color = "black";
    });

  });
};
window.addEventListener('load', time);
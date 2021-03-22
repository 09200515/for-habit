function scroll(){
  const PageTopBtn = document.getElementById('js-scroll-top');
  PageTopBtn.addEventListener('click', () =>{
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  });
}
window.addEventListener("load", scroll);
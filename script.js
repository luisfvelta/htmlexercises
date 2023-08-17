const wrapper = document.querySelector(".hwrapper");
const carousel = document.querySelector(".hcarousel");
const arrowBtns = document.querySelectorAll(".hwrapper i");
const firstCardWidth = carousel.querySelector(".hcard").offsetWidth;
const carouselChildrens = [...carousel.children];

// let's slide only when mouse clicked down and cursor moved
let isDragging = false, startX, startScrollLeft, timeoutId;

// get the number or cards that can fit in the carousel at once
let cardPerView = Math.round(carousel.offsetWidth / firstCardWidth);

// Insert copies of the last few cards to beginning of carousel for infinite scrolling
carouselChildrens.slice(0,cardPerView).forEach(hcard => {
    
    carousel.insertAdjacentHTML("afterbegin",hcard.outerHTML);
});

// Insert copies of the last few cards to beginning of carousel for infinite scrolling
carouselChildrens.slice(-cardPerView).reverse().forEach(hcard => {
    
    carousel.insertAdjacentHTML("beforeend",hcard.outerHTML);
});
// Add event listener for the arrow buttons to scroll the carousel left and right
arrowBtns.forEach(btn => {
    btn.addEventListener("click", () => {
        
        carousel.scrollLeft += btn.id === "hright" ? firstCardWidth : - firstCardWidth;        
        });
});

const dragStart = (e)=> {
    isDragging = true;
    carousel.classList.add("dragging"); 
    startX = e.pageX;
    startScrollLeft = carousel.scrollLeft;
} 

const dragging = (e)=> {
    if (!isDragging) return; // if false return from here
    // updates the scroll position of the carousel based on the cursor movement
    carousel.scrollLeft = startScrollLeft - (e.pageX - startX);
}

const dragStop = ()=> {
    isDragging = false;
    carousel.classList.remove("dragging"); 
} 
// Autoplay the carousel after 2500 ms
const autoPlay = () => {
    if (window.innerWidth < 800) return; 
    timeoutId = setTimeout(() => carousel.scrollLeft += firstCardWidth, 2500);
      

}

autoPlay();

const infiniteScroll = () => {
    if (carousel.scrollLeft === 0) {
        carousel.classList.add("no-transition");
        carousel.scrollLeft = carousel.scrollWidth - 2 * carousel.offsetWidth;
        carousel.classList.remove("no-transition");        
    } else if (Math.ceil(carousel.scrollLeft === (carousel.scrollWidth - carousel.offsetWidth ))){        
        carousel.classList.add("no-transition"); 
        carousel.scrollLeft = carousel.offsetWidth;
        carousel.classList.remove("no-transition");         
    }
    clearTimeout(timeoutId);
    if(!wrapper.matches(":hover")) autoPlay();

}


carousel.addEventListener("mousedown", dragStart);
carousel.addEventListener("mousemove", dragging);
// Stop cards from sliding when mouse button released   
document.addEventListener("mouseup",dragStop);
carousel.addEventListener("scroll", infiniteScroll);
// Let's slide the cards  properly according to the mouse movement

wrapper.addEventListener("mouseenter", () => clearTimeout(timeoutId));
wrapper.addEventListener("mouseleave", () => autoPlay);

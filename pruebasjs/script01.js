// Shape - superclass
function Shape(){
    this.x = 0
    this.y = 0
}

// superclass method
Shape.prototype.move = function(x,y){
    this.x+=x
    this.y+=y
    const resp="Shape moved to x:" + x + " y:" + y
    alert(resp)
}
// Rectangle - usbclass
function Rectangle(){
    Shape.call(this)  // call super constructor
}
// Subclass extends superclass
Rectangle.prototype = Object.create(Shape.prototype,{
    constructor:{
        value:Rectangle,
        enumerable:false,
        writable:true,
        configurable:true,
    },
});
function seleccionado(){
    const rect = new(Rectangle)
    boolresp = rect instanceof Rectangle ? "Yes" : "No"    
    let resp = "Is rect an instance of Rectangle? " + boolresp
    alert(resp)
    boolresp = rect instanceof Shape ? "Yes" : "No" 
    resp="Is rect an instance of Shape? " + boolresp
    alert(resp)
    rect.move(50,70)
    cuad=new(Shape)
    boolresp = cuad instanceof Rectangle ? "Yes" : "No"    
    resp = "Is cuad an instance of Rectangle? " + boolresp
    alert(resp)
    boolresp = cuad instanceof Shape ? "Yes" : "No" 
    resp="Is cuad an instance of Shape? " + boolresp
    alert(resp)
    cuad.move(50,70)
}

    //primitive assignments
    var myBike = "Mountain Bike";
    let currentGear = 5;
    const numberOfGears = 12;
    
    
  
function seleccionado(){
/*myBike = "Penny Farthing"; // this works
currentGear = 1; // so does this
numberOfGears = 1; // error
// call constructor, new object, assign it to bike
const bike = new Bike();
//Change internal state by calling a function
bike.changeGear("front", "Up");
// add a new member to bike that did not exist before
bike.type = "Penny Farthing";
// check for success
*/
alert(bike.calculateGearRatio()); // 4.0909...
alert(bike.type); // "Penny Farthing"
// attempt to point bike to new instance of Bike
bike = new Bike(1,2); // error      
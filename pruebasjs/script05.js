const bike = {
    frontGearIndex: 0,
    rearGearIndex: 0,
    transmission: {
       frontGearTeeth: [30,45],
        rearGearTeeth: [11,13,15,17,19,21,24,28,32,36]
   },
   
   calculateGearRatio: function() {
      let front = this.transmission.frontGearTeeth[this.frontGearIndex],
          rear = this.transmission.rearGearTeeth[this.rearGearIndex];
      return (front / rear);
   },  
   
   changeGear: function(frontOrRear, upOrDown) {
      let shiftFunction = frontOrRear + upOrDown;
      this[shiftFunction]();
   },
   
   frontUp: function(){
     this.frontGearIndex += 1;
   },
   
   frontDown: function(){
     this.frontGearIndex -= 1;
   },
   
   rearUp: function(){
     this.rearGearIndex += 1;
   },
   
   rearDown: function(){
     this.rearGearIndex -= 1;
   }
 };
 function seleccionado(){
    alert(bike.calculateGearRatio()); // 2.727272727
    //Calls the frontUp() function
    bike.changeGear("front", "Up");
    alert(bike.calculateGearRatio()); // 4.090909091
    //calls the rearUp() function
    bike.changeGear("rear", "Up");
    alert(bike.calculateGearRatio()); // 3.461538461
    bike.transmission.frontGearTeeth
    bike.calculateGearRatio()
 }
    
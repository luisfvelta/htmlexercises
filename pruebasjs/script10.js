let boton=document.getElementById("boton")
boton.addEventListener("click",seleccionado)


function seleccionado(){  
    
    var obj = {
        aValue: 0,
        increment: function(paso,incrementBy) {
          this.aValue = this.aValue + incrementBy;
          console.log(`Paso inside ${paso} this = ${this.aValue}`) 
          console.log(`Paso inside ${paso} obj = ${obj.aValue}`)             
        }
      }    
      console.log("Vamos")           
      obj.increment("1.", 2);
      console.log(`Despues del paso this = ${this.aValue}`)
      console.log(`Despues del paso obj = ${obj.aValue}`)
            
      var newIncrement = obj.increment;
      newIncrement("2.", 2);
      console.log(`Obj ${obj.aValue}`)
      console.log(`This ${this.aValue}`)
}


function countToThree() {
    // i is in the scope of the countToThree function
    for (let i = 0; i < 3; i++){
      console.log(i); // iteration 1: 0
      // iteration 2: 1
      // iteration 3: 2
    }
    console.log(i); // What is this?
  }
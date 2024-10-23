/*function doSomething(msg){
    return new Promise(
      function (resolve, reject) {
        setTimeout(
          function () {
            alert(msg);
            resolve();
          },
          1000);
      });
  }
      
*/
function doSomething(msg){
    return new Promise((resolve, reject) => {
        setTimeout(
          () => {
            alert(msg);
            resolve();
          },
          1000);
      })
  } 
function seleccionado(){
   doSomething("1st Call")
   .then(function() {
     return doSomething("2nd Call");
   })
   .then(function() {
     return doSomething("3rd Call");
   });
}

/*doSomething("1st Call")
  .then(() => doSomething("2nd Call >>"))
  .then(() => doSomething("3rd Call"));
*/
  

  doSomething("1st Call")
  .then(() => doSomething("2nd Call"))
  .then(() => doSomething("3rd Call"))
  .catch(err => alert(err.message));
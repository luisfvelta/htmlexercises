function doSomething(msg){
    return new Promise((resolve, reject) => {
        setTimeout(
          () => {
            try {
              if (msg.includes("3rd")) {
                throw new Error('bad error')
              }
              console.log(msg);
              resolve();
            } catch(e) {
              reject(e);
            }
          },
          1000);
      })
  }
async function doSomethingManyTimes() {
    try {
        await doSomething("1st Call");
        await doSomething("2nd Call");
        await doSomething("3rd Call");
    } catch (e) {
        console.error(e.message);
    }
}

function seleccionado(){    
    doSomethingManyTimes()
    
}   
  
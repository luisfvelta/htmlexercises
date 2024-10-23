class Parent {
    constructor(name) {
      this.name = name;
    }
        
    getName() {
      return this.name;
    }
  }

  class Child extends Parent {
    constructor(name) {
      super(name);
    }
          
    getMessage() {
      return 'Hello ' + super.getName();
    }
  }

  const myAnimal = class Animal {
    constructor(name) {
      this.name = name;
    }
    printName() {
      alert(this.name);
    }
  }

  function seleccionado(){
    let someone = new Child('Miguelito');
    alert(someone.getMessage());     // Displays "Hello person"
    let duck = new myAnimal('duck');
    duck.printName();  // Displays "duck"
    let bird= new myAnimal('pajaro')
    bird.printName();  // Displays "pajaro
  }
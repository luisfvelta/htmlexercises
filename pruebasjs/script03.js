class Rectangle {
    constructor(height, width) {
      this.height = height;
      this.width = width;
    }
    // Getter
    get area() {
      return this.calcArea();
    }
    // Method
    calcArea() {
      return this.height * this.width;
    }
    *getSides() {
      yield this.height;
      yield this.width;
      yield this.height;
      yield this.width;
    }
  }

  function seleccionado(){
  
    const square = new Rectangle(10, 10);
    resp="Area" + square.area
    alert(resp) // 100
    resp=[...square.getSides()]
    alert(resp) // 100
  }
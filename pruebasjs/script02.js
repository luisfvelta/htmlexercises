const person = {
    isHuman: false,
    printIntroduction : function(){
        return (`My name is ${this.name} Am I a human? ${this.isHuman}`)
    }
};

function seleccionado(){
    me=Object.create(person)
    me.name="Miguelito"
    me.isHuman=true
    resp=me.printIntroduction()
    alert(resp)
    me.name="Arturito"
    me.isHuman=false
    resp=me.printIntroduction()
    alert(resp)
}
function seleccionado(){
    let firstName='Miguelito'
    let lastName='Salazar'
    let user ={firstName,lastName}
    console.log("Iniciando >>>>>>>>>>>")
    console.log(`Llegó ${user.firstName} ${user.lastName}`)
    user.lastName='Velasquez'
    console.log(`Salió ${user.firstName} ${user.lastName}`)
    let numbers = [1, 2, 3, 4];
    //let one=numbers[0], two=numbers[1],three=numbers[2],four=numbers[3]
    let [one,two, three, four] = numbers
    console.log(one, two);
    let [,,tres]=numbers
    console.log(tres)
    const APPLE = {
        type: 'delicious',
        color: 'red',
        size: 'large'
    }
    const { type, color,size } = APPLE;
    console.log(`Color: ${color} Size: ${size} Type: ${type}`);
    console.log(APPLE.size)
}
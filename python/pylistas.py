# personas es una lista de elementos encerrados entre {} y separados por comas
# Los elementos separados por comas e incluídos dentro de corchetes {} son diccionarios en Python
# Un diccionario es una lista de parejas del tipo "clave":valor
# Al ser personas una lista, hereda una serie de métodos propios de la classe list, de la cual es una clase derivada
# Recuerda que un  método es una función.
# Para ejecutar un método de una clase se emplea la notación clase.método
# La línea personas.append({"nombre":"Miguelito","ciudad":"La Ceja","pais":"Colombia"}) agrega a la lista personas un
#    elemento al final de la lista

# Cada diccionario de esta lista contiene 3 claves, cada una tiene asociados los valores.
# Las claves van entre comillas. Ejemplo : "nombre" y se separan del valor con :.
# Los valores en este caso van entre comillas porque son cadenas de caracteres, strings.
# Los numéricos van sin comillas, como por ejemplo edad y saldo.
# Los valores lógicos, booleans, tampoco van entre comillas. Ejemplo: inscrito


personas = [{"nombre":"Joan","ciudad":"Paris","pais":"Francia","edad":30,"saldo":1180.23,"inscrito":True},
            {"nombre":"John","ciudad":"Chicago","pais":"USA""edad":25,"saldo":2340.15,"inscrito":False},
            {"nombre":"Peter","ciudad":"Chicago","pais":"USA""edad":60,"saldo":37500.00,"inscrito":True}]

personas.append({"nombre":"Miguelito","ciudad":"La Ceja","pais":"Colombia","edad":21,"saldo":475.32,"inscrito":False})

print(f"personas es de tipo {type(personas)}")

ciudades = []

print(f"ciudades es de tipo {type(ciudades)}")
impreso: bool = False
for persona  in personas:
    if not impreso:
      print(f"persona es de tipo {type(persona)}")
      impreso=True
    ciudades.append(persona["ciudad"])
print(f"Desde la lista ciudades de tipo : {type(ciudades)}")

impreso = False
for ciudad in sorted(ciudades):
  if not impreso:
      print(f"ciudad es de tipo {type(ciudad)}")
      print("====================================")
      impreso=True
  print(f"Ciudad habitada: {ciudad}")

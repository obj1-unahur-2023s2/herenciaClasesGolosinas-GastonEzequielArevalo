/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */
 
class Golosina{
	var peso
	var sabor
	method sabor() = sabor
	method peso() = peso
	method libreGluten() = true 
}
 
class Bombon inherits Golosina{
	method precio() { return 5 }
	method mordisco() { peso = peso * 0.8 - 1 }
}


class Alfajor inherits Golosina{
	method precio() { return 12 }
	method mordisco() { peso = peso * 0.8 }
	override method libreGluten() { return false }
}

class Caramelo inherits Golosina{
	method precio() { return 12 }
	method mordisco() { peso = peso - 1 }
}


class Chupetin inherits Golosina{
	method precio() { return 2 }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
}

class Oblea  inherits Golosina {
	method precio() { return 5 }
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}
	override method libreGluten() { return false }
}

class Chocolatin  inherits Golosina{
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var comido = 0
	
	method pesoInicial(unPeso) { peso = unPeso }
	method precio() { return peso * 0.50 }
	override method peso() { return (peso - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	override method libreGluten() { return false }

}

class GolosinaBaniada inherits Golosina{
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	override method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	override method sabor() { return golosinaInterior.sabor() }
	override method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti inherits Golosina{
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	override method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	override method peso() { return 5 }
	override method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}

class BombonDuro inherits Bombon{
	
	override method mordisco(){
		peso = 0.max(peso - 1)
	}
	
	method gradoDeDureza(){
		var salida = 0
		if (peso > 12){
			salida = 3
		}
		else if(peso.between(8,12)){
			salida = 2
		}
		else{
			salida = 1
		}
		return salida
	}
}

/* Indicar en cuál clase se encuentra el método que se
   ejecuta en cada caso, detallando el recorrido que realiza
   el method lookup.
  
  	var bombon = new Bombon() 
	bombon.mordisco() == Bombon
	bombon.peso() == Golosina
	bombon = new BombonDuro() 
	bombon.mordisco() == Bombon
	bombon.peso() == Golosina
*/

class CarameloCorazonDeChocolate inherits Caramelo{
	override method mordisco() {
		super()
		sabor = chocolate
	}
	override method precio(){return super() + 1}
}

/* Indicar en cuál clase se encuentra el método que se
   ejecuta en cada caso, detallando el recorrido que realiza
   el method lookup.
  
  	var caramelo = new Caramelo() 
	caramelo.mordisco() == Caramelo
	caramelo.peso() == Golosina
	caramelo.sabor() == Golosina
	caramelo = new CarameloRelleno() 
	caramelo.mordisco() == CarameloRelleno
	caramelo.peso() == Golosina
	caramelo.sabor() == Golosina
*/

class ObleaCrujiente inherits Oblea{
	var cantidadDeMordiscos = 0
	
	method cantidadDeMordisco(){return cantidadDeMordiscos}
	
	override method mordisco(){
		super()
		cantidadDeMordiscos += 1
		if(cantidadDeMordiscos <= 3){
			peso -= 3
		}
	}
	
	method estaDebil(){
		return cantidadDeMordiscos > 3
	}
}

/* Indicar en cuál clase se encuentra el método que se
   ejecuta en cada caso, detallando el recorrido que realiza
   el method lookup.
  
  	var oblea = new Oblea() 
	oblea.mordisco() == Oblea
	oblea.peso() == Golosina
	oblea = new ObleaCrujiente() 
	oblea.mordisco() == ObleaCrujiente() 
	oblea.peso() == Golosina
*/

class ChocolatinVip inherits Chocolatin{
	const humedad = 0
	
	method humedad(){return humedad}
	
	override method peso(){
		return super()*1 + humedad
	}
}

class ChocolatinPremium inherits ChocolatinVip{
	
	override method humedad(){return super() / 2}
}


/* Indicar en cuál clase se encuentra el método que se
   ejecuta en cada caso, detallando el recorrido que realiza
   el method lookup.
  
  	var chocolatin = new Chocolatin() 
	chocolatin.peso() == Golosina
	chocolatin = new ChocolatinVIP() 
	chocolatin.peso() == ChocolatinVIP
	chocolatin = new ChocolatinPremium() 
	chocolatin.peso() == ChocolatinVIP
*/


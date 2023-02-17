//
// This is only a SKELETON file for the 'Hello World' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

// Diese Funktionen werden für den Exercism Start Javascript getestet
module.exports = { hello, good_bye, hello_you };

function hello() {
  return 'Hello, World!';
}

function good_bye() {
  return 'Goodbye, Mars!';
}

// Diese Funktionen werden in diesem Skript definiert und ausgeführt
var name = ''
function hello_you(name) {
  var message = 'hi, ' + name + "!" 
  return message;
}

const foo = () => {
  console.log('hello world')
}

// self invoking function bzw. selbstaufrufende Funktion
(function bar(){
  console.log('hello world from bar')
})()

// Funktionsaufrufe
foo();

var message = hello_you("Sun");
console.log(message);

/*
Fogende Aufrufe sind hier möglich. 

  --- Testaufruf
  npm test 
  --- Aufruf in der CI
  node hello-world.js
  --- Weiterer CI-Aufruf nach der Definition im package.json
   npm run hello

   --- Eine weitere Möglichkeit eine Funktion in de CI aufzurufen
  npm i -S run-func
  npx run-func hello-world.js hello_you "Mars"
*/



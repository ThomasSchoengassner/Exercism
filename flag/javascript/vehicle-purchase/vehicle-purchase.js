// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * Determines whether or not you need a licence to operate a certain kind of vehicle.
 *
 * @param {string} kind
 * @returns {boolean} whether a license is required
 */
export function needsLicense(kind) {
  // due to the topic of the exercise I am not taking the shortest solution
  // var needsLicense = kind == 'truck' || kind == 'car';
  var needsLicense
  if (kind == 'truck' || kind == 'car'){
    needsLicense = true
  } else {
    needsLicense = false
  }
  return needsLicense;
}

/**
 * Helps choosing between two options by recommending the one that
 * comes first in dictionary order.
 *
 * @param {string} option1
 * @param {string} option2
 * @returns {string} a sentence of advice which option to choose
 */
export function chooseVehicle(option1, option2) {
  var chooseVehicle = "";
  if (option1 < option2) {
    chooseVehicle = option1;
  } else {
    chooseVehicle = option2;
  }
  return chooseVehicle + " is clearly the better choice.";
}

/**
 * Calculates an estimate for the price of a used vehicle in the dealership
 * based on the original price and the age of the vehicle.
 *
 * @param {number} originalPrice
 * @param {number} age
 * @returns {number} expected resell price in the dealership
 */
export function calculateResellPrice(originalPrice, age) {
  // there are other ways but you want to practice
  var resellPrice;
  if (age < 3) {
    resellPrice = originalPrice * 0.8;
  } else if (age >= 3 && age <= 10) {
    resellPrice = originalPrice * 0.7;
  } else {
    resellPrice = originalPrice * 0.5;
  }
  return resellPrice;
}

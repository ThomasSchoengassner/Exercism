// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

import { Console } from "console";

/**
 * Determines how long it takes to prepare a certain juice.
 *
 * @param {string} name
 * @returns {number} time in minutes
 */
export function timeToMixJuice(name) {
  let timeToMix = 0;
  
  switch (name) {
    case "Pure Strawberry Joy":
      timeToMix = 0.5;
      break;
    case "Energizer":
      timeToMix = 1.5;
      break;
    case "Green Garden":
      timeToMix = 1.5;
      break;
    case "Tropical Island":
      timeToMix = 3;
      break;
    case "All or Nothing":
      timeToMix = 5;
      break;
    default:
      timeToMix = 2.5;
  }

  return timeToMix;
}

/**
 * Calculates the number of limes that need to be cut
 * to reach a certain supply.
 *
 * @param {number} wedgesNeeded
 * @param {string[]} limes
 * @returns {number} number of limes cut
 */
export function limesToCut(wedgesNeeded, limes) { 
  let limesToCut = 0;
  let wedgesCut = 0;

  while (wedgesCut < wedgesNeeded && limesToCut < limes.length ) {
    switch (limes[limesToCut]) {
      case "small":
        wedgesCut += 6;
        break;
      case "medium":
        wedgesCut += 8;
        break;
      case "large":
        wedgesCut += 10;
        break;
      default:
        wedgesCut += 0;
    }
    limesToCut += 1
  }

  return limesToCut;
}

/**
 * Determines which juices still need to be prepared after the end of the shift.
 *
 * @param {number} timeLeft
 * @param {string[]} orders
 * @returns {string[]} remaining orders after the time is up
 */
export function remainingOrders(timeLeft, orders) {

  while (timeLeft > 0) {
    timeLeft -= timeToMixJuice(orders[0]);
    orders.shift();
  }

  return orders;
}

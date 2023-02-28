// @ts-check

import { type } from "os";
import { resourceLimits } from "worker_threads"

/**
 * Calculate the sum for the numbers on the slot machine
 * 
 * @param {array} firstArray
 * @param {array} secondArray
 * @returns {number}
 */
export const twoSum = (firstArray, secondArray) => {
  const value1 = Number(String(firstArray).replace(/,/g,''))
  const value2 = Number(secondArray.join(''));
  
  return value1 + value2;
} 

/**
 * Determine if a number is a palindrome
 * 
 * @param {number} number
 * @returns {boolean}
*/
export const luckyNumber = (number) => {
  const newNumber = number.toString().split('').reverse().join().replace(/,/g, '')
  // oder: newNumber = [...String(a)].reverse().join('')
  return Number(newNumber) == number;
}

/** 
 * Generate an error message for invalid user input
 * 
 * @param {string | null | undefined} input
 * @returns {string}
*/
export const errorMessage = (input) => {
  if (!input) {
    return 'Required field';
  } else {
    return Number(input) > 0 ? '' :  'Must be a number besides 0';
  }
}


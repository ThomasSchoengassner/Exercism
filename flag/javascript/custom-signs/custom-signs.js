// @ts-check

// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * Build an occasion sign
 * 
 * @param {string} celebration
 * @param {string} name
 * @returns {string}
*/
export const buildSign = (celebration, name) => {
  return `Happy ${celebration} ${name}!`
}

/**
 * Build a birthday sign
 * 
 * @param {number} age
 * @return {string}
*/
export const buildBirthdaySign = (age) => {
  return `Happy Birthday! What a ${age < 50 ? "young" : "mature"} fellow you are.`;
}

/**
 * Build a graduation sign
 * 
 * @param {string} name
 * @param {number} year
 * @returns {string}
 */
export const graduationFor = (name, year) => {
  return `Congratulations ${name}!\nClass of ${year}`;
}

/** 
 *  Compute the cost of a sign
 * 
 * @param {string} greetingMessage
 * @param {string} currency
 * @returns {string}
*/
export const costOf = (greetingMessage, currency) => {
  return `Your sign costs ${(greetingMessage.length * 2 + 20).toFixed(2)} ${currency}.`;
}
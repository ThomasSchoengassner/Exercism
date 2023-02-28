/// <reference path="./global.d.ts" />

const { isTSCallSignatureDeclaration } = require("@babel/types");

// @ts-check

/**
 * Implement the functions needed to solve the exercise here.
 * Do not forget to export them so they are available for the
 * tests. Here an example of the syntax as reminder:
 *
 * export function yourFunction(...) {
 *   ...
 * }
 */

/**
 * Determine whether the lasagna is done
 * 
 * @param {number} timer
 *  @returns {string}
*/
const cookingStatus = (timer) => {
  let message = "";
  switch(timer) {
    case null || undefined:
      message = 'You forgot to set the timer.';
      break
    case 0:
      message = 'Lasagna is done.';
      break
    default:
      message = 'Not done, please wait.';
  }
  return message;
}

/**
 * Estimate the preparation time
 * 
 * @param {array} layers
 * @param {number} timeNeeded
 * @returns {number}
 */
const preparationTime = (layers, timeNeeded) => {
  if (timeNeeded > 0) {
    return layers.length * timeNeeded;
  } else {
    return layers.length * 2;
  }
}

/**
 * Compute the amounts of noodles and sauce needed
 * 
 * @param {array} ingredients
 * @return {Quantities}
 */
const quantities = (ingredients) => {
  const noodlesNeeded = ingredients.filter(ingredient => ingredient == 'noodles').length;
  const sauceNeeded = ingredients.filter(ingredient => ingredient == 'sauce').length;

  return {
    noodles: noodlesNeeded * 50,
    sauce: sauceNeeded * 0.2,
  };
}

/**
 * Add the secret ingredient
 * 
 * @param {array} friendsList
 * @param {array} myList
 * @returns {}
*/
const addSecretIngredient = (friendsList, myList) => {
  myList.push(friendsList[friendsList.length - 1]);
  return;
}

/**
 * Scale the recipe
 * 
 * @param {Quantities} recipe
 * @param {number} portions
 * @returns {Quantities}
 */
const scaleRecipe = (recipe, portions) => {
  let scaledRecipe = Object.create(null);
  let keys = Object.keys(recipe);
  let i = 0;

  while (i < keys.length) {
    scaledRecipe[keys[i]] =  recipe[keys[i]] * portions / 2;
    i += 1;
  }

  return scaledRecipe;
}


module.exports = { cookingStatus, preparationTime, quantities, addSecretIngredient, scaleRecipe };

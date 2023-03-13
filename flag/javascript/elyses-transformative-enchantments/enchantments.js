// @ts-check

/**
 * Double every card in the deck.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} deck with every card doubled
 */
export function seeingDouble(deck) {
  return deck.map((value) => value * 2);
}

/**
 *  Creates triplicates of every 3 found in the deck.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} deck with triplicate 3s
 */
export function threeOfEachThree(deck) {
  let newDeck = [];

  for (let i = 0; i < deck.length; i++) {
    if (deck[i] == 3) {
      newDeck.push(deck[i])
      newDeck.push(deck[i])
      newDeck.push(deck[i])
    } else {
      newDeck.push(deck[i])
    }
  }

  return newDeck;
}

/**
 * Extracts the middle two cards from a deck.
 * Assumes a deck is always 10 cards.
 *
 * @param {number[]} deck of 10 cards
 *
 * @returns {number[]} deck with only two middle cards
 */
export function middleTwo(deck) {
  const middle = deck.length / 2 - 1;

  return deck.slice(middle, middle + 2);;
}

/**
 * Moves the outside two cards to the middle.
 *
 * @param {number[]} deck with even number of cards
 *
 * @returns {number[]} transformed deck
 */

export function sandwichTrick(deck) {
  let newDeck = deck.slice(1,-1);

  newDeck.splice(newDeck.length/2, 0, deck[0]);
  newDeck.splice(newDeck.length/2, 0, deck[deck.length-1]);

  return newDeck;
}

/**
 * Removes every card from the deck except 2s.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} deck with only 2s
 */
export function twoIsSpecial(deck) {
  let newDeck = {};

  newDeck = deck.reduce(
    /**
     * @param {Object} accumulator 
     * @param {number} currentValue 
     * @returns 
     */
    (accumulator, currentValue) => {
      if (currentValue === 2) {
        accumulator.two.push(currentValue);
      } else {
        accumulator.rest.push(currentValue);
      }
      return accumulator;
    },
    { two: [], rest: [] }
  );

  return deck.filter((value) => value === 2);
}

/**
 * Returns a perfectly order deck from lowest to highest.
 *
 * @param {number[]} deck shuffled deck
 *
 * @returns {number[]} ordered deck
 */
export function perfectlyOrdered(deck) {

  function compareNumbers(a, b) {
    return a - b;
  }
  
  return deck.sort(compareNumbers);
}

/**
 * Reorders the deck so that the top card ends up at the bottom.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} reordered deck
 */
export function reorder(deck) {
  return deck.reverse();
}

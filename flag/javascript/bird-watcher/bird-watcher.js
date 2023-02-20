// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * Calculates the total bird count.
 *
 * @param {number[]} birdsPerDay
 * @returns {number} total bird count
 */
export function totalBirdCount(birdsPerDay) {
  var totalBirds = 0;

  for (var i = 0; i < birdsPerDay.length; i++) {
    totalBirds += birdsPerDay[i]
  }
  
  return totalBirds;
}

/**
 * Calculates the total number of birds seen in a specific week.
 *
 * @param {number[]} birdsPerDay
 * @param {number} week
 * @returns {number} birds counted in the given week
 */
export function birdsInWeek(birdsPerDay, week) {
  var totalBirdsInWeek = 0;
  let start = 7 * (week - 1);

  for (var i = start; i <= start + 6; i++) {
    totalBirdsInWeek += birdsPerDay[i]
  }

  return totalBirdsInWeek;
}

/**
 * Fixes the counting mistake by increasing the bird count
 * by one for every second day.
 *
 * @param {number[]} birdsPerDay
 * @returns {number[]} corrected bird count data
 */
export function fixBirdCountLog(birdsPerDay) {
  const updatedBirdCounts = birdsPerDay;

  for (let i = 0; i < birdsPerDay.length - 1; i += 2) {
    updatedBirdCounts[i] += 1;
  }

  return updatedBirdCounts;
}

/// <reference path="./global.d.ts" />
// @ts-check

// if started once then export all needed functions here and not in the code
module.exports = { createScoreBoard, addPlayer, removePlayer, updateScore, applyMondayBonus, normalizeScore };

/*
 * Creates a new score board with an initial entry.
 *
 * @returns {Record<string, number>} new score board
 */
function createScoreBoard() {
  var object = {"The Best Ever": 1000000,}
  return object;
}

/**
 * Adds a player to a score board.
 *
 * @param {Record<string, number>} scoreBoard
 * @param {string} player
 * @param {number} score
 * @returns {Record<string, number>} updated score board
 */
function addPlayer(scoreBoard, player, score) {
  scoreBoard[player] = score;
  return scoreBoard;
}

/**
 * Removes a player from a score board.
 *
 * @param {Record<string, number>} scoreBoard
 * @param {string} player
 * @returns {Record<string, number>} updated score board
 */
function removePlayer(scoreBoard, player) {
  delete scoreBoard[player];
  return scoreBoard;
}

/**
 * Increases a player's score by the given amount.
 *
 * @param {Record<string, number>} scoreBoard
 * @param {string} player
 * @param {number} points
 * @returns {Record<string, number>} updated score board
 */
function updateScore(scoreBoard, player, points) {
  scoreBoard[player] = scoreBoard[player] + points;
  return scoreBoard;
}

/**
 * Applies 100 bonus points to all players on the board.
 *
 * @param {Record<string, number>} scoreBoard
 * @returns {Record<string, number>} updated score board
 */
export function applyMondayBonus(scoreBoard) {
  var keys = Object.keys(scoreBoard);
  
  for (let i = 0; i < keys.length; i++) {
    console.log("player: %i %s", i, keys[i]);
  }

  for (let key in scoreBoard) {
    updateScore(scoreBoard, key, 100);
  }
  return scoreBoard;
}

/**
 * Normalizes a score with the provided normalization function.
 *
 * @param {Params} params the parameters for performing the normalization
 * @returns {number} normalized score
 */
export function normalizeScore(params) {
  const normalizedScore = params.normalizeFunction(params.score);
  return normalizedScore;
}

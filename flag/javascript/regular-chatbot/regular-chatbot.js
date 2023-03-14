// @ts-check

/**
 * Given a certain command, help the chatbot recognize whether the command is valid or not.
 *
 * @param {string} command
 * @returns {boolean} whether or not is the command valid
 */

export function isValidCommand(command) {
  const reg = /chatbot/i;
  const ary = command.match(reg);
  console.log(ary)
  return ary == null ? false : ary.index == 0;
}

/**
 * Given a certain message, help the chatbot get rid of all the emoji's encryption through the message.
 *
 * @param {string} message
 * @returns {string} The message without the emojis encryption
 */
export function removeEmoji(message) {
  const reg = /emoji|[0-9]/g;
  return message.replace(reg, '')
}

/**
 * Given a certain phone number, help the chatbot recognize whether it is in the correct format.
 *
 * @param {string} number
 * @returns {string} the Chatbot response to the phone Validation
 */
export function checkPhoneNumber(number) {
  const reg = /[1-9+()]{5} [0-9]{3}-[0-9]{3}-[0-9]{3}/i;
  const ary = number.match(reg);
  if (ary != null) {
    return 'Thanks! You can now download me to your phone.';
  } else {
    return "Oops, it seems like I can't reach out to " + number;
  }
  // return ary == null ? '' : ary[0];
}

/**
 * Given a certain response from the user, help the chatbot get only the URL.
 *
 * @param {string} userInput
 * @returns {string[] | null} all the possible URL's that the user may have answered
 */
export function getURL(userInput) {
  return userInput.split(/\s/).filter(word => word.match(/\.[\w]{2}/i));
}

/**
 * Greet the user using the full name data from the profile.
 *
 * @param {string} fullName
 * @returns {string} Greeting from the chatbot
 */
export function niceToMeetYou(fullName) {
  const name = fullName.split(/,/).map(word => word.trim())
  return `Nice to meet you, ${name[1]} ${name[0]}`;
}

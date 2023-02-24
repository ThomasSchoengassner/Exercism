/// <reference path="./global.d.ts" />

import { Console } from "console";

// @ts-check

/**
 * Creates a new visitor.
 *
 * @param {string} name
 * @param {number} age
 * @param {string} ticketId
 * @returns {Visitor} the visitor that was created
 */
const createVisitor = (name, age, ticketId) => {
  let visitor = Object.create(null);

  visitor = {ticketId: ticketId};
  visitor.name = name;
  visitor['age'] = age;

  return visitor;
}

/**
 * Revokes a ticket for a visitor.
 *
 * @param {Visitor} visitor the visitor with an active ticket
 * @returns {Visitor} the visitor without a ticket
 */
const revokeTicket = (visitor) => {
  visitor.ticketId = null;

  return visitor;
}


/**
 * Determines the status a ticket has in the ticket tracking object.
 *
 * @param {Record<string, string|null>} tickets
 * @param {string} ticketId
 * @returns {string} ticket status
 */
var ticketStatus = (tickets, ticketId) => {
  let ticketHolder = tickets[ticketId];
  let ticketStatus = '';

  switch(ticketHolder) {
    case undefined:
      ticketStatus = 'unknown ticket id';
      break;
    case null:
      ticketStatus = 'not sold';
      break;
    default:
      ticketStatus = 'sold to ' + ticketHolder;   
  };

  return ticketStatus;
}


/**
 * Determines the status a ticket has in the ticket tracking object
 * and returns a simplified status message.
 *
 * @param {Record<string, string|null>} tickets
 * @param {string} ticketId
 * @returns {string} ticket status
 */
const simpleTicketStatus = (tickets, ticketId) => {
  let simpleStatus = ticketStatus(tickets, ticketId);

  if (simpleStatus[0] == "s") {
    simpleStatus = simpleStatus.slice(8,simpleStatus.length)
  } else {
    simpleStatus = 'invalid ticket !!!';
  };

  return simpleStatus;
}


/**
 * Determines the version of the GTC that was signed by the visitor.
 *
 * @param {VisitorWithGtc} visitor
 * @returns {string | undefined} version
 */
const gtcVersion = (Visitor) => {
  const version = Visitor.gtc?.version ?? undefined;

  return version;
}


module.exports = { createVisitor, revokeTicket, ticketStatus, simpleTicketStatus, gtcVersion };


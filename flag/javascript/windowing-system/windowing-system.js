// @ts-check


// Define Size for storing the dimensions of the window
export class Size {
  /**
   * @param {number | undefined} width
   * @param {number | undefined} height
  */
  constructor (width, height) {
    this.width = width == undefined ? 80 : width;
    this.height = height == undefined ? 60 : height;
  }

  /**
   * @param {number} width
   * @param {number} height
  */
  resize (width, height) {
    this.width = width;
    this.height = height;
  }
}


// Define Position to store a window position
export class Position {
  /**
   * @param {number | undefined} x
   * @param {number | undefined} y
  */
  constructor(x, y) {
    this.x = x == undefined || x < 0 ? x = 0 : x;
    this.y = y == undefined || y < 0 ? y = 0 : y;
  }

  /**
   * @param {number} x
   * @param {number} y
  */
  move(x, y) {
    this.x = x;
    this.y = y;
  }
}


// Define a ProgramWindow class
export class ProgramWindow {
  /**
   * @param {Size} size
   * @param {Position} position
  */
  constructor(size, position) {
    this.screenSize = new Size(size?.width || 800, size?.height || 600);
    this.size = new Size(undefined, undefined);
    this.position = new Position(undefined, undefined);
  }

  // Add a method to resize the window
  /**
   * @param {Size} size
  */
  resize(size) {
    this.size.width = Math.min(Math.max(size.width, 1), this.screenSize.width - this.position.x);
    this.size.height = Math.min(Math.max(size.height, 1), this.screenSize.height - this.position.y);
  }

  // Add a method to move the window
  /**
   * @param {Position} position
  */
  move(position) {
    const x = Math.min(position.x, this.screenSize.width - this.size.width)
    const y = Math.min(position.y, this.screenSize.height - this.size.height)

    this.position = new Position(x, y);
  }
}


/**
 * Change a program window
 * 
 * @param {ProgramWindow} programWindow 
 * @returns 
 */
export const changeWindow = (programWindow) => {
  programWindow.resize(new Size(400, 300))
  programWindow.move(new Position(100, 150))
  
  return programWindow;
}

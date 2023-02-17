import { hello, good_bye } from './hello-world';

describe('Hello World', () => {
  test('Say Hi!', () => {
    expect(hello()).toEqual('Hello, World!');
  });
  
  test('Say Good Bye!', () => {
    expect(good_bye()).toEqual('Goodbye, Mars!');
  });
});

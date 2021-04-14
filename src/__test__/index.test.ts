import { hello } from '../index';

test('test_hello_world', () => {
  expect(hello('World')).toBe('Hello, World!');
});

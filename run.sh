#!/bin/bash

git init
nodenv local 14.15.0
npm init -y
npm i -D prettier typescript @types/node@14 ts-node nodemon jest @types/jest ts-jest
npx tsc --init --rootDir src --outDir lib --esModuleInterop --resolveJsonModule --lib es6,dom --module commonjs
gibo dump Node > .gitignore
mkdir -p src/__test__

cat << EOF > ./.prettierrc
{
  "printWidth": 120,
  "semi": true,
  "trailingComma": "es5",
  "tabWidth": 2,
  "singleQuote": true
}
EOF

cat << EOF > ./jest.config.js
module.exports = {
  roots: ['<rootDir>/src'],
  testMatch: ['**/__tests__/**/*.+(ts|tsx|js)', '**/?(*.)+(spec|test).+(ts|tsx|js)'],
  transform: {
    '^.+\.(ts|tsx)$': 'ts-jest',
  },
};
EOF

cat << EOF > ./package.json
{
  "name": "ts_node_template",
  "version": "1.0.0",
  "description": "",
  "main": "src/index.js",
  "scripts": {
    "start": "npm run build:live",
    "build": "tsc -p .",
    "build:live": "nodemon --watch 'src/**/*.ts' --exec 'ts-node' src/index.ts",
    "test": "jest"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "@types/jest": "^26.0.22",
    "@types/node": "^14.14.37",
    "jest": "^26.6.3",
    "nodemon": "^2.0.7",
    "prettier": "^2.2.1",
    "ts-jest": "^26.5.4",
    "ts-node": "^9.1.1",
    "typescript": "^4.2.3"
  }
}
EOF

cat << EOF > ./tsconfig.json
{
  "compilerOptions": {
    "target": "es6",
    "module": "commonjs",
    "lib": ["es6","dom"],
    "outDir": "dist",
    "rootDir": "src",
    "strict": true,
    "esModuleInterop": true,
    "resolveJsonModule": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  }
}
EOF

cat << EOF > ./src/index.ts
export function hello(name: string): string {
  return \`Hello, \${name}!\`;
}

console.log(hello('World'));
EOF

cat << EOF > ./src/__test__/index.test.ts
import { hello } from '../index';

test('test_hello_world', () => {
  expect(hello('World')).toBe('Hello, World!');
});
EOF
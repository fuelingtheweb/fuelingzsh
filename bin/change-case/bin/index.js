#!/usr/bin/env node

const ChangeCase = require('change-case');
const UpperCase = require('upper-case');
const UpperCaseFirst = require('upper-case-first');
const LowerCase = require('lower-case');
const TitleCase = require('title-case');

ChangeCase.upperCase = UpperCase.upperCase;
ChangeCase.upperCaseFirst = UpperCaseFirst.upperCaseFirst;
ChangeCase.lowerCase = LowerCase.lowerCase;
ChangeCase.titleCase = TitleCase.titleCase;

const commands = {
    camel: 'camelCase',
    constant: 'constantCase',
    dot: 'dotCase',
    lower: 'lowerCase',
    pascal: 'pascalCase',
    path: 'pathCase',
    sentence: 'sentenceCase',
    snake: 'snakeCase',
    title: 'titleCase',
    upper: 'upperCase',
    upperFirst: 'upperCaseFirst',
    kebab: 'paramCase',
};

const arguments = process.argv.splice(2);
const to = arguments[0];
const text = arguments[1];
const method = commands[to];
const converter = ChangeCase[method];

console.log(converter(text));

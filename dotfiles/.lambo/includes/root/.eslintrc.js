const resolve = require('./webpack.config.resolve');

module.exports = {
    env: {
        es6: true,
        browser: true,
        node: true,
        jquery: true,
        jest: true
    },
    extends: ['airbnb', 'plugin:jest/recommended', 'plugin:vue/recommended', 'plugin:prettier/recommended', 'prettier/vue'],
    plugins: ['html', 'jest', 'prettier', 'vue'],
    rules: {
        'max-len': ['error', {code: 110}],
        'import/no-extraneous-dependencies': 0,
        'no-new': 0,
        'no-param-reassign': 0,
        'ignoreChainWithDepth': 4,
        'global-require': 0,
        'no-underscore-dangle': 0,
        'vue/html-self-closing': [
            'error',
            {
                'html': {
                    'void': 'any'
                }
            }
        ]
    },
    settings: {
        'html/html-extensions': ['.html'],
        'import/resolver': {
            webpack: {
                config: {
                    resolve
                }
            }
        }
    },
    'overrides': [
      {
        'files': ['resources/js/tests/**/*.@(spec|test).js'],
        'rules': {
            'no-use-before-define': ['error', {functions: false}]
        }
      }
    ]
}

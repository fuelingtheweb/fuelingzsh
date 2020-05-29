<?php

$rules = [
    '@Symfony' => true,
    'binary_operator_spaces' => ['align_double_arrow' => false],
    'array_syntax' => ['syntax' => 'short'],
    'linebreak_after_opening_tag' => true,
    'not_operator_with_successor_space' => false,
    'ordered_imports' => ['sortAlgorithm' => 'length'],
    'phpdoc_order' => true,
    'braces' => ['position_after_functions_and_oop_constructs' => 'next'],
    'visibility_required' => ['elements' => ['property']],
    'yoda_style' => false,
    'new_with_braces' => false,
    'concat_space' => ['spacing' => 'one'],
];

$finder = PhpCsFixer\Finder::create()
    ->notPath('bootstrap/cache')
    ->notPath('storage')
    ->notPath('vendor')
    ->in(__DIR__)
    ->name('*.php')
    ->notName('*.blade.php')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true);

return PhpCsFixer\Config::create()
    ->setRules($rules)
    ->setFinder($finder);

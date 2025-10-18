<?php

return [
    'name' => 'Artisan',

    'version' => app('git.version'),

    'env' => 'development',

    'providers' => [
        App\Providers\AppServiceProvider::class,
    ],

    'karabiner_path' => env('KARABINER_PATH'),
];

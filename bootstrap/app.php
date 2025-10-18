<?php

use LaravelZero\Framework\Application;

return Application::configure(basePath: dirname(__DIR__))
    ->create()
    ->useConfigPath(base_path('config/laravel'));

<?php

function indent($count = 1)
{
    return str_repeat('    ', $count);
}

function template_path($path)
{
    return base_path("src/templates/{$path}");
}

function anvil_config($key)
{
    $path = str($key)
        ->replace('.', '/')
        ->value();

    return base_path("config/{$path}.yml");
}

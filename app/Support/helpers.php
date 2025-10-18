<?php

function indent($count)
{
    return str_repeat('    ', $count);
}

function template_path($path)
{
    return base_path("src/templates/{$path}");
}

function anvil_config($key)
{
    return base_path("config/{$key}.yml");
}

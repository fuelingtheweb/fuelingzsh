<?php

namespace App\Models;

class Action
{
    public static $templates = [
        'alfred' => <<<'EDN'
            osascript -e 'tell application id \"com.runningwithcrayons.Alfred\" to run trigger \"%s\" in workflow \"%s\" with argument \"%s\"'
        EDN,
        'app' => "open -b '%s'",
        'hs' => "open -g 'hammerspoon://%s'",
        'hsk' => "open -g 'hammerspoon://handle-karabiner?mode=%s&key=%s'",
        'menu' => <<<'EDN'
            osascript -e 'tell application \"System Events\" to tell process \"%s\" to click menu item \"%s\" of menu \"%s\" of menu bar 1'
        EDN,
    ];

    public static function getTemplateDefinitions()
    {
        return collect(static::$templates)
            ->map(fn ($template, $name) => static::definition($name, $template))
            ->implode("\n");
    }

    public static function definition($name, $template)
    {
        return str('$indent:$name "$template"')
            ->replace('$indent', indent(2))
            ->replace('$name', $name)
            ->replace('$template', trim($template))
            ->value();
    }
}

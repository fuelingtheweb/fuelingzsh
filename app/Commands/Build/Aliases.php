<?php

namespace App\Commands\Build;

use App\Models\Alias;
use LaravelZero\Framework\Commands\Command;
use Symfony\Component\Yaml\Yaml;

class Aliases extends Command
{
    protected $signature = 'build:aliases';

    protected $description = 'Build Aliases';

    public function handle()
    {
        $this->info('Building Aliases...');

        $aliases = collect(Yaml::parse(file_get_contents(anvil_config('aliases.laravel'))))
            ->map(fn ($value, $key) => (new Alias($key, $value))->toArray())
            ->flatten();

        file_put_contents(
            base_path('aliases/laravel.sh'),
            $aliases->implode("\n"),
        );

        $this->info('Finished!');
    }
}

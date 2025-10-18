<?php

namespace App\Commands;

use App\Models\Action;
use App\Models\App;
use App\Models\Simlayer;
use LaravelZero\Framework\Commands\Command;
use Symfony\Component\Yaml\Yaml;

class Compile extends Command
{
    protected $signature = 'kc:compile';

    protected $description = 'Compile Karabiner Config';

    public function handle()
    {
        $this->info('Compiling Karabiner Config...');

        $simlayers = collect(Yaml::parse(file_get_contents(config_path('simlayers.yml'))))
            ->map(fn ($rules, $index) => (new Simlayer($index, $rules))->toArray());

        $config = str(file_get_contents(config_path('template.edn')))
            ->replace(
                '$simlayers',
                $simlayers
                    ->filter(fn ($simlayer) => $simlayer['name'] !== 'HyperMode')
                    ->pluck('definition')
                    ->implode("\n"),
            )
            ->replace('$templates', Action::getTemplateDefinitions())
            ->replace('$applications', App::getDefinitions())
            ->replace('$rulesets', $simlayers->pluck('rules')->implode("\n"))
            ->value();

        file_put_contents(config('app.karabiner_path'), $config);

        $this->info('Finished!');
    }
}

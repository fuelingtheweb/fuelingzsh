<?php

namespace App\Commands\Build;

use App\Models\Action;
use App\Models\App;
use App\Models\Simlayer;
use LaravelZero\Framework\Commands\Command;
use Symfony\Component\Yaml\Yaml;

class Karabiner extends Command
{
    protected $signature = 'build:karabiner';

    protected $description = 'Build Karabiner Config';

    public function handle()
    {
        $this->info('Building Karabiner Config...');

        $simlayers = collect(Yaml::parse(file_get_contents(anvil_config('simlayers'))))
            ->map(fn ($rules, $index) => (new Simlayer($index, $rules))->toArray());

        $config = str(file_get_contents(template_path('karabiner.edn')))
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

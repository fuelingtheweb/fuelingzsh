const mix = require('laravel-mix');
const resolve = require('./webpack.config.resolve');

mix.webpackConfig({resolve})
    .js('resources/js/app.js', 'public/js')
    .sass('resources/sass/app.scss', 'public/css')
    .sourceMaps()
    .extract()
    .browserSync({
        proxy: 'local.project.test',
        host: 'local.project.test',
        open: 'external',
        online: true,
    });

if (mix.inProduction()) {
    mix.version();
}

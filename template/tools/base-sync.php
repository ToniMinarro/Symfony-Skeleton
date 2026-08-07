<?php

declare(strict_types=1);

$root = dirname(__DIR__);
$manifestPath = $root.'/base/composer-requirements.json';
$composerPath = $root.'/composer.json';

if (!is_file($manifestPath) || !is_file($composerPath)) {
    fwrite(STDERR, "Missing base/composer-requirements.json or composer.json.\n");
    exit(1);
}

$manifest = json_decode((string) file_get_contents($manifestPath), true, 512, JSON_THROW_ON_ERROR);
$composer = json_decode((string) file_get_contents($composerPath), true, 512, JSON_THROW_ON_ERROR);

foreach (['require', 'require-dev'] as $section) {
    $composer[$section] ??= [];
    foreach ($manifest[$section] ?? [] as $package => $constraint) {
        $composer[$section][$package] = $constraint;
    }
    ksort($composer[$section]);
}

$composer['config'] ??= [];
$composer['config']['optimize-autoloader'] = true;
$composer['config']['sort-packages'] = true;
$composer['config']['allow-plugins'] ??= [];
$composer['config']['allow-plugins']['symfony/flex'] = true;
$composer['config']['allow-plugins']['symfony/runtime'] = true;

$composer['extra'] ??= [];
$composer['extra']['symfony'] = $manifest['extra']['symfony'];

file_put_contents(
    $composerPath,
    json_encode($composer, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES | JSON_THROW_ON_ERROR)."\n"
);

if (in_array('--packages', $argv, true)) {
    $packages = [];
    foreach (['require', 'require-dev'] as $section) {
        foreach (array_keys($manifest[$section] ?? []) as $package) {
            if (str_contains($package, '/')) {
                $packages[] = $package;
            }
        }
    }
    sort($packages);
    echo implode(' ', array_unique($packages));
}

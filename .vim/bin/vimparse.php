#!/usr/bin/php
<?php

function usage()
{
    global $command;
    $usage = "Usage:
    $command [-c] [-f <errorfile>] <programfile> [programargs]

    -c           compile only, don't run (executes 'php -l')
    -f           write errors to <errorfile>
    -h, --help   show this help

    Examples:
    * At the command line:
    $command program.php
    Displays output on STDOUT.

    $command -c -f errorfile program.php
    Then run 'vim -q errorfile' to edit the errors with Vim.

    * In Vim:
    Edit in Vim (and save, if you don't have autowrite on), then
    type ':mak' or ':mak args' (args being the program arguments)
    to error check." . PHP_EOL;
    echo $usage;
}

$command = array_shift($argv);

if (count($argv) < 2) {
    usage();
    exit(0);
}


$filename = null;
$option = '';
$error_file = null;

while ($arg = array_shift($argv)) {
    if ('-' !== substr($arg, 0, 1)) {
        if (!is_null($filename)) {
            echo $command . ': too many programfile parameter' . PHP_EOL;
            exit(1);
        }
        $filename = $arg;
        continue;
    }
    switch ($arg) {
        case '-c':
            $option = '-l ';
            break;
        case '-f':
            $error_file = array_shift($argv);
            break;
        case '-h':
        case '--help':
        default:
            usage();
            exit(0);
    }
}

if (!file_exists($filename)) {
    echo $command . ': ' . $filename . ' does not exist' . PHP_EOL;
    exit(1);
}

if (ob_get_level() !== 0) {
    ob_end_clean();
}

$cmd = 'php '.$option.escapeshellarg($filename). ' 2>&1';
if ((exec($cmd, $output, $status) !== false) && ($status !== 0)) {
    ob_start();
    foreach ($output as $part) {
        if (preg_match('/^.*?:(.*?) in (.*?) on line (\d+)/', $part, $matches)) {
            $matches = array_map('trim', $matches);
            $message = $matches[1];
            $file = $matches[2];
            $lineno = $matches[3];

            echo "{$file}:{$lineno}:{$message}" . PHP_EOL;
        }
    }

    if (!is_null($error_file)){
        file_put_contents($error_file, ob_get_contents());
    } 
    ob_end_flush();
}



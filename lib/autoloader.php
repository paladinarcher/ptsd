<?php

require_once('ClassLoader.php');

$loader = new \Symfony\Component\ClassLoader\UniversalClassLoader();
$loader->registerNamespaceFallbacks(
        array(
                __DIR__
        )
);
$loader->registerPrefixFallbacks($loader->getNamespaceFallbacks());
$loader->registerSuffixes(array(
        '.class.php',
        '.inc.php'
));
$loader->useIncludePath(true);
$loader->register();


?>

<?php 

$config['site_title'] = 'nsg.cc';
$config['theme'] = 'blog'; 	
$config['date_format'] = 'jS M Y';
$config['twig_config'] = array(	
	'cache' => '/tmp/cache',
	'autoescape' => false,
	'debug' => false
);

if ($_SERVER['HTTP_HOST'] != "localhost:8080") {
	$config['base_url'] = 'http://nsg.cc';
}

$config['cache_enabled'] = true;
$config['cache_dir'] = '/tmp/content/cache/';
$config['cache_time'] = 86400 * 14;

?>

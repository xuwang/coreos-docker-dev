<?php
$config = array(
	'servers' => array(
		array(
			'name' => 'redis.service',
			'host' => getenv('REDIS_PORT_6379_TCP_ADDR'),
			'port' => 6379,
			'filter' => '*',
			'db'=> 4
		),
	),

	'seperator' => ':',

	// You can ignore settings below this point.

	'maxkeylen'           => 200,
	'count_elements_page' => 200
);

?>
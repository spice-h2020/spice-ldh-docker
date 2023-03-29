<?php

return [
    'mongodb' => [
        'host' => 'spice-ldh-mongodb',
        'port' => '27017',
        'database' => 'spice',
	'queryLimit' => 100,
        'adminUser' => 'spice-admin',
        'adminPwd' => 'DATAHUB1234567890'
    ],
    'file' => [
        'destination' => 'data/filestore/',
        'metadata_dataset' => 'datahub__files'
    ],
	'metadata' => [
        'dataset' => 'spice_metadata'
    ],
    //Specify the dataset and key used for activity logging here
	'activityLog' => [
        'enabled' => true,
        'dataset' => 'spice_activity_log'
    ],
    'schema' => [
        'dataset' => 'spice_schema',
    ],
    'sparql' => [
        'host' => 'spice-ldh-blazegraph',
        'port' => '9999',
        'namespacePrefix' => 'spice_'
    ],
    'policies' => [
        'dataset' => 'spice_policies'
    ]
];

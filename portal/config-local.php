<?php

/**
 * Local Configuration Override
 *
 * This configuration override file is for overriding environment-specific and
 * security-sensitive configuration information. Copy this file without the
 * .dist extension at the end and populate values as needed.
 *
 * @NOTE: This file is ignored from Git by default with the .gitignore included
 * in ZendSkeletonApplication. This is a good practice, as it prevents sensitive
 * credentials from accidentally being committed into version control.
 */

return [
    'db'    => [
            'host'     => 'spice-ldh-mysql',
            'port'     => '3307',
            'user'     => 'root',
            'password' => 'NMg17ruPknQSC2rF',
            'dbname'   => 'spice_datahub',
            'charset'  => 'utf8mb4'
        ],
    'mkdf-stream'   =>  [
            'user'  =>  'spice-admin',
            'pass'  =>  'DATAHUB1234567890',
            'server-url'    =>  'http://spice-ldh-api:8090',
            'public-url'    =>  'http://spice-ldh-api:8090',
            'access-request' => 'spice_access_requests',
            'dataset-metadata' => 'spice_metadata'
        ],
    'mkdf-file' => [
        'destination' => 'data/'
    ],
    'mkdf-sparql' => [
        'rdfjobs-dataset' => 'spice_rdfjobs2',
        'rdfjobs-key' => 'rdfjobskey012'
    ],
        'mkdf-policies' => [
        'policies-dataset' => 'spice_policies',
        'policies-requests-dataset' => 'spice_policies_requests',
        'policies-key' => 'policieskey012'
    ],
        'notifications' => [
        'notifications-dataset' => 'spice_notifications',
        'notifications-key' => 'notificationskey023',
        // Set 'development' to True to avoid emailing all LDH users. Only users in development-emails will be sent to
        'development' => True,
        'development-emails' => [
        ]
    ],
    'email' => [
        'from-email' => 'noreply@spice-ldh-docker',
        'from-label' => 'SPICE LDH Portal',
    ],
];
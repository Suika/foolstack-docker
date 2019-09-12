<?php

return [
    /**
     * FoolFrame is the general structure built on FuelPHP
     */
    'main' => [

        /**
         * Version number for upgrading
         */
        'version' => '0.2.0',

        /**
         * Display name
         */
        'name' => 'FoolFrame',

        'class_context' => '\\Foolz\\FoolFrame\\Model\\Context',

        /**
         * The name that can be used in classes names
         */
        'class_name' => 'FoolFrame',

        /**
         *  URL to download a newer version
         */
        'git_tags_url' => 'https://api.github.com/repos/foolcode/foolfuuka/tags',

        /**
         * URL to fetch the changelog
         */
        'git_changelog_url' => 'https://raw.github.com/FoolCode/FoolFuuka/master/CHANGELOG.md',

    ],

    /**
     * Variables necessary for the installation module to work
     */
    'install' => [
        /**
         * Requirements to install FoolFrame
         */
        'requirements' => [
            /**
            * Minimal PHP requirement
            */
            'min_php_version' => '5.4.0',

            /**
             * Minimal MySQL requirement
             */
            'min_mysql_version' => '5.5.0'
        ]
    ],

    /**
     * Locations of the data out of the module folder
     */
    'directories' => [
        'themes' => VENDPATH.'foolz/foolframe/assets/themes/',
        'plugins' => VENDPATH.'foolz/foolframe/assets/plugins/'
    ],

    /**
     * Preferences defaults
     */
    'preferences' => [
        'gen' => [
            'website_title' => 'FoolFrame',
            'index_title' => 'FoolFrame',
        ],

        'maxmind' => [
            'geoip2_db_path' => VENDPATH.'foolz/foolframe/assets/packages/maxmind/GeoLite2-Country.mmdb'
        ],

        'imagick' => [
            'convert_path' => '/usr/bin/convert'
        ],

        'lang' => [
            'default' => 'en_EN',
            'available' => [
                'en_EN' => 'English',
                'fr_FR' => 'French',
                'it_IT' => 'Italian',
                'pt_PT' => 'Portuguese',
            ]
        ]
    ]
];

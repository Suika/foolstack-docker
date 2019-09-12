<?php

return [

    /**
     * FoolFuuka base variables
     */
    'main' => [
        /**
         * Version
         */
        'version' => '2.2.0',

        /**
         * Display name for the module
         */
        'name' => 'FoolFuuka',

        'class_context' => '\\Foolz\\FoolFuuka\\Model\\Context',

        /**
         * The name that can be used in classes names
         */
        'class_name' => 'FoolFuuka',

        /**
         *  URL to download a newer version
         */
        'git_tags_url' => 'https://api.github.com/repos/FoolCode/foolfuuka/tags',

        /**
         * URL to fetch the changelog
         */
        'git_changelog_url' => 'https://raw.github.com/FoolCode/FoOlFuuka/master/CHANGELOG.md',

        /**
         * Minimal PHP requirement
         */
        'min_php_version' => '5.3.0'
    ],

    /**
     * Locations of the data out of the module folder
     */
    'directories' => [
        'themes' => ASSETSPATH.'themes/',
        'plugins' => ASSETSPATH.'plugins/'
    ],

    /**
     * Preferences for when there's no default specified
     */
    'preferences' => [

        'gen' => [
            'website_title' => 'FoolFuuka',
            'index_title' => 'FoolFuuka',
        ],

        'lang' => [
            'default' => 'en_EN'
        ],

        'sphinx' => [
            'listen' => 'foolstack-sphinx:9306',
            'listen_mysql' => 'foolstack-db:3306',
            'dir' => '/var/lib/manticore',
            'min_word' => 3,
            'memory' => 2047,
            'enable_cache' => false,
            'cache_timeout' => 180
        ],

        'themes' => [],

        'radix' => [
            'op_image_upload_necessity' => 'always',
            'threads_per_page' => 10,
            'thumbnail_op_width' => 250,
            'thumbnail_op_height' => 250,
            'thumbnail_reply_width' => 125,
            'thumbnail_reply_height' => 125,
            'max_image_size_kilobytes' => 3072,
            'max_image_size_width' => 5000,
            'max_image_size_height' => 5000,
            'max_posts_count' => 400,
            'max_images_count' => 250,
            'min_image_repost_time' => 0,
            'anonymous_default_name' => 'Anonymous',
            'max_comment_characters_allowed' => 4096,
            'max_comment_lines_allowed' => 20,
            'cooldown_new_comment' => 10,
            'cooldown_new_thread' => 300,
            'thread_lifetime' => 432000,
            'captcha_comment_link_limit' => 3
        ],

        'boards' => [
            'directory' => DOCROOT.'foolfuuka/boards/',
            'url' => '/foolfuuka/boards',
            'enable_archive_cache' => false,
            'page_cache_timeout' => 60,
            'db' => 'asagi',
            'prefix' => ''
        ],

        'audit' => [
            '1_enabled' => true,
            '2_enabled' => true,
            '3_enabled' => true,
            '4_enabled' => true,
            '5_enabled' => true,
            '6_enabled' => true
        ]
    ]
];

<?php

namespace Foolz\FoolFrame\Theme\Admin\Partial\Install;

class DatabaseSetup extends \Foolz\FoolFrame\View\View
{
    public function toString()
    {
        $form = $this->getForm();
        ?>
        <p class="description">
            <?= _i('Please enter the connection details to the MySQL database.') ?>
        </p>

        <div style="padding-top:20px;">
            <?= $form->open(array('class' => 'form-horizontal')) ?>
                <fieldset>
                    <div class="control-group">
                        <label class="control-label" for="hostname"><?= _i('Database Type') ?></label>
                        <div class="controls">
                            <?= $form->select('type', $this->getPost('type', 'pdo_mysql'), array('pdo_mysql' => 'MySQL', 'pdo_pgsql' => 'PostgreSQL')); ?>
                            <p class="help-block small-text"><?= _i('The database software you are using.') ?></p>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="hostname"><?= _i('Database Hostname') ?></label>
                        <div class="controls">
                            <?= $form->input(array('id' => 'hostname', 'name' => 'hostname', 'value' => $this->getPost('hostname', 'foolstack-db'))) ?>
                            <p class="help-block small-text"><?= _i('Unless you are using a remote database server for this FoolFrame installation, leave it as `localhost`.') ?></p>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="database"><?= _i('Database Name') ?></label>
                        <div class="controls">
                            <?= $form->input(array('id' => 'database', 'name' => 'database', 'value' => $this->getPost('database', 'foolfuuka'))) ?>
                            <p class="help-block small-text"><?= _i('This is the name of the database which will store your FoolFrame installation.') ?></p>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="username"><?= _i('Username') ?></label>
                        <div class="controls">
                            <?= $form->input(array('id' => 'username', 'name' => 'username', 'value' => $this->getPost('username', 'foolfuuka'))) ?>
                            <p class="help-block small-text"><?= _i('This is the username of the account used to access the database server specified above.') ?></p>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="password"><?= _i('Password') ?></label>
                        <div class="controls">
                            <?= $form->password(array('id' => 'password', 'name' => 'password', 'value' => $this->getPost('password', 'pass'))) ?>
                            <p class="help-block small-text"><?= _i('Enter the password for the account specified above.') ?></p>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="prefix"><?= _i('Table Prefix') ?></label>
                        <div class="controls">
                            <?= $form->input(array('id' => 'prefix', 'name' => 'prefix', 'value' => $this->getPost('prefix', 'ff_'))) ?>
                            <p class="help-block small-text"><?= _i('If you wish to run multiple FoolFrame installations in a single database, change this.') ?></p>
                        </div>
                    </div>

                    <hr>

                    <?= $form->submit(array('name' => 'submit', 'value' => _i('Next'), 'class' => 'btn btn-success pull-right')) ?>
                </fieldset>
            <?= $form->close() ?>
        </div>
        <?php
    }
}

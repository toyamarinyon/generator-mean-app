/*global describe, beforeEach, it*/
'use strict';

var path    = require('path');
var helpers = require('yeoman-generator').test;


describe('mean-app generator', function () {
    beforeEach(function (done) {
        helpers.testDirectory(path.join(__dirname, 'temp'), function (err) {
            if (err) {
                return done(err);
            }

            this.app = helpers.createGenerator('mean-app:app', [
                '../../app'
            ]);
            done();
        }.bind(this));
    });

    it('creates expected files', function (done) {
        var expected = [
            // config
            'package.json',
            'bower.json',
            '.bowerrc',
            'gruntfile.coffee',
            'Gemfile',
            // server
            'app/src/server/server.coffee',
            'app/src/server/config/common.coffee',
            'app/src/server/config/express.coffee',
            'app/src/server/config/passport.coffee',
            'app/src/server/config/routes.coffee',
            'app/src/server/config/sockets.coffee',
            'app/src/server/config/env/development.coffee',
            'app/src/server/config/env/test.coffee',
            'app/src/server/config/env/production.coffee',
            'app/src/server/models/index.coffee',
            'app/src/server/models/user.coffee',
            // client
            'app/src/client/bootstrap.coffee',
            'app/src/client/controllers/index.coffee',
            'app/src/client/services/socket.coffee',
            'app/src/client/index.jade'
        ];

        helpers.mockPrompt(this.app, {
            'appName': 'MochaTest',
            'githubUser': 'toyamarinyon'
        });
        this.app.options['skip-install'] = true;
        this.app.run({}, function () {
            helpers.assertFiles(expected);
            done();
        });
    });
});

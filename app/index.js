'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');

var githubOptions = { version: '3.0.0' };

var GitHubApi = require('github');
var github = new GitHubApi(githubOptions);

var githubUserInfo = function (name, cb) {
  github.user.getFrom({
    user: name
  }, function (err, res) {
    if (err) throw(err);
    cb(JSON.parse(JSON.stringify(res)));
  });
};

var MeanAppGenerator = module.exports = function MeanAppGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(MeanAppGenerator, yeoman.generators.Base);

MeanAppGenerator.prototype.askFor = function askFor() {
  var done = this.async();

  // have Yeoman greet the user.
  // console.log(this.yeoman);

  var prompts = [{
    name: 'appName',
    message: 'What do you want to call your app?',
  },{
    name: 'githubUser',
    message: 'Would you mind telling me your username on GitHub?',
    default: 'someuser'
  }];

  this.prompt(prompts, function (props) {
    this.appName = props.appName;
    this.githubUser = props.githubUser;
    done();
  }.bind(this));
};

MeanAppGenerator.prototype.userInfo = function userInfo() {
  var done = this.async();

  githubUserInfo(this.githubUser, function (res) {
    this.realname = res.name;
    this.email = res.email;
    this.githubUrl = res.html_url;
    done();
  }.bind(this));
};

MeanAppGenerator.prototype.generateDirectoryHierarchy = function generateDirectoryHierarchy() {
  this.mkdir('app');
  this.mkdir('app/src');
  this.mkdir('app/src/server');
  this.mkdir('app/src/server/config');
  this.mkdir('app/src/server/controllers');
  this.mkdir('app/src/server/controllers/concerns');
  this.mkdir('app/src/server/models');
  this.mkdir('app/src/server/models/concerns');
  this.mkdir('app/src/client');
  this.mkdir('app/src/client/assets');
  this.mkdir('app/src/client/assets/images');
  this.mkdir('app/src/client/assets/styles');
  this.mkdir('app/src/client/config');
  this.mkdir('app/src/client/controllers');
  this.mkdir('app/src/client/controllers/concerns');
  this.mkdir('app/src/client/services');
  this.mkdir('app/src/client/services/concerns');
  this.mkdir('app/src/client/views');
  this.mkdir('app/src/client/views/concerns');
};

MeanAppGenerator.prototype.copyConfigFile = function copyConfigFile() {
  this.template('_package.json', 'package.json');
  this.template('_bower.json', 'bower.json');
  this.template('_bowerrc', '.bowerrc');
  this.template('_gruntfile.coffee', 'gruntfile.coffee');
};

MeanAppGenerator.prototype.copyServer = function copyServer() {
  this.copy('app/server/server.coffee'                 , 'app/src/server/server.coffee');
  this.copy('app/server/config/common.coffee'          , 'app/src/server/config/common.coffee');
  this.copy('app/server/config/express.coffee'         , 'app/src/server/config/express.coffee');
  this.copy('app/server/config/passport.coffee'        , 'app/src/server/config/passport.coffee');
  this.copy('app/server/config/routes.coffee'          , 'app/src/server/config/routes.coffee');
  this.copy('app/server/config/sockets.coffee'         , 'app/src/server/config/sockets.coffee');
  this.copy('app/server/config/env/development.coffee' , 'app/src/server/config/env/development.coffee');
  this.copy('app/server/config/env/test.coffee'        , 'app/src/server/config/env/test.coffee');
  this.copy('app/server/config/env/production.coffee'  , 'app/src/server/config/env/production.coffee');

};

MeanAppGenerator.prototype.copyClient = function copyClient() {
  this.copy('app/client/bootstrap.coffee'              , 'app/src/client/bootstrap.coffee');
  this.copy('app/client/controllers/index.coffee'      , 'app/src/client/controllers/index.coffee');
  this.copy('app/client/services/socket.coffee'        , 'app/src/client/services/socket.coffee');
  this.copy('app/client/index.jade'                    , 'app/src/client/index.jade');
};

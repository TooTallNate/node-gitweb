/**
 * A NodeJS wrapper for the official GitWeb CGI script.
 */
var url = require('url');
var path = require('path');

function gitweb(mountPoint, config) {
  if (typeof mountPoint !== 'string' || mountPoint[mountPoint.length-1] !== '/') {
    throw new Error("The 'mountPoint' must end with a slash '/'.");
  }

  config = config || {};
  config.__proto__ = gitweb.DEFAULTS;

  // The Environment configuration for the 'gitweb' CGI spawn
  var env = {
    // The Config File just reads all of it's configuration
    // from environment variables that are set below
    GITWEB_CONFIG_SYSTEM: __dirname + '/gitweb_config.perl'
  };

  // Extend the 'env' with the user-defined config properties.
  for (var prop in config) {
    env['NODE_GITWEB_'+prop.toUpperCase()] = config[prop];
  }

  // Return a "handler" function, created from 'stack'
  return require('stack')(
    require('creationix/static')(mountPoint, __dirname + '/static'),
    require('cgi')(__dirname + '/gitweb.cgi', {
      mountPoint: mountPoint,
      env: env,
      stderr: process.stderr
    })
  );
}
module.exports = gitweb;

// The default 'config' options to use.
gitweb.DEFAULTS = {
  projectroot: process.env.HOME,
  get homelink() {
    return this.projectroot;
  },
  sitename: "GitWeb powered by Node",
  version: "1.7.1",
  max_depth: "100",

  pathinfo: 1,

  avatar_default: 'gravatar',
  avatar_override: 0,

  timed: 1
};

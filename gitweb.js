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
    // Config File path is relative to the 'gitweb.cgi' file:
    GITWEB_CONFIG: 'gitweb_config.perl'
  };

  // Extend the 'env' with the user-defined config properties.
  for (var prop in config) {
    env['NODE_GITWEB_'+prop.toUpperCase()] = config[prop];
  }

  var handler = require('stack')(
    require('creationix/static')(mountPoint, __dirname + '/static'),
    require('cgi')(__dirname + '/gitweb.cgi', {
      mountPoint: mountPoint,
      env: env,
      stderr: process.stderr
    })
  );

  return function gitweb_handler(req, res, next) {
    if (!req.hasOwnProperty("uri")) { req.uri = url.parse(req.url); }
    var pathDir = path.dirname(req.uri.pathname);
    if (pathDir[pathDir.length-1] !== '/') pathDir += '/';
    if (pathDir !== mountPoint) return next();

    return handler.call(this, req, res);
  }
}
module.exports = gitweb;

// The default 'config' options to use.
gitweb.DEFAULTS = {
  projectroot: process.env.HOME,
  homelink: "My Projects",
  sitename: "GitWeb powered by Node",
  version: "1.7.1",
  max_depth: "100"
};

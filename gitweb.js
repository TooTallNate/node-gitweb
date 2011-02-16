/**
 * A NodeJS wrapper for the official GitWeb CGI script.
 */
var url = require('url');

module.exports = function gitweb(mountPoint, config) {
  if (typeof mountPoint !== 'string' || mountPoint[mountPoint.length-1] !== '/') {
    throw new Error("The 'mountPoint' must end with a slash '/'.");
  }

  config = config || {};

  var handler = require('stack')(
    require('creationix/static')(mountPoint, __dirname + '/static'),
    require('cgi')(__dirname + '/gitweb.cgi', {
      env: {
        GITWEB_CONFIG: __dirname + '/gitweb_config.perl'
      }
    })
  );

  return function gitweb(req, res, next) {
    if (!req.hasOwnProperty("uri")) { req.uri = url.parse(req.url); }
    if (req.uri.pathname !== mountPoint) return next();

    return handler.call(this, req, res);
  }
}

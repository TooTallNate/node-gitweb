require('http').createServer(
  require('stack')(
    // Simple logging
    require('creationix/log')(),

    // The 'GitWeb' layer requires a mount point, in which it and
    // it's necessary static files are served from.
    require('./gitweb')('/', {

      gitwebdir: process.env.HOME

    })
  )
).listen(3000);

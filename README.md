node-gitweb
===========
### Directly invoke and serve [GitWeb][] through [NodeJS][Node].


This module uses [node-cgi][] to invoke the `gitweb.cgi` perl file.


Example
-------

    var http = require('http');
    var gitweb = require('gitweb');

    http.createServer( gitweb('/') ).listen(80);

That's a very simple example.

It's recommended to pass a second argument, a `config` Object, that
can take the following parameters:

  * __projectroot__ - The root directory where git repos will be listed from. Default: `process.env.HOME`.
  * __max_depth__ - The number of directories deep from _projectroot_ that GitWeb should look for git repos. Default: `100`.
  * Lots More!!


[Node]: http://nodejs.org
[node-cgi]: https://github.com/TooTallNate/node-cgi
[GitWeb]: https://git.wiki.kernel.org/index.php/Gitweb

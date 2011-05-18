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

The first argument is the `mountPoint`. This is the HTTP url in which
GitWeb will be served from. It MUST start and end with a `/` slash character.

It's recommended to also pass a second argument, a `config` Object,
that can take the following parameters:

  * __projectroot__ - The root directory where git repos will be listed from. Default: `process.env.HOME`.
  * __homelink__ - The text of the link to the GitWeb root in the top-left corner of each page. Default: the value of __projectroot__.
  * __sitename__ - This value will be prefixed onto the `<title>` on each page. Default: `GitWeb powered by Node`.
  * __version__ - The version value of the internally used `gitweb.cgi` file. This can really just be any arbitrary String. Default: `1.7.1`.
  * __max_depth__ - The number of directories deep from _projectroot_ that GitWeb should look for git repos. Default: `100`.
  * __snapshot_default__ - The "snapshot" links are _off_ by default. If you would like to re-enable them, set this value to something like `tgz` or `zip`.


[Node]: http://nodejs.org
[node-cgi]: https://github.com/TooTallNate/node-cgi
[GitWeb]: https://git.wiki.kernel.org/index.php/Gitweb

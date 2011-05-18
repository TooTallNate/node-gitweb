# gitweb_config.perl
# 
# This is an example configuration file for simple, non-compiled deployments
# of Gitweb. It reads the necessary configuration from the $ENV, using acceptable
# default values when none is specified.
#   Modified from: http://joemaller.com/1596/faster-easier-gitweb-installation/


# * GIT_BINDIR
#   Points where to find the git executable.  You should set it up to
#   the place where the git binary was installed (usually /usr/bin) if you
#   don't install git from sources together with gitweb.  [Default: $(bindir)]

# First, extend PATH for any locally compiled Git binaries
$ENV{'PATH'} .= ":" . glob('~/bin');

our $GIT = $ENV{'NODE_GITWEB_GIT_BIN'} || `which git`;



# * GITWEB_PROJECTROOT
#   The root directory for all projects shown by gitweb. Must be set
#   correctly for gitweb to find repositories to display.  
# 
# The topmost path where all directory traversal starts from. Also used as
# root path for entries in $projects_list. Using glob() allows for tilde-
# expansion, if you need to hard-code a full path, just use a quoted string.

our $projectroot = $ENV{'NODE_GITWEB_PROJECTROOT'};



# * GITWEB_LIST
#   Points to a directory to scan for projects (defaults to project root
#   if not set / if empty) or to a file with explicit listing of projects
#   (together with projects' ownership). See "Generating projects list
#   using gitweb" in INSTALL file for gitweb to find out how to generate
#   such file from scan of a directory. [No default, which means use root
#   directory for projects]
# 
# address of the file containing a list of projects to display. Use this 
# instead of relying on directrory-traversal repository detection. The
# file is just a list of repositories, one per line formatted as:
# [path_to_repository] [owner]

our $projects_list = $ENV{'NODE_GITWEB_PROJECTSLIST'} || "";



# * GITWEB_CSS
#   Points to the location where you put gitweb.css on your web server
#   (or to be more generic, the URI of gitweb stylesheet).  Relative to the
#   base URI of gitweb.  Note that you can setup multiple stylesheets from
#   the gitweb config file.  [Default: gitweb.css]
# * GITWEB_LOGO
#   Points to the location where you put git-logo.png on your web server
#   (or to be more generic URI of logo, 72x27 size, displayed in top right
#   corner of each gitweb page, and used as logo for Atom feed).  Relative
#   to base URI of gitweb.  [Default: git-logo.png]
# * GITWEB_FAVICON
#   Points to the location where you put git-favicon.png on your web server
#   (or to be more generic URI of favicon, assumed to be image/png type;
#   web browsers that support favicons (website icons) may display them
#   in the browser's URL bar and next to site name in bookmarks).  Relative
#   to base URI of gitweb.  [Default: git-favicon.png]
# * GITWEB_JS
#   Points to the location where you put gitweb.js on your web server
#   (or to be more generic URI of JavaScript code used by gitweb).
#   Relative to base URI of gitweb.  [Default: gitweb.js]
# 
# CSS files display in array order, so customizations can be added easily 
# without having to modify any core files.

our @stylesheets = ( $ENV{'NODE_GITWEB_STYLESHEET_PATH'} || "gitweb.css");
our $logo = $ENV{'NODE_GITWEB_LOGO_PATH'} || "git-logo.png";
our $favicon = $ENV{'NODE_GITWEB_FAVICON_PATH'} || "git-favicon.png";
our $javascript = $ENV{'NODE_GITWEB_JAVASCRIPT_PATH'} || "gitweb.js";



# * GITWEB_HOME_LINK_STR
#   String of the home link on top of all pages, leading to $home_link
#   (usually main gitweb page, which means projects list).  Used as first
#   part of gitweb view "breadcrumb trail": <home> / <project> / <view>.

our $home_link_str = $ENV{'NODE_GITWEB_HOMELINK'};



# * GITWEB_SITENAME
#   Shown in the title of all generated pages, defaults to the server name
#   (SERVER_NAME CGI environment variable) if not set. [No default]
# * GITWEB_SITENAME
#   Name of your site or organization to appear in page titles.  Set it
#   to something descriptive for clearer bookmarks etc.  If not set
#   (if empty) gitweb uses "$SERVER_NAME Git", or "Untitled Git" if
#   SERVER_NAME CGI environment variable is not set (e.g. if running
#   gitweb as standalone script).  [No default]

our $site_name = $ENV{'NODE_GITWEB_SITENAME'};



# * GITWEB_SITE_HEADER
#   Filename of html text to include at top of each page.  Relative to
#   gitweb.cgi script.  [No default]
# * GITWEB_HOMETEXT
#   Points to an .html file which is included on the gitweb project
#   overview page ('projects_list' view), if it exists.  Relative to
#   gitweb.cgi script.  [Default: indextext.html]
# * GITWEB_SITE_FOOTER
#   Filename of html text to include at bottom of each page.  Relative to
#   gitweb.cgi script.  [No default]
# 
# These values specify files relative to gitweb.cgi. Path traversal works and
# thankfully doesn't appear to be able to climb above the web root.
# 
# The file specified in $home_text only appears on the top-level projects 
# listing page, inserted just below the topmost Gitweb navigation in a div with
# class "index_include". $site_header is inserted immediately after the opening
# body tag, $site_footer is inserted prior to the closing body tag, just before
# the page's script tag.

our $site_header = "site_header.txt";
our $home_text = "indextext.html";
our $site_footer = "site_footer.html";



# Version is intended to be the git source version Gitweb was installed from.
# Though the string is completely arbitrary, it's a good idea to copy the 
# downloaded version number so maintenance is easier somewhere down the road.
# The version number is inserted into an HTML comment and meta tag at the top
# of every Gitweb page.

our $version = $ENV{'NODE_GITWEB_VERSION'};





# Make gitweb use an alternative format of the URLs which can be
# more readable and natural-looking: project name is embedded
# directly in the path and the query string contains other
# auxiliary information. All gitweb installations recognize
# URL in either format; this configures in which formats gitweb
# generates links.

# To enable system wide have in $GITWEB_CONFIG
# $feature{'pathinfo'}{'default'} = [1];
# Project specific override is not supported.

# Note that you will need to change the default location of CSS,
# favicon, logo and possibly other files to an absolute URL. Also,
# if gitweb.cgi serves as your indexfile, you will need to force
# $my_uri to contain the script name in your $GITWEB_CONFIG.

$feature{'pathinfo'}{'default'} = [ $ENV{'NODE_GITWEB_PATHINFO'} ];




# Snapshot links seem largely unncessary. In most cases, anyone who needs a
# snapshot from a particular commit can just clone the repository and checkout
# whatever specific revision they want. From line 263, disable snapshot links:

if ($ENV{'NODE_GITWEB_SNAPSHOT_DEFAULT'}) {
  $feature{'snapshot'}{'default'} = [ $ENV{'NODE_GITWEB_SNAPSHOT_DEFAULT'} ];
} else {
  $feature{'snapshot'}{'default'} = [ ];
}


# Avatar support. When this feature is enabled, views such as
# shortlog or commit will display an avatar associated with
# the email of the committer(s) and/or author(s).
  
# Currently available providers are gravatar and picon.
# If an unknown provider is specified, the feature is disabled.

# Gravatar depends on Digest::MD5.
# Picon currently relies on the indiana.edu database.

# To enable system wide have in $GITWEB_CONFIG
# $feature{'avatar'}{'default'} = ['<provider>'];
# where <provider> is either gravatar or picon.
# To have project specific config enable override in $GITWEB_CONFIG
# $feature{'avatar'}{'override'} = 1;
# and in project config gitweb.avatar = <provider>;


$feature{'avatar'}{'override'} = $ENV{'NODE_GITWEB_AVATAR_OVERRIDE'};
$feature{'avatar'}{'default'} = [ $ENV{'NODE_GITWEB_AVATAR_DEFAULT'} ];





# Enable displaying how much time and how many git commands
# it took to generate and display page.  Disabled by default.   
# Project specific override is not supported.

$feature{'timed'}{'default'} = [ $ENV{'NODE_GITWEB_TIMED'} ];





# "the width (in characters) of the projects list "Description" column"
# This only affects the top-most projects page. I haven't found an option for
# changing the width of project summary listings. [Default: 25]

our $projects_list_description_width = 45;




# * GITWEB_PROJECT_MAXDEPTH
#   The filesystem traversing limit for getting the project list; the number
#   is taken as depth relative to the projectroot.  It is used when
#   GITWEB_LIST is a directory (or is not set; then project root is used).
#   Is is meant to speed up project listing on large work trees by limiting
#   search depth.  [Default: 2007]

our $project_maxdepth = int($ENV{'NODE_GITWEB_MAX_DEPTH'});



# * GITWEB_EXPORT_OK
#   Show repository only if this file exists (in repository).  Only
#   effective if this variable evaluates to true.  [No default / Not set]

our $export_ok = "";



# * GITWEB_STRICT_EXPORT
#   Only allow viewing of repositories also shown on the overview page.
#   This for example makes GITWEB_EXPORT_OK to decide if repository is
#   available and not only if it is shown.  If GITWEB_LIST points to
#   file with list of project, only those repositories listed would be
#   available for gitweb.  [No default]
# 
# This one plugs what seems to me to be a security hole where any git url
# could be displayed. Set this to true to limit display to items in 
# $projects_list. Perl doesn't have True/False keywords, I used "True" 
# for readability.

our $strict_export = "True";



# * GITWEB_BASE_URL
#   Git base URLs used for URL to where fetch project from, i.e. full
#   URL is "$git_base_url/$project".  Shown on projects summary page.
#   Repository URL for project can be also configured per repository; this
#   takes precedence over URLs composed from base URL and a project name.
#   Note that you can setup multiple base URLs (for example one for
#   git:// protocol access, another for http:// access) from the gitweb
#   config file.  [No default]
# Very powerful, probably rarely used, just blank the array:

our @git_base_url_list = ("");



# If Git's path was automatically detected, $GIT will have a trailing newline
# which needs to be removed. Chomp() is down here so as not to clutter up the
# rest of the script. Processing cost is negligent, it's probably not woth the 
# trouble of commenting this out.

chomp($GIT);

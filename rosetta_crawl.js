(function() {
  var BLACKLIST, HOST, LANGUAGE, LANGUAGE_PAGES_SELECTOR, LANGUAGE_WEBSITE, LANG_SELECTOR, PAGE_INTRO, ROSETTA_INTRO, color_syntax, dom_to_text, fix_tabs, html_decode, htmlparser, http, process_language_page, process_list, process_page, process_task_page, soupselect, wget;
  soupselect = require('soupselect');
  htmlparser = require('htmlparser');
  LANGUAGE = 'CoffeeScript';
  LANGUAGE_WEBSITE = "http://coffeescript.org";
  LANG_SELECTOR = 'pre.coffeescript.highlighted_source';
  BLACKLIST = function(title) {
    if (title === '24 game' || title === '100 doors' || title === 'A+B' || title === 'Comments' || title === 'CSV to HTML translation' || title === 'Empty program' || title === 'First-class functions' || title === 'Infinity' || title === 'Permutations' || title === 'Quine') {
      return true;
    }
    if (title.match(/Hello world/)) {
      return true;
    }
    if (title.match(/Loops\//)) {
      return true;
    }
    if (title.match(/Vigen.* cipher/)) {
      return true;
    }
    return false;
  };
  ROSETTA_INTRO = "<p>\nThis site aggregates some content from <a href=\"http://rosettacode.org\">Rosetta Code</a>, which is a website\nthat presents solutions to programming tasks in many different languages.\n</p>\n\n<p>\nIn particular, we focus on the <a href=\"" + LANGUAGE_WEBSITE + "\">" + LANGUAGE + "</a> programming language.  \nMost of the content here was originally posted on Rosetta Code, and this content remains licensed under the \n<a href=\"http://www.gnu.org/licenses/fdl-1.2.html\">GNU Free Documentation Licence version 1.2</a>.\n</p>\n\n<p>\nYou can see the code used for crawling Rosetta by\nfollowing <a href=\"https://github.com/showell/InterviewPrep/blob/master/rosetta_crawl.coffee\">this link</a>.\n</p>\n\n<p>\nBe a contributor!  You can enhance the Rosetta Code site by \n<a href=\"http://rosettacode.org/wiki/Reports:Tasks_not_implemented_in_" + LANGUAGE + "\">\nimplementing new tasks for " + LANGUAGE + "</a>.\n</p>";
  PAGE_INTRO = "<head>\n<title>" + LANGUAGE + " Examples from Rosetta Code</title>\n<link rel=\"stylesheet\" media=\"all\" href=\"docco.css\" />\n<style>\n  body {\n    margin-left: 50px;\n  }\n  p {\n    width: 500px;\n  }\n  pre.code {\n    margin-left: 30px;\n  }\n</style>\n</head>\n" + ROSETTA_INTRO;
  LANGUAGE_PAGES_SELECTOR = "#mw-pages li a";
  HOST = 'rosettacode.org';
  http = require('http');
  process_task_page = function(link_info, done) {
    var html, lang_link, page_link, path;
    path = link_info.href;
    page_link = "http://" + HOST + link_info.href;
    lang_link = "" + page_link + "#" + LANGUAGE;
    html = "<hr>\n<a name=\"" + link_info.title + "\" />\n<h2><a href=" + page_link + ">" + link_info.title + "</a></h2>\n<a href=" + lang_link + ">" + LANGUAGE + " section on Rosetta Code</a>\n<br>\n<a href=\"#" + link_info.title + "\">(local link)</a><br />";
    return process_page(path, function(err, dom) {
      var i, process_snippet, snippets;
      snippets = soupselect.select(dom, LANG_SELECTOR);
      i = 0;
      process_snippet = function(snippet, done) {
        var source;
        source = fix_tabs(dom_to_text(snippet));
        return color_syntax(source, function(code) {
          if (snippets.length > 1) {
            i += 1;
            html += "<h5>Example " + i + "</h5>";
          }
          html += "<pre class=\"code\">\n" + code + "\n</pre>";
          return done();
        });
      };
      return process_list(snippets, process_snippet, function() {
        return done("<div class='task'>" + html + "</div>");
      });
    });
  };
  process_language_page = function(done) {
    var handler, html;
    html = PAGE_INTRO;
    handler = function(err, dom) {
      var link, link_info, links, task_page_handler;
      links = soupselect.select(dom, LANGUAGE_PAGES_SELECTOR);
      link_info = function(link) {
        return {
          href: link.attribs.href,
          title: link.attribs.title
        };
      };
      links = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = links.length; _i < _len; _i++) {
          link = links[_i];
          _results.push(link_info(link));
        }
        return _results;
      })();
      links = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = links.length; _i < _len; _i++) {
          link = links[_i];
          if (!BLACKLIST(link.title)) {
            _results.push(link);
          }
        }
        return _results;
      })();
      task_page_handler = function(link_info, done) {
        return process_task_page(link_info, function(new_html) {
          html += new_html;
          return done();
        });
      };
      return process_list(links, task_page_handler, function() {
        console.log(html);
        return done();
      });
    };
    return process_page("/wiki/Category:" + LANGUAGE, handler);
  };
  process_page = function(path, cb) {
    return wget(path, function(body) {
      var handler, parser;
      handler = new htmlparser.DefaultHandler(cb);
      parser = new htmlparser.Parser(handler);
      return parser.parseComplete(body);
    });
  };
  process_list = function(list, f, done_cb) {
    var i, _process;
    i = 0;
    _process = function() {
      if (i < list.length) {
        return f(list[i], function() {
          i += 1;
          return _process();
        });
      } else {
        return done_cb();
      }
    };
    return _process();
  };
  wget = function(path, cb) {
    var options, req;
    options = {
      host: HOST,
      path: path,
      headers: {
        "Cache-Control": "max-age=0"
      }
    };
    req = http.request(options, function(res) {
      var s;
      s = '';
      res.on('data', function(chunk) {
        return s += chunk;
      });
      return res.on('end', function() {
        return cb(s);
      });
    });
    return req.end();
  };
  color_syntax = function(source, callback) {
    var output, pygments, spawn;
    spawn = require('child_process').spawn;
    pygments = spawn('pygmentize', ['-l', LANGUAGE.toLowerCase(), '-f', 'html', '-O', 'encoding=utf-8']);
    output = '';
    pygments.stderr.addListener('data', function(error) {
      if (error) {
        return console.error(error);
      }
    });
    pygments.stdout.addListener('data', function(result) {
      if (result) {
        return output += result;
      }
    });
    pygments.addListener('exit', function() {
      return callback(output);
    });
    pygments.stdin.write(source);
    return pygments.stdin.end();
  };
  dom_to_text = function(dom) {
    var child, s, _i, _len, _ref;
    if (dom.name === 'br') {
      return '\n';
    }
    s = '';
    if (dom.type === 'text') {
      s += dom.data;
    }
    if (dom.children) {
      _ref = dom.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        s += dom_to_text(child);
      }
    }
    return html_decode(s);
  };
  fix_tabs = function(s) {
    return s.replace("\t", "TABS, REALLY?");
  };
  html_decode = function(s) {
    s = s.replace(/&#(\d+);/g, function(a, b) {
      if (b === '160') {
        return ' ';
      }
      return String.fromCharCode(b);
    });
    return s = s.replace(/&(.*?);/g, function(a, b) {
      var map;
      map = {
        amp: '&',
        gt: '>',
        lt: '<',
        quot: '"'
      };
      return map[b] || ("UNKNOWN CHAR " + b);
    });
  };
  process_language_page(function() {});
}).call(this);

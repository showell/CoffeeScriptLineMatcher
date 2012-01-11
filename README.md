<h1>CS/JS Code Browser</h1>

This project lets you see CS and JS code side by side, with lines matched up.

<h2>Instructions</h2>

  1. Download: git clone git://github.com/showell/CoffeeScriptLineMatcher.git
  1. Find a directory that has .coffee and .js files in it.
  1. (There's an examples directory in this repo; just run "coffee -c *.coffee examples/*.coffee assets/*.coffee" to get js files.)
  1. Launch the web server, supplying the directory and port number as command line parameters.
  1. View your CS and JS code in the browser.
  
<h2>Example Usage</h2>
  
```
  /tmp > git clone git://github.com/showell/CoffeeScriptLineMatcher.git
  Cloning into CoffeeScriptLineMatcher...
  [snip...]
  
  /tmp > cd CoffeeScriptLineMatcher/
  
  /tmp/CoffeeScriptLineMatcher > coffee -c *.coffee examples/*.coffee assets/*.coffee
  
  /tmp/CoffeeScriptLineMatcher > coffee dashboard.coffee . 3000
  Server running at http://localhost:3000/
```
  

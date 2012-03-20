file_utils = require './file_utils'
{side_by_side} = require './side_by_side'
{source_line_mappings} = require './cs_js_source_mapping'
JQUERY_CDN = """
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
  """
  
head = ->
  console.log """
    <head>
      <title>CoffeeScriptLineMatcher -- static demo</title>
      <style>
        pre {
          font-size: 13px;
          padding: 4px;
        }

        .numbers {
          color: blue;
        }

        .code {
          overflow: auto;
        }

        p {
          width: 600px;
        }

        th {
          text-align: left;
        }
      </style>
      #{JQUERY_CDN}
      <script>
        $(function() {
          var $win, setPre;
          $win = $(window);
          setPre = function() {
            $('td').css({
              width: 50
            });
            return $('.code').css({
              width: ($win.width() - 185) * 0.50
            });
          };
          $win.resize(setPre);
          return setPre();
        })();
      </script>
    </head>
    """

generate_html = (js_fn, cs_fn) ->
  html = "<b>JS file</b>: #{js_fn}<br>" 
  coffee_lines = file_utils.file_lines(cs_fn)
  js_lines = file_utils.file_lines(js_fn)
  matches = source_line_mappings coffee_lines, js_lines
  html += side_by_side matches, coffee_lines, js_lines
  console.log html
  
do ->
  js_fn = 'dashboard.js'
  cs_fn = 'dashboard.coffee'
  head()
  generate_html js_fn, cs_fn
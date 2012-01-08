<style>
pre {
  font-size: 11px;
  padding: 4px;
}
</style>
<p>
This is a proof-of-concept of matching CS line numbers to JS
line numbers WITHOUT ANY COMPILER SUPPORT!
</p>
<p>
Line numbers are matched up by looking for matching tokens, with
a few heuristics for avoiding false matches between CS and JS, such
as ignoring JS var statements.
</p>

<table border=1><tr valign="top"><td><pre>cs:1
cs:2
cs:3
cs:4
cs:5
cs:6
cs:7
cs:8
cs:9
cs:10
cs:11
cs:12
cs:13
cs:14
cs:15
cs:16</pre></td><td><pre># **Underscore.coffee
# (c) 2011 Jeremy Ashkenas, DocumentCloud Inc.**
# Underscore is freely distributable under the terms of the
# [MIT license](http://en.wikipedia.org/wiki/MIT_License).
# Portions of Underscore are inspired by or borrowed from
# [Prototype.js](http://prototypejs.org/api), Oliver Steele's
# [Functional](http://osteele.com), and John Resig's
# [Micro-Templating](http://ejohn.org).
# For all details and documentation:
# http://documentcloud.github.com/underscore/


# Baseline setup
# --------------

# Establish the root object, `window` in the browser, or `global` on the server.</pre></td><td><pre>js:1
js:2
js:3</pre></td><td><pre>(function() {
  var ArrayProto, ObjProto, addToWrapper, breaker, escapeRegExp, hasOwnProperty, idCo
  var __hasProp = Object.prototype.hasOwnProperty;</pre></td></tr><tr valign="top"><td><pre>cs:17
cs:18
cs:19
cs:20</pre></td><td><pre>root = this


# Save the previous value of the `_` variable.</pre></td><td><pre>js:4</pre></td><td><pre>  root = this;</pre></td></tr><tr valign="top"><td><pre>cs:21
cs:22
cs:23
cs:24
cs:25</pre></td><td><pre>previousUnderscore = root._


# Establish the object that gets thrown to break out of a loop iteration.
# `StopIteration` is SOP on Mozilla.</pre></td><td><pre>js:5</pre></td><td><pre>  previousUnderscore = root._;</pre></td></tr><tr valign="top"><td><pre>cs:26
cs:27
cs:28
cs:29</pre></td><td><pre>breaker = if typeof(StopIteration) is 'undefined' then '__break__' else StopIteration


# Helper function to escape **RegExp** contents, because JS doesn't have one.</pre></td><td><pre>js:6</pre></td><td><pre>  breaker = typeof StopIteration === 'undefined' ? '__break__' : StopIteration;</pre></td></tr><tr valign="top"><td><pre>cs:30
cs:31
cs:32
cs:33</pre></td><td><pre>escapeRegExp = (string) -&gt; string.replace(/([.*+?^${}()|[\]\/\\])/g, '\\$1')


# Save bytes in the minified (but not gzipped) version:</pre></td><td><pre>js:7
js:8
js:9</pre></td><td><pre>  escapeRegExp = function(string) {
    return string.replace(/([.*+?^${}()|[\]\/\\])/g, '\\$1');
  };</pre></td></tr><tr valign="top"><td><pre>cs:34</pre></td><td><pre>ArrayProto           = Array.prototype</pre></td><td><pre>js:10</pre></td><td><pre>  ArrayProto = Array.prototype;</pre></td></tr><tr valign="top"><td><pre>cs:35
cs:36
cs:37
cs:38</pre></td><td><pre>ObjProto             = Object.prototype


# Create quick reference variables for speed access to core prototypes.</pre></td><td><pre>js:11</pre></td><td><pre>  ObjProto = Object.prototype;</pre></td></tr><tr valign="top"><td><pre>cs:39</pre></td><td><pre>slice                = ArrayProto.slice</pre></td><td><pre>js:12</pre></td><td><pre>  slice = ArrayProto.slice;</pre></td></tr><tr valign="top"><td><pre>cs:40</pre></td><td><pre>unshift              = ArrayProto.unshift</pre></td><td><pre>js:13</pre></td><td><pre>  unshift = ArrayProto.unshift;</pre></td></tr><tr valign="top"><td><pre>cs:41</pre></td><td><pre>toString             = ObjProto.toString</pre></td><td><pre>js:14</pre></td><td><pre>  toString = ObjProto.toString;</pre></td></tr><tr valign="top"><td><pre>cs:42</pre></td><td><pre>hasOwnProperty       = ObjProto.hasOwnProperty</pre></td><td><pre>js:15</pre></td><td><pre>  hasOwnProperty = ObjProto.hasOwnProperty;</pre></td></tr><tr valign="top"><td><pre>cs:43
cs:44
cs:45
cs:46</pre></td><td><pre>propertyIsEnumerable = ObjProto.propertyIsEnumerable


# All **ECMA5** native implementations we hope to use are declared here.</pre></td><td><pre>js:16</pre></td><td><pre>  propertyIsEnumerable = ObjProto.propertyIsEnumerable;</pre></td></tr><tr valign="top"><td><pre>cs:47</pre></td><td><pre>nativeForEach        = ArrayProto.forEach</pre></td><td><pre>js:17</pre></td><td><pre>  nativeForEach = ArrayProto.forEach;</pre></td></tr><tr valign="top"><td><pre>cs:48</pre></td><td><pre>nativeMap            = ArrayProto.map</pre></td><td><pre>js:18</pre></td><td><pre>  nativeMap = ArrayProto.map;</pre></td></tr><tr valign="top"><td><pre>cs:49</pre></td><td><pre>nativeReduce         = ArrayProto.reduce</pre></td><td><pre>js:19</pre></td><td><pre>  nativeReduce = ArrayProto.reduce;</pre></td></tr><tr valign="top"><td><pre>cs:50</pre></td><td><pre>nativeReduceRight    = ArrayProto.reduceRight</pre></td><td><pre>js:20</pre></td><td><pre>  nativeReduceRight = ArrayProto.reduceRight;</pre></td></tr><tr valign="top"><td><pre>cs:51</pre></td><td><pre>nativeFilter         = ArrayProto.filter</pre></td><td><pre>js:21</pre></td><td><pre>  nativeFilter = ArrayProto.filter;</pre></td></tr><tr valign="top"><td><pre>cs:52</pre></td><td><pre>nativeEvery          = ArrayProto.every</pre></td><td><pre>js:22</pre></td><td><pre>  nativeEvery = ArrayProto.every;</pre></td></tr><tr valign="top"><td><pre>cs:53</pre></td><td><pre>nativeSome           = ArrayProto.some</pre></td><td><pre>js:23</pre></td><td><pre>  nativeSome = ArrayProto.some;</pre></td></tr><tr valign="top"><td><pre>cs:54</pre></td><td><pre>nativeIndexOf        = ArrayProto.indexOf</pre></td><td><pre>js:24</pre></td><td><pre>  nativeIndexOf = ArrayProto.indexOf;</pre></td></tr><tr valign="top"><td><pre>cs:55</pre></td><td><pre>nativeLastIndexOf    = ArrayProto.lastIndexOf</pre></td><td><pre>js:25</pre></td><td><pre>  nativeLastIndexOf = ArrayProto.lastIndexOf;</pre></td></tr><tr valign="top"><td><pre>cs:56</pre></td><td><pre>nativeIsArray        = Array.isArray</pre></td><td><pre>js:26</pre></td><td><pre>  nativeIsArray = Array.isArray;</pre></td></tr><tr valign="top"><td><pre>cs:57
cs:58
cs:59
cs:60</pre></td><td><pre>nativeKeys           = Object.keys


# Create a safe reference to the Underscore object for use below.</pre></td><td><pre>js:27</pre></td><td><pre>  nativeKeys = Object.keys;</pre></td></tr><tr valign="top"><td><pre>cs:61
cs:62
cs:63
cs:64</pre></td><td><pre>_ = (obj) -&gt; new wrapper(obj)


# Export the Underscore object for **CommonJS**.</pre></td><td><pre>js:28
js:29
js:30</pre></td><td><pre>  _ = function(obj) {
    return new wrapper(obj);
  };</pre></td></tr><tr valign="top"><td><pre>cs:65
cs:66
cs:67
cs:68</pre></td><td><pre>if typeof(exports) != 'undefined' then exports._ = _


# Export Underscore to global scope.</pre></td><td><pre>js:31
js:32
js:33</pre></td><td><pre>  if (typeof exports !== 'undefined') {
    exports._ = _;
  }</pre></td></tr><tr valign="top"><td><pre>cs:69
cs:70
cs:71
cs:72</pre></td><td><pre>root._ = _


# Current version.</pre></td><td><pre>js:34</pre></td><td><pre>  root._ = _;</pre></td></tr><tr valign="top"><td><pre>cs:73
cs:74
cs:75
cs:76
cs:77
cs:78
cs:79
cs:80</pre></td><td><pre>_.VERSION = '1.1.0'


# Collection Functions
# --------------------

# The cornerstone, an **each** implementation.
# Handles objects implementing **forEach**, arrays, and raw objects.</pre></td><td><pre>js:35</pre></td><td><pre>  _.VERSION = '1.1.0';</pre></td></tr><tr valign="top"><td><pre>cs:81</pre></td><td><pre>_.each = (obj, iterator, context) -&gt;</pre></td><td><pre>js:36
js:37</pre></td><td><pre>  _.each = function(obj, iterator, context) {
    var i, key, val, _ref;</pre></td></tr><tr valign="top"><td><pre>cs:82</pre></td><td><pre>  try</pre></td><td><pre>js:38</pre></td><td><pre>    try {</pre></td></tr><tr valign="top"><td><pre>cs:83</pre></td><td><pre>    if nativeForEach and obj.forEach is nativeForEach</pre></td><td><pre>js:39</pre></td><td><pre>      if (nativeForEach &amp;&amp; obj.forEach === nativeForEach) {</pre></td></tr><tr valign="top"><td><pre>cs:84</pre></td><td><pre>      obj.forEach iterator, context</pre></td><td><pre>js:40</pre></td><td><pre>        obj.forEach(iterator, context);</pre></td></tr><tr valign="top"><td><pre>cs:85</pre></td><td><pre>    else if _.isNumber obj.length</pre></td><td><pre>js:41
js:42</pre></td><td><pre>      } else if (_.isNumber(obj.length)) {
        for (i = 0, _ref = obj.length; 0 &lt;= _ref ? i &lt; _ref : i &gt; _ref; 0 &lt;= _ref ? i</pre></td></tr><tr valign="top"><td><pre>cs:86
cs:87</pre></td><td><pre>      iterator.call context, obj[i], i, obj for i in [0...obj.length]
    else</pre></td><td><pre>js:43
js:44
js:45</pre></td><td><pre>          iterator.call(context, obj[i], i, obj);
        }
      } else {</pre></td></tr><tr valign="top"><td><pre>cs:88</pre></td><td><pre>      iterator.call context, val, key, obj  for own key, val of obj</pre></td><td><pre>js:46
js:47
js:48
js:49
js:50
js:51</pre></td><td><pre>        for (key in obj) {
          if (!__hasProp.call(obj, key)) continue;
          val = obj[key];
          iterator.call(context, val, key, obj);
        }
      }</pre></td></tr><tr valign="top"><td><pre>cs:89</pre></td><td><pre>  catch e</pre></td><td><pre>js:52</pre></td><td><pre>    } catch (e) {</pre></td></tr><tr valign="top"><td><pre>cs:90</pre></td><td><pre>    throw e if e isnt breaker</pre></td><td><pre>js:53
js:54
js:55
js:56</pre></td><td><pre>      if (e !== breaker) {
        throw e;
      }
    }</pre></td></tr><tr valign="top"><td><pre>cs:91
cs:92
cs:93
cs:94
cs:95</pre></td><td><pre>  obj


# Return the results of applying the iterator to each element. Use JavaScript
# 1.6's version of **map**, if possible.</pre></td><td><pre>js:57
js:58</pre></td><td><pre>    return obj;
  };</pre></td></tr><tr valign="top"><td><pre>cs:96</pre></td><td><pre>_.map = (obj, iterator, context) -&gt;</pre></td><td><pre>js:59
js:60</pre></td><td><pre>  _.map = function(obj, iterator, context) {
    var results;</pre></td></tr><tr valign="top"><td><pre>cs:97</pre></td><td><pre>  return obj.map(iterator, context) if nativeMap and obj.map is nativeMap</pre></td><td><pre>js:61
js:62
js:63</pre></td><td><pre>    if (nativeMap &amp;&amp; obj.map === nativeMap) {
      return obj.map(iterator, context);
    }</pre></td></tr><tr valign="top"><td><pre>cs:98</pre></td><td><pre>  results = []</pre></td><td><pre>js:64</pre></td><td><pre>    results = [];</pre></td></tr><tr valign="top"><td><pre>cs:99</pre></td><td><pre>  _.each obj, (value, index, list) -&gt;</pre></td><td><pre>js:65</pre></td><td><pre>    _.each(obj, function(value, index, list) {</pre></td></tr><tr valign="top"><td><pre>cs:100
cs:101
cs:102
cs:103
cs:104
cs:105</pre></td><td><pre>    results.push iterator.call context, value, index, list
  results


# **Reduce** builds up a single result from a list of values. Also known as
# **inject**, or **foldl**. Uses JavaScript 1.8's version of **reduce**, if possible.</pre></td><td><pre>js:66
js:67
js:68
js:69</pre></td><td><pre>      return results.push(iterator.call(context, value, index, list));
    });
    return results;
  };</pre></td></tr><tr valign="top"><td><pre>cs:106</pre></td><td><pre>_.reduce = (obj, iterator, memo, context) -&gt;</pre></td><td><pre>js:70</pre></td><td><pre>  _.reduce = function(obj, iterator, memo, context) {</pre></td></tr><tr valign="top"><td><pre>cs:107</pre></td><td><pre>  if nativeReduce and obj.reduce is nativeReduce</pre></td><td><pre>js:71</pre></td><td><pre>    if (nativeReduce &amp;&amp; obj.reduce === nativeReduce) {</pre></td></tr><tr valign="top"><td><pre>cs:108</pre></td><td><pre>    iterator = _.bind iterator, context if context</pre></td><td><pre>js:72</pre></td><td><pre>      if (context) {</pre></td></tr><tr valign="top"><td><pre>cs:109</pre></td><td><pre>    return obj.reduce iterator, memo</pre></td><td><pre>js:73
js:74</pre></td><td><pre>        iterator = _.bind(iterator, context);
      }</pre></td></tr><tr valign="top"><td><pre>cs:110</pre></td><td><pre>  _.each obj, (value, index, list) -&gt;</pre></td><td><pre>js:75
js:76</pre></td><td><pre>      return obj.reduce(iterator, memo);
    }</pre></td></tr><tr valign="top"><td><pre>cs:111</pre></td><td><pre>    memo = iterator.call context, memo, value, index, list</pre></td><td><pre>js:77</pre></td><td><pre>    _.each(obj, function(value, index, list) {</pre></td></tr><tr valign="top"><td><pre>cs:112
cs:113
cs:114
cs:115
cs:116</pre></td><td><pre>  memo


# The right-associative version of **reduce**, also known as **foldr**. Uses
# JavaScript 1.8's version of **reduceRight**, if available.</pre></td><td><pre>js:78
js:79
js:80
js:81</pre></td><td><pre>      return memo = iterator.call(context, memo, value, index, list);
    });
    return memo;
  };</pre></td></tr><tr valign="top"><td><pre>cs:117</pre></td><td><pre>_.reduceRight = (obj, iterator, memo, context) -&gt;</pre></td><td><pre>js:82
js:83</pre></td><td><pre>  _.reduceRight = function(obj, iterator, memo, context) {
    var reversed;</pre></td></tr><tr valign="top"><td><pre>cs:118</pre></td><td><pre>  if nativeReduceRight and obj.reduceRight is nativeReduceRight</pre></td><td><pre>js:84</pre></td><td><pre>    if (nativeReduceRight &amp;&amp; obj.reduceRight === nativeReduceRight) {</pre></td></tr><tr valign="top"><td><pre>cs:119</pre></td><td><pre>    iterator = _.bind iterator, context if context</pre></td><td><pre>js:85</pre></td><td><pre>      if (context) {</pre></td></tr><tr valign="top"><td><pre>cs:120</pre></td><td><pre>    return obj.reduceRight iterator, memo</pre></td><td><pre>js:86
js:87</pre></td><td><pre>        iterator = _.bind(iterator, context);
      }</pre></td></tr><tr valign="top"><td><pre>cs:121</pre></td><td><pre>  reversed = _.clone(_.toArray(obj)).reverse()</pre></td><td><pre>js:88
js:89</pre></td><td><pre>      return obj.reduceRight(iterator, memo);
    }</pre></td></tr><tr valign="top"><td><pre>cs:122
cs:123
cs:124
cs:125</pre></td><td><pre>  _.reduce reversed, iterator, memo, context


# Return the first value which passes a truth test.</pre></td><td><pre>js:90</pre></td><td><pre>    reversed = _.clone(_.toArray(obj)).reverse();</pre></td></tr><tr valign="top"><td><pre>cs:126</pre></td><td><pre>_.detect = (obj, iterator, context) -&gt;</pre></td><td><pre>js:91
js:92
js:93
js:94</pre></td><td><pre>    return _.reduce(reversed, iterator, memo, context);
  };
  _.detect = function(obj, iterator, context) {
    var result;</pre></td></tr><tr valign="top"><td><pre>cs:127</pre></td><td><pre>  result = null</pre></td><td><pre>js:95</pre></td><td><pre>    result = null;</pre></td></tr><tr valign="top"><td><pre>cs:128</pre></td><td><pre>  _.each obj, (value, index, list) -&gt;</pre></td><td><pre>js:96</pre></td><td><pre>    _.each(obj, function(value, index, list) {</pre></td></tr><tr valign="top"><td><pre>cs:129</pre></td><td><pre>    if iterator.call context, value, index, list</pre></td><td><pre>js:97</pre></td><td><pre>      if (iterator.call(context, value, index, list)) {</pre></td></tr><tr valign="top"><td><pre>cs:130</pre></td><td><pre>      result = value</pre></td><td><pre>js:98</pre></td><td><pre>        result = value;</pre></td></tr><tr valign="top"><td><pre>cs:131</pre></td><td><pre>      _.breakLoop()</pre></td><td><pre>js:99
js:100
js:101</pre></td><td><pre>        return _.breakLoop();
      }
    });</pre></td></tr><tr valign="top"><td><pre>cs:132
cs:133
cs:134
cs:135
cs:136</pre></td><td><pre>  result


# Return all the elements that pass a truth test. Use JavaScript 1.6's
# **filter**, if it exists.</pre></td><td><pre>js:102
js:103</pre></td><td><pre>    return result;
  };</pre></td></tr><tr valign="top"><td><pre>cs:137</pre></td><td><pre>_.filter = (obj, iterator, context) -&gt;</pre></td><td><pre>js:104
js:105</pre></td><td><pre>  _.filter = function(obj, iterator, context) {
    var results;</pre></td></tr><tr valign="top"><td><pre>cs:138</pre></td><td><pre>  return obj.filter iterator, context if nativeFilter and obj.filter is nativeFilter</pre></td><td><pre>js:106
js:107
js:108</pre></td><td><pre>    if (nativeFilter &amp;&amp; obj.filter === nativeFilter) {
      return obj.filter(iterator, context);
    }</pre></td></tr><tr valign="top"><td><pre>cs:139</pre></td><td><pre>  results = []</pre></td><td><pre>js:109</pre></td><td><pre>    results = [];</pre></td></tr><tr valign="top"><td><pre>cs:140</pre></td><td><pre>  _.each obj, (value, index, list) -&gt;</pre></td><td><pre>js:110</pre></td><td><pre>    _.each(obj, function(value, index, list) {</pre></td></tr><tr valign="top"><td><pre>cs:141</pre></td><td><pre>    results.push value if iterator.call context, value, index, list</pre></td><td><pre>js:111</pre></td><td><pre>      if (iterator.call(context, value, index, list)) {</pre></td></tr><tr valign="top"><td><pre>cs:142
cs:143
cs:144
cs:145</pre></td><td><pre>  results


# Return all the elements for which a truth test fails.</pre></td><td><pre>js:112
js:113
js:114
js:115
js:116</pre></td><td><pre>        return results.push(value);
      }
    });
    return results;
  };</pre></td></tr><tr valign="top"><td><pre>cs:146</pre></td><td><pre>_.reject = (obj, iterator, context) -&gt;</pre></td><td><pre>js:117
js:118</pre></td><td><pre>  _.reject = function(obj, iterator, context) {
    var results;</pre></td></tr><tr valign="top"><td><pre>cs:147</pre></td><td><pre>  results = []</pre></td><td><pre>js:119</pre></td><td><pre>    results = [];</pre></td></tr><tr valign="top"><td><pre>cs:148</pre></td><td><pre>  _.each obj, (value, index, list) -&gt;</pre></td><td><pre>js:120</pre></td><td><pre>    _.each(obj, function(value, index, list) {</pre></td></tr><tr valign="top"><td><pre>cs:149</pre></td><td><pre>    results.push value if not iterator.call context, value, index, list</pre></td><td><pre>js:121</pre></td><td><pre>      if (!iterator.call(context, value, index, list)) {</pre></td></tr><tr valign="top"><td><pre>cs:150
cs:151
cs:152
cs:153
cs:154</pre></td><td><pre>  results


# Determine whether all of the elements match a truth test. Delegate to
# JavaScript 1.6's **every**, if it is present.</pre></td><td><pre>js:122
js:123
js:124
js:125
js:126</pre></td><td><pre>        return results.push(value);
      }
    });
    return results;
  };</pre></td></tr><tr valign="top"><td><pre>cs:155</pre></td><td><pre>_.every = (obj, iterator, context) -&gt;</pre></td><td><pre>js:127
js:128</pre></td><td><pre>  _.every = function(obj, iterator, context) {
    var result;</pre></td></tr><tr valign="top"><td><pre>cs:156</pre></td><td><pre>  iterator ||= _.identity</pre></td><td><pre>js:129</pre></td><td><pre>    iterator || (iterator = _.identity);</pre></td></tr><tr valign="top"><td><pre>cs:157</pre></td><td><pre>  return obj.every iterator, context if nativeEvery and obj.every is nativeEvery</pre></td><td><pre>js:130
js:131
js:132</pre></td><td><pre>    if (nativeEvery &amp;&amp; obj.every === nativeEvery) {
      return obj.every(iterator, context);
    }</pre></td></tr><tr valign="top"><td><pre>cs:158</pre></td><td><pre>  result = true</pre></td><td><pre>js:133</pre></td><td><pre>    result = true;</pre></td></tr><tr valign="top"><td><pre>cs:159</pre></td><td><pre>  _.each obj, (value, index, list) -&gt;</pre></td><td><pre>js:134</pre></td><td><pre>    _.each(obj, function(value, index, list) {</pre></td></tr><tr valign="top"><td><pre>cs:160
cs:161
cs:162
cs:163
cs:164
cs:165</pre></td><td><pre>    _.breakLoop() unless (result = result and iterator.call(context, value, index, li
  result


# Determine if at least one element in the object matches a truth test. Use
# JavaScript 1.6's **some**, if it exists.</pre></td><td><pre>js:135
js:136
js:137
js:138
js:139
js:140</pre></td><td><pre>      if (!(result = result &amp;&amp; iterator.call(context, value, index, list))) {
        return _.breakLoop();
      }
    });
    return result;
  };</pre></td></tr><tr valign="top"><td><pre>cs:166</pre></td><td><pre>_.some = (obj, iterator, context) -&gt;</pre></td><td><pre>js:141
js:142</pre></td><td><pre>  _.some = function(obj, iterator, context) {
    var result;</pre></td></tr><tr valign="top"><td><pre>cs:167</pre></td><td><pre>  iterator ||= _.identity</pre></td><td><pre>js:143</pre></td><td><pre>    iterator || (iterator = _.identity);</pre></td></tr><tr valign="top"><td><pre>cs:168</pre></td><td><pre>  return obj.some iterator, context if nativeSome and obj.some is nativeSome</pre></td><td><pre>js:144
js:145
js:146</pre></td><td><pre>    if (nativeSome &amp;&amp; obj.some === nativeSome) {
      return obj.some(iterator, context);
    }</pre></td></tr><tr valign="top"><td><pre>cs:169</pre></td><td><pre>  result = false</pre></td><td><pre>js:147</pre></td><td><pre>    result = false;</pre></td></tr><tr valign="top"><td><pre>cs:170</pre></td><td><pre>  _.each obj, (value, index, list) -&gt;</pre></td><td><pre>js:148</pre></td><td><pre>    _.each(obj, function(value, index, list) {</pre></td></tr><tr valign="top"><td><pre>cs:171
cs:172
cs:173
cs:174
cs:175
cs:176</pre></td><td><pre>    _.breakLoop() if (result = iterator.call(context, value, index, list))
  result


# Determine if a given value is included in the array or object,
# based on `===`.</pre></td><td><pre>js:149
js:150
js:151
js:152
js:153
js:154</pre></td><td><pre>      if ((result = iterator.call(context, value, index, list))) {
        return _.breakLoop();
      }
    });
    return result;
  };</pre></td></tr><tr valign="top"><td><pre>cs:177</pre></td><td><pre>_.include = (obj, target) -&gt;</pre></td><td><pre>js:155
js:156</pre></td><td><pre>  _.include = function(obj, target) {
    var key, val;</pre></td></tr><tr valign="top"><td><pre>cs:178</pre></td><td><pre>  return _.indexOf(obj, target) isnt -1 if nativeIndexOf and obj.indexOf is nativeInd</pre></td><td><pre>js:157</pre></td><td><pre>    if (nativeIndexOf &amp;&amp; obj.indexOf === nativeIndexOf) {</pre></td></tr><tr valign="top"><td><pre>cs:179
cs:180
cs:181
cs:182
cs:183</pre></td><td><pre>  return true for own key, val of obj when val is target
  false


# Invoke a method with arguments on every item in a collection.</pre></td><td><pre>js:158
js:159
js:160
js:161
js:162
js:163
js:164
js:165
js:166
js:167
js:168</pre></td><td><pre>      return _.indexOf(obj, target) !== -1;
    }
    for (key in obj) {
      if (!__hasProp.call(obj, key)) continue;
      val = obj[key];
      if (val === target) {
        return true;
      }
    }
    return false;
  };</pre></td></tr><tr valign="top"><td><pre>cs:184</pre></td><td><pre>_.invoke = (obj, method) -&gt;</pre></td><td><pre>js:169
js:170</pre></td><td><pre>  _.invoke = function(obj, method) {
    var args, val, _i, _len, _results;</pre></td></tr><tr valign="top"><td><pre>cs:185</pre></td><td><pre>  args = _.rest arguments, 2</pre></td><td><pre>js:171
js:172</pre></td><td><pre>    args = _.rest(arguments, 2);
    _results = [];</pre></td></tr><tr valign="top"><td><pre>cs:186
cs:187
cs:188
cs:189</pre></td><td><pre>  (if method then val[method] else val).apply(val, args) for val in obj


# Convenience version of a common use case of **map**: fetching a property.</pre></td><td><pre>js:173
js:174
js:175
js:176
js:177
js:178</pre></td><td><pre>    for (_i = 0, _len = obj.length; _i &lt; _len; _i++) {
      val = obj[_i];
      _results.push((method ? val[method] : val).apply(val, args));
    }
    return _results;
  };</pre></td></tr><tr valign="top"><td><pre>cs:190</pre></td><td><pre>_.pluck = (obj, key) -&gt;</pre></td><td><pre>js:179</pre></td><td><pre>  _.pluck = function(obj, key) {</pre></td></tr><tr valign="top"><td><pre>cs:191
cs:192
cs:193
cs:194</pre></td><td><pre>  _.map(obj, (val) -&gt; val[key])


# Return the maximum item or (item-based computation).</pre></td><td><pre>js:180
js:181
js:182
js:183</pre></td><td><pre>    return _.map(obj, function(val) {
      return val[key];
    });
  };</pre></td></tr><tr valign="top"><td><pre>cs:195</pre></td><td><pre>_.max = (obj, iterator, context) -&gt;</pre></td><td><pre>js:184
js:185</pre></td><td><pre>  _.max = function(obj, iterator, context) {
    var result;</pre></td></tr><tr valign="top"><td><pre>cs:196</pre></td><td><pre>  return Math.max.apply(Math, obj) if not iterator and _.isArray(obj)</pre></td><td><pre>js:186
js:187
js:188</pre></td><td><pre>    if (!iterator &amp;&amp; _.isArray(obj)) {
      return Math.max.apply(Math, obj);
    }</pre></td></tr><tr valign="top"><td><pre>cs:197</pre></td><td><pre>  result = computed: -Infinity</pre></td><td><pre>js:189
js:190
js:191</pre></td><td><pre>    result = {
      computed: -Infinity
    };</pre></td></tr><tr valign="top"><td><pre>cs:198</pre></td><td><pre>  _.each obj, (value, index, list) -&gt;</pre></td><td><pre>js:192
js:193</pre></td><td><pre>    _.each(obj, function(value, index, list) {
      var computed;</pre></td></tr><tr valign="top"><td><pre>cs:199</pre></td><td><pre>    computed = if iterator then iterator.call(context, value, index, list) else value</pre></td><td><pre>js:194</pre></td><td><pre>      computed = iterator ? iterator.call(context, value, index, list) : value;</pre></td></tr><tr valign="top"><td><pre>cs:200</pre></td><td><pre>    computed &gt;= result.computed and (result = {value: value, computed: computed})</pre></td><td><pre>js:195</pre></td><td><pre>      return computed &gt;= result.computed &amp;&amp; (result = {</pre></td></tr><tr valign="top"><td><pre>cs:201
cs:202
cs:203
cs:204</pre></td><td><pre>  result.value


# Return the minimum element (or element-based computation).</pre></td><td><pre>js:196
js:197
js:198
js:199
js:200
js:201</pre></td><td><pre>        value: value,
        computed: computed
      });
    });
    return result.value;
  };</pre></td></tr><tr valign="top"><td><pre>cs:205</pre></td><td><pre>_.min = (obj, iterator, context) -&gt;</pre></td><td><pre>js:202
js:203</pre></td><td><pre>  _.min = function(obj, iterator, context) {
    var result;</pre></td></tr><tr valign="top"><td><pre>cs:206</pre></td><td><pre>  return Math.min.apply(Math, obj) if not iterator and _.isArray(obj)</pre></td><td><pre>js:204
js:205
js:206</pre></td><td><pre>    if (!iterator &amp;&amp; _.isArray(obj)) {
      return Math.min.apply(Math, obj);
    }</pre></td></tr><tr valign="top"><td><pre>cs:207</pre></td><td><pre>  result = computed: Infinity</pre></td><td><pre>js:207
js:208
js:209</pre></td><td><pre>    result = {
      computed: Infinity
    };</pre></td></tr><tr valign="top"><td><pre>cs:208</pre></td><td><pre>  _.each obj, (value, index, list) -&gt;</pre></td><td><pre>js:210
js:211</pre></td><td><pre>    _.each(obj, function(value, index, list) {
      var computed;</pre></td></tr><tr valign="top"><td><pre>cs:209</pre></td><td><pre>    computed = if iterator then iterator.call(context, value, index, list) else value</pre></td><td><pre>js:212</pre></td><td><pre>      computed = iterator ? iterator.call(context, value, index, list) : value;</pre></td></tr><tr valign="top"><td><pre>cs:210</pre></td><td><pre>    computed &lt; result.computed and (result = {value: value, computed: computed})</pre></td><td><pre>js:213</pre></td><td><pre>      return computed &lt; result.computed &amp;&amp; (result = {</pre></td></tr><tr valign="top"><td><pre>cs:211
cs:212
cs:213
cs:214</pre></td><td><pre>  result.value


# Sort the object's values by a criterion produced by an iterator.</pre></td><td><pre>js:214
js:215
js:216
js:217
js:218
js:219</pre></td><td><pre>        value: value,
        computed: computed
      });
    });
    return result.value;
  };</pre></td></tr><tr valign="top"><td><pre>cs:215</pre></td><td><pre>_.sortBy = (obj, iterator, context) -&gt;</pre></td><td><pre>js:220</pre></td><td><pre>  _.sortBy = function(obj, iterator, context) {</pre></td></tr><tr valign="top"><td><pre>cs:216</pre></td><td><pre>  _.pluck(((_.map obj, (value, index, list) -&gt;</pre></td><td><pre>js:221
js:222
js:223</pre></td><td><pre>    return _.pluck((_.map(obj, function(value, index, list) {
      return {
        value: value,</pre></td></tr><tr valign="top"><td><pre>cs:217</pre></td><td><pre>    {value: value, criteria: iterator.call(context, value, index, list)}</pre></td><td><pre>js:224
js:225</pre></td><td><pre>        criteria: iterator.call(context, value, index, list)
      };</pre></td></tr><tr valign="top"><td><pre>cs:218</pre></td><td><pre>  ).sort((left, right) -&gt;</pre></td><td><pre>js:226
js:227</pre></td><td><pre>    })).sort(function(left, right) {
      var a, b;</pre></td></tr><tr valign="top"><td><pre>cs:219
cs:220</pre></td><td><pre>    a = left.criteria; b = right.criteria
    if a &lt; b then -1 else if a &gt; b then 1 else 0</pre></td><td><pre>js:228
js:229
js:230
js:231
js:232
js:233
js:234
js:235
js:236</pre></td><td><pre>      a = left.criteria;
      b = right.criteria;
      if (a &lt; b) {
        return -1;
      } else if (a &gt; b) {
        return 1;
      } else {
        return 0;
      }</pre></td></tr><tr valign="top"><td><pre>cs:221
cs:222
cs:223
cs:224
cs:225</pre></td><td><pre>  )), 'value')


# Use a comparator function to figure out at what index an object should
# be inserted so as to maintain order. Uses binary search.</pre></td><td><pre>js:237
js:238</pre></td><td><pre>    }), 'value');
  };</pre></td></tr><tr valign="top"><td><pre>cs:226</pre></td><td><pre>_.sortedIndex = (array, obj, iterator) -&gt;</pre></td><td><pre>js:239
js:240</pre></td><td><pre>  _.sortedIndex = function(array, obj, iterator) {
    var high, low, mid;</pre></td></tr><tr valign="top"><td><pre>cs:227</pre></td><td><pre>  iterator ||= _.identity</pre></td><td><pre>js:241</pre></td><td><pre>    iterator || (iterator = _.identity);</pre></td></tr><tr valign="top"><td><pre>cs:228</pre></td><td><pre>  low =  0</pre></td><td><pre>js:242</pre></td><td><pre>    low = 0;</pre></td></tr><tr valign="top"><td><pre>cs:229</pre></td><td><pre>  high = array.length</pre></td><td><pre>js:243</pre></td><td><pre>    high = array.length;</pre></td></tr><tr valign="top"><td><pre>cs:230</pre></td><td><pre>  while low &lt; high</pre></td><td><pre>js:244</pre></td><td><pre>    while (low &lt; high) {</pre></td></tr><tr valign="top"><td><pre>cs:231</pre></td><td><pre>    mid = (low + high) &gt;&gt; 1</pre></td><td><pre>js:245</pre></td><td><pre>      mid = (low + high) &gt;&gt; 1;</pre></td></tr><tr valign="top"><td><pre>cs:232</pre></td><td><pre>    if iterator(array[mid]) &lt; iterator(obj) then low = mid + 1 else high = mid</pre></td><td><pre>js:246</pre></td><td><pre>      if (iterator(array[mid]) &lt; iterator(obj)) {</pre></td></tr><tr valign="top"><td><pre>cs:233
cs:234
cs:235
cs:236</pre></td><td><pre>  low


# Convert anything iterable into a real, live array.</pre></td><td><pre>js:247
js:248
js:249
js:250
js:251
js:252
js:253</pre></td><td><pre>        low = mid + 1;
      } else {
        high = mid;
      }
    }
    return low;
  };</pre></td></tr><tr valign="top"><td><pre>cs:237
cs:238
cs:239</pre></td><td><pre>_.toArray = (iterable) -&gt;
  return []                   if (!iterable)
  return iterable.toArray()   if (iterable.toArray)</pre></td><td><pre>js:254
js:255
js:256
js:257
js:258
js:259
js:260</pre></td><td><pre>  _.toArray = function(iterable) {
    if (!iterable) {
      return [];
    }
    if (iterable.toArray) {
      return iterable.toArray();
    }</pre></td></tr><tr valign="top"><td><pre>cs:240</pre></td><td><pre>  return iterable             if (_.isArray(iterable))</pre></td><td><pre>js:261
js:262
js:263</pre></td><td><pre>    if (_.isArray(iterable)) {
      return iterable;
    }</pre></td></tr><tr valign="top"><td><pre>cs:241</pre></td><td><pre>  return slice.call(iterable) if (_.isArguments(iterable))</pre></td><td><pre>js:264
js:265
js:266</pre></td><td><pre>    if (_.isArguments(iterable)) {
      return slice.call(iterable);
    }</pre></td></tr><tr valign="top"><td><pre>cs:242
cs:243
cs:244
cs:245</pre></td><td><pre>  _.values(iterable)


# Return the number of elements in an object.</pre></td><td><pre>js:267
js:268</pre></td><td><pre>    return _.values(iterable);
  };</pre></td></tr><tr valign="top"><td><pre>cs:246
cs:247
cs:248
cs:249
cs:250
cs:251
cs:252
cs:253
cs:254</pre></td><td><pre>_.size = (obj) -&gt; _.toArray(obj).length


# Array Functions
# ---------------

# Get the first element of an array. Passing `n` will return the first N
# values in the array. Aliased as **head**. The `guard` check allows it to work
# with **map**.</pre></td><td><pre>js:269
js:270
js:271</pre></td><td><pre>  _.size = function(obj) {
    return _.toArray(obj).length;
  };</pre></td></tr><tr valign="top"><td><pre>cs:255</pre></td><td><pre>_.first = (array, n, guard) -&gt;</pre></td><td><pre>js:272
js:273</pre></td><td><pre>  _.first = function(array, n, guard) {
    if (n &amp;&amp; !guard) {</pre></td></tr><tr valign="top"><td><pre>cs:256
cs:257
cs:258
cs:259
cs:260
cs:261
cs:262</pre></td><td><pre>  if n and not guard then slice.call(array, 0, n) else array[0]


# Returns everything but the first entry of the array. Aliased as **tail**.
# Especially useful on the arguments object. Passing an `index` will return
# the rest of the values in the array from that index onward. The `guard`
# check allows it to work with **map**.</pre></td><td><pre>js:274
js:275
js:276
js:277
js:278</pre></td><td><pre>      return slice.call(array, 0, n);
    } else {
      return array[0];
    }
  };</pre></td></tr><tr valign="top"><td><pre>cs:263</pre></td><td><pre>_.rest = (array, index, guard) -&gt;</pre></td><td><pre>js:279</pre></td><td><pre>  _.rest = function(array, index, guard) {</pre></td></tr><tr valign="top"><td><pre>cs:264
cs:265
cs:266
cs:267</pre></td><td><pre>  slice.call(array, if _.isUndefined(index) or guard then 1 else index)


# Get the last element of an array.</pre></td><td><pre>js:280
js:281</pre></td><td><pre>    return slice.call(array, _.isUndefined(index) || guard ? 1 : index);
  };</pre></td></tr><tr valign="top"><td><pre>cs:268
cs:269
cs:270
cs:271</pre></td><td><pre>_.last = (array) -&gt; array[array.length - 1]


# Trim out all falsy values from an array.</pre></td><td><pre>js:282
js:283
js:284</pre></td><td><pre>  _.last = function(array) {
    return array[array.length - 1];
  };</pre></td></tr><tr valign="top"><td><pre>cs:272
cs:273
cs:274
cs:275</pre></td><td><pre>_.compact = (array) -&gt; item for item in array when item


# Return a completely flattened version of an array.</pre></td><td><pre>js:285
js:286
js:287
js:288
js:289
js:290
js:291
js:292
js:293
js:294
js:295</pre></td><td><pre>  _.compact = function(array) {
    var item, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = array.length; _i &lt; _len; _i++) {
      item = array[_i];
      if (item) {
        _results.push(item);
      }
    }
    return _results;
  };</pre></td></tr><tr valign="top"><td><pre>cs:276</pre></td><td><pre>_.flatten = (array) -&gt;</pre></td><td><pre>js:296</pre></td><td><pre>  _.flatten = function(array) {</pre></td></tr><tr valign="top"><td><pre>cs:277</pre></td><td><pre>  _.reduce array, (memo, value) -&gt;</pre></td><td><pre>js:297</pre></td><td><pre>    return _.reduce(array, function(memo, value) {</pre></td></tr><tr valign="top"><td><pre>cs:278</pre></td><td><pre>    return memo.concat(_.flatten(value)) if _.isArray value</pre></td><td><pre>js:298</pre></td><td><pre>      if (_.isArray(value)) {</pre></td></tr><tr valign="top"><td><pre>cs:279
cs:280
cs:281
cs:282
cs:283
cs:284</pre></td><td><pre>    memo.push value
    memo
  , []


# Return a version of the array that does not contain the specified value(s).</pre></td><td><pre>js:299
js:300
js:301
js:302
js:303
js:304</pre></td><td><pre>        return memo.concat(_.flatten(value));
      }
      memo.push(value);
      return memo;
    }, []);
  };</pre></td></tr><tr valign="top"><td><pre>cs:285</pre></td><td><pre>_.without = (array) -&gt;</pre></td><td><pre>js:305
js:306</pre></td><td><pre>  _.without = function(array) {
    var val, values, _i, _len, _ref, _results;</pre></td></tr><tr valign="top"><td><pre>cs:286</pre></td><td><pre>  values = _.rest arguments</pre></td><td><pre>js:307</pre></td><td><pre>    values = _.rest(arguments);</pre></td></tr><tr valign="top"><td><pre>cs:287
cs:288
cs:289
cs:290
cs:291</pre></td><td><pre>  val for val in _.toArray(array) when not _.include values, val


# Produce a duplicate-free version of the array. If the array has already
# been sorted, you have the option of using a faster algorithm.</pre></td><td><pre>js:308
js:309
js:310
js:311
js:312
js:313
js:314
js:315
js:316
js:317</pre></td><td><pre>    _ref = _.toArray(array);
    _results = [];
    for (_i = 0, _len = _ref.length; _i &lt; _len; _i++) {
      val = _ref[_i];
      if (!_.include(values, val)) {
        _results.push(val);
      }
    }
    return _results;
  };</pre></td></tr><tr valign="top"><td><pre>cs:292</pre></td><td><pre>_.uniq = (array, isSorted) -&gt;</pre></td><td><pre>js:318
js:319</pre></td><td><pre>  _.uniq = function(array, isSorted) {
    var el, i, memo, _len, _ref;</pre></td></tr><tr valign="top"><td><pre>cs:293</pre></td><td><pre>  memo = []</pre></td><td><pre>js:320</pre></td><td><pre>    memo = [];</pre></td></tr><tr valign="top"><td><pre>cs:294</pre></td><td><pre>  for el, i in _.toArray array</pre></td><td><pre>js:321
js:322
js:323</pre></td><td><pre>    _ref = _.toArray(array);
    for (i = 0, _len = _ref.length; i &lt; _len; i++) {
      el = _ref[i];</pre></td></tr><tr valign="top"><td><pre>cs:295
cs:296
cs:297
cs:298
cs:299
cs:300</pre></td><td><pre>    memo.push el if i is 0 || (if isSorted is true then _.last(memo) isnt el else not
  memo


# Produce an array that contains every item shared between all the
# passed-in arrays.</pre></td><td><pre>js:324
js:325
js:326
js:327
js:328
js:329</pre></td><td><pre>      if (i === 0 || (isSorted === true ? _.last(memo) !== el : !_.include(memo, el))
        memo.push(el);
      }
    }
    return memo;
  };</pre></td></tr><tr valign="top"><td><pre>cs:301</pre></td><td><pre>_.intersect = (array) -&gt;</pre></td><td><pre>js:330
js:331</pre></td><td><pre>  _.intersect = function(array) {
    var rest;</pre></td></tr><tr valign="top"><td><pre>cs:302</pre></td><td><pre>  rest = _.rest arguments</pre></td><td><pre>js:332</pre></td><td><pre>    rest = _.rest(arguments);</pre></td></tr><tr valign="top"><td><pre>cs:303</pre></td><td><pre>  _.select _.uniq(array), (item) -&gt;</pre></td><td><pre>js:333</pre></td><td><pre>    return _.select(_.uniq(array), function(item) {</pre></td></tr><tr valign="top"><td><pre>cs:304</pre></td><td><pre>    _.all rest, (other) -&gt;</pre></td><td><pre>js:334</pre></td><td><pre>      return _.all(rest, function(other) {</pre></td></tr><tr valign="top"><td><pre>cs:305
cs:306
cs:307
cs:308
cs:309</pre></td><td><pre>      _.indexOf(other, item) &gt;= 0


# Zip together multiple lists into a single array -- elements that share
# an index go together.</pre></td><td><pre>js:335
js:336
js:337
js:338</pre></td><td><pre>        return _.indexOf(other, item) &gt;= 0;
      });
    });
  };</pre></td></tr><tr valign="top"><td><pre>cs:310</pre></td><td><pre>_.zip = -&gt;</pre></td><td><pre>js:339
js:340</pre></td><td><pre>  _.zip = function() {
    var i, length, results;</pre></td></tr><tr valign="top"><td><pre>cs:311</pre></td><td><pre>  length =  _.max _.pluck arguments, 'length'</pre></td><td><pre>js:341</pre></td><td><pre>    length = _.max(_.pluck(arguments, 'length'));</pre></td></tr><tr valign="top"><td><pre>cs:312
cs:313</pre></td><td><pre>  results = new Array length
  for i in [0...length]</pre></td><td><pre>js:342
js:343</pre></td><td><pre>    results = new Array(length);
    for (i = 0; 0 &lt;= length ? i &lt; length : i &gt; length; 0 &lt;= length ? i++ : i--) {</pre></td></tr><tr valign="top"><td><pre>cs:314
cs:315
cs:316
cs:317
cs:318
cs:319
cs:320</pre></td><td><pre>    results[i] = _.pluck arguments, String i
  results


# If the browser doesn't supply us with **indexOf** (I'm looking at you, MSIE),
# we need this function. Return the position of the first occurrence of an
# item in an array, or -1 if the item is not included in the array.</pre></td><td><pre>js:344
js:345
js:346
js:347</pre></td><td><pre>      results[i] = _.pluck(arguments, String(i));
    }
    return results;
  };</pre></td></tr><tr valign="top"><td><pre>cs:321</pre></td><td><pre>_.indexOf = (array, item) -&gt;</pre></td><td><pre>js:348
js:349</pre></td><td><pre>  _.indexOf = function(array, item) {
    var i, l;</pre></td></tr><tr valign="top"><td><pre>cs:322</pre></td><td><pre>  return array.indexOf item if nativeIndexOf and array.indexOf is nativeIndexOf</pre></td><td><pre>js:350
js:351
js:352
js:353</pre></td><td><pre>    if (nativeIndexOf &amp;&amp; array.indexOf === nativeIndexOf) {
      return array.indexOf(item);
    }
    i = 0;</pre></td></tr><tr valign="top"><td><pre>cs:323</pre></td><td><pre>  i = 0; l = array.length</pre></td><td><pre>js:354</pre></td><td><pre>    l = array.length;</pre></td></tr><tr valign="top"><td><pre>cs:324</pre></td><td><pre>  while l - i</pre></td><td><pre>js:355</pre></td><td><pre>    while (l - i) {</pre></td></tr><tr valign="top"><td><pre>cs:325
cs:326
cs:327
cs:328
cs:329
cs:330</pre></td><td><pre>    if array[i] is item then return i else i++
  -1


# Provide JavaScript 1.6's **lastIndexOf**, delegating to the native function,
# if possible.</pre></td><td><pre>js:356
js:357
js:358
js:359
js:360
js:361
js:362
js:363</pre></td><td><pre>      if (array[i] === item) {
        return i;
      } else {
        i++;
      }
    }
    return -1;
  };</pre></td></tr><tr valign="top"><td><pre>cs:331</pre></td><td><pre>_.lastIndexOf = (array, item) -&gt;</pre></td><td><pre>js:364
js:365</pre></td><td><pre>  _.lastIndexOf = function(array, item) {
    var i;</pre></td></tr><tr valign="top"><td><pre>cs:332</pre></td><td><pre>  return array.lastIndexOf(item) if nativeLastIndexOf and array.lastIndexOf is native</pre></td><td><pre>js:366
js:367
js:368</pre></td><td><pre>    if (nativeLastIndexOf &amp;&amp; array.lastIndexOf === nativeLastIndexOf) {
      return array.lastIndexOf(item);
    }</pre></td></tr><tr valign="top"><td><pre>cs:333</pre></td><td><pre>  i = array.length</pre></td><td><pre>js:369</pre></td><td><pre>    i = array.length;</pre></td></tr><tr valign="top"><td><pre>cs:334</pre></td><td><pre>  while i</pre></td><td><pre>js:370</pre></td><td><pre>    while (i) {</pre></td></tr><tr valign="top"><td><pre>cs:335
cs:336
cs:337
cs:338
cs:339
cs:340</pre></td><td><pre>    if array[i] is item then return i else i--
  -1


# Generate an integer Array containing an arithmetic progression. A port of
# [the native Python **range** function](http://docs.python.org/library/functions.htm</pre></td><td><pre>js:371
js:372
js:373
js:374
js:375
js:376
js:377
js:378</pre></td><td><pre>      if (array[i] === item) {
        return i;
      } else {
        i--;
      }
    }
    return -1;
  };</pre></td></tr><tr valign="top"><td><pre>cs:341</pre></td><td><pre>_.range = (start, stop, step) -&gt;</pre></td><td><pre>js:379
js:380</pre></td><td><pre>  _.range = function(start, stop, step) {
    var a, i, idx, len, range, solo, _results;</pre></td></tr><tr valign="top"><td><pre>cs:342</pre></td><td><pre>  a         = arguments</pre></td><td><pre>js:381</pre></td><td><pre>    a = arguments;</pre></td></tr><tr valign="top"><td><pre>cs:343</pre></td><td><pre>  solo      = a.length &lt;= 1</pre></td><td><pre>js:382</pre></td><td><pre>    solo = a.length &lt;= 1;</pre></td></tr><tr valign="top"><td><pre>cs:344</pre></td><td><pre>  i = start = if solo then 0 else a[0]</pre></td><td><pre>js:383</pre></td><td><pre>    i = start = solo ? 0 : a[0];</pre></td></tr><tr valign="top"><td><pre>cs:345</pre></td><td><pre>  stop      = if solo then a[0] else a[1]</pre></td><td><pre>js:384</pre></td><td><pre>    stop = solo ? a[0] : a[1];</pre></td></tr><tr valign="top"><td><pre>cs:346</pre></td><td><pre>  step      = a[2] or 1</pre></td><td><pre>js:385</pre></td><td><pre>    step = a[2] || 1;</pre></td></tr><tr valign="top"><td><pre>cs:347
cs:348</pre></td><td><pre>  len       = Math.ceil((stop - start) / step)
  return []   if len &lt;= 0</pre></td><td><pre>js:386
js:387
js:388
js:389</pre></td><td><pre>    len = Math.ceil((stop - start) / step);
    if (len &lt;= 0) {
      return [];
    }</pre></td></tr><tr valign="top"><td><pre>cs:349</pre></td><td><pre>  range     = new Array len</pre></td><td><pre>js:390</pre></td><td><pre>    range = new Array(len);</pre></td></tr><tr valign="top"><td><pre>cs:350
cs:351</pre></td><td><pre>  idx       = 0
  loop</pre></td><td><pre>js:391
js:392
js:393</pre></td><td><pre>    idx = 0;
    _results = [];
    while (true) {</pre></td></tr><tr valign="top"><td><pre>cs:352</pre></td><td><pre>    return range if (if step &gt; 0 then i - stop else stop - i) &gt;= 0</pre></td><td><pre>js:394</pre></td><td><pre>      if ((step &gt; 0 ? i - stop : stop - i) &gt;= 0) {</pre></td></tr><tr valign="top"><td><pre>cs:353</pre></td><td><pre>    range[idx] = i</pre></td><td><pre>js:395
js:396</pre></td><td><pre>        return range;
      }</pre></td></tr><tr valign="top"><td><pre>cs:354</pre></td><td><pre>    idx++</pre></td><td><pre>js:397
js:398</pre></td><td><pre>      range[idx] = i;
      idx++;</pre></td></tr><tr valign="top"><td><pre>cs:355
cs:356
cs:357
cs:358
cs:359
cs:360
cs:361
cs:362</pre></td><td><pre>    i+= step


# Function Functions
# ------------------

# Create a function bound to a given object (assigning `this`, and arguments,
# optionally). Binding with arguments is also known as **curry**.</pre></td><td><pre>js:399
js:400
js:401
js:402</pre></td><td><pre>      _results.push(i += step);
    }
    return _results;
  };</pre></td></tr><tr valign="top"><td><pre>cs:363</pre></td><td><pre>_.bind = (func, obj) -&gt;</pre></td><td><pre>js:403
js:404</pre></td><td><pre>  _.bind = function(func, obj) {
    var args;</pre></td></tr><tr valign="top"><td><pre>cs:364</pre></td><td><pre>  args = _.rest arguments, 2</pre></td><td><pre>js:405
js:406</pre></td><td><pre>    args = _.rest(arguments, 2);
    return function() {</pre></td></tr><tr valign="top"><td><pre>cs:365
cs:366
cs:367
cs:368
cs:369</pre></td><td><pre>  -&gt; func.apply obj or root, args.concat arguments


# Bind all of an object's methods to that object. Useful for ensuring that
# all callbacks defined on an object belong to it.</pre></td><td><pre>js:407
js:408
js:409</pre></td><td><pre>      return func.apply(obj || root, args.concat(arguments));
    };
  };</pre></td></tr><tr valign="top"><td><pre>cs:370</pre></td><td><pre>_.bindAll = (obj) -&gt;</pre></td><td><pre>js:410
js:411</pre></td><td><pre>  _.bindAll = function(obj) {
    var funcs;</pre></td></tr><tr valign="top"><td><pre>cs:371</pre></td><td><pre>  funcs = if arguments.length &gt; 1 then _.rest(arguments) else _.functions(obj)</pre></td><td><pre>js:412</pre></td><td><pre>    funcs = arguments.length &gt; 1 ? _.rest(arguments) : _.functions(obj);</pre></td></tr><tr valign="top"><td><pre>cs:372</pre></td><td><pre>  _.each funcs, (f) -&gt; obj[f] = _.bind obj[f], obj</pre></td><td><pre>js:413</pre></td><td><pre>    _.each(funcs, function(f) {</pre></td></tr><tr valign="top"><td><pre>cs:373
cs:374
cs:375
cs:376
cs:377</pre></td><td><pre>  obj


# Delays a function for the given number of milliseconds, and then calls
# it with the arguments supplied.</pre></td><td><pre>js:414
js:415
js:416
js:417</pre></td><td><pre>      return obj[f] = _.bind(obj[f], obj);
    });
    return obj;
  };</pre></td></tr><tr valign="top"><td><pre>cs:378</pre></td><td><pre>_.delay = (func, wait) -&gt;</pre></td><td><pre>js:418
js:419</pre></td><td><pre>  _.delay = function(func, wait) {
    var args;</pre></td></tr><tr valign="top"><td><pre>cs:379</pre></td><td><pre>  args = _.rest arguments, 2</pre></td><td><pre>js:420</pre></td><td><pre>    args = _.rest(arguments, 2);</pre></td></tr><tr valign="top"><td><pre>cs:380
cs:381
cs:382
cs:383</pre></td><td><pre>  setTimeout((-&gt; func.apply(func, args)), wait)


# Memoize an expensive function by storing its results.</pre></td><td><pre>js:421</pre></td><td><pre>    return setTimeout((function() {</pre></td></tr><tr valign="top"><td><pre>cs:384</pre></td><td><pre>_.memoize = (func, hasher) -&gt;</pre></td><td><pre>js:422
js:423
js:424
js:425
js:426</pre></td><td><pre>      return func.apply(func, args);
    }), wait);
  };
  _.memoize = function(func, hasher) {
    var memo;</pre></td></tr><tr valign="top"><td><pre>cs:385</pre></td><td><pre>  memo = {}</pre></td><td><pre>js:427</pre></td><td><pre>    memo = {};</pre></td></tr><tr valign="top"><td><pre>cs:386
cs:387</pre></td><td><pre>  hasher or= _.identity
  -&gt;</pre></td><td><pre>js:428
js:429
js:430</pre></td><td><pre>    hasher || (hasher = _.identity);
    return function() {
      var key;</pre></td></tr><tr valign="top"><td><pre>cs:388</pre></td><td><pre>    key = hasher.apply this, arguments</pre></td><td><pre>js:431</pre></td><td><pre>      key = hasher.apply(this, arguments);</pre></td></tr><tr valign="top"><td><pre>cs:389</pre></td><td><pre>    return memo[key] if key of memo</pre></td><td><pre>js:432
js:433
js:434</pre></td><td><pre>      if (key in memo) {
        return memo[key];
      }</pre></td></tr><tr valign="top"><td><pre>cs:390
cs:391
cs:392
cs:393
cs:394</pre></td><td><pre>    memo[key] = func.apply this, arguments


# Defers a function, scheduling it to run after the current call stack has
# cleared.</pre></td><td><pre>js:435
js:436
js:437</pre></td><td><pre>      return memo[key] = func.apply(this, arguments);
    };
  };</pre></td></tr><tr valign="top"><td><pre>cs:395</pre></td><td><pre>_.defer = (func) -&gt;</pre></td><td><pre>js:438</pre></td><td><pre>  _.defer = function(func) {</pre></td></tr><tr valign="top"><td><pre>cs:396
cs:397
cs:398
cs:399
cs:400
cs:401</pre></td><td><pre>  _.delay.apply _, [func, 1].concat _.rest arguments


# Returns the first function passed as an argument to the second,
# allowing you to adjust arguments, run code before and after, and
# conditionally execute the original function.</pre></td><td><pre>js:439
js:440</pre></td><td><pre>    return _.delay.apply(_, [func, 1].concat(_.rest(arguments)));
  };</pre></td></tr><tr valign="top"><td><pre>cs:402</pre></td><td><pre>_.wrap = (func, wrapper) -&gt;</pre></td><td><pre>js:441
js:442</pre></td><td><pre>  _.wrap = function(func, wrapper) {
    return function() {</pre></td></tr><tr valign="top"><td><pre>cs:403
cs:404
cs:405
cs:406
cs:407</pre></td><td><pre>  -&gt; wrapper.apply wrapper, [func].concat arguments


# Returns a function that is the composition of a list of functions, each
# consuming the return value of the function that follows.</pre></td><td><pre>js:443
js:444
js:445</pre></td><td><pre>      return wrapper.apply(wrapper, [func].concat(arguments));
    };
  };</pre></td></tr><tr valign="top"><td><pre>cs:408</pre></td><td><pre>_.compose = -&gt;</pre></td><td><pre>js:446
js:447</pre></td><td><pre>  _.compose = function() {
    var funcs;</pre></td></tr><tr valign="top"><td><pre>cs:409
cs:410</pre></td><td><pre>  funcs = arguments
  -&gt;</pre></td><td><pre>js:448
js:449
js:450</pre></td><td><pre>    funcs = arguments;
    return function() {
      var args, i, _ref, _step;</pre></td></tr><tr valign="top"><td><pre>cs:411</pre></td><td><pre>    args = arguments</pre></td><td><pre>js:451</pre></td><td><pre>      args = arguments;</pre></td></tr><tr valign="top"><td><pre>cs:412</pre></td><td><pre>    for i in [funcs.length - 1..0] by -1</pre></td><td><pre>js:452</pre></td><td><pre>      for (i = _ref = funcs.length - 1, _step = -1; _ref &lt;= 0 ? i &lt;= 0 : i &gt;= 0; i +=</pre></td></tr><tr valign="top"><td><pre>cs:413
cs:414
cs:415
cs:416
cs:417
cs:418
cs:419
cs:420</pre></td><td><pre>      args = [funcs[i].apply(this, args)]
    args[0]


# Object Functions
# ----------------

# Retrieve the names of an object's properties.</pre></td><td><pre>js:453
js:454
js:455
js:456
js:457</pre></td><td><pre>        args = [funcs[i].apply(this, args)];
      }
      return args[0];
    };
  };</pre></td></tr><tr valign="top"><td><pre>cs:421</pre></td><td><pre>_.keys = nativeKeys or (obj) -&gt;</pre></td><td><pre>js:458
js:459</pre></td><td><pre>  _.keys = nativeKeys || function(obj) {
    var key, val, _results;</pre></td></tr><tr valign="top"><td><pre>cs:422</pre></td><td><pre>  return _.range 0, obj.length if _.isArray(obj)</pre></td><td><pre>js:460
js:461
js:462
js:463</pre></td><td><pre>    if (_.isArray(obj)) {
      return _.range(0, obj.length);
    }
    _results = [];</pre></td></tr><tr valign="top"><td><pre>cs:423
cs:424
cs:425
cs:426</pre></td><td><pre>  key for key, val of obj


# Retrieve the values of an object's properties.</pre></td><td><pre>js:464
js:465
js:466
js:467
js:468
js:469</pre></td><td><pre>    for (key in obj) {
      val = obj[key];
      _results.push(key);
    }
    return _results;
  };</pre></td></tr><tr valign="top"><td><pre>cs:427</pre></td><td><pre>_.values = (obj) -&gt;</pre></td><td><pre>js:470</pre></td><td><pre>  _.values = function(obj) {</pre></td></tr><tr valign="top"><td><pre>cs:428
cs:429
cs:430
cs:431</pre></td><td><pre>  _.map obj, _.identity


# Return a sorted list of the function names available in Underscore.</pre></td><td><pre>js:471
js:472</pre></td><td><pre>    return _.map(obj, _.identity);
  };</pre></td></tr><tr valign="top"><td><pre>cs:432</pre></td><td><pre>_.functions = (obj) -&gt;</pre></td><td><pre>js:473</pre></td><td><pre>  _.functions = function(obj) {</pre></td></tr><tr valign="top"><td><pre>cs:433
cs:434
cs:435
cs:436</pre></td><td><pre>  _.filter(_.keys(obj), (key) -&gt; _.isFunction(obj[key])).sort()


# Extend a given object with all of the properties in a source object.</pre></td><td><pre>js:474
js:475
js:476
js:477</pre></td><td><pre>    return _.filter(_.keys(obj), function(key) {
      return _.isFunction(obj[key]);
    }).sort();
  };</pre></td></tr><tr valign="top"><td><pre>cs:437</pre></td><td><pre>_.extend = (obj) -&gt;</pre></td><td><pre>js:478
js:479</pre></td><td><pre>  _.extend = function(obj) {
    var key, source, val, _i, _len, _ref;</pre></td></tr><tr valign="top"><td><pre>cs:438</pre></td><td><pre>  for source in _.rest(arguments)</pre></td><td><pre>js:480
js:481</pre></td><td><pre>    _ref = _.rest(arguments);
    for (_i = 0, _len = _ref.length; _i &lt; _len; _i++) {</pre></td></tr><tr valign="top"><td><pre>cs:439</pre></td><td><pre>    obj[key] = val for key, val of source</pre></td><td><pre>js:482
js:483
js:484</pre></td><td><pre>      source = _ref[_i];
      for (key in source) {
        val = source[key];</pre></td></tr><tr valign="top"><td><pre>cs:440
cs:441
cs:442
cs:443</pre></td><td><pre>  obj


# Create a (shallow-cloned) duplicate of an object.</pre></td><td><pre>js:485
js:486
js:487
js:488
js:489</pre></td><td><pre>        obj[key] = val;
      }
    }
    return obj;
  };</pre></td></tr><tr valign="top"><td><pre>cs:444</pre></td><td><pre>_.clone = (obj) -&gt;</pre></td><td><pre>js:490</pre></td><td><pre>  _.clone = function(obj) {</pre></td></tr><tr valign="top"><td><pre>cs:445</pre></td><td><pre>  return obj.slice 0 if _.isArray obj</pre></td><td><pre>js:491
js:492
js:493</pre></td><td><pre>    if (_.isArray(obj)) {
      return obj.slice(0);
    }</pre></td></tr><tr valign="top"><td><pre>cs:446
cs:447
cs:448
cs:449
cs:450</pre></td><td><pre>  _.extend {}, obj


# Invokes interceptor with the obj, and then returns obj.
# The primary purpose of this method is to "tap into" a method chain, in order to per</pre></td><td><pre>js:494
js:495</pre></td><td><pre>    return _.extend({}, obj);
  };</pre></td></tr><tr valign="top"><td><pre>cs:451
cs:452
cs:453
cs:454
cs:455
cs:456</pre></td><td><pre>_.tap = (obj, interceptor) -&gt;
  interceptor obj
  obj


# Perform a deep comparison to check if two objects are equal.</pre></td><td><pre>js:496
js:497
js:498
js:499</pre></td><td><pre>  _.tap = function(obj, interceptor) {
    interceptor(obj);
    return obj;
  };</pre></td></tr><tr valign="top"><td><pre>cs:457
cs:458
cs:459
cs:460</pre></td><td><pre>_.isEqual = (a, b) -&gt;
  # Check object identity.
  return true if a is b
  # Different types?</pre></td><td><pre>js:500
js:501
js:502
js:503
js:504</pre></td><td><pre>  _.isEqual = function(a, b) {
    var aKeys, atype, bKeys, btype, key, val;
    if (a === b) {
      return true;
    }</pre></td></tr><tr valign="top"><td><pre>cs:461</pre></td><td><pre>  atype = typeof(a); btype = typeof(b)</pre></td><td><pre>js:505</pre></td><td><pre>    atype = typeof a;</pre></td></tr><tr valign="top"><td><pre>cs:462
cs:463
cs:464
cs:465
cs:466
cs:467</pre></td><td><pre>  return false if atype isnt btype
  # Basic equality test (watch out for coercions).
  return true if `a == b`
  # One is falsy and the other truthy.
  return false if (!a and b) or (a and !b)
  # One of them implements an `isEqual()`?</pre></td><td><pre>js:506
js:507
js:508
js:509
js:510
js:511
js:512
js:513
js:514
js:515</pre></td><td><pre>    btype = typeof b;
    if (atype !== btype) {
      return false;
    }
    if (a == b) {
      return true;
    }
    if ((!a &amp;&amp; b) || (a &amp;&amp; !b)) {
      return false;
    }</pre></td></tr><tr valign="top"><td><pre>cs:468
cs:469</pre></td><td><pre>  return a.isEqual(b) if a.isEqual
  # Check dates' integer values.</pre></td><td><pre>js:516
js:517
js:518</pre></td><td><pre>    if (a.isEqual) {
      return a.isEqual(b);
    }</pre></td></tr><tr valign="top"><td><pre>cs:470
cs:471</pre></td><td><pre>  return a.getTime() is b.getTime() if _.isDate(a) and _.isDate(b)
  # Both are NaN?</pre></td><td><pre>js:519
js:520
js:521</pre></td><td><pre>    if (_.isDate(a) &amp;&amp; _.isDate(b)) {
      return a.getTime() === b.getTime();
    }</pre></td></tr><tr valign="top"><td><pre>cs:472
cs:473</pre></td><td><pre>  return false if _.isNaN(a) and _.isNaN(b)
  # Compare regular expressions.</pre></td><td><pre>js:522
js:523
js:524</pre></td><td><pre>    if (_.isNaN(a) &amp;&amp; _.isNaN(b)) {
      return false;
    }</pre></td></tr><tr valign="top"><td><pre>cs:474</pre></td><td><pre>  if _.isRegExp(a) and _.isRegExp(b)</pre></td><td><pre>js:525</pre></td><td><pre>    if (_.isRegExp(a) &amp;&amp; _.isRegExp(b)) {</pre></td></tr><tr valign="top"><td><pre>cs:475
cs:476
cs:477
cs:478
cs:479</pre></td><td><pre>    return a.source     is b.source and
           a.global     is b.global and
           a.ignoreCase is b.ignoreCase and
           a.multiline  is b.multiline
  # If a is not an object by this point, we can't handle it.</pre></td><td><pre>js:526
js:527</pre></td><td><pre>      return a.source === b.source &amp;&amp; a.global === b.global &amp;&amp; a.ignoreCase === b.ign
    }</pre></td></tr><tr valign="top"><td><pre>cs:480
cs:481</pre></td><td><pre>  return false if atype isnt 'object'
  # Check for different array lengths before comparing contents.</pre></td><td><pre>js:528
js:529
js:530</pre></td><td><pre>    if (atype !== 'object') {
      return false;
    }</pre></td></tr><tr valign="top"><td><pre>cs:482
cs:483</pre></td><td><pre>  return false if a.length and (a.length isnt b.length)
  # Nothing else worked, deep compare the contents.</pre></td><td><pre>js:531
js:532
js:533</pre></td><td><pre>    if (a.length &amp;&amp; (a.length !== b.length)) {
      return false;
    }</pre></td></tr><tr valign="top"><td><pre>cs:484
cs:485</pre></td><td><pre>  aKeys = _.keys(a); bKeys = _.keys(b)
  # Different object sizes?</pre></td><td><pre>js:534</pre></td><td><pre>    aKeys = _.keys(a);</pre></td></tr><tr valign="top"><td><pre>cs:486
cs:487</pre></td><td><pre>  return false if aKeys.length isnt bKeys.length
  # Recursive comparison of contents.</pre></td><td><pre>js:535
js:536
js:537
js:538</pre></td><td><pre>    bKeys = _.keys(b);
    if (aKeys.length !== bKeys.length) {
      return false;
    }</pre></td></tr><tr valign="top"><td><pre>cs:488
cs:489
cs:490
cs:491
cs:492</pre></td><td><pre>  return false for key, val of a when !(key of b) or !_.isEqual(val, b[key])
  true


# Is a given array or object empty?</pre></td><td><pre>js:539
js:540
js:541
js:542
js:543
js:544
js:545
js:546</pre></td><td><pre>    for (key in a) {
      val = a[key];
      if (!(key in b) || !_.isEqual(val, b[key])) {
        return false;
      }
    }
    return true;
  };</pre></td></tr><tr valign="top"><td><pre>cs:493</pre></td><td><pre>_.isEmpty = (obj) -&gt;</pre></td><td><pre>js:547
js:548</pre></td><td><pre>  _.isEmpty = function(obj) {
    var key;</pre></td></tr><tr valign="top"><td><pre>cs:494</pre></td><td><pre>  return obj.length is 0 if _.isArray(obj) or _.isString(obj)</pre></td><td><pre>js:549
js:550
js:551</pre></td><td><pre>    if (_.isArray(obj) || _.isString(obj)) {
      return obj.length === 0;
    }</pre></td></tr><tr valign="top"><td><pre>cs:495
cs:496
cs:497
cs:498
cs:499</pre></td><td><pre>  return false for own key of obj
  true


# Is a given value a DOM element?</pre></td><td><pre>js:552
js:553
js:554
js:555
js:556
js:557</pre></td><td><pre>    for (key in obj) {
      if (!__hasProp.call(obj, key)) continue;
      return false;
    }
    return true;
  };</pre></td></tr><tr valign="top"><td><pre>cs:500
cs:501
cs:502
cs:503</pre></td><td><pre>_.isElement   = (obj) -&gt; obj and obj.nodeType is 1


# Is a given value an array?</pre></td><td><pre>js:558
js:559
js:560</pre></td><td><pre>  _.isElement = function(obj) {
    return obj &amp;&amp; obj.nodeType === 1;
  };</pre></td></tr><tr valign="top"><td><pre>cs:504
cs:505
cs:506
cs:507</pre></td><td><pre>_.isArray     = nativeIsArray or (obj) -&gt; !!(obj and obj.concat and obj.unshift and n


# Is a given variable an arguments object?</pre></td><td><pre>js:561</pre></td><td><pre>  _.isArray = nativeIsArray || function(obj) {</pre></td></tr><tr valign="top"><td><pre>cs:508
cs:509
cs:510
cs:511</pre></td><td><pre>_.isArguments = (obj) -&gt; obj and obj.callee


# Is the given value a function?</pre></td><td><pre>js:562
js:563
js:564
js:565
js:566</pre></td><td><pre>    return !!(obj &amp;&amp; obj.concat &amp;&amp; obj.unshift &amp;&amp; !obj.callee);
  };
  _.isArguments = function(obj) {
    return obj &amp;&amp; obj.callee;
  };</pre></td></tr><tr valign="top"><td><pre>cs:512
cs:513
cs:514
cs:515</pre></td><td><pre>_.isFunction  = (obj) -&gt; !!(obj and obj.constructor and obj.call and obj.apply)


# Is the given value a string?</pre></td><td><pre>js:567
js:568
js:569</pre></td><td><pre>  _.isFunction = function(obj) {
    return !!(obj &amp;&amp; obj.constructor &amp;&amp; obj.call &amp;&amp; obj.apply);
  };</pre></td></tr><tr valign="top"><td><pre>cs:516
cs:517
cs:518
cs:519</pre></td><td><pre>_.isString    = (obj) -&gt; !!(obj is '' or (obj and obj.charCodeAt and obj.substr))


# Is a given value a number?</pre></td><td><pre>js:570
js:571
js:572</pre></td><td><pre>  _.isString = function(obj) {
    return !!(obj === '' || (obj &amp;&amp; obj.charCodeAt &amp;&amp; obj.substr));
  };</pre></td></tr><tr valign="top"><td><pre>cs:520
cs:521
cs:522
cs:523</pre></td><td><pre>_.isNumber    = (obj) -&gt; (obj is +obj) or toString.call(obj) is '[object Number]'


# Is a given value a boolean?</pre></td><td><pre>js:573
js:574
js:575</pre></td><td><pre>  _.isNumber = function(obj) {
    return (obj === +obj) || toString.call(obj) === '[object Number]';
  };</pre></td></tr><tr valign="top"><td><pre>cs:524
cs:525
cs:526
cs:527</pre></td><td><pre>_.isBoolean   = (obj) -&gt; obj is true or obj is false


# Is a given value a Date?</pre></td><td><pre>js:576
js:577
js:578</pre></td><td><pre>  _.isBoolean = function(obj) {
    return obj === true || obj === false;
  };</pre></td></tr><tr valign="top"><td><pre>cs:528
cs:529
cs:530
cs:531</pre></td><td><pre>_.isDate      = (obj) -&gt; !!(obj and obj.getTimezoneOffset and obj.setUTCFullYear)


# Is the given value a regular expression?</pre></td><td><pre>js:579
js:580
js:581</pre></td><td><pre>  _.isDate = function(obj) {
    return !!(obj &amp;&amp; obj.getTimezoneOffset &amp;&amp; obj.setUTCFullYear);
  };</pre></td></tr><tr valign="top"><td><pre>cs:532
cs:533
cs:534
cs:535
cs:536</pre></td><td><pre>_.isRegExp    = (obj) -&gt; !!(obj and obj.exec and (obj.ignoreCase or obj.ignoreCase is


# Is the given value NaN -- this one is interesting. `NaN != NaN`, and
# `isNaN(undefined) == true`, so we make sure it's a number first.</pre></td><td><pre>js:582
js:583
js:584</pre></td><td><pre>  _.isRegExp = function(obj) {
    return !!(obj &amp;&amp; obj.exec &amp;&amp; (obj.ignoreCase || obj.ignoreCase === false));
  };</pre></td></tr><tr valign="top"><td><pre>cs:537
cs:538
cs:539
cs:540</pre></td><td><pre>_.isNaN       = (obj) -&gt; _.isNumber(obj) and window.isNaN(obj)


# Is a given value equal to null?</pre></td><td><pre>js:585
js:586
js:587</pre></td><td><pre>  _.isNaN = function(obj) {
    return _.isNumber(obj) &amp;&amp; window.isNaN(obj);
  };</pre></td></tr><tr valign="top"><td><pre>cs:541
cs:542
cs:543
cs:544</pre></td><td><pre>_.isNull      = (obj) -&gt; obj is null


# Is a given variable undefined?</pre></td><td><pre>js:588
js:589
js:590</pre></td><td><pre>  _.isNull = function(obj) {
    return obj === null;
  };</pre></td></tr><tr valign="top"><td><pre>cs:545
cs:546
cs:547
cs:548
cs:549
cs:550
cs:551
cs:552</pre></td><td><pre>_.isUndefined = (obj) -&gt; typeof obj is 'undefined'


# Utility Functions
# -----------------

# Run Underscore.js in noConflict mode, returning the `_` variable to its
# previous owner. Returns a reference to the Underscore object.</pre></td><td><pre>js:591
js:592
js:593</pre></td><td><pre>  _.isUndefined = function(obj) {
    return typeof obj === 'undefined';
  };</pre></td></tr><tr valign="top"><td><pre>cs:553</pre></td><td><pre>_.noConflict = -&gt;</pre></td><td><pre>js:594</pre></td><td><pre>  _.noConflict = function() {</pre></td></tr><tr valign="top"><td><pre>cs:554
cs:555
cs:556
cs:557
cs:558</pre></td><td><pre>  root._ = previousUnderscore
  this


# Keep the identity function around for default iterators.</pre></td><td><pre>js:595
js:596
js:597</pre></td><td><pre>    root._ = previousUnderscore;
    return this;
  };</pre></td></tr><tr valign="top"><td><pre>cs:559
cs:560
cs:561
cs:562</pre></td><td><pre>_.identity = (value) -&gt; value


# Run a function `n` times.</pre></td><td><pre>js:598
js:599
js:600</pre></td><td><pre>  _.identity = function(value) {
    return value;
  };</pre></td></tr><tr valign="top"><td><pre>cs:563
cs:564
cs:565
cs:566
cs:567</pre></td><td><pre>_.times = (n, iterator, context) -&gt;
  iterator.call context, i for i in [0...n]


# Break out of the middle of an iteration.</pre></td><td><pre>js:601
js:602
js:603
js:604
js:605
js:606
js:607
js:608</pre></td><td><pre>  _.times = function(n, iterator, context) {
    var i, _results;
    _results = [];
    for (i = 0; 0 &lt;= n ? i &lt; n : i &gt; n; 0 &lt;= n ? i++ : i--) {
      _results.push(iterator.call(context, i));
    }
    return _results;
  };</pre></td></tr><tr valign="top"><td><pre>cs:568
cs:569
cs:570
cs:571
cs:572</pre></td><td><pre>_.breakLoop = -&gt; throw breaker


# Add your own custom functions to the Underscore object, ensuring that
# they're correctly added to the OOP wrapper as well.</pre></td><td><pre>js:609
js:610
js:611</pre></td><td><pre>  _.breakLoop = function() {
    throw breaker;
  };</pre></td></tr><tr valign="top"><td><pre>cs:573</pre></td><td><pre>_.mixin = (obj) -&gt;</pre></td><td><pre>js:612
js:613</pre></td><td><pre>  _.mixin = function(obj) {
    var name, _i, _len, _ref, _results;</pre></td></tr><tr valign="top"><td><pre>cs:574</pre></td><td><pre>  for name in _.functions(obj)</pre></td><td><pre>js:614
js:615
js:616</pre></td><td><pre>    _ref = _.functions(obj);
    _results = [];
    for (_i = 0, _len = _ref.length; _i &lt; _len; _i++) {</pre></td></tr><tr valign="top"><td><pre>cs:575
cs:576
cs:577
cs:578
cs:579</pre></td><td><pre>    addToWrapper name, _[name] = obj[name]


# Generate a unique integer id (unique within the entire client session).
# Useful for temporary DOM ids.</pre></td><td><pre>js:617
js:618
js:619
js:620
js:621</pre></td><td><pre>      name = _ref[_i];
      _results.push(addToWrapper(name, _[name] = obj[name]));
    }
    return _results;
  };</pre></td></tr><tr valign="top"><td><pre>cs:580</pre></td><td><pre>idCounter = 0</pre></td><td><pre>js:622</pre></td><td><pre>  idCounter = 0;</pre></td></tr><tr valign="top"><td><pre>cs:581</pre></td><td><pre>_.uniqueId = (prefix) -&gt;</pre></td><td><pre>js:623</pre></td><td><pre>  _.uniqueId = function(prefix) {</pre></td></tr><tr valign="top"><td><pre>cs:582
cs:583
cs:584
cs:585
cs:586</pre></td><td><pre>  (prefix or '') + idCounter++


# By default, Underscore uses **ERB**-style template delimiters, change the
# following template settings to use alternative delimiters.</pre></td><td><pre>js:624
js:625</pre></td><td><pre>    return (prefix || '') + idCounter++;
  };</pre></td></tr><tr valign="top"><td><pre>cs:587</pre></td><td><pre>_.templateSettings = {</pre></td><td><pre>js:626</pre></td><td><pre>  _.templateSettings = {</pre></td></tr><tr valign="top"><td><pre>cs:588</pre></td><td><pre>  start:        '&lt;%'</pre></td><td><pre>js:627</pre></td><td><pre>    start: '&lt;%',</pre></td></tr><tr valign="top"><td><pre>cs:589</pre></td><td><pre>  end:          '%&gt;'</pre></td><td><pre>js:628</pre></td><td><pre>    end: '%&gt;',</pre></td></tr><tr valign="top"><td><pre>cs:590
cs:591
cs:592
cs:593
cs:594
cs:595
cs:596
cs:597</pre></td><td><pre>  interpolate:  /&lt;%=(.+?)%&gt;/g
}


# JavaScript templating a-la **ERB**, pilfered from John Resig's
# *Secrets of the JavaScript Ninja*, page 83.
# Single-quote fix from Rick Strahl.
# With alterations for arbitrary delimiters, and to preserve whitespace.</pre></td><td><pre>js:629
js:630</pre></td><td><pre>    interpolate: /&lt;%=(.+?)%&gt;/g
  };</pre></td></tr><tr valign="top"><td><pre>cs:598</pre></td><td><pre>_.template = (str, data) -&gt;</pre></td><td><pre>js:631
js:632</pre></td><td><pre>  _.template = function(str, data) {
    var c, endMatch, fn;</pre></td></tr><tr valign="top"><td><pre>cs:599</pre></td><td><pre>  c = _.templateSettings</pre></td><td><pre>js:633</pre></td><td><pre>    c = _.templateSettings;</pre></td></tr><tr valign="top"><td><pre>cs:600</pre></td><td><pre>  endMatch = new RegExp("'(?=[^"+c.end.substr(0, 1)+"]*"+escapeRegExp(c.end)+")","g")</pre></td><td><pre>js:634</pre></td><td><pre>    endMatch = new RegExp("'(?=[^" + c.end.substr(0, 1) + "]*" + escapeRegExp(c.end) </pre></td></tr><tr valign="top"><td><pre>cs:601
cs:602
cs:603
cs:604
cs:605
cs:606
cs:607
cs:608
cs:609
cs:610
cs:611
cs:612
cs:613</pre></td><td><pre>  fn = new Function 'obj',
    'var p=[],print=function(){p.push.apply(p,arguments);};' +
    'with(obj||{}){p.push(\'' +
    str.replace(/\r/g, '\\r')
       .replace(/\n/g, '\\n')
       .replace(/\t/g, '\\t')
       .replace(endMatch,"✄")
       .split("'").join("\\'")
       .split("✄").join("'")
       .replace(c.interpolate, "',$1,'")
       .split(c.start).join("');")
       .split(c.end).join("p.push('") +
       "');}return p.join('');"</pre></td><td><pre>js:635</pre></td><td><pre>    fn = new Function('obj', 'var p=[],print=function(){p.push.apply(p,arguments);};'</pre></td></tr><tr valign="top"><td><pre>cs:614
cs:615
cs:616
cs:617
cs:618
cs:619</pre></td><td><pre>  if data then fn(data) else fn


# Aliases
# -------
</pre></td><td><pre>js:636
js:637
js:638
js:639
js:640
js:641</pre></td><td><pre>    if (data) {
      return fn(data);
    } else {
      return fn;
    }
  };</pre></td></tr><tr valign="top"><td><pre>cs:620</pre></td><td><pre>_.forEach  = _.each</pre></td><td><pre>js:642</pre></td><td><pre>  _.forEach = _.each;</pre></td></tr><tr valign="top"><td><pre>cs:621</pre></td><td><pre>_.foldl    = _.inject = _.reduce</pre></td><td><pre>js:643</pre></td><td><pre>  _.foldl = _.inject = _.reduce;</pre></td></tr><tr valign="top"><td><pre>cs:622</pre></td><td><pre>_.foldr    = _.reduceRight</pre></td><td><pre>js:644</pre></td><td><pre>  _.foldr = _.reduceRight;</pre></td></tr><tr valign="top"><td><pre>cs:623</pre></td><td><pre>_.select   = _.filter</pre></td><td><pre>js:645</pre></td><td><pre>  _.select = _.filter;</pre></td></tr><tr valign="top"><td><pre>cs:624</pre></td><td><pre>_.all      = _.every</pre></td><td><pre>js:646</pre></td><td><pre>  _.all = _.every;</pre></td></tr><tr valign="top"><td><pre>cs:625</pre></td><td><pre>_.any      = _.some</pre></td><td><pre>js:647</pre></td><td><pre>  _.any = _.some;</pre></td></tr><tr valign="top"><td><pre>cs:626</pre></td><td><pre>_.contains = _.include</pre></td><td><pre>js:648</pre></td><td><pre>  _.contains = _.include;</pre></td></tr><tr valign="top"><td><pre>cs:627</pre></td><td><pre>_.head     = _.first</pre></td><td><pre>js:649</pre></td><td><pre>  _.head = _.first;</pre></td></tr><tr valign="top"><td><pre>cs:628</pre></td><td><pre>_.tail     = _.rest</pre></td><td><pre>js:650</pre></td><td><pre>  _.tail = _.rest;</pre></td></tr><tr valign="top"><td><pre>cs:629
cs:630
cs:631
cs:632
cs:633
cs:634
cs:635
cs:636
cs:637</pre></td><td><pre>_.methods  = _.functions


# Setup the OOP Wrapper
# ---------------------

# If Underscore is called as a function, it returns a wrapped object that
# can be used OO-style. This wrapper holds altered versions of all the
# underscore functions. Wrapped objects may be chained.</pre></td><td><pre>js:651</pre></td><td><pre>  _.methods = _.functions;</pre></td></tr><tr valign="top"><td><pre>cs:638</pre></td><td><pre>wrapper = (obj) -&gt;</pre></td><td><pre>js:652</pre></td><td><pre>  wrapper = function(obj) {</pre></td></tr><tr valign="top"><td><pre>cs:639
cs:640
cs:641
cs:642
cs:643</pre></td><td><pre>  this._wrapped = obj
  this


# Helper function to continue chaining intermediate results.</pre></td><td><pre>js:653
js:654
js:655</pre></td><td><pre>    this._wrapped = obj;
    return this;
  };</pre></td></tr><tr valign="top"><td><pre>cs:644
cs:645
cs:646
cs:647
cs:648</pre></td><td><pre>result = (obj, chain) -&gt;
  if chain then _(obj).chain() else obj


# A method to easily add functions to the OOP wrapper.</pre></td><td><pre>js:656
js:657
js:658
js:659
js:660
js:661
js:662</pre></td><td><pre>  result = function(obj, chain) {
    if (chain) {
      return _(obj).chain();
    } else {
      return obj;
    }
  };</pre></td></tr><tr valign="top"><td><pre>cs:649</pre></td><td><pre>addToWrapper = (name, func) -&gt;</pre></td><td><pre>js:663</pre></td><td><pre>  addToWrapper = function(name, func) {</pre></td></tr><tr valign="top"><td><pre>cs:650</pre></td><td><pre>  wrapper.prototype[name] = -&gt;</pre></td><td><pre>js:664
js:665</pre></td><td><pre>    return wrapper.prototype[name] = function() {
      var args;</pre></td></tr><tr valign="top"><td><pre>cs:651</pre></td><td><pre>    args = _.toArray arguments</pre></td><td><pre>js:666</pre></td><td><pre>      args = _.toArray(arguments);</pre></td></tr><tr valign="top"><td><pre>cs:652</pre></td><td><pre>    unshift.call args, this._wrapped</pre></td><td><pre>js:667</pre></td><td><pre>      unshift.call(args, this._wrapped);</pre></td></tr><tr valign="top"><td><pre>cs:653
cs:654
cs:655
cs:656</pre></td><td><pre>    result func.apply(_, args), this._chain


# Add all ofthe Underscore functions to the wrapper object.</pre></td><td><pre>js:668
js:669
js:670</pre></td><td><pre>      return result(func.apply(_, args), this._chain);
    };
  };</pre></td></tr><tr valign="top"><td><pre>cs:657
cs:658
cs:659
cs:660</pre></td><td><pre>_.mixin _


# Add all mutator Array functions to the wrapper.</pre></td><td><pre>js:671</pre></td><td><pre>  _.mixin(_);</pre></td></tr><tr valign="top"><td><pre>cs:661</pre></td><td><pre>_.each ['pop', 'push', 'reverse', 'shift', 'sort', 'splice', 'unshift'], (name) -&gt;</pre></td><td><pre>js:672
js:673</pre></td><td><pre>  _.each(['pop', 'push', 'reverse', 'shift', 'sort', 'splice', 'unshift'], function(n
    var method;</pre></td></tr><tr valign="top"><td><pre>cs:662</pre></td><td><pre>  method = Array.prototype[name]</pre></td><td><pre>js:674</pre></td><td><pre>    method = Array.prototype[name];</pre></td></tr><tr valign="top"><td><pre>cs:663</pre></td><td><pre>  wrapper.prototype[name] = -&gt;</pre></td><td><pre>js:675</pre></td><td><pre>    return wrapper.prototype[name] = function() {</pre></td></tr><tr valign="top"><td><pre>cs:664</pre></td><td><pre>    method.apply(this._wrapped, arguments)</pre></td><td><pre>js:676</pre></td><td><pre>      method.apply(this._wrapped, arguments);</pre></td></tr><tr valign="top"><td><pre>cs:665
cs:666
cs:667
cs:668</pre></td><td><pre>    result(this._wrapped, this._chain)


# Add all accessor Array functions to the wrapper.</pre></td><td><pre>js:677
js:678
js:679</pre></td><td><pre>      return result(this._wrapped, this._chain);
    };
  });</pre></td></tr><tr valign="top"><td><pre>cs:669</pre></td><td><pre>_.each ['concat', 'join', 'slice'], (name) -&gt;</pre></td><td><pre>js:680
js:681</pre></td><td><pre>  _.each(['concat', 'join', 'slice'], function(name) {
    var method;</pre></td></tr><tr valign="top"><td><pre>cs:670</pre></td><td><pre>  method = Array.prototype[name]</pre></td><td><pre>js:682</pre></td><td><pre>    method = Array.prototype[name];</pre></td></tr><tr valign="top"><td><pre>cs:671</pre></td><td><pre>  wrapper.prototype[name] = -&gt;</pre></td><td><pre>js:683</pre></td><td><pre>    return wrapper.prototype[name] = function() {</pre></td></tr><tr valign="top"><td><pre>cs:672
cs:673
cs:674
cs:675</pre></td><td><pre>    result(method.apply(this._wrapped, arguments), this._chain)


# Start chaining a wrapped Underscore object.</pre></td><td><pre>js:684
js:685
js:686</pre></td><td><pre>      return result(method.apply(this._wrapped, arguments), this._chain);
    };
  });</pre></td></tr><tr valign="top"><td><pre>cs:676</pre></td><td><pre>wrapper::chain = -&gt;</pre></td><td><pre>js:687</pre></td><td><pre>  wrapper.prototype.chain = function() {</pre></td></tr><tr valign="top"><td><pre>cs:677
cs:678
cs:679
cs:680
cs:681</pre></td><td><pre>  this._chain = true
  this


# Extracts the result from a wrapped and chained object.</pre></td><td><pre>js:688
js:689
js:690</pre></td><td><pre>    this._chain = true;
    return this;
  };</pre></td></tr><tr valign="top"><td><pre>cs:682</pre></td><td><pre>wrapper::value = -&gt; this._wrapped</pre></td><td><pre>js:691
js:692
js:693
js:694
js:695</pre></td><td><pre>  wrapper.prototype.value = function() {
    return this._wrapped;
  };
}).call(this);
</pre></td></tr></table>

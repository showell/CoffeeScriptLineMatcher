Canvas = (div, id, width=600, height=300) ->
  canvas_html = """
    <canvas id='#{id}' width='#{width}' height='#{height}' style='border: 1px blue solid'>
    </canvas>
  """
  div.append canvas_html

  canvas = document.getElementById(id)
  ctx = canvas.getContext("2d")
  
  moveTo = (point) ->
    [x,y] = point
    ctx.moveTo Math.floor(x), Math.floor(y)
    
  lineTo = (point) ->
    [x,y] = point
    ctx.lineTo Math.floor(x), Math.floor(y)

  clear: ->
    canvas.width = width

  segment: (color, point1, point2) ->
    ctx.strokeStyle = color
    ctx.lineWidth = 2
    ctx.beginPath()
    moveTo point1
    lineTo point2
    ctx.stroke()
    ctx.closePath()
    
  draw_polygon: (color, point1, more_points...) ->
    ctx.fillStyle = color
    ctx.beginPath()
    moveTo point1
    for point in more_points
      lineTo point
    lineTo point1
    ctx.fill()
    ctx.closePath()
  
  outline_triangle: (color, point1, point2, point3) ->
    ctx.strokeStyle = color
    ctx.lineWidth = 1
    ctx.beginPath()
    moveTo point1
    lineTo point2
    lineTo point3
    lineTo point1
    ctx.stroke()
    ctx.closePath()
  
Linkage = ->
  width = 700
  height = 450
  x_offset = 0
  y_distort = 0
  rescale = (point) ->
    [x, y] = point
    x += x_offset
    y *= y_distort
    [x * 20 + 100, height - y * 20 - 10]  

  canvas = Canvas $("#linkage"), "linkage_canvas", width, height
  a = 17
  b = 5
  h = 0
  dh = 0.05
  dt = 2

  paused = false
  
  recording = true
  path1 = []
  path2 = []
  path3 = []
  path4 = []
  draw = ->
    if paused
      return
      
    canvas.clear()
    c = Math.sqrt a*a - b*b
    d = Math.sqrt c*c + h*h # distance from A to center of rhombus
    e = Math.sqrt b*b - h*h # distance from C to center of rhombus
    # rhomubs is DBCE, D is top point, A is bottom point
  
    pos_neg =
      if h > 0
        1
      else
        -1
    i = pos_neg * h
  
    A = [0, 0]
    B = [0, d-i]
    C = [e, d]
    D = [0, d+i]
    E = [-e, d]
    Y = [a + c/2, c]
    cos = c / (d+i)
    sin = Math.sqrt(1 - cos*cos) * pos_neg

    rotate = (point) ->
      [x, y] = point
      [x*cos + y*sin, y*cos - x*sin]

    segment = (color, point1, point2) ->
      canvas.segment color, rescale(point1), rescale(point2)
      
    show = ->
      segment "pink", A, B
      segment "blue", E, D
      segment "blue", D, C
      segment "blue", C, B
      segment "blue", B, E
      segment "green", A, E
      segment "green", A, C

    A = rotate A
    B = rotate B
    C = rotate C
    D = rotate D
    E = rotate E

    x_offset = 12
    y_distort = 1
    if recording
      path1.push B
      path2.push D
      path3.push C
      path4.push E
    
    for path in [path1, path2, path3, path4]
      for i in [0...path.length-1]
        segment "pink", path[i], path[i+1]
    show()

    h += dh
    if h < -b or h > b
      recording = false if h < 0
      dh *= -1
      h += dh
    setTimeout(draw, dt)
  draw()
  button = $("#linkage_pause")
  button.click ->
    if paused
      paused = false
      draw()
      button.val "pause"
    else
      paused = true
      button.val "resume"
  
PythagFolding = ->
  x_offset = 50
  height = 130
  rescale = (point) ->
    [x, y] = point
    [x * 10 + x_offset, height - y * 10 - 10]  

  canvas = Canvas $("#pythag_fold1"), "pythag_fold1_canvas", 400, height

  a = 8.5
  b = 11

  A = [0,0]
  B = [0,b]
  C = [a,b]
  D = [a,0]

  draw_poly = (color, points...) ->
    scaled_points = (rescale point for point in points)
    canvas.draw_polygon color, scaled_points...

  segment = (color, point1, point2) ->
    canvas.segment color, rescale(point1), rescale(point2)

  draw_poly "lightblue", A, B, C, D
  
  x_offset += 120
  
  D = [a * (a*a - b*b) / (a*a + b*b), a * (2*a*b) / (a*a + b*b)]
  draw_poly "lightblue", A, B, C
  draw_poly "red", A, D, C
  segment "black", A, C
  
  x_offset += 100
  
  D = [a, 0]
  draw_poly "lightblue", A, B, C
  draw_poly "lightblue", A, C, D
  segment "blue", A, C
  
  x_offset = 50
  canvas = Canvas $("#pythag_fold2"), "pythag_fold2_canvas", 800, height
  draw_poly "lightblue", A, B, C
  draw_poly "lightblue", A, C, D
  segment "blue", A, C
  
  x_offset += 100
  E = [0, a]
  F = [a, a]
  draw_poly "lightblue", A, B, C, F
  segment "blue", A, C
  draw_poly "red", A, E, F
  segment "black", A, F
  segment "pink", E, F
  
  x_offset += 100
  G = [a, 2*a-b]
  H = [0, 2*a-b]
  K = [2*a-b, 2*a-b]
  draw_poly "lightblue", A, E, F
  draw_poly "red", E, F, G, H
  segment "black", E, F
  segment "pink", H, K
  
  x_offset += 100
  L = [2*a-b, a]
  draw_poly "lightblue", A, E, F
  draw_poly "lightblue", E, F, K, H
  draw_poly "red", L, K, F
  segment "pink", H, K
  segment "pink", L, K
  segment "black", K, F
  
  x_offset += 100
  I = [3*a-2*b, a]
  draw_poly "lightblue", A, H, K
  draw_poly "lightblue", E, L, K, H
  draw_poly "red", L, K, I
  segment "pink", H, K
  segment "pink", L, K
  segment "pink", K, I
  segment "black", K, L
  
  x_offset += 100
  J = [3*a-2*b, 2*a-b]
  draw_poly "lightblue", A, H, K
  draw_poly "lightblue", E, I, K, H
  draw_poly "red", J, K, I
  segment "pink", H, K
  segment "pink", I, J
  segment "black", I, K
  
  x_offset += 100
  M = [2*a-b, b]
  N = [a, 2*a-b]
  O = [a, 3*a-2*b]
  draw_poly "lightblue", A, B, C, D
  segment "blue", A, C
  segment "blue", A, F
  segment "blue", E, F
  segment "green", M, L
  segment "blue", L, K
  segment "green", K, N
  segment "blue", I, K
  segment "green", K, O
  segment "green", I, M
  segment "green", M, F
  
  x_offset = 50
  canvas = Canvas $("#pythag_fold3"), "pythag_fold3_canvas", 600, height
    
  for i in [1..2]
    draw_poly "lightgreen", A, B, C
    draw_poly "yellow", A, C, D
    segment "blue", A, C
    x_offset += 100

  draw_poly "black", A, B, M, K, N, D
  draw_poly "cyan", M, C, N, K
  segment "blue", E, F
  
  blue = "#AAAADD"
  for i in [1..2]
    x_offset += 100
    D = [a, 0]
    P = [a * a / b, a]
    draw_poly blue, A, P, F, D
    draw_poly "lightblue", P, F, C
    draw_poly "red", A, E, P
    draw_poly "pink", E, B, C, P

PythagProof = ->
  canvas = Canvas $("#pythag_proof"), "pythag_canvas", 350, 350
  
  rescale = (point) ->
    [x, y] = point
    y -= 4
    [x * 10 + 150, -y * 10 + 170]

  draw_poly = (poly, color, points) ->
    coords = (points[poly.charAt(i)] for i in [0...poly.length])
    canvas.draw_polygon color, coords...


  a = 8.5
  b = 2.5
  c = (a * b) / (a + b)
  points =
    A: -> [-a, 0]
    B: -> [-a-b, 0]
    C: -> [-a, b+c]
    D: -> [-a, b]
    E: -> [-a-b, b]
    F: -> [-a-b, a+b]
    G: -> [-a, a+b]
    H: -> [0, a+b]
    I: -> [a, a+b]
    J: -> [a+b, a+b]
    K: -> [a+b, a]
    L: -> [a, a]
    M: -> [b, a+b]
    N: -> [a+b, 2*a+b]
    O: -> [2*a+b, a]
    P: -> [a+b, c]
    Q: -> [a, 0]
    R: -> [a, -a]
    S: -> [0, c-a]
    T: -> [0, -a]
    U: -> [0, 0]
    V: -> [b, a+b+c]
    W: -> [0, b]
    X: -> [-b, -a]
    Y: -> [-b, 0]

  blue = "#AAAADD"
  
  triangles = [
    ["EDAB", "cyan"]
    ["ECGF", "pink"]
    ["EDC", "lightblue"]
    ["AUG", "yellow"]
    ["UGH", "lightgreen"]
    #
    ["STRQ", blue]
    ["UQS", "red"]
    #
    ["HIQ", "lightgreen"]
    ["HMV", "lightblue"]
    ["VNJM", blue]
    ["NKO", "yellow"]
    ["OKP", "red"]
    ["LKPQ", "pink"]
    ["IJKL", "cyan"]
  ]
  
  redraw = ->
    canvas.clear()
    scaled_points = {}
    for vertex, point of points
      scaled_points[vertex] = rescale point()
    
    segment = (segment, color) ->
      point1 = scaled_points[segment.charAt(0)]
      point2 = scaled_points[segment.charAt(1)]
      canvas.segment color, point1, point2

    for triangle in triangles
      [vertices, color] = triangle
      draw_poly vertices, color, scaled_points

    
    # black > blue > green
    segment "EH", "black"
    segment "HQ", "black"
    segment "HN", "black"
    segment "NO", "black"
    segment "OQ", "black"
    segment "GU", "black"
    
    segment "BU", "blue"
    segment "UH", "blue"
    segment "HF", "blue"
    segment "FB", "blue"
    
    segment "QI", "blue"
    segment "NK", "blue"
    
    segment "ED", "orange"
    segment "DW", "green"
    segment "UQ", "green"
    segment "AG", "blue"
    
    segment "XY", "green"
    segment "XT", "orange"
    segment "XQ", "black"
    segment "TR", "green"
    segment "QR", "green"
    segment "UT", "green"
    
  redraw()      
  
TwelveTriangles = ->
  canvas = Canvas $("#twelve_triangles"), "twelve_triangles_canvas"
  skew = 0
  height = 1
  
  rescale = (point) ->
    [x, y] = point
    x -= 4 # keep centroid centered
    x += y * skew
    x /= height
    y *= height
    [x * 40 + 300, -y * 40 + 150]
    
  draw_triangle = (triangle, color, points) ->
    v0 = triangle.charAt(0)
    v1 = triangle.charAt(1)
    v2 = triangle.charAt(2)
    canvas.draw_polygon color, points[v0], points[v1], points[v2]
    
  draw = ->
    points =
      A: [0, 2]
      B: [2, 2]
      C: [6, 2]
      D: [3, 1]
      E: [0, 0]
      F: [4, 0]
      G: [6, 0]
      H: [3, -1]
      I: [0, -2]
      J: [2, -2]
      K: [6, -2]
      

    triangles = [
      ["ABE", "red"]
      ["BED", "green"]
      ["BCD", "blue"]
      ["DEF", "blue"]
      ["DFC", "green"]
      ["CFG", "red"]
      #
      ["EFH", "pink"]
      ["FHK", "lightgreen"]
      ["FGK", "lightblue"]
      ["EIJ", "lightblue"]
      ["EJH", "lightgreen"]
      ["JHK", "pink"]
    ]
    
    redraw = ->
      canvas.clear()
      scaled_points = {}
      for vertex, point of points
        scaled_points[vertex] = rescale point
      
      for triangle in triangles
        [vertices, color] = triangle
        draw_triangle vertices, color, scaled_points
      
      vertices = (scaled_points[vertex] for vertex in ["E", "C", "K"])
      canvas.outline_triangle "black", vertices...

    redraw()
    
    $("#more_skew").click ->
      skew += 0.2
      redraw()
          
    $("#less_skew").click ->
      skew -= 0.2
      redraw()

    $("#taller").click ->
      height += 0.1
      redraw()
    
    $("#wider").click ->
      height -= 0.1
      redraw()
      
  draw()

MultiplicationTables = ->
  colors =
    2: "#EEEEEE"
    4: "#CCCCCC"
    8: "#AAAAAA"
    16: "#999999"
    3: "#EEAAAA"
    6: "#DDAAAA"
    9: "#CCAAAA"
    11: "DD6666"
    5: "#AAEEAA"
    10: "#AADDAA"
    15: "#AACCAA"
    20: "#AABBAA"
    7: "#AAAADD"
    14: "#AAAACC"
    12: "#00FFFF"
    13: "#FFFF00"
    17: "#FF00FF"
    18: "#55DD55"
    19: "#DD00DD"

  set_color = (n, width) ->
    color = "white"
    for delta in [0, 1]
      i = width + delta
      if n % i == 0 and colors[i]
        return colors[i]
    for i in [20..1] by -1
      if n % i == 0 and width % i == 0 and colors[i]
        return colors[i]
    if n % 2 == 0
      return colors[2]
    color

  max_prime_factor = (n) ->
    return n if n <= 15
    max = null
    for i in [2...n]
      break if i * 2 > n
      if n % i == 0
        max = i
        return max if i * i >= n
    return max if max
    return n if n <= 23
    return max_prime_factor(n+1)

  width = 10
  special_number = 10
  draw = ->
    html = """
      <h3>#{special_number}</h3>
    """
    for i in [1..special_number]
      if special_number % i == 0
        html += """
          #{i} * #{special_number / i} = <b>#{special_number}</b><br>
          """
    html += "<hr>"
    for i in [1..10]
      html += """
        <b>#{special_number}</b> * #{i} = #{special_number * i}<br>
        """
    facts = $ "<div>"
    facts.html html
    facts.css "border", "1px black solid"    
    $("#multi_right").html facts
        
    table = $("#multiplication")
    table.empty()
    height = Math.floor 169 / width
    max = null
    for n in [2, 3, 4, 5, 7, 11, 13, 17]
      if width % n == 0
        max = n

          
    for i in [0...height]
      tr = $ "<tr>"
      table.append tr
      for j in [0...width]
        n = i * width + j + 1
        color = set_color(n, width)
        style = "background: #{color}"
        td = $ "<td style='#{style}' align='center'>#{n}</td>"
        if max and (j + 1) % max == 0
          td.css "border-right", "2px black solid"
        td.attr "height", 40
        td.attr "width", 40
        td.attr "font-size", "13px"
        if n == special_number
          td.css "border", "5px black solid"
        else if special_number % n == 0
          td.css "border", "3px blue solid"
        else if n % special_number == 0
          td.css "border", "3px red solid"
        if (n % width == 0) or (n % (width-1) == 0) or (n % (width+1) == 0)
          td.css "font-weight", "bold"
        f = (n) ->
          td.click ->
            special_number = n
            width = max_prime_factor n
            draw()
        f(n)
        tr.append td
      td = $ "<td> #{width} * #{i+1} = #{(i+1)*(width)} </td>"
      td.css "border", "1px blue solid"
      tr.append td

  $("#multi_wide").click ->
    width += 1
    special_number = width
    draw()
    
  $("#multi_narrow").click ->
    width -= 1
    special_number = width
    draw()
    
  $("#multi_plus_one").click ->
    special_number += 1
    width = max_prime_factor special_number
    draw()
    
  draw()

jQuery(document).ready ->
  $("body").css "width", 800
  Linkage()
  PythagProof()
  PythagFolding()
  TwelveTriangles()
  MultiplicationTables()
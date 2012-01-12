# This is Conway's Game of Life, with some tests interspersed.
# It is written in Coffeescript.
#
# - [live demo](http://shpaml.webfactional.com/misc/Game-Of-Life/game.html)
# - [Github repo](https://github.com/showell/Game-Of-Life/blob/master/game.coffee)

# <hr>
# At an abstract level, the Game of Live just involves cells
# that mutate according to their own liveness and the number of 
# alive neighbors.  Details about the world's geometry or exact
# rules for survival can be configured later.  
#
# IMPORTANT NOTE: This function returns another function. The
# function it returns will be called several times during the
# simulation (once per generation).
#
abstract_game_of_life = (world_factory, point_lives_next_gen) ->
  # This method controls the functional mapping of an old world to a 
  # new world, across one generation.
  return (old_world) -> 
    # We will create a new world and populate it.
    new_world = world_factory()
    # No fancy algorithm here: we just iterate the entire world.
    for cell in old_world.cells()
      is_alive = old_world.alive(cell)
      n = old_world.num_alive_neighbors(cell)
      fate = point_lives_next_gen(is_alive, n)
      new_world.set(cell, fate)
    new_world
 
# <hr>
# To keep things simple, we roll our own assert method.
assert = (cond) -> 
  if !cond
    debugger
    throw("assertion error")

# <hr>
# Inling unit testing.  We don't need a complicated world to test
# out the basic logic of an abstract game.  In fact, we use a 
# one-cell world.
do ->
  world_factory = ->
    cells = [false]
    obj =
      cells:
        -> [0]
      num_alive_neighbors:
        (i) -> 0
      alive:
        (i) -> cells[i]
      set:
        (i, fate) -> cells[0] = fate
      status:
        -> cells[0]
  toggle = (alive, n) -> !alive
  f = abstract_game_of_life(world_factory, toggle)
  w = world_factory()
  assert !w.status()
  w = f(w)
  assert w.status()
  w = f(w)
  assert !w.status()


# <hr>
# Out internal data structure is a simple hash, with keys that are comma-delimited
# coordinates.  We have a light abstraction here (set/alive), which should be
# durable across other data structures we might choose in the future.
data_2d = ->
  hash = {}
  key = (point) ->
    [x, y] = point
    "#{x},#{y}"
  obj =
    set: (point, fate) ->
      hash[key(point)] = fate
    alive: (point) -> 
      hash[key(point)]

# <hr>
# Testing an object with two methods is fairly straightforward.
do ->
  d = data_2d()
  assert !d.alive([5,7])
  d.set([5,7], true)
  assert d.alive([5,7])

# <hr>
# Our geometry is toroidal, which is a fancy term for saying we
# work like PacMan.  The left/right edges of the world are virtually
# connected to each other, as are the bottom/top.
get_toroidal_neighbors = (point, width, height) ->
  [x, y] = point
  # Perhaps a little overly clever in the code layout here?  These are 
  # actually 1-D arrays with eight values each.
  x_deltas = [
    -1,  0,  1,
    -1,      1,
    -1,  0,  1
  ]
  y_deltas = [
    -1, -1, -1,
     0,      0,
     1,  1,  1
  ]

  # Now we will return the coordinates of the eight neighbors, using the
  # relative values from above.  
  x_deltas.map (dx, i) ->
    dy = y_deltas[i]
    # A little gotch in Javascript in modular
    # arithmetic is that -1 % 10 is -1, not 9 as you expect. Since dx can
    # be negative, we have to add width first.
    xx = (x + dx + width) % width
    yy = (y + dy + height) % height
    [xx, yy]

# <hr>
# Testing.  Writing in a very functional style makes code easy to test.
do ->
  result = get_toroidal_neighbors([1,1], 10, 10)
  expected = [
    [0,0], [1,0], [2,0],
    [0,1],        [2,1],
    [0,2], [1,2], [2,2]
  ]
  assert(result.toString() == expected.toString())

# <hr>
# Our "world" object makes this program implement a concrete
# version of the Game of Life.  There are many variations.
# 
# The objects that use "world" are still abstracted from many
# details of the game.  But our implementation here restricts
# us to a rectangular two-dimensional toroidal geometry.
pacman_world = (width, height) ->
  # Create our internal data structure and populate it.
  data = data_2d()
  # We use "do ->" to make sure we don't pollute our scope
  # for one-time setup.
  cells = do ->
    points = []
    for x in [0...width]
      for y in [0...height]
        points.push([x,y])
    points

  # Report the number of alive neighbors for any cell.  This is
  # just glue on top of our internal data structure and an
  # external function.
  num_alive_neighbors = (loc) ->
    num = 0
    neighbors = get_toroidal_neighbors(loc, width, height)
    for n in neighbors
      num += 1 if data.alive(n)
    num

  # Set up our interface to the outside world.
  obj =
    alive: (x,y) -> data.alive(x,y)
    set: (x,y) -> data.set(x,y)
    cells: -> cells
    num_alive_neighbors: (point) -> num_alive_neighbors(point)

# <hr>
# Testing.
do ->
  w = pacman_world(10, 10)
  assert(w.cells().length == 100)
  w.set([5,5], true)
  assert(w.alive([5,5]))
  assert(w.num_alive_neighbors([5,5]) == 0)
  w.set([5,6], true)
  assert(w.num_alive_neighbors([5,5]) == 1)
  w.set([6,6], true)
  assert(w.num_alive_neighbors([5,5]) == 2)
  # try to fool us with a far-off cell
  w.set([9,9], true)
  assert(w.num_alive_neighbors([5,5]) == 2)
  # kill thy neighbor
  w.set([6,6], false)
  assert(w.num_alive_neighbors([5,5]) == 1)

# <hr>
# The SURVIVAL RULE.  If you are alive this generation, you need
# 2 or 3 neighbors to survive.  Unpopulated cells come into existence
# when there are exactly three neighbors.      
point_lives_next_gen = (alive, n) ->
  if alive
    n in [2, 3]
  else
    n == 3

# <hr>
# Inline unit testing.  For a pretty simple functional method, we really 
# just want a smoke test.  Laziness when it comes to testing leads to
# virtuous behavior--we extract methods that are dirt simple.
do ->
  assert point_lives_next_gen(true, 2)
  assert point_lives_next_gen(true, 3)
  assert point_lives_next_gen(false, 3)
  assert !point_lives_next_gen(false, 4)


# <hr>
# Our transform function uses an abstract method to do the heavy
# lifting.  We are just configuring stuff here.
board_transform_function = (width, height) ->
  create_world = -> pacman_world(width, height)
  abstract_game_of_life(
    create_world,
    point_lives_next_gen)

do ->
  f = board_transform_function()
  w = pacman_world(10, 10)
  w.set([0,0], true)
  w.set([1,0], true)
  w.set([2,0], true)
  assert(w.alive([1,0]))
  assert(!w.alive([1,1]))
  w = f(w)
  assert(!w.alive([0,0]))
  assert(w.alive([1,0]))
  assert(w.alive([1,1]))

# <hr>
# Seed our world with a configuration of cells.  This specific seeding has
# the nice property that the simulation will run for quite a while with
# many interesting variations.
seed_coords = ->
  # We could seed coordinates more directly than this algorithm, but we
  # represent the coordinates with strings to make the program easier to
  # inspect.
  seed = [
    "X      ",
    "       ",
    "XX     ",
    "       ",
    "  XXX  ",
    "       ",
    "   XXX ",
    "    X  ",
  ]
  points = []
  for s, x in seed
    for y in [0...s.length]
      points.push([x,y]) if s.charAt(y) != ' '
  [x+5, y+5] for [x,y] in points

seed_world = (world) ->
  for coord in seed_coords()
    world.set(coord, true)

do ->
  w = pacman_world(20, 20)
  seed_world(w)
  assert(w.alive([5, 5]))
  assert(w.alive([7, 5]))
  assert(!w.alive([8, 5]))

# <hr>
# Drawing code.  There is nothing fancy here. We represent a 2D
# matrix of cells using rectangles on a canvas.
view_2d = (width, height) ->
  canvas = document.getElementById("canvas")
  ctx = canvas.getContext("2d")

  draw: (x, y, fate) ->
    ctx.fillStyle = 
      if fate
        'black'
      else
        'white'
    w = 10
    h = 10
    x = x * w
    y = y * h
    ctx.fillRect(x, y, w, h)

# <hr>
# This object ties together a view-agnostic model with a model-agnostic view.
# It is very light, but it decouples two objects that do more heavy lifting.
display = (width, height) ->
  view = view_2d(width, height)
  render_board: (world) ->
    for x in [0...width]
      for y in [0...height]
        fate = world.alive([x, y])
        view.draw(x, y, fate)

# <hr>
# This is a very abstract animation object.  It doesn't know anything about
# the Game of Life.  It just renders frames in succession, using a step_function
# to iterate from one opaque data object to another.
animate = (initial_data, step_function, render_func, delay, max_ticks) ->
  tick = 0
  current_data = initial_data

  pulse = ->
    tick += 1
    render_func(current_data)
    if (tick < max_ticks)
      current_data = step_function(current_data)
      render_func(current_data)
      setTimeout(pulse, delay)
  pulse()

# <hr>
# Now we set everything in motion!
do -> 
  # CONFIGURATION
  WIDTH = 50
  HEIGHT = 40
  MAX_TICKS = 800
  DELAY = 5 # milliseconds

  # Set up our key objects, starting with our model.
  initial_world = pacman_world(WIDTH, HEIGHT)
  seed_world(initial_world)
  # Layer on rendering.
  render_function = display(WIDTH, HEIGHT).render_board
  # Create the function to evolve our model.
  data_transform_function = board_transform_function(WIDTH, HEIGHT)
  # And then animate it.
  animate(
    initial_world,
    data_transform_function,
    render_function,
    DELAY,
    MAX_TICKS
  )


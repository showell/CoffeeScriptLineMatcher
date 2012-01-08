lru_list = ->
  # This is a list supporting these operations quickly:
  #    push, shift, size
  #
  # We don't need random access, so we use a doubly linked list
  # to get O(1) time on the operations we do support.
  # 
  # The list is very opaque.  Once you push an item on to the back of the
  # list, you can only retrieve it (later) when it's the front element.  The call
  # to push() also gives you a callback to remove the element.
  #
  # Use case: helper for lru_cache.
  cnt = 0
  start_node = null
  end_node = null

  remove = (node) ->
    cnt -= 1
    throw "error" if cnt < 0
    if node.prev
      node.prev.next = node.next
    else
      start_node = node.next
    if node.next
      node.next.prev = node.prev
    else
      end_node = node.prev
  
  lst =
    push: (v) ->
      cnt += 1
      if cnt == 1
        node =
          v: v
          prev: null
          next: null
        start_node = node
        end_node = node
      else
        node =
          v: v
          prev: end_node
          next: null
        end_node.next = node
        end_node = node
      # return a function so caller can remove item
      # from the list
      -> remove(node)
    
    shift: ->
      cnt -= 1
      throw "error" if cnt < 0
      v = start_node.v
      if cnt == 0
        start_node = null
        end_node = null
      else
        start_node = start_node.next
        start_node.prev = null
      v
      
    debug: ->
      console.log '----'
      if cnt == 0
        console.log '(empty)'
      node = start_node
      while node
        console.log node.v
        node = node.next
    
    size: ->
      cnt
      
    test: ->
      # call lru_list().test() to see in action
      lst.push "hello"
      lst.push "goodbye"
      lst.debug()
      lst.shift()
      lst.debug()
      lst.shift()
      lst.debug()
      remove_a = lst.push "a"
      remove_b = lst.push "b"
      remove_c = lst.push "c"
      lst.debug()
      remove_b()
      lst.debug()
      remove_c()
      lst.debug()
      remove_a()
      lst.debug()
      
lru_cache = (capacity) ->
  # This is an LRU cache.  An LRU behaves like a hash where old items expire.
  # We implement it as a hash for the core data structure, then we have a linked
  # list of keys that allows us to keep track of expiring keys.  
  lst = lru_list()
  cache = {}
  
  add = (k, v) ->
    if lst.size() == capacity
      old_key = lst.shift()
      # console.log "purging #{old_key} from cache!"
      delete cache[old_key]
    cache[k] =
      remover: lst.push k  
      v: v
      
  update = (k) ->
    cell = cache[k]
    cell.remover()
    cell.remover = lst.push k
  
  self =
    put: (k, v) ->
      cell = cache[k]
      if cell
        update k
      else
        add k, v 
        
    get: (k) ->
      cell = cache[k]
      return [false, null] if !cell
      update k
      [true, cell.v]
      
    test: ->
      # call lru_cache(2).test() to see in action
      self.put(1, "one")
      self.put(2, "two")
      self.put(3, "three")
      console.log self.get(3)
      console.log self.get(2)
      console.log self.get(1)
      self.put(4, "four")
      console.log self.get(3)
      console.log self.get(2)
      console.log self.get(4)
      
lru_cache(2).test()   
    
  


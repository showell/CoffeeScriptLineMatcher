(function() {
  var lru_cache, lru_list;
  lru_list = function() {
    var cnt, end_node, lst, remove, start_node;
    cnt = 0;
    start_node = null;
    end_node = null;
    remove = function(node) {
      cnt -= 1;
      if (cnt < 0) {
        throw "error";
      }
      if (node.prev) {
        node.prev.next = node.next;
      } else {
        start_node = node.next;
      }
      if (node.next) {
        return node.next.prev = node.prev;
      } else {
        return end_node = node.prev;
      }
    };
    return lst = {
      push: function(v) {
        var node;
        cnt += 1;
        if (cnt === 1) {
          node = {
            v: v,
            prev: null,
            next: null
          };
          start_node = node;
          end_node = node;
        } else {
          node = {
            v: v,
            prev: end_node,
            next: null
          };
          end_node.next = node;
          end_node = node;
        }
        return function() {
          return remove(node);
        };
      },
      shift: function() {
        var v;
        cnt -= 1;
        if (cnt < 0) {
          throw "error";
        }
        v = start_node.v;
        if (cnt === 0) {
          start_node = null;
          end_node = null;
        } else {
          start_node = start_node.next;
          start_node.prev = null;
        }
        return v;
      },
      debug: function() {
        var node, _results;
        console.log('----');
        if (cnt === 0) {
          console.log('(empty)');
        }
        node = start_node;
        _results = [];
        while (node) {
          console.log(node.v);
          _results.push(node = node.next);
        }
        return _results;
      },
      size: function() {
        return cnt;
      },
      test: function() {
        var remove_a, remove_b, remove_c;
        lst.push("hello");
        lst.push("goodbye");
        lst.debug();
        lst.shift();
        lst.debug();
        lst.shift();
        lst.debug();
        remove_a = lst.push("a");
        remove_b = lst.push("b");
        remove_c = lst.push("c");
        lst.debug();
        remove_b();
        lst.debug();
        remove_c();
        lst.debug();
        remove_a();
        return lst.debug();
      }
    };
  };
  lru_cache = function(capacity) {
    var add, cache, lst, self, update;
    lst = lru_list();
    cache = {};
    add = function(k, v) {
      var old_key;
      if (lst.size() === capacity) {
        old_key = lst.shift();
        delete cache[old_key];
      }
      return cache[k] = {
        remover: lst.push(k),
        v: v
      };
    };
    update = function(k) {
      var cell;
      cell = cache[k];
      cell.remover();
      return cell.remover = lst.push(k);
    };
    return self = {
      put: function(k, v) {
        var cell;
        cell = cache[k];
        if (cell) {
          return update(k);
        } else {
          return add(k, v);
        }
      },
      get: function(k) {
        var cell;
        cell = cache[k];
        if (!cell) {
          return [false, null];
        }
        update(k);
        return [true, cell.v];
      },
      test: function() {
        self.put(1, "one");
        self.put(2, "two");
        self.put(3, "three");
        console.log(self.get(3));
        console.log(self.get(2));
        console.log(self.get(1));
        self.put(4, "four");
        console.log(self.get(3));
        console.log(self.get(2));
        return console.log(self.get(4));
      }
    };
  };
  lru_cache(2).test();
}).call(this);

window.urb = window.urb || {}

/// dependency long-poll

urb.dependencies = {}
urb.tries = 0
urb.pollDependencies = function() {
  var deps = []
  for(dep in urb.dependencies){
    deps.push(dep)
  }
  urb.dependencyPoll = new XMLHttpRequest()
  urb.dependencyPoll.open('GET', "/~/dependency.json?"+deps.join('&'), true)
  urb.dependencyPoll.addEventListener('load', function() {
    // if(~~(this.status / 100) == 4)
    //   return document.write(this.responseText)
    if(this.status === 200) {
      var dep = JSON.parse(this.responseText)
      var type = urb.dependencies[dep]
      urb.dependencyHandlers[type](dep)
      urb.delDependency(dep)
    }
    urb.retryDependencyPoll()
  })
  urb.dependencyPoll.addEventListener('error', urb.retryDependencyPoll)
  urb.dependencyPoll.addEventListener('abort', urb.retryDependencyPoll)
  urb.dependencyPoll.send()
}
urb.retryDependencyPoll = function() {
  setTimeout(urb.pollDependencies,1000*urb.tries)
  urb.tries++
}

urb.dependencyHandlers = {
  "code": function(){document.location.reload()},
  "data": function(){document.location.reload()}
}

urb.addDependency = function(deh,type){
  type = type || "code"
  if (deh && !urb.dependencies[deh]){
    if(urb.dependencies[deh] != type && urb.dependencyPoll)
        urb.dependencyPoll.abort(); // trigger keep
    urb.dependencies[deh] = type
  }
}
urb.delDependency = function(deh){
  if(urb.dependencies[deh]){
    delete urb.dependencies[deh]
    if(urb.dependencyPoll)  urb.dependencyPoll.abort(); // trigger keep
  }
}
    
/// helpers

urb.addDependencyElem = function(ele){
  url = ele.src || ele.href
  if(!url || (new URL(url)).host != document.location.host)
    return;
  urb.addDependencyUrl(url)
}
urb.addDependencyUrl = function(url){
  var xhr = new XMLHttpRequest()
  xhr.open("HEAD", url)
  xhr.send()
  xhr.onload = function(){
    urb.addDependency(urb.readDependencyHeader(this))
  }
}
urb.readDependencyHeader = function(xhr){
  var dep = xhr.getResponseHeader("etag")
  if(dep) return JSON.parse(dep.substr(2))
}


// Entry point

urb.initDependencies = function(){

  urb.addDependencyAllOf = function(sel){
    [].map.call(document.querySelectorAll(sel), urb.addDependencyElem)
  }
  urb.addDependencyAllOf('script'); urb.addDependencyAllOf('link')

  urb.pollDependencies()
}

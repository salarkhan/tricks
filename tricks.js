//sleep without setTimeout. genius.
function start(){
  console.log("i'm about to sleep yo")

  function sleep(milliSeconds){
    var startTime = new Date().getTime();
    while (new Date().getTime() < startTime + milliSeconds){}
  }
sleep(10000)
return ("i'm up!")
}

//returning console.error
var http = require('http')

http.get(process.argv[2], function (response) {
  response.setEncoding('utf8')
  response.on('data', console.log)
  response.on('error', console.error)
})


//css selector with jQuery
var anchor = $(a[href='/user/1'])

//custom javascript assert
function test(number){
    return number - 4
}

function assert(condition, description){
    if(!condition){
        throw description || 'failed'
    }
}

assert(test(3) === 4, 'line 21, tests 3==4')

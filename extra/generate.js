const clipboardy = require('clipboardy');
var generated = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15)
clipboardy.writeSync(generated)
console.log(generated)

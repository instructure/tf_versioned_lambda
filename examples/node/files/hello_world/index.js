var config
try {
  config = require('./config.json')
} catch (e) {
  config = {name: 'default'}
}
module.exports.handler = function(event, context, cb) {
  console.log('hello world ' + config.name)
  cb(null, config.name)
}

if (module === require.main) {
  module.exports.handler({}, {}, function() {
    console.log('done')
  })
}

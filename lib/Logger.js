const logger = require('pino')()

function createLogger (opts) {
  return logger.child(opts)
}

function createDebugLogger (opts) {
  return logger.child(opts).debug
}

module.exports = {
  createDebugLogger,
  createLogger
}

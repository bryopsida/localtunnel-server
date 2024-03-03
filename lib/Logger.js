const logger = require('pino')({
  level: process.env.LOG_LEVEL ?? 'info'
})

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

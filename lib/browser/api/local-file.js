'use strict'

const binding = process.atomBinding('local_file')

module.exports = {

  createBookmark: function(path) {
    return binding.createBookmark(String(path));
  },

  resolveBookmark: function(data) {
    return binding.resolveBookmark(String(data));
  },

  startAccessingSecurityScopedResource() {
    
  },

  stopAccessingSecurityScopedResource() {

  }

}

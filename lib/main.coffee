class LogEntry extends Backbone.Model

class LogEntryList extends Backbone.Collection
  model: LogEntry
  localStorage: new Backbone.LocalStorage("exercise-log-db")

class LogEntryView extends Backbone.View
  tagName: "tr"
  template: _.template($('#row-item').html()),

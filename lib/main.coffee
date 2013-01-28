class LogEntry extends Backbone.Model

class LogEntryList extends Backbone.Collection

  model: LogEntry
  localStorage: new Backbone.LocalStorage("exercise-log-db")

class LogEntryRowView extends Backbone.View

  tagName: "tr"
  template: _.template($('#row-item').html())

  render: =>
    @$el.html(@template())
    @

class AppView extends Backbone.View

  el: '#exercise-log-app'

  events:
    'click #add_entry': 'add_entry'

  initialize: =>

  add_entry: =>
    entry = new LogEntryRowView
    @$('#log_entries').append entry.render().el


$ ->
  new AppView

class LogEntry extends Backbone.Model

class LogEntryList extends Backbone.Collection

  model: LogEntry
  localStorage: new Backbone.LocalStorage("exercise-log-db")

class LogEntryRowView extends Backbone.View

  tagName: "tr"
  template: _.template($('#row-item').html())

  render: =>
    @$el.html(@template(@model.toJSON()))
    @

class AppView extends Backbone.View

  el: '#exercise-log-app'

  events:
    'click #add_new_entry': 'new_entry'

  initialize: =>
    @input_time = @$('#input_time')
    @entry_list = new LogEntryList
    @listenTo(@entry_list, 'add', @add_entry)
    @entry_list.fetch()

  add_entry: (entry) =>
    view = new LogEntryRowView(model: entry)
    @$('#log_entries').append view.render().el

  new_entry: =>
    @entry_list.create({time: @input_time.val()})
    @input_time.val('')


$ ->
  new AppView

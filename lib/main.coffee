class LogEntry extends Backbone.Model

class LogEntryList extends Backbone.Collection

  model: LogEntry
  localStorage: new Backbone.LocalStorage("exercise_log_db")

  total_time: =>
    @reduce (sum, model) =>
      sum + (parseInt(model.get('time')) || 0)
    , 0

class LogEntryRowView extends Backbone.View

  tagName: "tr"
  template: _.template($('#row_item_template').html())

  render: =>
    @$el.html(@template(@model.toJSON()))
    @

class AppView extends Backbone.View

  el: '#exercise_log_app'

  summary_template: _.template($('#summary_template').html())

  events:
    'click #add_new_entry': 'new_entry'

  initialize: =>
    @summary_info = $('#summary_info')
    @input_time = @$('#input_time')
    @entry_list = new LogEntryList
    @listenTo(@entry_list, 'add', @add_entry)
    @listenTo(@entry_list, 'all', @render)
    @entry_list.fetch({update: true})

  render: =>
    total = @entry_list.total_time()
    @summary_info.html(@summary_template({total: total}))
    @

  add_entry: (entry) =>
    view = new LogEntryRowView(model: entry)
    @$('#log_entries').append view.render().el

  new_entry: =>
    @entry_list.create({time: @input_time.val()})
    @input_time.val('')


$ ->
  new AppView

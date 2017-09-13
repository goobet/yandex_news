$ ->
  App.cable.subscriptions.create channel: 'TopicsChannel',
    received: (data) ->
      topic = data.topic
      $('.main-topic .title').html(topic.title)
      $('.main-topic .text').html(topic.text)
      $('.main-topic .date').html(topic.date)

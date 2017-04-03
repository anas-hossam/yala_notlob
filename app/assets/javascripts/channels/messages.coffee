jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))

    messages_to_bottom()
  App.messages = App.cable.subscriptions.create {
      channel: "OrdersChannel"
    },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      puts "test received"
      messages.append(data['message']+" invited to Order<br>")
    send_message: (message) ->
      @perform 'send_message', message: message
      messages.append(message+" invited to Order<br>")
     $('#friends').blur (e) ->
        $this = $(this)
        invited = $this
        App.messages.send_message invited.val()+"\n"
        console.log(invited.val())
        invited.val('')
        e.preventDefault()
        return false

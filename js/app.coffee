---
---
Contacter = 
  init: ->
    Contacter.name = $('#contactName').val().trim()
    Contacter.email = $('#contactEmail').val().trim()
    Contacter.message = $('#contactMessage').val().trim()

  valid: ->
    Contacter.init()
    !!Contacter.name && !!Contacter.email && !!Contacter.message

  clearFlash: ->
    $('#contact .flash_message').html('')

  showSuccessFlash: (msg) ->
    $('#contact .flash_message').html("<div class='alert alert-success alert-dismissible' role='alert'><button type='button' class='close' data-dismiss='alert'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button><span class='msg'>#{msg}</span></div>")


  showErrorFlash: (msg) ->
    $('#contact .flash_message').html("<div class='alert alert-danger alert-dismissible' role='alert'><button type='button' class='close' data-dismiss='alert'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button><span class='msg'>#{msg}</span></div>")

  post: ->
    Parse.initialize("Tmza9Fa6e6r40VCSQ4JrWPJPXSJOyHPoEkJe2aEy", "v0o3DH6CFJ8xlvWaG6snjtobJ9AnSCBq86kBpUXB")
    Message = Parse.Object.extend("Message")
    message = new Message()
    message.set("name", Contacter.name)
    message.set("email", Contacter.email)
    message.set("message", Contacter.message)
    message.save null,
      success: (message) ->
        $('#contactForm')[0].reset()
        Contacter.showSuccessFlash("Thanks for your message. We will get back to you shortly!")
      error: (message, error) ->
        Contacter.showErrorFlash("There was a problem submitting your message. Please try again, or drop an email to <em>hi@codeastra.com</em>.")
    return true

  submit: ->
    Contacter.clearFlash()
    if Contacter.valid()
      Contacter.post()
    else
      Contacter.showErrorFlash("Please enter all details")

$ ->
  $('#contactForm').submit (ev) ->
    ev.preventDefault()
    Contacter.submit()
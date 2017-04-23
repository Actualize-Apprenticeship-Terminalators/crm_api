class WebhooksController < ApplicationController
  def incoming_voice
    twiml = Twilio::TwiML::Response.new do |r|
      if params['From'] and params['From'] != ''
        r.Dial callerId: params['From'] do |d|
          d.Number '+17733048862'
        end
      else
        r.Say "Thanks for calling!"
      end
    end
    
    render xml: twiml.text
  end

  def incoming_text
    # twiml = Twilio::TwiML::Response.new do |r|
    #     r.Message do |message|
    #     # message.Body params['Body']
    #     # message.Media "https://demo.twilio.com/owl.png"
    #     # message.Media "https://demo.twilio.com/logo.png"
    #     end
    # end
    # render xml: twiml.text
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+17734666919',
      to: '+17733048862',
      body: "Message from #{params['From']}: #{params['Body']}"
    )
  end

end

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
    begin
      standard_phone = Phoner::Phone.parse(params['From'], country_code: '1').to_s
      @lead = Lead.find_by(standard_phone: standard_phone) if standard_phone
    rescue 
      # this will throw an exception if the given phone number is very off
    end

    extra_info = @lead.email if @lead
    
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+17734666919',
      to: '+17733048862',
      body: "Message from #{params['From']}: #{params['Body']}. Extra Info: #{extra_info}"
    )
  end

end

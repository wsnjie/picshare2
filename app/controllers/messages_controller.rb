class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  #skip_before_filter :authenticate_user!, :only => "reply"

  def incoming
    from = params["From"]

    if Number.find_by(number: from).blank?
      Number.create(number:from)
    end

    number = Number.find_by(number: from)

    if number.user.blank? && number.skip_sign_up == false
      boot_twilio
      sms = @client.messages.create(
        from: Rails.application.secrets.twilio_phone_number,
        to: from,
        body: "If you would like to register your name so we can give you credit for your pictures, send a text with 'Register' followed by your name :)"
      )

      number.update(skip_sign_up: true)
    end
    body = params["Body"]
    split = body.split(" ")

    if split[0]&.downcase == 'register'
      if number.user.blank?
        User.create(
          name: split.drop(1).join(" "),
          number: number
        )

        boot_twilio
        sms = @client.messages.create(
          from: Rails.application.secrets.twilio_phone_number,
          to: from,
          body: "Successfully registered #{from} to #{number.user.name}"
        )
      elsif number.user.present?
        boot_twilio
        sms = @client.messages.create(
          from: Rails.application.secrets.twilio_phone_number,
          to: from,
          body: "#{from} is already registered to #{number.user.name}. Text William @ 4046801732 if this isn't right."
        )
      end
    elsif params["MediaUrl0"].present?
      Pic.create(
        number: number,
        description: params["Body"],
        path: params["MediaUrl0"]
      )
      reply_body = "Thanks for for sending the pics of the party!"
      if number.user.present?
        reply_body = "#{number.user.name}, Thanks for sending pics!"
      end

      from_number = params["From"]
      boot_twilio
      sms = @client.messages.create(
        from: Rails.application.secrets.twilio_phone_number,
        to: from_number,
        body: reply_body
      )
    end
  end

   private

   def boot_twilio
     account_sid = Rails.application.secrets.twilio_account_sid
     auth_token = Rails.application.secrets.twilio_auth_token
     @client = Twilio::REST::Client.new account_sid, auth_token
   end
end
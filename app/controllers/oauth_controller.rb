#gem 'soundcloud-ruby-api-wrapper'
#require 'soundcloud'

class OauthController < ApplicationController
  def request_token
    callback_url = url_for :action => :access_token

    request_token = $sc_consumer.get_request_token(:oauth_callback => callback_url)
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    authorize_url = "http://#{$sc_host}/oauth/authorize?oauth_token=#{request_token.token}&display=popup"
    redirect_to authorize_url
  end

  def access_token
    post_uri = if params[:oauth_token] == session[:request_token]
      request_token = OAuth::RequestToken.new($sc_consumer, session[:request_token], session[:request_token_secret])
      access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

      #sc = Soundcloud.register({:access_token => access_token, :site => "http://api.#{$sc_host}"})
      #me = sc.User.find_me
      #username = me.username

      session[:access_token] = access_token.token
      session[:access_token_secret] = access_token.secret
      session[:request_token] = session[:request_token_secret] = nil

      url = "http://api.#{$sc_host}/tracks" # ?track[title]=Recording&track[public]=true"
      req = Net::HTTP::Post.new(url)
      access_token.sign!(req)
    else
      logger.error 'ERROR: OauthController::access_token: authorization failed -' +
        'request token in session does not match token passed in params'
      username = ''
    end

    redirect_to "/sc-connect-complete.html?post_uri=#{CGI::escape(post_uri)}"
  end

  def check_for_answers
    consumer = OAuth::Consumer.new \
      $consumer_token,
      $consumer_secret,
      :site => "http://api.#{$sc_host}"

    access_token = OAuth::AccessToken.new(consumer, $admin_consumer_token, $admin_consumer_secret)

    range = 10.hours
    query = "/me/tracks.json?created_at[from]=#{OAuth::Helper.escape (Time.now - range)}&created_at[to]=#{OAuth::Helper.escape Time.now}"

    response = access_token.request(:get, query)
    tracks = JSON.parse(response.body)

    text = ""
    tracks.each do |track|
      unless Track.find_by_track_id(track[:id])
        match = track['title'].match /^A(\d*) .*/ # like "A123 Awesome Answer!!!"
        if match && question_number = match[1]
          # this seems to be an answer
          qa = Qa.find_by_question_number(question_number)
          if qa && !qa.answer
            answer = Track.create({
              :track_id => track[:id],
              :user_id => track[:user_id],
              :permalink => track[:permalink],
              :title => track['title'],
              :user_permalink => track[:user_username],
              :artwork_url => track[:artwork_url],
              :waveform_url => track[:waveform_url],
              :user_username => track[:user_username]
            })
            qa.answer = answer
            qa.save!
            text += "new answer saved"
          else
            text += "answered a question that was not asked?"
          end
        else
          text += "question no match"
        end
      else
        text += "answer already in database"
      end
    end
    render :text => text
  end
end

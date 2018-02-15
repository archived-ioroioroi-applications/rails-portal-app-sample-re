# require './config/initializers/slack_api.rb'

module Messaging
  class Slack_api
    def self.create_channel(channel_name)
      response = Slack.channels_create({name: channel_name})
      if response['ok']
        p message = "[Success!] Created Slack channel \"\##{channel_name}\""
        return message
      else
        p message = "[Failed!] Check your Slack channel. "
        return message
      end
    end

    def self.leave_channel(channel_name)
      response = Slack.channels_leave({channel: channel_name})
      if response['ok']
        p message = "[Success!] Leaved Slack channel \"\##{channel_name}\""
        return message
      else
        p message = "[Failed!] Check your Slack channel. "
        return message
      end
    end

    def self.check_channel
      response = Slack.channels_list
      if response['ok']
        response['channels'].each do |channel|
          p "The Channel : #{channel['name']} has ChannelID [#{channel['id']}]"
        end
        return response
      else
        p message = "[Failed!] Check your Slack channel. "
        return message
      end
    end

    def self.post_message(content, user_name, channel_name)
      p response = Slack.chat_postMessage(text: content, username: user_name, channel: channel_name)
      if response['ok']
        p message = "[Success!] Posted message to your channel \"#{channel_name}\""
        return message
      else
        p message = "[Failed!] What happen!. "
        return message
      end

    end
  end
end

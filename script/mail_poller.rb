# default rails environment to development
ENV['RAILS_ENV'] ||= 'development'
# require rails environment file which basically "boots" up rails for this script
require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require 'gmail'

loop do
  Gmail.new('reportdengue', 'dengue@!$') do |gmail|
    gmail.inbox.emails.each do |email|
      email = gmail.imap.uid_fetch(email.uid, 'RFC822').first.attr['RFC822']
      ReportReader.receive(email)
    end
  end
  sleep(3)
end
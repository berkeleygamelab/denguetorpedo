# default rails environment to development
ENV['RAILS_ENV'] ||= 'development'
# require rails environment file which basically "boots" up rails for this script
require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require 'gmail'

STDOUT.sync = true unless ENV['RAILS_ENV'] == 'production'# flush all log messages to STDOUT
logger = Logger.new(STDOUT)
username = 'reportdengue'
password = 'dengue@!$'

loop do
  logger.info "starting another session"
  Gmail.new(username, password) do |gmail|
    # making sure we are logged in to parse an email, otherwise print out a log
    if gmail.logged_in? 
      logger.info "account logged in"
      gmail.inbox.emails(:unread).each_with_index do |email, index|
        logger.info "about to fetch an email via imap"
        ReportReader.receive(gmail.imap.uid_fetch(email.uid, 'RFC822').first.attr['RFC822'])
        
        #email.read!
        #email.archive!      
      end
    else
      logger.info "account not logged in"
    end
  end
  
  sleep(3)
end
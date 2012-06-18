task :starting_mail_poller do
  exec "ruby script/mail_poller_ctl.rb run"
end
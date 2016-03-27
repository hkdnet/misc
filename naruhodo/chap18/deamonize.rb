def daemonize_app
  if RUBY_VERSION < '1.9'
    daemonize_app_19
  else
    Process.daemon
  end
end

def daemonize_app_19
  exit if fork
  Process.setsid
  exit if fork
  Dir.chdir '/'
  STDIN.reopen '/dev/null'
  STDOUT.reopen '/dev/null', 'a'
  STDERR.reopen '/dev/null', 'a'
end

daemonize_app

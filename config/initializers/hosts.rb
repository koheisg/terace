Rails.application.configure do
  config.hosts << ".#{ENV['MAIN_DOMEIN']}"
  config.hosts << "koheisg.dreamin.cc"
  config.hosts << "dev.dreamin.cc"
  config.hosts << "www.forward-cc.com"
end

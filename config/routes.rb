Rails.application.routes.draw do
  constraints(-> (req) { ENV['MAIN_DOMEIN'].eql?(req.host) }) do
    mount Desk::Engine => "/"
  end
  constraints(-> (req) { req.subdomain.present? }) do
    mount Fishur::Engine => "/"
  end

  constraints(-> (req) { req.subdomain.present? }) do
    mount Terrace::Engine => "/"
  end

  get '/', to: redirect { |_p, r| "http://#{ENV['MAIN_DOMEIN']}:#{r.port}/" } if Rails.env.development?
end

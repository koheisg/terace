PRODUCTION_DATABASE_URL=`heroku config:get DATABASE_URL -a terace`
pg_dump -a -d  $PRODUCTION_DATABASE_URL > hoge.sql
./bin/rails db:schema:load
psql -d postgres://postgres:postgres@0.0.0.0:54320/terace_development -f hoge.sql
rm hoge.sql
./bin/rails r 'User.all.each {|u| u.update(password: "password")}; Site.all.each {|s| s.domain = s.domain.split(".").first + ".lvh.me"; s.save }'

FROM ruby:2.7

RUN apt-get update -q && apt-get install -qy vim

RUN gem install bundler -v 2.1.4
RUN gem install webrick -v 1.6.1

WORKDIR /usr/src/app
COPY . /usr/src/app
RUN bundle install

EXPOSE 4000

CMD [ "bundle", "exec", "jekyll", "serve", "--livereload" ]

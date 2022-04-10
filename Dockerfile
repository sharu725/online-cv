FROM ruby:3.0.1

RUN apt-get update -q && apt-get install -qy vim

RUN gem install jekyll

WORKDIR /usr/src/app
COPY . /usr/src/app
RUN gem install webrick

EXPOSE 4000

CMD [ "jekyll", "serve", "--livereload" ]

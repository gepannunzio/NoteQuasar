# Application Setup

## Important Versions
- Ruby: 3.3.0
- Node.js: 20.10.0
- Rails: 7.1.2
- PostgreSQL: 1.1
- Puma: 5.0
- Redis: 4.0.1
- bcrypt: 3.1.7
- image_processing: 1.2

## Prerequisites
Make sure you have the following tools installed on your machine:
- [asdf](https://github.com/asdf-vm/asdf)
- [Node.js](https://nodejs.org/)
- [Yarn](https://yarnpkg.com/)
- [PostgreSQL](https://www.postgresql.org/)

## Installation Steps

1. Install asdf and plugins:

asdf plugin add ruby
<br/>
asdf plugin add nodejs

2. Run setup bash script to install

cd Pannunzio-037fd6
<br/>
./setup.sh

## Alternatively you can perform the installation by hand

1. Install asdf and plugins:

asdf plugin add ruby
<br/>
asdf plugin add nodejs

2. Go To APP Repository

cd Pannunzio-037fd6


3. Install Ruby and Node.js:

asdf install ruby 3.3.0
<br/>
asdf global ruby 3.3.0
<br/>
gem update --system
<br/>
asdf install nodejs 20.10.0
<br/>
asdf global nodejs 20.10.0

4. Install dependencies:

npm install -g yarn
<br/>
gem install rails -v 7.1.2

5. Setup PostgreSQL:

sudo apt install postgresql libpq-dev
<br/>
sudo -u postgres createuser user -s

6. Install gems

bundle install

7. Tailwind CSS Setup:

rails tailwindcss:install
<br/>
rake db:create
<br/>
bin/importmap pin tailwindcss-stimulus-components

8. Run Server

bin/dev

## Importat Aclarations

1. The FrontEnd can be found in app/views (There you will find html + TailWindCSS), also you can find some of my CSS in app/assets/stylesheets
2. The BackEnd is all the rest, you can find all related with my DB in db/ and in app/models
3. You Can also see the backend for my objects in app/controllers
4. For Stimulus you can find it in app/javascript

## USERS

Feel Free to create as many test users as you desire, each user is owner of their notes and tags, hence the content is private
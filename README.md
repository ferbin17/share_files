# README
ShareFiles
==============
ShareFiles is a application that let you share files over internet.

## Requirements/Dependencies
-----------------
- #### RVM (Optional)
- #### Ruby: 2.6 or above.
- #### Rails: 6.0 or above
- #### Redis: 4.0+

## Requirements/Dependencies installations
-----------------
Before we set up the application, we need to install the requirements first.
- ### RVM  
  RVM is a Optional installation.  
  You can either use RVM or install ruby seperately.  
  RVM makes ruby installation and management easier  
  [RVM installation steps](https://rvm.io/rvm/install)  
- ### Ruby:  
  If using RVM,  
  ```sh
  rvm install 2.6.3
  ```
  (or any version >= 2.6.3)  
  
  If you are not using RVM,  
  ```sh
  $ sudo apt update
  $ sudo apt install ruby-full
  ```  
  [Ruby installation steps](https://www.ruby-lang.org/en/documentation/installation/)

- ### Redis  
  [Redis installation steps](https://redis.io/topics/quickstart)  
  Note: Check if redis-server is running wihtout problem by steps from above link.  

## Setting up application
-----------------
Change directory to project folder

- ### Bundler install  
  [Bundler Gem](https://bundler.io/)  
  run the commands  
  ```sh
  $ gem install bundler
  $ bundle install
  ```
  
- ### Yarn  
  ```sh
  yarn
  ```
  
- ### Database and Migrations  
  Run rake taks for database creation and migrations  
  ```sh
  rake db:create
  rake db:migrate
  ```
- ### Sidekiq  
  [Sidekiq Gem](https://github.com/mperham/sidekiq)  
  ```sh
  $ bundle exec sidekiq
  ```
  
- ### Whenever  
  [Whenever Gem](https://github.com/javan/whenever)  
  ```sh
  $ bundle exec wheneverize .
  $ whenever --update-crontab
  ```
  (Pullstop is mandatory)  
  
- ### Mail Settings  
  Goto config folder of the project  
  Open app_config.yml  
  Change the mail settings from default to your's.  
 
- ### Host Settings  
  Goto config folder of the project  
  Open app_config.yml  
  Change the host settings from default to your's.  
  
- ### Database Configuration  
  Goto config folder of project  
  Open database.yml   
  Change the database name, username and password to your's.  
  
- ### Set up the logo  
  Goto app/assets/images/ of project  
  Replace the logo.png with your logo.  
  
- ### Advertisement Settings if needed  
  Goto app/assets/images/carousel/ of project  
  Place your advertisement images in here  
  Open carousel.yml  
  Add the new advertisement image details in the format  
  ```ruby
    file_name_including_extension:  
      title: "Title"  
      description: "Description"  
      url: "www.example.com"  
  ```  
  
## Optionals:  
- ### Puma configuration  
  Goto config folder of project  
  Rename puma.rb.example to puma.rb  
  Open puma.rb  
  Change app_dir value to absolute path of project folder   
  ```ruby
    app_dir = 'home/user/some_folder/some_folder/some_folder/project_folder'
  ```
  
  #### Goto project folder
  Create folder services  
  Create folder services/logs  
  Create folder services/pids  
  Create folder services/sockets  

  #### as root user  
  copy share_file_app.service to /etc/systemd/system/share_file_app.service  
  ```sh
    $ systemctl daemon-reload  
    $ systemctl enable share_file_app.service  
    $ systemctl start share_file_app.service  
  ```
  
  #### Check status  
  ```sh
    $ systemctl status share_file_app.service  
  ```
  check errors with "journalctl -xe" or check for logs in services folder  

  #### Stop  
  ```sh
    $ systemctl status share_file_app.service  
  ```
  
  #### Restart  
  ```sh
    $ systemctl restart share_file_app.service  
  ```
  or
  ```sh  
    $ touch tmp/restart.txt  
  ```
  
- ### Service configuration  
  Open share_file_app.service file  
  Change the value User to your username  
  ```ruby
    User=username
  ```
  Change the value of WorkingDirectory to the absolute path of project folder
  ```ruby
    WorkingDirectory=/share_file/
  ```
  
  Change the /share_file/ of ExecStart with the absolute path of project folder  
  ```ruby
    ExecStart=/usr/local/rvm/wrappers/ruby-2.6.3@share_files/puma -C /share_file/ ../config.ru
  ```   
  
  ### Social Media links  
  Goto config folder of project  
  Open app_config.yml  
  Change values of social media url.  

----
Copyright © 2017 ShareFiles
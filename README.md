# README
ShareFiles
==============
ShareFiles is a application that let you share files over internet.

Requirements/Dependencies
-----------------
- RVM (Optional)
- Ruby: 2.6 or above.
- Rails: 6.0 or above
- Redis: 4.0+

Requirements/Dependencies installations
-----------------
Before we set up the application, we need to install the requirements first.
- RVM  
  RVM is a Optional installation.  
  You can either use RVM or install ruby seperately.  
  RVM makes ruby installation and management easier  
  [RVM installation steps](https://rvm.io/rvm/install)  
- Ruby:  
  If using RVM,  
  ```sh
  rvm install 2.6.3 (or any version >= 2.6.3).
  ```
  
  If you are not using RVM,  
  ```sh
  $ sudo apt update
  $ sudo apt install ruby-full
  ```  
  [Ruby installation steps](https://www.ruby-lang.org/en/documentation/installation/)

- Redis  
  [Redis installation steps](https://redis.io/topics/quickstart)  
  Note: Check if redis-server is running wihtout problem by steps from above link.  

Setting up application
-----------------
Change directory to project folder

- Bundler install
  [Bundler Gem](https://bundler.io/)
  run the commands
  ```sh
  $ gem install bundler
  $ bundle install
  ```
  
- Sidekiq
  [Sidekiq Gem](https://github.com/mperham/sidekiq)
  ```sh
  $ bundle exec sidekiq
  ```
  
- Whenever
  [Whenever Gem](https://github.com/javan/whenever)
  ```sh
  $ bundle exec wheneverize . (Pullstop is mandatory)
  $ whenever --update-crontab
  ```
  
 - Mail Settings
  Goto config folder in the project
  Open app_config.yml
  Change the mail settings from default to your's.
 
 - Host Settings
  Goto config folder in the project
  Open app_config.yml
  Change the host settings from default to your's.

 - Advertisement Settings if needed
  Goto app/assets/images/carousel/ of project
  Place your advertisement images in here
  Open carousel.yml
  Add the new advertisement image details in the format
    file_name:
      title: "Title"
      description: "Description"
      url: "www.example.com"
      
----
Copyright © 2017 ShareFiles
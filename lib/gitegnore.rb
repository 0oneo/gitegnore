require "gitegnore/version"
require 'fileutils'
require 'json'
require 'date'

module Gitegnore
  def self.list
    self.check

    return all_gitignores_in_repo
  end

  def self.fetch(name)
    self.check

    all_ig_names = self.all_gitignores_in_repo
    base_path = self.repo_dir

    name = "#{name}.gitignore" unless name.end_with? ".gitignore"

    all_ig_names.each do |ig_name|
      if ig_name.casecmp(name) == 0
        puts "found #{name}! copy to current directory..."
        FileUtils.cp "#{base_path}/#{ig_name}", "#{Dir.pwd}/.gitignore"
        return
      end
    end

    raise RuntimeError, "#{name}.gitignore not found"
  end

  private

    GITHUB_BASE_DIR = ".github"

    REPO_UPDATE_RECORD = "repo_update_date.json"

    # repo github/gitignore related
    GITIGNORE_REPO_USERNAME = "github"
    GITIGNORE_REPO_NAME = "gitignore"
    GITIGNORE_REPO_URL = "git@github.com:#{GITIGNORE_REPO_USERNAME}/#{GITIGNORE_REPO_NAME}.git"

    def self.check
      # create the repo if not exists
      if repo_exists? == false
        create_repo_env
      end

      # update repo to latest
      if self.need_to_update_repo?
        self.repo_fetch
      end
    end

    def self.repo_dir
      File.expand_path("~/" + GITHUB_BASE_DIR + "/" + GITIGNORE_REPO_USERNAME + "/" + GITIGNORE_REPO_NAME)
    end

    def self.update_record_path
      File.expand_path("~/" + GITHUB_BASE_DIR + "/" + REPO_UPDATE_RECORD)
    end

    def self.repo_update_date
      repo_update_record_path = self.update_record_path
      repo_update_record = {}
      if File.exists? repo_update_record_path
        file = File.read(repo_update_record_path)
        repo_update_record = JSON.parse(file)
      end
      return repo_update_record
    end

    def self.need_to_update_repo?
      update_record = repo_update_date
      repo_name = "#{GITIGNORE_REPO_USERNAME}/#{GITIGNORE_REPO_NAME}"
      last_update_date_str = update_record[repo_name]
      if last_update_date_str == nil
        return true
      end

      date_format = "%Y-%m-%d"
      last_update_date = Date::strptime(last_update_date_str, date_format)
      return last_update_date < (Date.today - 7)
    end

    def self.repo_exists?
      if Dir.exist?(repo_dir)
        origin_remote_url = self.change_pwd_do_sth(repo_dir, "git remote get-url origin").strip
        if origin_remote_url == GITIGNORE_REPO_URL
          return true
        end
      end

      return false;
    end

    def self.create_repo_env
      raise RuntimeError, "repo does exists" if repo_exists? == true

      # create the directory
      repo_parent_dir = File.expand_path("~/#{GITHUB_BASE_DIR}/#{GITIGNORE_REPO_USERNAME}")
      FileUtils::mkdir_p repo_parent_dir # TODO have not check whether create success or fail

      raise RuntimeError, "dir: #{repo_parent_dir} create failed" unless File.directory?(repo_parent_dir)

      # git clone the repo
      self.change_pwd_do_sth(repo_parent_dir, "git clone #{GITIGNORE_REPO_URL} 2> /dev/null")

      raise RuntimeError, "repo does not exists" if repo_exists? == false
    end

    def self.repo_fetch
      raise RuntimeError, "repo does exists" if repo_exists? == false

      puts "fetching upstream updates..."
      result = self.change_pwd_do_sth(repo_dir, "git pull origin master 2> /dev/null").strip
      if result == "Already up-to-date."
        update_record = repo_update_date
        repo_name = "#{GITIGNORE_REPO_USERNAME}/#{GITIGNORE_REPO_NAME}"
        today_date = DateTime.now.strftime('%Y-%m-%d')
        update_record[repo_name] = today_date

        File.open(self.update_record_path, "w") do |f|
          f.write(update_record.to_json)
        end
        puts "done...."
      else
        puts "some error happened: #{result}"
      end

    end

    def self.all_gitignores_in_repo
      raise RuntimeError, "repo does exists" if repo_exists? == false

      all_files = self.change_pwd_do_sth(repo_dir, "git ls-files -z")
      all_gitignore_files = all_files.split("\x0").reject do |f|
                              f.match(%r{^(.github|Global)/})
                            end
      return all_gitignore_files
    end

    def self.change_pwd_do_sth(new_pwd, action)
      previous_pwd = Dir.pwd
      FileUtils.cd new_pwd
      result = `#{action}`
      FileUtils.cd previous_pwd
      return result
    end

    # add a custom name to exsited language, then you can use `gitegnore install $custome_name` to install
    #
    def add_custom_name(custom_name, language_name)

    end
end

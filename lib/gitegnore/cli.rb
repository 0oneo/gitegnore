require "thor"
require "gitegnore"

module Gitegnore
  class CLI < Thor

    desc "list", "list all supported gitignores"
    def list
      ignorefile_list = Gitegnore.list
      ignorefile_list.each_with_index do |name, index|
        if index == 0
          print "all supported gitignore files:\n\n"
        end
        print name.gsub(".gitignore", "").ljust(30)

        if((index + 1) % 5) == 0
          puts
        end
      end
    end

    desc "fetch NAME", "fetch the corresponding $NAME.gitignore file to .gitignore in current working directory"
    def fetch(name)
      puts Dir.pwd
      Gitegnore.fetch(name)
    end
  end
end

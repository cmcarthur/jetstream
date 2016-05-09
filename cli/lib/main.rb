require "fileutils"
require "open3"
require "thor"
require "yaml"

require './lib/renderer'
require './lib/repository'

module Jet
class Logger
  def self.error(s)
    puts s
  end

  def self.info(s)
    puts s
  end
end

class Shell
  def self.create_directory(path, overwrite=false)
    if self.directory_exists?(path)
      if overwrite
        return true
      else
        Logger::error "FAILED: directory #{path} already exists!"
        return false
      end
    else
      Logger::info " - creating directory #{path}"
      dir = Dir.mkdir(path)
      return true
    end
  end

  def self.remove_directory!(path)
    if path == "/"
      Logger::error "You tried to `rm -rf /`, you fool!"
      exit 1
    end

    if self.directory_exists?(path)
      FileUtils.rm_rf(path)
    end

    return true
  end


  def self.create_file(path, contents, overwrite=false)
    if not overwrite and self.file_exists?(path)
      Logger::error "FAILED: file #{path} already exists!"
      return false
    else
      Logger::info " - creating file #{path}"
      file = File.new(path, "w")
      file.write(contents)
      file.close
      return true
    end
  end

  def self.directory_exists?(path)
    Dir.exists?(path)
  end

  def self.file_exists?(path)
    File.exists?(path)
  end

  def self.cmd(cmd, verbose=true)
    STDOUT.sync = true
    Open3.popen3(cmd) do |stdin, stdout, stderr, thread|
      while line=stdout.gets or line=stderr.gets
        if verbose then Logger::info line end
      end
    end
  end
end

class CLI < Thor
  desc "compile", "Pull dependencies and compile resource templates into .jet"
  def compile
    repo = Repository.new([
      {
        :name => "base",
        :type => "base",
        :dependencies => [],
        :properties => {},
        :ref => nil
      },
      {
        :name => "zone__us-east-1a",
        :type => "zone",
        :dependencies => [
          "base"
        ],
        :properties => {
          :az => "us-east-1a",
          :private_cidr_block => "10.0.1.0/24",
          :public_cidr_block => "10.0.2.0/24"
        },
        :ref => nil
      }
    ])

    renderer = Renderer.new(repo)

    Shell::create_file(
      "/jet/compiled/rendered.tf",
      renderer.render_all!,
      true
    ) or exit 1
  end

  desc "clean", "Remove all compiled files for current jet project."
  def clean
    if not in_project?
      Logger::error "FAILED: Couldn't find a jetstream project!"
      exit 1
    end

    Shell::remove_directory!(".jet/compiled")

    puts "Done!"
  end


  desc "configure", "Configure the current jet project"
  def configure
    access_key_id = ask("Access Key ID:")
    secret_access_key = ask("Secret Access Key:")

    provider_config = <<PROVIDER_CONFIG
    provider "aws" {
      access_key = "#{access_key_id}"
      secret_key = "#{secret_access_key}"
      region = "us-east-1"
    }
PROVIDER_CONFIG

    Shell::create_directory(
      "/jet/compiled",
      true
    ) or exit 1

    Shell::create_file(
      "/jet/compiled/provider.tf",
      provider_config,
      true
    ) or exit 1

    Logger::info("Done!")
  end

  desc "plan", "example task"
  def plan
    compile

    cmd = <<CMD
      /usr/bin/terraform plan -input=false \
        -state=/usr/lib/jetstream/state/terraform.tfstate \
        -var-file=/usr/lib/jetstream/state/variables.tfvars \
        -refresh=true \
        /jet/compiled
CMD
    Shell::cmd(cmd)
  end

  desc "apply", "example task"
  def apply
    cmd = <<CMD
      /usr/bin/terraform apply -input=false \
      -state=/data/state/terraform.tfstate \
      -var-file=/data/state/variables.tfvars \
      -refresh=true \
      /data/terraform
CMD
    Shell::cmd(cmd)
  end
end
end

Jet::CLI.start(ARGV)

#!/usr/bin/env ruby

require 'bundler/inline'

gemfile true do
  source 'https://rubygems.org'
  gem 'octokit', require: true
end


client = Octokit::Client.new(access_token: ENV['GITHUB_PERSONAL_ACCESS_TOKEN'])
client.auto_paginate = true

repos = client.organization_repositories(ENV['GITHUB_ORG'], type: 'all')

repos.each do |repo|
  p repo[:full_name]
  if Dir.exists?("#{ENV['HOME']}/src/github.com/#{repo[:full_name]}")
    Dir.chdir("#{ENV['HOME']}/src/github.com/#{repo[:full_name]}") do
      p `git fetch`
    end
  else
    p `git clone #{repo[:ssh_url]} #{ENV['HOME']}/src/github.com/#{repo[:full_name]}`
  end
end


#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  require 'octokit'
end


client = Octokit::Client.new(access_token: ENV['GITHUB_PERSONAL_ACCESS_TOKEN'])
client.auto_paginate = true

repos = client.organization_repositories(ENV['GITHUB_ORG'], type: 'all')

repos.each do |repo|
  p repo[:full_name]
  unless Dir.exists?("#{ENV['HOME']}/src/github.com/#{repo[:full_name]}")
    p `git clone #{repo[:ssh_url]} #{ENV['HOME']}/src/github.com/#{repo[:full_name]}`
  end
end


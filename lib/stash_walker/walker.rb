# Copyright 2016 PayByPhone Technologies, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'httparty'
require 'json'

module StashWalker
  class Walker
    include HTTParty

    def initialize(base:, user:, password:)
      self.class.basic_auth(user, password)
      @base_url = "#{base}/rest/api/1.0"
      self.class.base_uri(@base_url)
    end

    def repos(key:)
      STDERR.puts "Gathering repos from project key: #{key}"
      uri = "/projects/#{key}/repos"

      list = []
      values(uri: uri, start: 0).each do |value|
        path = "#{key}/#{value['slug']}"
        clone = (value['links']['clone'].select { |c| c['name'] == 'ssh' })[0]['href']
        list.push(path: path, clone: clone)
      end
      list
    end

    def projects
      uri = '/projects'

      list = []
      values(uri: uri, start: 0).each do |value|
        list.push(repos(key: value['key']))
      end
      list.flatten
    end

    def values(uri:, start:)
      resp = self.class.get("#{uri}?start=#{start}").body
      json = JSON.parse(resp)
      if json.include?('errors')
        messages = []
        json['errors'].each do |error|
          messages.push(error['message'])
        end
        raise "Errors were encountered with URL #{@base_url}#{uri}:\n#{messages.join("\n")}"
      end
      return [json['values'], values(uri: uri, start: json['nextPageStart'])].flatten unless json['isLastPage']
      json['values']
    end

    def projects_json(minified: false)
      return JSON.generate(projects) if minified
      JSON.pretty_generate(projects)
    end
  end
end

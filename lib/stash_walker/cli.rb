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

require 'trollop'
require 'stash_walker/walker'
require 'highline'

module StashWalker
  module CLI
    module_function

    # loads the command-line options.
    def load_opts(args: ARGV)
      Trollop.options(args) do
        banner <<-EOS.gsub(/^ {10}/, '')
          stash-walker: Fetch project URLs from BitBucket Server
          Usage:
            stash-walker [options] COMMAND ARGS
          [options] are:
        EOS

        opt :url, 'URL to your BitBucket server', type: String, default: 'https://bitbucket.org/'
        opt :username, 'Your BitBucket username', type: String
        opt :minify, 'Produce minified JSON', type: TrueClass, default: nil
        stop_on_unknown
      end
    end

    # Start the CLI.
    def start
      opts = load_opts
      cli = HighLine.new
      opts[:username] = cli.ask('Enter username: ') if opts[:username].nil?
      password = cli.ask('Enter password: ') { |q| q.echo = '*' }
      walker = StashWalker::Walker.new(base: opts[:url], user: opts[:username], password: password)
      cli.say(walker.projects_json(minified: opts[:minify]))
    end
  end
end

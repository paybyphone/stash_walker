# stash_walker

`stash-walker` walks a BitBucket (aka Stash) server and prints out the repo path
and SSH clone URLs in JSON format (pretty by default).

Check the code for info on how you can use the class itself versus the CLI.

## Usage

```
stash-walker: Fetch project URLs from BitBucket Server
Usage:
  stash-walker [options] COMMAND ARGS
[options] are:
  -u, --url=<s>         URL to your BitBucket server
  -s, --username=<s>    Your BitBucket username
  -m, --minify          Produce minified JSON
  -h, --help            Show this message<Paste>
```

## License

```
Copyright 2016 PayByPhone Technologies, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

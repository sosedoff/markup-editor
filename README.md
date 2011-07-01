Markup Editor
=============

MarkupEditor is a simple Sinatra-based web application to render html for markups (Markdown, Textile, Rdoc).

Main feature of this app is a split-screen where you can see how the result will look like. Also the produced output has the same styles as Github's README pages.

Based on Docify gem.

Online example
--------------

Hosted on Heroku: http://markup.heroku.com

Example document: http://markup.heroku.com/sample

Installation
------------

Just clone the repo:

    git clone git@github.com:sosedoff/markup-editor.git

And install all dependencies:

    cd ~/path/markup-editor
    bundle install

That's it. Its ready to go.

Deployment
----------

Run via Thin:

    cd ~/path/markup-editor
    thin start -e production

Run via Passenger:

    server {
      listen 80;
      server_name your.host.name.com;
      passenger_enabled on;
      rails_env production;
      rack_env production;
      root /path/to/markup-editor/public;
    }

Contribution
------------

- Fork project
- Add features
- Run tests
- Send pull request

License
-------

Copyright &copy; 2011 Dan Sosedoff.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Markup Editor

Markup Editor is a tiny sinatra application to render html pages from markup documents.

## Features

- Split screen view for editing and live preview
- Multiple markups: Markdown, RDoc, Textile
- Syntax highlighting
- Github-like styles
- Import gist documents

## Demo

- Live demo: [http://markup.heroku.com](http://markup.heroku.com)
- Example document: [http://markup.heroku.com/sample](http://markup.heroku.com/sample)
- Gist document: [http://markup.heroku.com/gist/959f04242b23c3e7573d](http://markup.heroku.com/gist/959f04242b23c3e7573d)

## Install

Just clone the repo:

```
git clone git@github.com:sosedoff/markup-editor.git
```

And install all dependencies:

```
bundle install
```

That's it. Its ready to go.

## Run

Run via Thin:

```
thin start -e production
```

## Contribute

- Fork project
- Add features
- Run tests
- Send pull request

## License

See LICENSE file for details

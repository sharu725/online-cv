# Hugo Orbit Theme

This is a Hugo port of [Orbit](//github.com/xriley/Orbit-Theme) - great looking resume/CV template designed for developers by Xiaoying Riley.

## Screenshot

![Orbit screenshot](https://raw.githubusercontent.com/aerohub/hugo-orbit-theme/master/images/screenshot.png)

## Features

### Original

- Fully Responsive
- HTML5 + CSS3
- Built on Bootstrap 3
- 6 Colour Schemes
- FontAwesome icons
- **LESS** files included
- Compatible with all modern browsers

### Added

- Google Analytics
- Print format improvements from [PR](//github.com/xriley/Orbit-Theme/pull/3)

## Demo

You can see it in action on [Hugo Themes site](http://themes.gohugo.io/theme/hugo-orbit-theme/).

## Contents

- [Installation](#installation)
- [Getting started](#getting-started)
    - [Copying files](#copying-files)
    - [Configuring](#configuring)
    - [Test your site](#test-your-site)
	- [Build your site](#build-your-site)
- [Contributing](#contributing)
- [License](#license)


## Installation

Inside the folder of your new Hugo site run:

    $ mkdir themes
    $ cd themes
    $ git clone https://github.com/aerohub/hugo-orbit-theme

For more information read the official [setup guide](//gohugo.io/overview/installing/) of Hugo.


## Getting started

After installing the theme successfully it requires just a few more steps to get your resume running.

### Copying  files

Take a look inside the [`exampleSite`](//github.com/aerohub/hugo-orbit-theme/tree/master/exampleSite) folder of this theme. You'll find a file called [`config.toml`](//github.com/aerohub/hugo-orbit-theme/blob/master/exampleSite/config.toml). To start just copy the `config.toml` into the root folder of your Hugo site.

### Configuring

Open your just-copied `config.toml` and fill it with your data. All the page content may be configured throw one file.

### Test your site

In order to see your site in action, run Hugo's built-in local server. 

    $ hugo server -w

Now enter `localhost:1313` in the address bar of your browser.

### Build your site

Just run

	$ hugo

You'll find your resume files in `public` folder in the root of Hugo project.

## Contributing

Did you found a bug or got an idea? Feel free to use the [issue tracker](//github.com/aerohub/hugo-orbit-theme/issues). Or make directly a [pull request](//github.com/aerohub/hugo-orbit-theme/pulls).

## License

The original template is released under the Creative Commons Attribution 3.0 License. Please keep the original attribution link when using for your own project. If you'd like to use the template without the attribution, you can check out other license options via template author's website: themes.3rdwavemedia.com

As for Hugo port you may rewrite the "Ported for..." line with setting your name at the end of `config.toml`
	
	[params.footer]
        copyright = ""


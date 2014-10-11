Emacs Zen
========

My simple minimalist emacs installation on Mac OS X, focused on editing LaTeX.

**Screenshot:**
![Emacs Zen Screenshot](http://personal.lse.ac.uk/robert49/misc/emacs-shot.png "Emacs Zen Screenshot")

## Requirements

Nothing special is required for emacs. But I'm writing this from the perspective of someone using Mac OS X, and I will assume some familiarity with the [command line](http://lifehacker.com/5633909/who-needs-a-mouse-learn-to-use-the-command-line-for-almost-anything) and with [basic emacs](http://www.jesshamrick.com/2012/09/10/absolute-beginners-guide-to-emacs/) operations.

## Basic Installation

### This folder

Make sure this folder is in your home directory ~/.emacs.d --- it's a hidden file, so if you don't have all hidden files revealed, you can access it through the Terminal by list using `ls -a` or just `cd` into it.

Even easier: create a Github account and fork this respository. Then use Github's desktop software to clone your .emacs.d folder to your home directory. You'll be able to repeat this process on all your machines, using Github to keep your Emacs preferences synced and shared on the web.

### Download and Install Emacs

The first step is to install a better version of emacs. There are various distributions available, e.g. [Aquamacs](http://aquamacs.org/) or [Emacs for Mac](http://emacsformacosx.com/). But Homebrew is the most hacker-friendly, and I'll assume here that you've installed that:

- [Homebrew](http://brew.sh/) -- Installation instructions are available on [wikemacs](http://wikemacs.org/wiki/Installing_Emacs_on_OS_X).

Of course your Mac comes pre-installed with emacs. But it's not kept up to date, e.g. at time of writing, Mac OS has emacs 22, but emacs is at emacs 24 which has all kinds of awesome and crucial stuff. So as to not mess with the factory-installed version, we use Homebrew to install and update a custom version. You can run this installation through the command line or through an Xwindows/GUI.

If you use Homebrew, note the comment at the end of the installation process that says where Emacs was installed. In my case it was in /usr/local/Cellar/emacs/24.3

### Link Updated Versions

You'll want to have Emacs sitting in your Applications folder with your other apps. And you'll want to be able to run it from the command line in the OS X terminal without screwing with the existing emacs installation. The former is accomplished by running the following in the command line:

	brew linkapps

You'll then see Emacs.app appear in your /Applications folder. The latter is accomplished by creating a shell alias. You can do this by editing your bash profile following these steps:

- Open Terminal.app	
- Open your bash profile by typing: `emacs ~/.bash_profile`
- Add this line to the end: `alias Emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"`
- Active you new settings by saving and quitting emacs (`C-x C-s` `C-x C-c`) and running this command in the terminal: `source .bash_profile`
- Now you'll be able to access your new Emacs installation by just running `Emacs` with a capital E in the command line.

There are lots more great suggestions for bash profile customizations written up by  [Nate Landau](http://natelandau.com/my-mac-osx-bash_profile/).

### Use a better package manager

We want to install a better package manager. The basic pre-installed package manager is called elpa. You can access it within emacs by going to `M-x` package-list --- but let's install the superior "melpa" manager first. The necessary code for this is included in the init.el file.

## All Things LaTeX

### Install Auctex

Now you need to install Auctex. This is the golden package for everything latex: an amazing reference manager, cool dropdown menus and completions, the works. Use the Emacs package mannager to install it. Within your sparkling new Emacs installation:

- `M-x package-list`
- Search/scroll down to Auctex and hit enter, then click install.

The basic compile command is `C-c C-c`. In general `C-c` will start you off with an Auctex command.

### Sync Skim

Now that Auctex is installed, you can get Latex to sync properly with a PDF reader. The best one for this is Skim.

- [Download Skim](http://skim-app.sourceforge.net/)

There are two steps to setting up syncing: forward syncing (hit `C-c C-v` in LaTeX and go to the line in the PDF where your cursor is) and backward syncing (command-shift-click on a paragraph in the PDF to go to the LaTeX line.)

As a preparation step, create a file called ~/.latexmkrc in your home directory and paste the following into it.

	$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
	$pdf_previewer = 'open -a skim';
	$clean_ext = 'bbl rel %R-blx.bib %R.synctex.gz';

Then set up forward and backward syncing using the following.

1. **Forward Syncing.** This is enabled in the init.el file, in the portion labeled "Skim PDF Syncing"

2. **Backward Syncing.** Open Emacs and go to Preferences > Sync. Choose Emacs, then change it to Custom and replace `emacsclient` with the location of your emacsclient file. In my case, it is: `/usr/local/Cellar/emacs/24.3/bin/emacsclient`

### Yasnippet

Use Melpa to install Yasnippet, an awesome tab-completion and snippet tool. Then activate it using the Yasnippet code in the init.el file. Once installed, Yasnippet will appear in the menu and let you create your own snippets.

### Further Notes on Reftex

Make sure you read up on Reftex and play around with it. It's amazing. As a test, open a document with an equation that is labeled with something like \label{eq:myequation}. Try typing the word Equation, then a space, and then hitting `C-c C-)` which calls Reftex's label-completion. A dropdown menu will appear with your file's section structure, and all the labeled equations highlighted for you to scroll through.

Other nice Reftex tricks include:

- `C-c [` - dropdown with citations pulled automatically from a linked bib file
- `C-c ]` - auto-end closest existing open environment
- `C-c (` - insert label

### Latex Preview Function

Auctex has a cool preview function. Notice in the preview menu that you can hit C-c C-c C-p to toggle a preview of latex-stuff, including math mode. This function uses ghostscript to display a little preview of the rendered results right in the buffer. It can be a little buggy for very complex maths environments, but for simple stuff it's great:

![Auctex Preview Screenshot](http://personal.lse.ac.uk/robert49/misc/auctex-preview.gif "Auctex Preview Screenshot")

Requirements:

1. **Ghostscript.** On OS X, it's now installed automatically starting with TexLive 2014. If you prefer to use TexLive 2013 or earlier, you can run `brew install ghostscript`

2. **Get emacs to find ghostscript.** For some reason emacs wouldn't find ghostscript by itself on my installation, and would return baloney like `pdf2dsc: command not found` and `No such file or directory, gs`. This is corrected by adding the location of the ghostscript bin to the PATH and executive path, with the following code (already in .emacs.d/init.el):

	(setenv "PATH"
	   (concat
	   "/usr/texbin" ":"
	   "/usr/local/bin" ":"
	   (getenv "PATH")
	   )
   )
   (setq exec-path (append exec-path '("/usr/local/bin")))

## Multimarkdown

Emacs Zen is also great for multimarkdown. It's pretty easy.

1. Install markdown from the terminal with `brew install markdown`
2. Add the markdown installation hooks (already in .emacs.d/init.el)

Especially nice features include `C-c C-c m` which will compile your markdown and open a web browser for you to look at it.

## Web-Mode: A better html mode

Editing html in emacs is also sublime. However, the default html-mode for emacs is pretty useless. To reach zen, you'll need a more serious html mode called `web-mode`, which is already all set up in this .emacs.d directory. The folder is in the .emacs.d file, and there's a hook to make it the default mode for html, css and js files is in `init.el`.

Apart from a number of helpful completion and tab conveniences, web-mode is smart enough to color html syntax, while also coloring css syntax when found within <style></style> tags, and js syntax when found within <script></script> tags.

![Web-Mode Syntax Coloring](http://web-mode.org/web-mode.png?v=4)

Absolutely lovely.

### Using Yasnippet with Web-Mode

Yasnippet has a rich set of built-in tab completions in html/css for almost everything you can think of. A quirk is just that it does not have a web-mode folder by default, and so these commands don't normally get loaded. This is easy to fix, and I have done so for this emacs setup. All I had to do is go to the yasnippet `snippets` folder and create a new folder called `web-mode`. Then I copied all the commands from `html-mode` and `css-mode` into it that new folder. The effect is lovely. For example, here are some of the built-in snippets:

- `p TAB` &rarr; `<p>[cursor here]</p>`
- `em TAB` &rarr; `<em>[cursor here]</em>`
- `img TAB` &rarr; `<img src="[1st tab]" class="[2nd tab]" alt="[3rd tab]" />`

Lots of the built-in snippets are really intuitive like that, but there are others, and of course you can create your own.

## More Emacs Zen Pleasantries on Mac OS X

I've added a couple of Mac OS X specific keystrokes to .emacs.d/init.el to make things pleasant on a Mac:

- **Up/Down Scrolling.** Using the up and down arrows will scroll the screen. In Emacs.app you have a ton of mousey actions available, clicking, scrolling, etc. But I like the arrows for fine-scrolling control.

- **Easy Italics/Bold.** I added hooks to LaTeX and markdown modes so that Cmd-i and Cmd-b will pop in italics and bold environments, respectively.

The OS X "command" key already does a lot of stuff you're used to: Cmd-s to save, Cmd-c to copy, Cmd-v to paste, etc. You can add more Cmd key bindings by using the code (kbd "s-<key>") for your desired <key>. See some examples in .emacs.d/init.el to get a feel for this.

## Forking and Github

Once you've achieved Emacs Zen, why not share the love? Create your own [github](https://github.com) repository for your .emacs.d folder, or create a fork for [my github repository](https://github.com/soulphysics/.emacs.d), and use Github's desktop application to keep your emacs folder synced across machines and forever shared on the web.

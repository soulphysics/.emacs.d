Emacs Zen
========

How to set up a simple, minimalist emacs installation, for editing LaTeX on Mac OS X.

**Screenshot:**
![Emacs Zen Screenshot](http://personal.lse.ac.uk/robert49/misc/emacs-shot.png "Emacs Zen Screenshot")

## Requirements

Drop the following files in your home directory.

- .emacs
- .latexmkrc

Drop the following file into the directory ~/.emacs.d/themes (create this directory if it doesn't exist yet).

- montekai.el

Then follow the instructions below.

## Basic Installation

### Download and Install

The first step is to install a better version of emacs. There are various distributions available. [Aquamacs](http://aquamacs.org/) is among the easiest and comes with Auctex installed out of the box. [Emacs for Mac](http://emacsformacosx.com/) is a bit more "no frills." Homebrew is the most hacker-friendly, and I'll assume here that you've installed that:

- [Homebrew](http://brew.sh/) -- Installation instructions are available on [wikemacs](http://wikemacs.org/wiki/Installing_Emacs_on_OS_X).

Of course your Mac comes pre-installed with emacs. But it's not kept up to date, e.g. at time of writing, Mac OS has emacs 22, but emacs is at emacs 24 which has all kinds of awesome and crucial stuff. So as to not mess with the factory-installed version, we use Homebrew to install and update a custom version. You can run this installation through the command line or through an Xwindows/GUI.

If you use Homebrew, note the comment at the end of the installation process that says where Emacs was installed. In my case it was in /usr/local/Cellar/emacs/24.3

### Link Updated Versions

You'll want to have Emacs sitting in your Applications folder with your other apps. And you'll want to be able to run it from the command line in the OS X terminal without screwing with the existing emacs installation. The former is accomplished by running the following in the command line:

	brew linkapps

The latter is accomplished by creating a shell alias. You can do this by editing your .bash_profile following these steps:

- Open Terminal.app	
- Open your bash profile by typing: emacs ~/.bash_profile
- Add this line to the end: alias Emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
- Active you new settings by saving and quitting emacs (C-x C-s C-x C-c) and running this command in the terminal: source .bash_profile
- Now you'll be able to access your new Emacs installation by just running Emacs with a capital E.

There are lots more great suggestions for .bash profile customizations written up by  [Nate Landau](http://natelandau.com/my-mac-osx-bash_profile/).

### Use a better package manager

We want to install a better package manager. The basic pre-installed package manager is called elpa. You can access it within emacs by going to M-x package-list --- but let's install the superior "melpa" manager first. The necessary code for this is included in the .emacs file.

## All Things LaTeX

### Install Auctex

Now you need to install Auctex. This is the golden package for everything latex: an amazing reference manager, cool dropdown menus and completions, the works. Use the Emacs package mannager to install it. Within your sparkling new Emacs installation:

	M-x package-list
	Search/scroll down to Auctex and hit enter, then click install.

The basic compile command is C-c C-c. In general C-c will start you off with an Auctex command.

### Sync Skim

Now that Auctex is installed, you can get Latex to sync properly with a PDF reader. The best one for this is Skim.

- [Download Skim](http://skim-app.sourceforge.net/)

There are two steps to setting up syncing: forward syncing (hit C-c C-v in LaTeX and go to the line in the PDF where your cursor is) and backward syncing (command-shift-click on a paragraph in the PDF to go to the LaTeX line.)

As a preparation step, create a file called .latexmkrc and paste the following into it.

	$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
	$pdf_previewer = 'open -a skim';
	$clean_ext = 'bbl rel %R-blx.bib %R.synctex.gz';

Then set up forward and backward syncing using the following.

1. **Forward Syncing.** Add the portion of my .emacs file labeled "Skim PDF Syncing"

2. **Backward Syncing.** Open Emacs and go to Preferences > Sync. Choose Emacs, then change it to Custom and replace emacsclient with the location of your emacsclient file. In my case, it's in: /usr/local/Cellar/emacs/24.3/bin/emacsclient

### Yasnippet

Use Melpa to install Yasnippet, an awesome tab-completion and snippet tool. Then activate it using the Yasnippet code in my .emacs file. Once installed, Yasnippet will appear in the menu and let you create your own snippets.

## Further Notes on Reftex

Make sure you read up on Reftex and play around with it. It's amazing. As a test, open a document with an equation that is labeled with something like \label{eq:myequation}. Try typing the word Equation, then a space, and then hitting C-c C-) which calls Reftex's label-completion. A dropdown menu will appear with your file's section structure, and all the labeled equations highlighted for you to scroll through.

Other nice Reftex tricks include:

- C-c [ (dropdown with citations pulled automatically from a linked bib file)
- C-c ] (auto-end closest existing open environment)
- C-c ( (insert label)

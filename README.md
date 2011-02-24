## This is my .vimrc.

I'm usually working with Python/Django and HTML/CSS/JavaScript, so my Vim IDE is configured for these languages.

All of the plugins are installed and updated via [Vundle plugin manager](http://github.com/gmarik/vundle)!

Have fun and fork at will! :)

## Quick start

1. Clone this repo: `git clone git://github.com/oryband/dotvim.git ~/.vim` - (Be careful not to override your own configuration...)
2. Initialize the [Vundle](http://github.com/gmarik/vundle) plugin as a sub-repository:

        git submodule add http://github.com/gmarik/vundle.git ~/.vim/vundle.git
        git submodule init
        git submodule update

3. You can then use `git submodule update` to update [Vundle](http://github.com/gmarik/vundle) any time.
4. Open vim and type `:BundleInstall!` to install all the plugins.
5. The rest is fully commented and explained in the `.virmc` file itself.


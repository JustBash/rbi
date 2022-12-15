# /bin/bash

rubyHome=/usr/local/ruby
rubyArchive=ruby.tar

if ! [[ $UID -eq 0 ]];then
   echo "You are not root! You are $USER"
   exit
fi

if ! [ $1 ]; then
    echo "No argument specified"
    exit
fi

if [ $1 == "setup" ]; then
    if [ -d $rubyHome ]; then
        echo "Ruby is already installed"
        exit
    fi

    if ! [ -f $rubyArchive.gz ] || ! [ -f $rubyArchive ]; then
        wget https://cache.ruby-lang.org/pub/ruby/3.1/ruby-3.1.3.tar.gz -O $rubyArchive.gz
    fi

    if ! [ -f $rubyArchive ]; then
        gunzip $rubyArchive.gz
    fi

    if ! [ -d ruby-3.1.3 ] || ! [ -d ruby ] || ! [ -d rubyHome ]; then
        tar xvf $rubyArchive
    fi

    mv ruby-3.1.3 $rubyHome
    cd $rubyHome
    bash configure
    make install
fi
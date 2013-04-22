# puppet-tkellem

A Puppet module for setting up the [tkellem](https://github.com/codekitchen/tkellem) IRC bouncer.

## Usage

First, install this module.

Then, do something like this:

    # install and start tkellem
    include tkellem
    
    # set up a user
    tkellem::user { 'phinze':
      admin    => true,
      password => 'somepassword'
    }
    
## Work in progress

Still need to define a `tkellem::network` type before this is really useful. Once I do that I'll get the normal puppet module metadata action going.
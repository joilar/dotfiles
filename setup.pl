#!/bin/perl

use strict;
use warnings;

use 5.010;

use Cwd qw(realpath);
use FindBin;

# Files reference: https://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc

my @SYMLINK_FILES = qw(.gitconfig .gitignore .vimrc);
my $HOME = realpath($ENV{'HOME'});

sub command
{
    my ($command, $message) = @_;
    say $message . ' [' . $command . ']';
    `$command`;
}

sub update_bash_config
{
    my ($file) = @_;

    # Open the file
    # Look for the source line
    # If it is not present, append it

    my $found = 0;

    if (open my $fh, '<', $HOME . '/' . $file)
    {
        while (my $line = <$fh>)
        {
            if ($line =~ m{(?:source|\.)\s+~/\.files/$file})
            {
                $found = 1;
                last;
            }
        }

        close $fh;
    }
    else
    {
        say 'Failed to open ' . $file . ': ' . $!;
        return;
    }

    return if $found;

    say 'Updating bash config [' . $file . ']';

    if (open my $fh, '>>', $HOME . '/' . $file)
    {
        say {$fh} '# User specific aliases and functions';
        say {$fh} 'if [ -f ~/.files/' . $file . ' ]; then';
        say {$fh} '     . ~/.files/' . $file;
        say {$fh} 'fi';
        close $fh;
    }
}

sub setup
{
    # Install .files in home folder
    my $source_folder = $FindBin::RealBin;
    if ($source_folder ne $HOME . '/.files')
    {
        command('rsync -r ' . $source_folder . '/ ~/.files', 'Syncing files');
    }

    # Create .bash_profile if necesssary
    my $bash_profile_note = 0;
    if (-e $HOME . '/.bash_profile' || -l $HOME . '/.bash_profile')
    {
        $bash_profile_note = 1;
    }
    else
    {
        command('cp ~/.files/.bash_profile ~/.bash_profile', 'Copying .bash_profile');
    }

    # Create bash configs if necessary
    command('touch ~/.bashrc ~/.profile', 'Touching bash configs');

    # Update them to source .files/ counterparts if they don't already
    update_bash_config('.bashrc');
    update_bash_config('.profile');

    # Remove .bash_login
    if (-e $HOME . '/.bash_login' || -l $HOME . '/.bash_login')
    {
        command('rm ~/.bash_login', 'Removing .bash_login');
    }

    # Symlink program specific config files
    for my $source_file (@SYMLINK_FILES)
    {
        unless (-e $HOME . '/' . $source_file || -l $HOME . '/' . $source_file)
        {
            command('ln -s ~/.files/' . $source_file . ' ~/' . $source_file, 'Symlinking ' . $source_file);
        }
    }

    if ($bash_profile_note)
    {
        say '';
        say 'Note: ~/.bash_profile already exists. Manually update it to source ~/.profile and ~/.bashrc if necessary.';
        say '  See ~/.files/.bash_profile for an example.';
    }
}

sub clean
{
    command('rm -rf ~/.files', 'Removing files');

    # Unlink program specific config files
    for my $source_file (@SYMLINK_FILES)
    {
        if (-l $HOME . '/' . $source_file)
        {
            command('rm ~/' . $source_file, 'Unlinking ' . $source_file);
        }
    }
}

for my $arg (@ARGV)
{
    if ($arg eq '-clean')
    {
        clean();
        exit;
    }
}

setup();


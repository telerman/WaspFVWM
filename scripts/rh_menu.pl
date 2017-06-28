#!/usr/bin/perl
#
# Description:   Adding remote hosts connections submenus to the FVWM main menu
# Requirements : remote_hosts file in $HOME/.fvwm directory,
#                written in the following format
#                <Host Name>:<menu name - free text>

my $my_display=$ENV{DISPLAY};
my $ORIGINAL_PATH=$ENV{PATH};
my $remote_term_font  = "-xos4-terminus-medium-r-normal-*-14-*-*-*-*-*-iso10646-*";
my $service_term_font = "-xos4-terminus-medium-r-normal-*-20-*-*-*-*-*-iso10646-*";
my $remote_xterm      = "xterm -bg \\#000000 -fg \\#00ff00 -fn $remote_term_font";
my $driver_status     = "xterm -geometry 75x30-0+0 -bg grey10 -fg \\#ff7f00 -fn $service_term_font";
my $link_status       = "xterm -geometry 75x10-0+0 -bg grey10 -fg \\#ff7f00 -fn $service_term_font";
my $lanconf_xterm     = "xterm -fn $remote_term_font -geometry 82x25";
my $service_term_cmd  = "xterm -geometry 75x10-0+0 -fn 7x15 -bg \\#1f0000 -fg \\#ff7f00";

print "\nDestroyMenu RHMenu";
print "\nAddToMenu RHMenu";
print "\n + \"Edit List\"\texec emacs --no-desktop --no-splash $ENV{HOME}/.fvwm/remote_hosts";

my %hosts_menu =undef;

open (REMOTE_HOSTS,"<$ENV{HOME}/.fvwm/remote_hosts");

while (<REMOTE_HOSTS>){
    chomp;
    next if (m/^\#/);
    if (m/^sep/) {
	print "\n + \"\"\t\t\tNop\n";
	next;
    }
    my @mi=split(/\:/,$_);
    print "\n + \"".$mi[0]."\"\tPopup \"".$mi[0]."\"";
    $hosts_menu{$mi[0]} = SubMenu($mi[1],$mi[0],$mi[2]);
}
close REMOTE_HOSTS;

foreach $line (keys %hosts_menu) {
    print $hosts_menu{$line};
}

print "\n";

sub SubMenu() {
    my $menu = $_[0];
    my $host = $_[1];
    my $user = $_[2];
    my $retval= "
\nDestroyMenu\t\"$menu\"
AddToMenu\t\"$menu\"
 + \"SSH\"\texec $remote_xterm -T $host -e 'ssh $host'";
    if ($user) {
    $retval = $retval."\n + \"SSH $user\"\texec $remote_xterm -T $host -e 'ssh $host -l $user'";
    }
    return $retval;
}

exit(0);

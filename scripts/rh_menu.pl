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
my $service_term_cmd  = "xterm -fn 7x15 -bg \\#1f0000 -fg \\#ff7f00";

print "\nDestroyMenu RemoteHostsMenu";
print "\nAddToMenu RemoteHostsMenu";
print "\n + \"Edit List\"\texec emacs $ENV{HOME}/.fvwm/remote_hosts";

my %hosts_menu =undef;

open (REMOTE_HOSTS,"<$ENV{HOME}/.fvwm/remote_hosts");
while (<REMOTE_HOSTS>){
    chomp;
    next if (m/^\#/);
    if (m/^sep/) {
	print "\n + \"\"\t\t\tNop\n";
	next;
    }
    my @line_split=split(/\:/,$_);
    $hosts_menu{$line_split[1]} = $line_split[0];
    my $host      = $line_split[0];
    my $menu_item = $line_split[1];
    next if (!$host);
    print "\n + \"$menu_item\"\tPopup \"$menu_item\"";
}
close REMOTE_HOSTS;

print "\n";

foreach $menu_item (keys %hosts_menu){
    my $host = $hosts_menu{$menu_item};
    next if (!$host);
    next if (!($host =~ m/^inx/));
    print "\n\nDestroyMenu \"$menu_item\"";
    print "\nAddToMenu \"$menu_item\"";
    print "\n + \"SSH\"\t   exec ssh -X -n -f $host \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& $remote_xterm -T $host\'";
    print "\n + \"ping\"\t\t      exec $service_term_cmd -T \'ping $host\' -e ping $host";
}

exit(0);

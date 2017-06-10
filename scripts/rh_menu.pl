#!/usr/bin/perl
# Author: Oleg Telerman
#         oleg.telerman@intel.com
#
# Description:   Adding remote hosts connections submenus to the FVWM main menu
# Requirements : remote_hosts file in $HOME/.fvwm directory,
#                written in the following format
#                <Host Name>:<menu name - free text>

my $my_display=$ENV{DISPLAY};
my $ORIGINAL_PATH=$ENV{PATH};
my $it_username = olegt;
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
    if (!($host =~ m/^inx/)) {
	print "\n + \"$menu_item\"\texec xterm -T $host -e ssh -X $host -l $it_username";
	next;
    }
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
    print "\n + \"SSH SV10G\"\t   exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& $remote_xterm -T $host\'";
    print "\n + \"lanconf\"\t     exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& $lanconf_xterm -T \"lanconf on $host\" -e sudo /opt/lanconf/lanconf32\'";
    print "\n + \"lanconf ZI\"\t  exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& $lanconf_xterm -T \"lanconf \-zeroinit on $host\" -e sudo /opt/lanconf/lanconf32 \-zeroinit\'";
    print "\n + \"dlog\"\t\t      exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& $service_term_cmd -T \"dlog\@$host\" -e dlog\'";
    print "\n + \"emacs\"\t\t     exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& emacs -geometry 120x50-0+0\'";
    print "\n + \"reload SVDT\"\t\t exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& \$HOME\/sv_driver\/load.sh ixgbe && $driver_status -T SVDT_STATUS -e \"/usr/bin/svdt -c && /usr/bin/svdt -s && sleep 5\"'";
    print "\n + \"SVDT -net\"\t\t   exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& \$HOME\/sv_driver\/load.sh ixgbe -net && $driver_status -T SVDT_STATUS -e \"/usr/bin/svdt -c && /usr/bin/svdt -s && sleep 5\"'";
    print "\n + \"SVDT -polling\"\t\t   exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& \$HOME\/sv_driver\/load.sh ixgbe -polling && $driver_status -T SVDT_STATUS -e \"/usr/bin/svdt -c && /usr/bin/svdt -s && sleep 5\"'";
    print "\n + \"SVDT Status\"\t\t exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& $driver_status -T SVDT_STATUS -e \"watch \'/usr/bin/svdt -c\'\"'";
    print "\n + \"Link Status\"\t\t exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& $link_status -T \"`hostname` LINK STATUS\" -e \"watch \'/usr/bin/svdt -s\'\"'";
    print "\n + \"ShutDown\"\t\t  exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& sudo init 0\'";
    print "\n + \"Reboot\"\t\t    exec ssh -X -n -f $host -l sv10g \'export DISPLAY\=$ENV{HOSTNAME}$ENV{DISPLAY} \&\& sudo init 6\'";
    print "\n + \"ping\"\t\t      exec $service_term_cmd -T \'ping $host\' -e ping $host";
}

exit(0);

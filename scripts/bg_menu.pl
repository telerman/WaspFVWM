#!/usr/bin/perl
use File::Copy;

my $icons_dir      = $ENV{HOME}."/.fvwm/icons";
my $background_dir = $ENV{HOME}."/.fvwm/backgrounds";

my @my_file_list=glob("$background_dir/*.*");

print "AddToMenu BGMenu\n";
print "+ DynamicPopupAction Function MakeBGMenu\n";

print " + \"None\"\texec rm $background_dir/default; xsetroot -fg \\#002222 -bg \\#00010e -mod 16 20\n";
print " + \"cycle\"\texec $ENV{HOME}/.fvwm/scripts/bg_cycle&";
    
foreach (@my_file_list){
    next if (m/icon/g);
    $new_name = $_;
    $new_name =~ s/\ +/_/g;
    $new_name =~ s/\,+/_/g;
    $new_name =~ s/\'+/_/g;
    move($_, $new_name);
    $icon_name = "icon_".(split(/\//,$new_name))[-1];
    $icon_name = (split(/\./,$icon_name))[0];
    $icon_name = $icon_name.".png";
    unless (-e $icons_dir."/".$icon_name) {
	system ("convert -resize 64x64 \"$new_name\" $icons_dir/$icon_name");
    }
    print " + \%$icon_name\%\t\texec feh --bg-scale $new_name;ln -sf $new_name  $ENV{HOME}/.fvwm/backgrounds/default\n";
}
exit 0;

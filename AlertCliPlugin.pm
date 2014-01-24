#
#
# Name of the plugin
package AlertCliPlugin;

# highly recommended for good style Perl programming
use strict;
use NfProfile;
use NfConf;
use Sys::Syslog;

# This string identifies the plugin as a version 1.3.0 plugin.
our $VERSION = 130;

#
# Periodic data processing function
#       input:  hash reference including the items:
#               'profile'       profile name
#               'profilegroup'  profile group
#               'timeslot'      time of slot to process: Format yyyymmddHHMM e.g. 200503031200
sub run {
        my $argref       = shift;

        my $profile      = $$argref{'profile'};
        my $profilegroup = $$argref{'profilegroup'};
        my $timeslot     = $$argref{'timeslot'};

        # Add your code here

} # End of run

#
# Alert condition function.
# if defined it will be automatically listed as available plugin, when defining an alert.
# Called after flow filter is applied. Resulting flows stored in $alertflows file
# Should return 0 or 1 if condition is met or not
sub alert_condition {
        my $argref = shift;

        my $alert      = $$argref{'alert'};
        my $alertflows = $$argref{'alertfile'};
        my $timeslot   = $$argref{'timeslot'};
        
        #syslog('info', "Alert condition called: alert: $alert, alertfile: $alertflows, timeslot: $timeslot");
        # Add your code here

        return 1;
}

#
# Alert action function.
# if defined it will be automatically listed as available plugin, when defining an alert.
# Called when the trigger of an alert fires.
# Return value ignored
sub alert_action {
	my $argref 	 = shift;

	my $alert 	   = $$argref{'alert'};
	my $timeslot   = $$argref{'timeslot'};

	#syslog('info', "Alert action function called: alert: $alert, timeslot: $timeslot");
  system("/opt/kayako_ticket/cli_kayako_ticket.php nfsen:$alert timeslot:$timeslot");
  

	return 1;
}

#
# The Init function is called when the plugin is loaded. It's purpose is to give the plugin 
# the possibility to initialize itself. The plugin should return 1 for success or 0 for 
# failure. If the plugin fails to initialize, it's disabled and not used. Therefore, if
# you want to temporarily disable your plugin return 0 when Init is called.
#
sub Init {
        return 1;
}

#
# The Cleanup function is called, when nfsend terminates. It's purpose is to give the
# plugin the possibility to cleanup itself. It's return value is discard.
sub Cleanup {
        #syslog("info", "PluginAlertCli Cleanup");
        # not used here
}

1;
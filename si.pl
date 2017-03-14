#!/usr/bin/perl

use File::Copy;
use File::Find;
use File::Spec;
use File::Path;
use File::Basename;
use File::Compare;
use Cwd;
use Win32::Registry;


my $ARGC = @ARGV;
my $command = $ARGV[0];

$command =~ s/(^\s+|\s+$)//g;

if($command eq "touch")
{
    my $file_new  = $ARGV[1];  

    if(-e $file_new)
    {
        my $currtime = time();
        utime($currtime,$currtime,$file_new);
    }
}
elsif ($command eq "compare")
{
    my $Register = "SOFTWARE\\Source Dynamics\\Source Insight\\3.0";
    my ($hkey,@key_list,$key);
    my %values;

    $HKEY_CURRENT_USER->Open($Register,$hkey)|| die $!;

    $hkey->GetValues(\%values);

    foreach $value (keys(%values))
    {
        $RegType  = $values{$value}->[1];
        $RegValue = $values{$value}->[2];
        $RegName  = $values{$value}->[0];

        print $RegName . ":" . $RegValue . "\n";

        if ($RegName eq "COMPARE_LEFTFILE")
        {
            $cmd_stsr = "\"C:\\Program Files (x86)\\Beyond Compare 3\\BCompare.exe\"";

            $cmd_stsr = $cmd_stsr . " \"" . $RegValue . "\"";

            $cmd_stsr = $cmd_stsr . " \"" . $ARGV[1] . "\"";

            print $cmd_stsr;
            
            system($cmd_stsr);
            
            last;
        }
    }
    $hkey->Close();
}
elsif ($command eq "get_file")
{
    $path_str  = $ARGV[1];  # location

    $dest_str  = $path_str;  # location
    $dest_str =~ s/[^\\]*$/patch/;

    $tmp_file = "make_svn_result_patch.txt";

    open (inf,$path_str) || die ("$path_str");
    @alllines = <inf>;
    close (inf);

    foreach $myline (@alllines)
    {
    	$dest = $myline;
        $is_modify = 1;
        
    	if ($dest !~ /.*:.*/)
    	{
    	    next;
    	}
    	
    	$dest =~ s/:.*$//;
        $_ = $dest;
        
        /(.*) \((.*)\)/;

        $temp_dir = $2;
        $file     = $1;
        $temp_dir =~s/\\/\//g;
        $dir = "/";

        $last_file = $file;
        
        if ($temp_dir =~ /^\s*$/)
        {       
            $src = "." . $dir;

        }
        else
        {        
            $dir = $dir . $temp_dir;
            $src = "." . $dir . "/";

        }
        
        $src  = "." . $dir . "/$file";

        system("svn status $src > $tmp_file 2>&1");
        open (inf,$tmp_file) || die ("$tmp_file!!!");
        @file_all = <inf>;
        close (inf);  

        foreach $item (@file_all)
        {
            if($item =~ m/^\?/ || $item =~ m/was not found/)
            {
                $is_modify = 0;
            }
        }

        if ($is_modify != 1)
        {
            next;
        }
        
        $dest = $dest_str . $dir;
        
        RecursiveMkdir($dest);
        
        $dest = $dest . "/$file";
        
        if (! -d $dest)
        {
            copy ($src ,$dest);
        }
    }
}
elsif($command eq "open_cmd")
{
    my $cur_dir_spd = $ARGV[1] . "\\Ms_code";
    my $cur_dir_mtk = $ARGV[1] . "\\base";
    my $dest_dir = $ARGV[1];
    
    if (-d $cur_dir_spd)
    {
        $dest_dir = $cur_dir_spd;
    }
    elsif (-d $cur_dir_mtk)
    {
        $dest_dir = $cur_dir_mtk;
    }

    my $Register = "SOFTWARE\\Source Dynamics\\Source Insight\\3.0";
    my ($hkey,@key_list,$key);
    my %values;

    $HKEY_CURRENT_USER->Open($Register,$hkey)|| die $!;

    $hkey->GetValues(\%values);

    $hkey->SetValueEx("CUR_PRJ_BASE",0,REG_SZ,$dest_dir);
    
    $hkey->Close();
}


sub get_key()
{
    $hkey->GetKeys(\@key_list);
    print "$Register keys\n";
    foreach $key (@key_list)
    {
        #
        print "$key\n";
    }
}

sub RecursiveMkdir()
{
    if (!(-d $_[0]))
    {
        RecursiveMkdir(dirname($_[0]));
        mkdir($_[0]);
    }
}


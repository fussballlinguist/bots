#!/usr/bin/perl -w

open FILE, "< /Pfad/zur/Datei.txt" or die $!;
foreach (<FILE>) {
	if ($_ =~ /(Und [\w, ]{50,275}\.)/) {
		print "$1\n";
	}
}

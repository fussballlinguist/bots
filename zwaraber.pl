#!/usr/bin/perl -w

open FILE, "< /Pfad/zur/Datei.txt" or die $!;
foreach (<FILE>) {
	if ($_ =~ /\. ([\w ]+?zwar [\w ]+?, )/) {
		$zwar{$1}++ if (length($1) > 30);
	}
	if ($_ =~ /Aber ([\w ]{50,100}\.)/) {
		$aber{$1}++;
	}
}
for (my $i = 0; $i < 1000; $i++) {
	@zwar_keys = keys %zwar;
	@aber_keys = keys %aber;
	print $zwar_keys[int rand(@zwar_keys)] . "aber " . $aber_keys[int rand(@aber_keys)] . "\n";
}

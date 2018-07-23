#!/usr/bin/perl -w

open FILE, "< /Pfad/zur/Datei.txt" or die $!;
foreach (<FILE>) {
	my $line = $_;
	if ($line =~ /\. ([\w ]+?zwar [\w ]+?, )/) {
		$zwar_hash{$1}++ if (length($1) > 30);
	}
	if ($line =~ /Aber ([\w ]{50,100}\.)/) {
		$aber_hash{$1}++;
	}
}
for (my $i = 0; $i < 1000; $i++) {
	@zwar_keys = keys %zwar_hash;
	@aber_keys = keys %aber_hash;
	print $zwar_keys[int rand(@zwar_keys)] . "aber " . $aber_keys[int rand(@aber_keys)] . "\n";
}

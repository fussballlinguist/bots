#!/usr/bin/perl -w

open FILE, "< /Pfad/zur/Datei.txt" or die $!;
foreach (<FILE>) {
	my $line = $_;
	if ($line =~ /\. ([\w ]+?zwar [\w ]+?, )/) {
		$zwar = $1;
		if (length($zwar) > 30) {
			$zwar_hash{$zwar}++;
		}
	}
	if ($line =~ /Aber ([\w ]{50,100}\.)/) {
		$aber = $1;
		$aber_hash{$aber}++;
	}
}
for (my $i = 0; $i < 1000; $i++) {
	@zwar_keys = keys %zwar_hash;
	$zwar_token = $zwar_keys[int rand(@zwar_keys)];
	@aber_keys = keys %aber_hash;
	$aber_token = $aber_keys[int rand(@aber_keys)];
	print "$zwar_token" . "aber " . "$aber_token\n";
}
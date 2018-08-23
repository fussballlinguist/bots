#! /usr/bin/perl -w

# Das Skript generiert eine zufällige Livetickermeldung und publiziert sie ggf. auf Twitter.
# Alle anzupassenden Teile sind mit # markiert.

use strict;
use warnings;
use Net::Twitter;
use Scalar::Util 'blessed';
use utf8;
use open ':std', ':encoding(utf8)';

# Pfad zur Tabelle mit den Teams (https://github.com/fussballlinguist/bots/blob/master/teams.txt) anpassen:
my $fh = "./teams.txt" 

# Wenn die Tickermeldung auf Twitter publiziert werden soll, hier Keys und Access Tokens der Twitter App definieren:
my $consumer_key = "xxxxxxxxxxxxxxxxxxxxxxxxx";
my $consumer_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
my $token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
my $token_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

open TEAMS, "< $fh" or die $!;

my %teams;
my $home;
my $away;
my $coach;
my $playername1;
my $playername2;
my $keeper;
my $nickname_home;
my $nickname_away;
my $ticker;

while (my $line = <TEAMS>) {
	$line = substr($line, 1, 3);
	$teams{$line}++;
}
do {
	my @team_keys = keys %teams;
	$home = $team_keys[int rand(@team_keys)];
	$away = $team_keys[int rand(@team_keys)];
} while ($home eq $away);

open TEAMS, "< $fh" or die $!;
while (<TEAMS>) {
	if (/\"$home\"/) {
		my @team_position = split /\t/, $_;
		$coach = $team_position[1];
		$coach =~ s/"//g;
		my @players = split ",", $team_position[3];
		do {
			$playername1 = $players[rand @players];
			$playername1 =~ s/"//;
			$playername2 = $players[rand @players];
			$playername2 =~ s/"//;
		} while ($playername1 eq $playername2);
		my @nicknames = split ",", $team_position[4];
		$nickname_home = $nicknames[rand @nicknames];
		$nickname_home =~ s/"//g;
	}
	if (/\"$away\"/) {
		my @team_position = split /\t/, $_;
		my @keepers = split ",", $team_position[2];
		$keeper = $keepers[rand @keepers];
		$keeper =~ s/"//;
		my @nicknames = split ",", $team_position[4];
		$nickname_away = $nicknames[rand @nicknames];
		$nickname_away =~ s/"//g;
	}
}
# Ab hier gebe ich jeweils drei exemplarische Array-Elemente an, die nach Wunsch ergänzt werden können. 
my @verbs = ("spielt","legt","schlägt");
my $verb = $verbs[rand @verbs];
my @balls = ("den Ball","das Ei","die Kugel");
my $ball1;
my $ball2;
do {
	$ball1 = $balls[rand @balls];
	$ball2 = $balls[rand @balls];
} while ($ball1 eq $ball2);
my @adjds = ("flach","direkt","sicher");
my $adjd = $adjds[rand @adjds];
my @adjas = ("schön","toll","stark");
my $adja = $adjas[rand @adjas];
my @nns = ("Pass1","Einsteigen1","Vorarbeit2");
my $nn = $nns[rand @nns];
my $nach;
if (substr($nn,-1) eq "1") {
	$nach = "Nach ".$adja."em ".$nn;
} elsif (substr($nn,-1) eq "2") {
	$nach = "Nach ".$adja."er ".$nn;
}
$nach = substr($nach,0,-1);
my @pps = ("in den rechten Winkel","durch die Beine von $keeper","über die Linie");
my $pp = $pps[rand @pps];
my @apprs = ("auf","zu");
my $appr = $apprs[rand @apprs];
my @kons = ("aber der","der aber","doch der","der jedoch");
my $kon = $kons[rand @kons];
my @fails = ("steht im Abseits","kann $ball2 nicht richtig stoppen","bringt $keeper fast zum Lachen","hat gar keine Zeit $ball2 zu platzieren und so gibt es Abstoß für die $nickname_away");
my $fail = $fails[rand @fails];
my @shots = ("Flachschuss","Distanzschuss","Fernschuss");
my $shot = $shots[rand @shots];
my @adjas_shot = ("satten","wuchtigen","strammen");
my $adja_shot = $adjas_shot[rand @adjas_shot];
my @vvfins_save = ("baggert","boxt","faustet");
my $vvfin_save = $vvfins_save[rand @vvfins_save];
my @pps_save = ("aus der Gefahrenzone","aus dem Strafraum","ins Toraus");
my $pp_save = $pps_save[rand @pps_save];
my @adjds_save = ("sicher","schön","souverän");
my $adjd_save = $adjds_save[rand @adjds_save];
my @roles = ("hängende Spitze","Rechtsverteidiger","Kapitän");
my $role = $roles[rand @roles];
my @tactics = ("läuft heute als $role auf","geht heute als $role in die Partie","wird von Trainer $coach als $role auf den Rasen geschickt");
my $tactic = $tactics[rand @tactics];
my @quotes = ("die Gunst der Stunde nutzen","an unsere Grenze gehen, um gegen die $nickname_away erfolgreich zu sein","an unsere Qualität glauben");
my $quote = $quotes[rand @quotes];
my @inquits = ("sagte","warnte","forderte");
my $inquit = $inquits[rand @inquits];
my @pps_quote = ("vor der Partie","vor dem Spiel","in der Pressekonferenz");
my $pp_quote = $pps_quote[rand @pps_quote];
my @injuries = ("Verletzung2","Kreuzbandriss1","Muskelproblemen3");
my $injury = $injuries[rand @injuries];
my @cures = ("ausgeheilt","überstanden","auskuriert");
my $cure = $cures[rand @cures];
my $cured;
if (substr($injury,-1) eq "1") {
	$cured = "nach $cure"."em $injury";
} elsif (substr($injury,-1) eq "2") {
	$cured = "nach $cure"."er $injury";
} elsif (substr($injury,-1) eq "3") {
	$cured = "nach $cure"."en $injury";
}
$cured = substr($cured,0,-1);
my @comebacks = ("gibt $cured sein Comeback","ist $cured wieder fit","kann $cured wieder auflaufen");
my $comeback = $comebacks[rand @comebacks];
my @games = ("mit drei Mann alleine vor dem Gehäuse von $keeper, aber sie sind sich nicht einig - und der Keeper der $nickname_away hat den Ball","versuchen es immer wieder aus der Distanz, weil die $nickname_away hinten gut stehen","haben das hier ganz gut im Griff, sind dem dritten Tor näher als die $nickname_away dem Ausgleich");
my $game = $games[rand @games];

my $ticker_goal = "$nach $verb $player1 $ball1 $adjd $pp.";
my $ticker_fail = "$nach $verb $player1 $ball1 $adjd $appr $player2, $kon $fail.";
my $ticker_save = "Nach einem $adja_shot $shot von $player1 $vvfin_save $keeper $ball1 $adjd_save $pp_save.";
my $ticker_tactic = "$player1 $tactic.";
my $ticker_quote = "\"Wir müssen $quote\", $inquit Trainer $coach $pp_quote.";
my $ticker_comeback = "$player1 $comeback.";
my $ticker_game = "Die $nickname_home $game.";

my $random = int(rand(11));
if ($random == 0) {
	$ticker = $ticker_tactic;
} elsif ($random == 1) {
	$ticker = $ticker_quote;
} elsif ($random <= 3) {
	$ticker = $ticker_fail;
} elsif ($random <= 5) {
	$ticker = $ticker_save;
} elsif ($random <= 7) {
	$ticker = $ticker_game;
} elsif ($random <= 9) {
	$ticker = $ticker_goal;
} elsif ($random == 10) {
	$ticker = $ticker_comeback;
}
$ticker .= " #$home$away";
print "$ticker\n";

my $nt = Net::Twitter->new(
    traits   => [qw/API::RESTv1_1/],
    consumer_key        => $consumer_key,
    consumer_secret     => $consumer_secret,
    access_token        => $token,
    access_token_secret => $token_secret,
);
my $result = $nt->update($ticker);

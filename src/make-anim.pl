#!/usr/bin/perl

use strict;
use warnings;

sub animation {
	my ($bounces, $width, $height) = @_;
	my $pc_delta = 50 / $bounces;
	my $x_delta = $width / $bounces;
	for (my $bounce = 0; $bounce < $bounces; $bounce++) {
		bounce($pc_delta * $bounce, $pc_delta, $x_delta * $bounce, $x_delta, $height);
	}
	for (my $bounce = $bounces; $bounce > 0; $bounce--) {
		bounce(50 + $pc_delta * ($bounces - $bounce), $pc_delta, $x_delta * $bounce, -$x_delta, $height);
	}
}

sub bounce {
	my ($pc_from, $pc_delta, $x_from, $x_delta, $height) = @_;
	my @tfs = (
		"cubic-bezier(0.250, 0.460, 0.450, 0.940)",
		"cubic-bezier(0.550, 0.085, 0.680, 0.530)",
		"cubic-bezier(0, 1.6, 0, -0.6)"
	);
	my $frames = 8;
	for (my $frame = 0; $frame < $frames; $frame++) {
		my $frac = $frame / $frames;
		my $pc = trunc($pc_from + $pc_delta * qw(0 0.1 0.15 0.4 0.65 0.675 0.7 1.0)[$frame]);
		my $sy = trunc(qw(1 0.7 1 1   1 0.95 1 1)[$frame]);
		my $ty = trunc(qw(0 0   0 1   0 0    0 0)[$frame] * -$height);
		my $tx = trunc($x_from + $x_delta * qw(0 0   0 0.5 1 1    1 1)[$frame]);
		my $tf = qw(0 1 0 1 1 0 1 1)[$frame];
		print "${pc}% { transform: scaleY(${sy}) translate(${tx}px, ${ty}px); animation-timing-function: $tfs[$tf]; }\n";
	}
}

sub trunc {
	my ($value) = @_;
	return sprintf("%.3g", $value);
}

print "\@keyframes bounce {\n";
animation(3, 1000, 400);
print "}\n";

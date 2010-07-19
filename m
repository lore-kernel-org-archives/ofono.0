Content-Type: multipart/mixed; boundary="===============2574822054090171456=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/4] Add original patch format checking script
Date: Mon, 19 Jul 2010 14:19:27 +0800
Message-ID: <1279520369-13214-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1279520369-13214-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2574822054090171456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test script is just a copy from kernel project. oFono uses this one
to check if the patch has some coding style issue.
---
 test/checkpatch.pl | 2615 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 2615 insertions(+), 0 deletions(-)
 create mode 100755 test/checkpatch.pl

diff --git a/test/checkpatch.pl b/test/checkpatch.pl
new file mode 100755
index 0000000..2d5ece7
--- /dev/null
+++ b/test/checkpatch.pl
@@ -0,0 +1,2615 @@
+#!/usr/bin/perl -w
+# (c) 2001, Dave Jones. <davej@redhat.com> (the file handling bit)
+# (c) 2005, Joel Schopp <jschopp@austin.ibm.com> (the ugly bit)
+# (c) 2007,2008, Andy Whitcroft <apw@uk.ibm.com> (new conditions, test s=
uite)
+# (c) 2008, Andy Whitcroft <apw@canonical.com>
+# Licensed under the terms of the GNU GPL License version 2
+
+use strict;
+
+my $P =3D $0;
+$P =3D~ s(a).*/@@g;
+
+my $V =3D '0.28';
+
+use Getopt::Long qw(:config no_auto_abbrev);
+
+my $quiet =3D 0;
+my $tree =3D 1;
+my $chk_signoff =3D 1;
+my $chk_patch =3D 1;
+my $tst_only;
+my $emacs =3D 0;
+my $terse =3D 0;
+my $file =3D 0;
+my $check =3D 0;
+my $summary =3D 1;
+my $mailback =3D 0;
+my $summary_file =3D 0;
+my $root;
+my %debug;
+GetOptions(
+	'q|quiet+'	=3D> \$quiet,
+	'tree!'		=3D> \$tree,
+	'signoff!'	=3D> \$chk_signoff,
+	'patch!'	=3D> \$chk_patch,
+	'emacs!'	=3D> \$emacs,
+	'terse!'	=3D> \$terse,
+	'file!'		=3D> \$file,
+	'subjective!'	=3D> \$check,
+	'strict!'	=3D> \$check,
+	'root=3Ds'	=3D> \$root,
+	'summary!'	=3D> \$summary,
+	'mailback!'	=3D> \$mailback,
+	'summary-file!'	=3D> \$summary_file,
+
+	'debug=3Ds'	=3D> \%debug,
+	'test-only=3Ds'	=3D> \$tst_only,
+) or exit;
+
+my $exit =3D 0;
+
+if ($#ARGV < 0) {
+	print "usage: $P [options] patchfile\n";
+	print "version: $V\n";
+	print "options: -q               =3D> quiet\n";
+	print "         --no-tree        =3D> run without a kernel tree\n";
+	print "         --terse          =3D> one line per report\n";
+	print "         --emacs          =3D> emacs compile window format\n";
+	print "         --file           =3D> check a source file\n";
+	print "         --strict         =3D> enable more subjective tests\n";
+	print "         --root           =3D> path to the kernel tree root\n";
+	print "         --no-summary     =3D> suppress the per-file summary\n";
+	print "         --summary-file   =3D> include the filename in summary\n";
+	exit(1);
+}
+
+my $dbg_values =3D 0;
+my $dbg_possible =3D 0;
+my $dbg_type =3D 0;
+my $dbg_attr =3D 0;
+for my $key (keys %debug) {
+	## no critic
+	eval "\${dbg_$key} =3D '$debug{$key}';";
+	die "$@" if ($@);
+}
+
+if ($terse) {
+	$emacs =3D 1;
+	$quiet++;
+}
+
+if ($tree) {
+	if (defined $root) {
+		if (!top_of_kernel_tree($root)) {
+			die "$P: $root: --root does not point at a valid tree\n";
+		}
+	} else {
+		if (top_of_kernel_tree('.')) {
+			$root =3D '.';
+		} elsif ($0 =3D~ m@(.*)/scripts/[^/]*$@ &&
+						top_of_kernel_tree($1)) {
+			$root =3D $1;
+		}
+	}
+
+	if (!defined $root) {
+		print "Must be run from the top-level dir. of a kernel tree\n";
+		exit(2);
+	}
+}
+
+my $emitted_corrupt =3D 0;
+
+our $Ident       =3D qr{[A-Za-z_][A-Za-z\d_]*};
+our $Storage	=3D qr{extern|static|asmlinkage};
+our $Sparse	=3D qr{
+			__user|
+			__kernel|
+			__force|
+			__iomem|
+			__must_check|
+			__init_refok|
+			__kprobes|
+			__ref
+		}x;
+our $Attribute	=3D qr{
+			const|
+			__read_mostly|
+			__kprobes|
+			__(?:mem|cpu|dev|)(?:initdata|init)|
+			____cacheline_aligned|
+			____cacheline_aligned_in_smp|
+			____cacheline_internodealigned_in_smp|
+			__weak
+		  }x;
+our $Modifier;
+our $Inline	=3D qr{inline|__always_inline|noinline};
+our $Member	=3D qr{->$Ident|\.$Ident|\[[^]]*\]};
+our $Lval	=3D qr{$Ident(?:$Member)*};
+
+our $Constant	=3D qr{(?:[0-9]+|0x[0-9a-fA-F]+)[UL]*};
+our $Assignment	=3D qr{(?:\*\=3D|/=3D|%=3D|\+=3D|-=3D|<<=3D|>>=3D|&=3D|\^=
=3D|\|=3D|=3D)};
+our $Compare    =3D qr{<=3D|>=3D|=3D=3D|!=3D|<|>};
+our $Operators	=3D qr{
+			<=3D|>=3D|=3D=3D|!=3D|
+			=3D>|->|<<|>>|<|>|!|~|
+			&&|\|\||,|\^|\+\+|--|&|\||\+|-|\*|\/|%
+		  }x;
+
+our $NonptrType;
+our $Type;
+our $Declare;
+
+our $UTF8	=3D qr {
+	[\x09\x0A\x0D\x20-\x7E]              # ASCII
+	| [\xC2-\xDF][\x80-\xBF]             # non-overlong 2-byte
+	|  \xE0[\xA0-\xBF][\x80-\xBF]        # excluding overlongs
+	| [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2}  # straight 3-byte
+	|  \xED[\x80-\x9F][\x80-\xBF]        # excluding surrogates
+	|  \xF0[\x90-\xBF][\x80-\xBF]{2}     # planes 1-3
+	| [\xF1-\xF3][\x80-\xBF]{3}          # planes 4-15
+	|  \xF4[\x80-\x8F][\x80-\xBF]{2}     # plane 16
+}x;
+
+our $typeTypedefs =3D qr{(?x:
+	(?:__)?(?:u|s|be|le)(?:\d|\d\d)|
+	atomic_t
+)};
+
+our @typeList =3D (
+	qr{void},
+	qr{(?:unsigned\s+)?char},
+	qr{(?:unsigned\s+)?short},
+	qr{(?:unsigned\s+)?int},
+	qr{(?:unsigned\s+)?long},
+	qr{(?:unsigned\s+)?long\s+int},
+	qr{(?:unsigned\s+)?long\s+long},
+	qr{(?:unsigned\s+)?long\s+long\s+int},
+	qr{unsigned},
+	qr{float},
+	qr{double},
+	qr{bool},
+	qr{struct\s+$Ident},
+	qr{union\s+$Ident},
+	qr{enum\s+$Ident},
+	qr{${Ident}_t},
+	qr{${Ident}_handler},
+	qr{${Ident}_handler_fn},
+);
+our @modifierList =3D (
+	qr{fastcall},
+);
+
+sub build_types {
+	my $mods =3D "(?x:  \n" . join("|\n  ", @modifierList) . "\n)";
+	my $all =3D "(?x:  \n" . join("|\n  ", @typeList) . "\n)";
+	$Modifier	=3D qr{(?:$Attribute|$Sparse|$mods)};
+	$NonptrType	=3D qr{
+			(?:$Modifier\s+|const\s+)*
+			(?:
+				(?:typeof|__typeof__)\s*\(\s*\**\s*$Ident\s*\)|
+				(?:$typeTypedefs\b)|
+				(?:${all}\b)
+			)
+			(?:\s+$Modifier|\s+const)*
+		  }x;
+	$Type	=3D qr{
+			$NonptrType
+			(?:[\s\*]+\s*const|[\s\*]+|(?:\s*\[\s*\])+)?
+			(?:\s+$Inline|\s+$Modifier)*
+		  }x;
+	$Declare	=3D qr{(?:$Storage\s+)?$Type};
+}
+build_types();
+
+$chk_signoff =3D 0 if ($file);
+
+my @dep_includes =3D ();
+my @dep_functions =3D ();
+my $removal =3D "Documentation/feature-removal-schedule.txt";
+if ($tree && -f "$root/$removal") {
+	open(my $REMOVE, '<', "$root/$removal") ||
+				die "$P: $removal: open failed - $!\n";
+	while (<$REMOVE>) {
+		if (/^Check:\s+(.*\S)/) {
+			for my $entry (split(/[, ]+/, $1)) {
+				if ($entry =3D~ m(a)include/(.*)@) {
+					push(@dep_includes, $1);
+
+				} elsif ($entry !~ m@/@) {
+					push(@dep_functions, $entry);
+				}
+			}
+		}
+	}
+	close($REMOVE);
+}
+
+my @rawlines =3D ();
+my @lines =3D ();
+my $vname;
+for my $filename (@ARGV) {
+	my $FILE;
+	if ($file) {
+		open($FILE, '-|', "diff -u /dev/null $filename") ||
+			die "$P: $filename: diff failed - $!\n";
+	} elsif ($filename eq '-') {
+		open($FILE, '<&STDIN');
+	} else {
+		open($FILE, '<', "$filename") ||
+			die "$P: $filename: open failed - $!\n";
+	}
+	if ($filename eq '-') {
+		$vname =3D 'Your patch';
+	} else {
+		$vname =3D $filename;
+	}
+	while (<$FILE>) {
+		chomp;
+		push(@rawlines, $_);
+	}
+	close($FILE);
+	if (!process($filename)) {
+		$exit =3D 1;
+	}
+	@rawlines =3D ();
+	@lines =3D ();
+}
+
+exit($exit);
+
+sub top_of_kernel_tree {
+	my ($root) =3D @_;
+
+	my @tree_check =3D (
+		"COPYING", "CREDITS", "Kbuild", "MAINTAINERS", "Makefile",
+		"README", "Documentation", "arch", "include", "drivers",
+		"fs", "init", "ipc", "kernel", "lib", "scripts",
+	);
+
+	foreach my $check (@tree_check) {
+		if (! -e $root . '/' . $check) {
+			return 0;
+		}
+	}
+	return 1;
+}
+
+sub expand_tabs {
+	my ($str) =3D @_;
+
+	my $res =3D '';
+	my $n =3D 0;
+	for my $c (split(//, $str)) {
+		if ($c eq "\t") {
+			$res .=3D ' ';
+			$n++;
+			for (; ($n % 8) !=3D 0; $n++) {
+				$res .=3D ' ';
+			}
+			next;
+		}
+		$res .=3D $c;
+		$n++;
+	}
+
+	return $res;
+}
+sub copy_spacing {
+	(my $res =3D shift) =3D~ tr/\t/ /c;
+	return $res;
+}
+
+sub line_stats {
+	my ($line) =3D @_;
+
+	# Drop the diff line leader and expand tabs
+	$line =3D~ s/^.//;
+	$line =3D expand_tabs($line);
+
+	# Pick the indent from the front of the line.
+	my ($white) =3D ($line =3D~ /^(\s*)/);
+
+	return (length($line), length($white));
+}
+
+my $sanitise_quote =3D '';
+
+sub sanitise_line_reset {
+	my ($in_comment) =3D @_;
+
+	if ($in_comment) {
+		$sanitise_quote =3D '*/';
+	} else {
+		$sanitise_quote =3D '';
+	}
+}
+sub sanitise_line {
+	my ($line) =3D @_;
+
+	my $res =3D '';
+	my $l =3D '';
+
+	my $qlen =3D 0;
+	my $off =3D 0;
+	my $c;
+
+	# Always copy over the diff marker.
+	$res =3D substr($line, 0, 1);
+
+	for ($off =3D 1; $off < length($line); $off++) {
+		$c =3D substr($line, $off, 1);
+
+		# Comments we are wacking completly including the begin
+		# and end, all to $;.
+		if ($sanitise_quote eq '' && substr($line, $off, 2) eq '/*') {
+			$sanitise_quote =3D '*/';
+
+			substr($res, $off, 2, "$;$;");
+			$off++;
+			next;
+		}
+		if ($sanitise_quote eq '*/' && substr($line, $off, 2) eq '*/') {
+			$sanitise_quote =3D '';
+			substr($res, $off, 2, "$;$;");
+			$off++;
+			next;
+		}
+
+		# A \ in a string means ignore the next character.
+		if (($sanitise_quote eq "'" || $sanitise_quote eq '"') &&
+		    $c eq "\\") {
+			substr($res, $off, 2, 'XX');
+			$off++;
+			next;
+		}
+		# Regular quotes.
+		if ($c eq "'" || $c eq '"') {
+			if ($sanitise_quote eq '') {
+				$sanitise_quote =3D $c;
+
+				substr($res, $off, 1, $c);
+				next;
+			} elsif ($sanitise_quote eq $c) {
+				$sanitise_quote =3D '';
+			}
+		}
+
+		#print "c<$c> SQ<$sanitise_quote>\n";
+		if ($off !=3D 0 && $sanitise_quote eq '*/' && $c ne "\t") {
+			substr($res, $off, 1, $;);
+		} elsif ($off !=3D 0 && $sanitise_quote && $c ne "\t") {
+			substr($res, $off, 1, 'X');
+		} else {
+			substr($res, $off, 1, $c);
+		}
+	}
+
+	# The pathname on a #include may be surrounded by '<' and '>'.
+	if ($res =3D~ /^.\s*\#\s*include\s+\<(.*)\>/) {
+		my $clean =3D 'X' x length($1);
+		$res =3D~ s@\<.*\>@<$clean>@;
+
+	# The whole of a #error is a string.
+	} elsif ($res =3D~ /^.\s*\#\s*(?:error|warning)\s+(.*)\b/) {
+		my $clean =3D 'X' x length($1);
+		$res =3D~ s@(\#\s*(?:error|warning)\s+).*@$1$clean@;
+	}
+
+	return $res;
+}
+
+sub ctx_statement_block {
+	my ($linenr, $remain, $off) =3D @_;
+	my $line =3D $linenr - 1;
+	my $blk =3D '';
+	my $soff =3D $off;
+	my $coff =3D $off - 1;
+	my $coff_set =3D 0;
+
+	my $loff =3D 0;
+
+	my $type =3D '';
+	my $level =3D 0;
+	my @stack =3D ();
+	my $p;
+	my $c;
+	my $len =3D 0;
+
+	my $remainder;
+	while (1) {
+		@stack =3D (['', 0]) if ($#stack =3D=3D -1);
+
+		#warn "CSB: blk<$blk> remain<$remain>\n";
+		# If we are about to drop off the end, pull in more
+		# context.
+		if ($off >=3D $len) {
+			for (; $remain > 0; $line++) {
+				last if (!defined $lines[$line]);
+				next if ($lines[$line] =3D~ /^-/);
+				$remain--;
+				$loff =3D $len;
+				$blk .=3D $lines[$line] . "\n";
+				$len =3D length($blk);
+				$line++;
+				last;
+			}
+			# Bail if there is no further context.
+			#warn "CSB: blk<$blk> off<$off> len<$len>\n";
+			if ($off >=3D $len) {
+				last;
+			}
+		}
+		$p =3D $c;
+		$c =3D substr($blk, $off, 1);
+		$remainder =3D substr($blk, $off);
+
+		#warn "CSB: c<$c> type<$type> level<$level> remainder<$remainder> coff_s=
et<$coff_set>\n";
+
+		# Handle nested #if/#else.
+		if ($remainder =3D~ /^#\s*(?:ifndef|ifdef|if)\s/) {
+			push(@stack, [ $type, $level ]);
+		} elsif ($remainder =3D~ /^#\s*(?:else|elif)\b/) {
+			($type, $level) =3D @{$stack[$#stack - 1]};
+		} elsif ($remainder =3D~ /^#\s*endif\b/) {
+			($type, $level) =3D @{pop(@stack)};
+		}
+
+		# Statement ends at the ';' or a close '}' at the
+		# outermost level.
+		if ($level =3D=3D 0 && $c eq ';') {
+			last;
+		}
+
+		# An else is really a conditional as long as its not else if
+		if ($level =3D=3D 0 && $coff_set =3D=3D 0 &&
+				(!defined($p) || $p =3D~ /(?:\s|\}|\+)/) &&
+				$remainder =3D~ /^(else)(?:\s|{)/ &&
+				$remainder !~ /^else\s+if\b/) {
+			$coff =3D $off + length($1) - 1;
+			$coff_set =3D 1;
+			#warn "CSB: mark coff<$coff> soff<$soff> 1<$1>\n";
+			#warn "[" . substr($blk, $soff, $coff - $soff + 1) . "]\n";
+		}
+
+		if (($type eq '' || $type eq '(') && $c eq '(') {
+			$level++;
+			$type =3D '(';
+		}
+		if ($type eq '(' && $c eq ')') {
+			$level--;
+			$type =3D ($level !=3D 0)? '(' : '';
+
+			if ($level =3D=3D 0 && $coff < $soff) {
+				$coff =3D $off;
+				$coff_set =3D 1;
+				#warn "CSB: mark coff<$coff>\n";
+			}
+		}
+		if (($type eq '' || $type eq '{') && $c eq '{') {
+			$level++;
+			$type =3D '{';
+		}
+		if ($type eq '{' && $c eq '}') {
+			$level--;
+			$type =3D ($level !=3D 0)? '{' : '';
+
+			if ($level =3D=3D 0) {
+				last;
+			}
+		}
+		$off++;
+	}
+	# We are truly at the end, so shuffle to the next line.
+	if ($off =3D=3D $len) {
+		$loff =3D $len + 1;
+		$line++;
+		$remain--;
+	}
+
+	my $statement =3D substr($blk, $soff, $off - $soff + 1);
+	my $condition =3D substr($blk, $soff, $coff - $soff + 1);
+
+	#warn "STATEMENT<$statement>\n";
+	#warn "CONDITION<$condition>\n";
+
+	#print "coff<$coff> soff<$off> loff<$loff>\n";
+
+	return ($statement, $condition,
+			$line, $remain + 1, $off - $loff + 1, $level);
+}
+
+sub statement_lines {
+	my ($stmt) =3D @_;
+
+	# Strip the diff line prefixes and rip blank lines at start and end.
+	$stmt =3D~ s/(^|\n)./$1/g;
+	$stmt =3D~ s/^\s*//;
+	$stmt =3D~ s/\s*$//;
+
+	my @stmt_lines =3D ($stmt =3D~ /\n/g);
+
+	return $#stmt_lines + 2;
+}
+
+sub statement_rawlines {
+	my ($stmt) =3D @_;
+
+	my @stmt_lines =3D ($stmt =3D~ /\n/g);
+
+	return $#stmt_lines + 2;
+}
+
+sub statement_block_size {
+	my ($stmt) =3D @_;
+
+	$stmt =3D~ s/(^|\n)./$1/g;
+	$stmt =3D~ s/^\s*{//;
+	$stmt =3D~ s/}\s*$//;
+	$stmt =3D~ s/^\s*//;
+	$stmt =3D~ s/\s*$//;
+
+	my @stmt_lines =3D ($stmt =3D~ /\n/g);
+	my @stmt_statements =3D ($stmt =3D~ /;/g);
+
+	my $stmt_lines =3D $#stmt_lines + 2;
+	my $stmt_statements =3D $#stmt_statements + 1;
+
+	if ($stmt_lines > $stmt_statements) {
+		return $stmt_lines;
+	} else {
+		return $stmt_statements;
+	}
+}
+
+sub ctx_statement_full {
+	my ($linenr, $remain, $off) =3D @_;
+	my ($statement, $condition, $level);
+
+	my (@chunks);
+
+	# Grab the first conditional/block pair.
+	($statement, $condition, $linenr, $remain, $off, $level) =3D
+				ctx_statement_block($linenr, $remain, $off);
+	#print "F: c<$condition> s<$statement> remain<$remain>\n";
+	push(@chunks, [ $condition, $statement ]);
+	if (!($remain > 0 && $condition =3D~ /^\s*(?:\n[+-])?\s*(?:if|else|do)\b/=
s)) {
+		return ($level, $linenr, @chunks);
+	}
+
+	# Pull in the following conditional/block pairs and see if they
+	# could continue the statement.
+	for (;;) {
+		($statement, $condition, $linenr, $remain, $off, $level) =3D
+				ctx_statement_block($linenr, $remain, $off);
+		#print "C: c<$condition> s<$statement> remain<$remain>\n";
+		last if (!($remain > 0 && $condition =3D~ /^(?:\s*\n[+-])*\s*(?:else|do)=
\b/s));
+		#print "C: push\n";
+		push(@chunks, [ $condition, $statement ]);
+	}
+
+	return ($level, $linenr, @chunks);
+}
+
+sub ctx_block_get {
+	my ($linenr, $remain, $outer, $open, $close, $off) =3D @_;
+	my $line;
+	my $start =3D $linenr - 1;
+	my $blk =3D '';
+	my @o;
+	my @c;
+	my @res =3D ();
+
+	my $level =3D 0;
+	my @stack =3D ($level);
+	for ($line =3D $start; $remain > 0; $line++) {
+		next if ($rawlines[$line] =3D~ /^-/);
+		$remain--;
+
+		$blk .=3D $rawlines[$line];
+
+		# Handle nested #if/#else.
+		if ($rawlines[$line] =3D~ /^.\s*#\s*(?:ifndef|ifdef|if)\s/) {
+			push(@stack, $level);
+		} elsif ($rawlines[$line] =3D~ /^.\s*#\s*(?:else|elif)\b/) {
+			$level =3D $stack[$#stack - 1];
+		} elsif ($rawlines[$line] =3D~ /^.\s*#\s*endif\b/) {
+			$level =3D pop(@stack);
+		}
+
+		foreach my $c (split(//, $rawlines[$line])) {
+			##print "C<$c>L<$level><$open$close>O<$off>\n";
+			if ($off > 0) {
+				$off--;
+				next;
+			}
+
+			if ($c eq $close && $level > 0) {
+				$level--;
+				last if ($level =3D=3D 0);
+			} elsif ($c eq $open) {
+				$level++;
+			}
+		}
+
+		if (!$outer || $level <=3D 1) {
+			push(@res, $rawlines[$line]);
+		}
+
+		last if ($level =3D=3D 0);
+	}
+
+	return ($level, @res);
+}
+sub ctx_block_outer {
+	my ($linenr, $remain) =3D @_;
+
+	my ($level, @r) =3D ctx_block_get($linenr, $remain, 1, '{', '}', 0);
+	return @r;
+}
+sub ctx_block {
+	my ($linenr, $remain) =3D @_;
+
+	my ($level, @r) =3D ctx_block_get($linenr, $remain, 0, '{', '}', 0);
+	return @r;
+}
+sub ctx_statement {
+	my ($linenr, $remain, $off) =3D @_;
+
+	my ($level, @r) =3D ctx_block_get($linenr, $remain, 0, '(', ')', $off);
+	return @r;
+}
+sub ctx_block_level {
+	my ($linenr, $remain) =3D @_;
+
+	return ctx_block_get($linenr, $remain, 0, '{', '}', 0);
+}
+sub ctx_statement_level {
+	my ($linenr, $remain, $off) =3D @_;
+
+	return ctx_block_get($linenr, $remain, 0, '(', ')', $off);
+}
+
+sub ctx_locate_comment {
+	my ($first_line, $end_line) =3D @_;
+
+	# Catch a comment on the end of the line itself.
+	my ($current_comment) =3D ($rawlines[$end_line - 1] =3D~ m@.*(/\*.*\*/)=
\s*(?:\\\s*)?$@);
+	return $current_comment if (defined $current_comment);
+
+	# Look through the context and try and figure out if there is a
+	# comment.
+	my $in_comment =3D 0;
+	$current_comment =3D '';
+	for (my $linenr =3D $first_line; $linenr < $end_line; $linenr++) {
+		my $line =3D $rawlines[$linenr - 1];
+		#warn "           $line\n";
+		if ($linenr =3D=3D $first_line and $line =3D~ m@^.\s*\*@) {
+			$in_comment =3D 1;
+		}
+		if ($line =3D~ m@/\*@) {
+			$in_comment =3D 1;
+		}
+		if (!$in_comment && $current_comment ne '') {
+			$current_comment =3D '';
+		}
+		$current_comment .=3D $line . "\n" if ($in_comment);
+		if ($line =3D~ m@\*/@) {
+			$in_comment =3D 0;
+		}
+	}
+
+	chomp($current_comment);
+	return($current_comment);
+}
+sub ctx_has_comment {
+	my ($first_line, $end_line) =3D @_;
+	my $cmt =3D ctx_locate_comment($first_line, $end_line);
+
+	##print "LINE: $rawlines[$end_line - 1 ]\n";
+	##print "CMMT: $cmt\n";
+
+	return ($cmt ne '');
+}
+
+sub raw_line {
+	my ($linenr, $cnt) =3D @_;
+
+	my $offset =3D $linenr - 1;
+	$cnt++;
+
+	my $line;
+	while ($cnt) {
+		$line =3D $rawlines[$offset++];
+		next if (defined($line) && $line =3D~ /^-/);
+		$cnt--;
+	}
+
+	return $line;
+}
+
+sub cat_vet {
+	my ($vet) =3D @_;
+	my ($res, $coded);
+
+	$res =3D '';
+	while ($vet =3D~ /([^[:cntrl:]]*)([[:cntrl:]]|$)/g) {
+		$res .=3D $1;
+		if ($2 ne '') {
+			$coded =3D sprintf("^%c", unpack('C', $2) + 64);
+			$res .=3D $coded;
+		}
+	}
+	$res =3D~ s/$/\$/;
+
+	return $res;
+}
+
+my $av_preprocessor =3D 0;
+my $av_pending;
+my @av_paren_type;
+my $av_pend_colon;
+
+sub annotate_reset {
+	$av_preprocessor =3D 0;
+	$av_pending =3D '_';
+	@av_paren_type =3D ('E');
+	$av_pend_colon =3D 'O';
+}
+
+sub annotate_values {
+	my ($stream, $type) =3D @_;
+
+	my $res;
+	my $var =3D '_' x length($stream);
+	my $cur =3D $stream;
+
+	print "$stream\n" if ($dbg_values > 1);
+
+	while (length($cur)) {
+		@av_paren_type =3D ('E') if ($#av_paren_type < 0);
+		print " <" . join('', @av_paren_type) .
+				"> <$type> <$av_pending>" if ($dbg_values > 1);
+		if ($cur =3D~ /^(\s+)/o) {
+			print "WS($1)\n" if ($dbg_values > 1);
+			if ($1 =3D~ /\n/ && $av_preprocessor) {
+				$type =3D pop(@av_paren_type);
+				$av_preprocessor =3D 0;
+			}
+
+		} elsif ($cur =3D~ /^($Type)\s*(?:$Ident|,|\)|\()/) {
+			print "DECLARE($1)\n" if ($dbg_values > 1);
+			$type =3D 'T';
+
+		} elsif ($cur =3D~ /^($Modifier)\s*/) {
+			print "MODIFIER($1)\n" if ($dbg_values > 1);
+			$type =3D 'T';
+
+		} elsif ($cur =3D~ /^(\#\s*define\s*$Ident)(\(?)/o) {
+			print "DEFINE($1,$2)\n" if ($dbg_values > 1);
+			$av_preprocessor =3D 1;
+			push(@av_paren_type, $type);
+			if ($2 ne '') {
+				$av_pending =3D 'N';
+			}
+			$type =3D 'E';
+
+		} elsif ($cur =3D~ /^(\#\s*(?:undef\s*$Ident|include\b))/o) {
+			print "UNDEF($1)\n" if ($dbg_values > 1);
+			$av_preprocessor =3D 1;
+			push(@av_paren_type, $type);
+
+		} elsif ($cur =3D~ /^(\#\s*(?:ifdef|ifndef|if))/o) {
+			print "PRE_START($1)\n" if ($dbg_values > 1);
+			$av_preprocessor =3D 1;
+
+			push(@av_paren_type, $type);
+			push(@av_paren_type, $type);
+			$type =3D 'E';
+
+		} elsif ($cur =3D~ /^(\#\s*(?:else|elif))/o) {
+			print "PRE_RESTART($1)\n" if ($dbg_values > 1);
+			$av_preprocessor =3D 1;
+
+			push(@av_paren_type, $av_paren_type[$#av_paren_type]);
+
+			$type =3D 'E';
+
+		} elsif ($cur =3D~ /^(\#\s*(?:endif))/o) {
+			print "PRE_END($1)\n" if ($dbg_values > 1);
+
+			$av_preprocessor =3D 1;
+
+			# Assume all arms of the conditional end as this
+			# one does, and continue as if the #endif was not here.
+			pop(@av_paren_type);
+			push(@av_paren_type, $type);
+			$type =3D 'E';
+
+		} elsif ($cur =3D~ /^(\\\n)/o) {
+			print "PRECONT($1)\n" if ($dbg_values > 1);
+
+		} elsif ($cur =3D~ /^(__attribute__)\s*\(?/o) {
+			print "ATTR($1)\n" if ($dbg_values > 1);
+			$av_pending =3D $type;
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(sizeof)\s*(\()?/o) {
+			print "SIZEOF($1)\n" if ($dbg_values > 1);
+			if (defined $2) {
+				$av_pending =3D 'V';
+			}
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(if|while|for)\b/o) {
+			print "COND($1)\n" if ($dbg_values > 1);
+			$av_pending =3D 'E';
+			$type =3D 'N';
+
+		} elsif ($cur =3D~/^(case)/o) {
+			print "CASE($1)\n" if ($dbg_values > 1);
+			$av_pend_colon =3D 'C';
+			$type =3D 'N';
+
+		} elsif ($cur =3D~/^(return|else|goto|typeof|__typeof__)\b/o) {
+			print "KEYWORD($1)\n" if ($dbg_values > 1);
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(\()/o) {
+			print "PAREN('$1')\n" if ($dbg_values > 1);
+			push(@av_paren_type, $av_pending);
+			$av_pending =3D '_';
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(\))/o) {
+			my $new_type =3D pop(@av_paren_type);
+			if ($new_type ne '_') {
+				$type =3D $new_type;
+				print "PAREN('$1') -> $type\n"
+							if ($dbg_values > 1);
+			} else {
+				print "PAREN('$1')\n" if ($dbg_values > 1);
+			}
+
+		} elsif ($cur =3D~ /^($Ident)\s*\(/o) {
+			print "FUNC($1)\n" if ($dbg_values > 1);
+			$type =3D 'V';
+			$av_pending =3D 'V';
+
+		} elsif ($cur =3D~ /^($Ident\s*):(?:\s*\d+\s*(,|=3D|;))?/) {
+			if (defined $2 && $type eq 'C' || $type eq 'T') {
+				$av_pend_colon =3D 'B';
+			} elsif ($type eq 'E') {
+				$av_pend_colon =3D 'L';
+			}
+			print "IDENT_COLON($1,$type>$av_pend_colon)\n" if ($dbg_values > 1);
+			$type =3D 'V';
+
+		} elsif ($cur =3D~ /^($Ident|$Constant)/o) {
+			print "IDENT($1)\n" if ($dbg_values > 1);
+			$type =3D 'V';
+
+		} elsif ($cur =3D~ /^($Assignment)/o) {
+			print "ASSIGN($1)\n" if ($dbg_values > 1);
+			$type =3D 'N';
+
+		} elsif ($cur =3D~/^(;|{|})/) {
+			print "END($1)\n" if ($dbg_values > 1);
+			$type =3D 'E';
+			$av_pend_colon =3D 'O';
+
+		} elsif ($cur =3D~/^(,)/) {
+			print "COMMA($1)\n" if ($dbg_values > 1);
+			$type =3D 'C';
+
+		} elsif ($cur =3D~ /^(\?)/o) {
+			print "QUESTION($1)\n" if ($dbg_values > 1);
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(:)/o) {
+			print "COLON($1,$av_pend_colon)\n" if ($dbg_values > 1);
+
+			substr($var, length($res), 1, $av_pend_colon);
+			if ($av_pend_colon eq 'C' || $av_pend_colon eq 'L') {
+				$type =3D 'E';
+			} else {
+				$type =3D 'N';
+			}
+			$av_pend_colon =3D 'O';
+
+		} elsif ($cur =3D~ /^(\[)/o) {
+			print "CLOSE($1)\n" if ($dbg_values > 1);
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(-(?![->])|\+(?!\+)|\*|\&\&|\&)/o) {
+			my $variant;
+
+			print "OPV($1)\n" if ($dbg_values > 1);
+			if ($type eq 'V') {
+				$variant =3D 'B';
+			} else {
+				$variant =3D 'U';
+			}
+
+			substr($var, length($res), 1, $variant);
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^($Operators)/o) {
+			print "OP($1)\n" if ($dbg_values > 1);
+			if ($1 ne '++' && $1 ne '--') {
+				$type =3D 'N';
+			}
+
+		} elsif ($cur =3D~ /(^.)/o) {
+			print "C($1)\n" if ($dbg_values > 1);
+		}
+		if (defined $1) {
+			$cur =3D substr($cur, length($1));
+			$res .=3D $type x length($1);
+		}
+	}
+
+	return ($res, $var);
+}
+
+sub possible {
+	my ($possible, $line) =3D @_;
+
+	print "CHECK<$possible> ($line)\n" if ($dbg_possible > 2);
+	if ($possible !~ /(?:
+		^(?:
+			$Modifier|
+			$Storage|
+			$Type|
+			DEFINE_\S+|
+			goto|
+			return|
+			case|
+			else|
+			asm|__asm__|
+			do
+		)$|
+		^(?:typedef|struct|enum)\b
+	    )/x) {
+		# Check for modifiers.
+		$possible =3D~ s/\s*$Storage\s*//g;
+		$possible =3D~ s/\s*$Sparse\s*//g;
+		if ($possible =3D~ /^\s*$/) {
+
+		} elsif ($possible =3D~ /\s/) {
+			$possible =3D~ s/\s*$Type\s*//g;
+			for my $modifier (split(' ', $possible)) {
+				warn "MODIFIER: $modifier ($possible) ($line)\n" if ($dbg_possible);
+				push(@modifierList, $modifier);
+			}
+
+		} else {
+			warn "POSSIBLE: $possible ($line)\n" if ($dbg_possible);
+			push(@typeList, $possible);
+		}
+		build_types();
+	} else {
+		warn "NOTPOSS: $possible ($line)\n" if ($dbg_possible > 1);
+	}
+}
+
+my $prefix =3D '';
+
+sub report {
+	if (defined $tst_only && $_[0] !~ /\Q$tst_only\E/) {
+		return 0;
+	}
+	my $line =3D $prefix . $_[0];
+
+	$line =3D (split('\n', $line))[0] . "\n" if ($terse);
+
+	push(our @report, $line);
+
+	return 1;
+}
+sub report_dump {
+	our @report;
+}
+sub ERROR {
+	if (report("ERROR: $_[0]\n")) {
+		our $clean =3D 0;
+		our $cnt_error++;
+	}
+}
+sub WARN {
+	if (report("WARNING: $_[0]\n")) {
+		our $clean =3D 0;
+		our $cnt_warn++;
+	}
+}
+sub CHK {
+	if ($check && report("CHECK: $_[0]\n")) {
+		our $clean =3D 0;
+		our $cnt_chk++;
+	}
+}
+
+sub check_absolute_file {
+	my ($absolute, $herecurr) =3D @_;
+	my $file =3D $absolute;
+
+	##print "absolute<$absolute>\n";
+
+	# See if any suffix of this path is a path within the tree.
+	while ($file =3D~ s@^[^/]*/@@) {
+		if (-f "$root/$file") {
+			##print "file<$file>\n";
+			last;
+		}
+	}
+	if (! -f _)  {
+		return 0;
+	}
+
+	# It is, so see if the prefix is acceptable.
+	my $prefix =3D $absolute;
+	substr($prefix, -length($file)) =3D '';
+
+	##print "prefix<$prefix>\n";
+	if ($prefix ne ".../") {
+		WARN("use relative pathname instead of absolute in changelog text\n" . $=
herecurr);
+	}
+}
+
+sub process {
+	my $filename =3D shift;
+
+	my $linenr=3D0;
+	my $prevline=3D"";
+	my $prevrawline=3D"";
+	my $stashline=3D"";
+	my $stashrawline=3D"";
+
+	my $length;
+	my $indent;
+	my $previndent=3D0;
+	my $stashindent=3D0;
+
+	our $clean =3D 1;
+	my $signoff =3D 0;
+	my $is_patch =3D 0;
+
+	our @report =3D ();
+	our $cnt_lines =3D 0;
+	our $cnt_error =3D 0;
+	our $cnt_warn =3D 0;
+	our $cnt_chk =3D 0;
+
+	# Trace the real file/line as we go.
+	my $realfile =3D '';
+	my $realline =3D 0;
+	my $realcnt =3D 0;
+	my $here =3D '';
+	my $in_comment =3D 0;
+	my $comment_edge =3D 0;
+	my $first_line =3D 0;
+	my $p1_prefix =3D '';
+
+	my $prev_values =3D 'E';
+
+	# suppression flags
+	my %suppress_ifbraces;
+	my %suppress_whiletrailers;
+
+	# Pre-scan the patch sanitizing the lines.
+	# Pre-scan the patch looking for any __setup documentation.
+	#
+	my @setup_docs =3D ();
+	my $setup_docs =3D 0;
+
+	sanitise_line_reset();
+	my $line;
+	foreach my $rawline (@rawlines) {
+		$linenr++;
+		$line =3D $rawline;
+
+		if ($rawline=3D~/^\+\+\+\s+(\S+)/) {
+			$setup_docs =3D 0;
+			if ($1 =3D~ m(a)Documentation/kernel-parameters.txt$@) {
+				$setup_docs =3D 1;
+			}
+			#next;
+		}
+		if ($rawline=3D~/^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
+			$realline=3D$1-1;
+			if (defined $2) {
+				$realcnt=3D$3+1;
+			} else {
+				$realcnt=3D1+1;
+			}
+			$in_comment =3D 0;
+
+			# Guestimate if this is a continuing comment.  Run
+			# the context looking for a comment "edge".  If this
+			# edge is a close comment then we must be in a comment
+			# at context start.
+			my $edge;
+			my $cnt =3D $realcnt;
+			for (my $ln =3D $linenr + 1; $cnt > 0; $ln++) {
+				next if (defined $rawlines[$ln - 1] &&
+					 $rawlines[$ln - 1] =3D~ /^-/);
+				$cnt--;
+				#print "RAW<$rawlines[$ln - 1]>\n";
+				last if (!defined $rawlines[$ln - 1]);
+				if ($rawlines[$ln - 1] =3D~ m@(/\*|\*/)@ &&
+				    $rawlines[$ln - 1] !~ m@"[^"]*(?:/\*|\*/)[^"]*"@) {
+					($edge) =3D $1;
+					last;
+				}
+			}
+			if (defined $edge && $edge eq '*/') {
+				$in_comment =3D 1;
+			}
+
+			# Guestimate if this is a continuing comment.  If this
+			# is the start of a diff block and this line starts
+			# ' *' then it is very likely a comment.
+			if (!defined $edge &&
+			    $rawlines[$linenr] =3D~ m@^.\s*(?:\*\*+| \*)(?:\s|$)@)
+			{
+				$in_comment =3D 1;
+			}
+
+			##print "COMMENT:$in_comment edge<$edge> $rawline\n";
+			sanitise_line_reset($in_comment);
+
+		} elsif ($realcnt && $rawline =3D~ /^(?:\+| |$)/) {
+			# Standardise the strings and chars within the input to
+			# simplify matching -- only bother with positive lines.
+			$line =3D sanitise_line($rawline);
+		}
+		push(@lines, $line);
+
+		if ($realcnt > 1) {
+			$realcnt-- if ($line =3D~ /^(?:\+| |$)/);
+		} else {
+			$realcnt =3D 0;
+		}
+
+		#print "=3D=3D>$rawline\n";
+		#print "-->$line\n";
+
+		if ($setup_docs && $line =3D~ /^\+/) {
+			push(@setup_docs, $line);
+		}
+	}
+
+	$prefix =3D '';
+
+	$realcnt =3D 0;
+	$linenr =3D 0;
+	foreach my $line (@lines) {
+		$linenr++;
+
+		my $rawline =3D $rawlines[$linenr - 1];
+		my $hunk_line =3D ($realcnt !=3D 0);
+
+#extract the line range in the file after the patch is applied
+		if ($line=3D~/^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
+			$is_patch =3D 1;
+			$first_line =3D $linenr + 1;
+			$realline=3D$1-1;
+			if (defined $2) {
+				$realcnt=3D$3+1;
+			} else {
+				$realcnt=3D1+1;
+			}
+			annotate_reset();
+			$prev_values =3D 'E';
+
+			%suppress_ifbraces =3D ();
+			%suppress_whiletrailers =3D ();
+			next;
+
+# track the line number as we move through the hunk, note that
+# new versions of GNU diff omit the leading space on completely
+# blank context lines so we need to count that too.
+		} elsif ($line =3D~ /^( |\+|$)/) {
+			$realline++;
+			$realcnt-- if ($realcnt !=3D 0);
+
+			# Measure the line length and indent.
+			($length, $indent) =3D line_stats($rawline);
+
+			# Track the previous line.
+			($prevline, $stashline) =3D ($stashline, $line);
+			($previndent, $stashindent) =3D ($stashindent, $indent);
+			($prevrawline, $stashrawline) =3D ($stashrawline, $rawline);
+
+			#warn "line<$line>\n";
+
+		} elsif ($realcnt =3D=3D 1) {
+			$realcnt--;
+		}
+
+#make up the handle for any error we report on this line
+		$prefix =3D "$filename:$realline: " if ($emacs && $file);
+		$prefix =3D "$filename:$linenr: " if ($emacs && !$file);
+
+		$here =3D "#$linenr: " if (!$file);
+		$here =3D "#$realline: " if ($file);
+
+		# extract the filename as it passes
+		if ($line=3D~/^\+\+\+\s+(\S+)/) {
+			$realfile =3D $1;
+			$realfile =3D~ s@^([^/]*)/@@;
+
+			$p1_prefix =3D $1;
+			if (!$file && $tree && $p1_prefix ne '' &&
+			    -e "$root/$p1_prefix") {
+				WARN("patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
+			}
+
+			if ($realfile =3D~ m@^include/asm/@) {
+				ERROR("do not modify files in include/asm, change architecture specifi=
c files in include/asm-<architecture>\n" . "$here$rawline\n");
+			}
+			next;
+		}
+
+		$here .=3D "FILE: $realfile:$realline:" if ($realcnt !=3D 0);
+
+		my $hereline =3D "$here\n$rawline\n";
+		my $herecurr =3D "$here\n$rawline\n";
+		my $hereprev =3D "$here\n$prevrawline\n$rawline\n";
+
+		$cnt_lines++ if ($realcnt !=3D 0);
+
+#check the patch for a signoff:
+		if ($line =3D~ /^\s*signed-off-by:/i) {
+			# This is a signoff, if ugly, so do not double report.
+			$signoff++;
+			if (!($line =3D~ /^\s*Signed-off-by:/)) {
+				WARN("Signed-off-by: is the preferred form\n" .
+					$herecurr);
+			}
+			if ($line =3D~ /^\s*signed-off-by:\S/i) {
+				WARN("space required after Signed-off-by:\n" .
+					$herecurr);
+			}
+		}
+
+# Check for wrappage within a valid hunk of the file
+		if ($realcnt !=3D 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
+			ERROR("patch seems to be corrupt (line wrapped?)\n" .
+				$herecurr) if (!$emitted_corrupt++);
+		}
+
+# Check for absolute kernel paths.
+		if ($tree) {
+			while ($line =3D~ m{(?:^|\s)(/\S*)}g) {
+				my $file =3D $1;
+
+				if ($file =3D~ m{^(.*?)(?::\d+)+:?$} &&
+				    check_absolute_file($1, $herecurr)) {
+					#
+				} else {
+					check_absolute_file($file, $herecurr);
+				}
+			}
+		}
+
+# UTF-8 regex found at http://www.w3.org/International/questions/qa-forms-=
utf-8.en.php
+		if (($realfile =3D~ /^$/ || $line =3D~ /^\+/) &&
+		    $rawline !~ m/^$UTF8*$/) {
+			my ($utf8_prefix) =3D ($rawline =3D~ /^($UTF8*)/);
+
+			my $blank =3D copy_spacing($rawline);
+			my $ptr =3D substr($blank, 0, length($utf8_prefix)) . "^";
+			my $hereptr =3D "$hereline$ptr\n";
+
+			ERROR("Invalid UTF-8, patch and commit message should be encoded in UTF=
-8\n" . $hereptr);
+		}
+
+# ignore non-hunk lines and lines being removed
+		next if (!$hunk_line || $line =3D~ /^-/);
+
+#trailing whitespace
+		if ($line =3D~ /^\+.*\015/) {
+			my $herevet =3D "$here\n" . cat_vet($rawline) . "\n";
+			ERROR("DOS line endings\n" . $herevet);
+
+		} elsif ($rawline =3D~ /^\+.*\S\s+$/ || $rawline =3D~ /^\+\s+$/) {
+			my $herevet =3D "$here\n" . cat_vet($rawline) . "\n";
+			ERROR("trailing whitespace\n" . $herevet);
+		}
+
+# check we are in a valid source file if not then ignore this hunk
+		next if ($realfile !~ /\.(h|c|s|S|pl|sh)$/);
+
+#80 column limit
+		if ($line =3D~ /^\+/ && $prevrawline !~ /\/\*\*/ &&
+		    $rawline !~ /^.\s*\*\s*\@$Ident\s/ &&
+		    $line !~ /^\+\s*printk\s*\(\s*(?:KERN_\S+\s*)?"[X\t]*"\s*(?:,|\)\s*;=
)\s*$/ &&
+		    $length > 80)
+		{
+			WARN("line over 80 characters\n" . $herecurr);
+		}
+
+# check for adding lines without a newline.
+		if ($line =3D~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =3D~ =
/^\\ No newline at end of file/) {
+			WARN("adding a line without newline at end of file\n" . $herecurr);
+		}
+
+# check we are in a valid source file C or perl if not then ignore this hu=
nk
+		next if ($realfile !~ /\.(h|c|pl)$/);
+
+# at the beginning of a line any tabs must come first and anything
+# more than 8 must use tabs.
+		if ($rawline =3D~ /^\+\s* \t\s*\S/ ||
+		    $rawline =3D~ /^\+\s*        \s*/) {
+			my $herevet =3D "$here\n" . cat_vet($rawline) . "\n";
+			ERROR("code indent should use tabs where possible\n" . $herevet);
+		}
+
+# check we are in a valid C source file if not then ignore this hunk
+		next if ($realfile !~ /\.(h|c)$/);
+
+# check for RCS/CVS revision markers
+		if ($rawline =3D~ /^\+.*\$(Revision|Log|Id)(?:\$|)/) {
+			WARN("CVS style keyword markers, these will _not_ be updated\n". $herec=
urr);
+		}
+
+# Check for potential 'bare' types
+		my ($stat, $cond, $line_nr_next, $remain_next, $off_next);
+		if ($realcnt && $line =3D~ /.\s*\S/) {
+			($stat, $cond, $line_nr_next, $remain_next, $off_next) =3D
+				ctx_statement_block($linenr, $realcnt, 0);
+			$stat =3D~ s/\n./\n /g;
+			$cond =3D~ s/\n./\n /g;
+
+			my $s =3D $stat;
+			$s =3D~ s/{.*$//s;
+
+			# Ignore goto labels.
+			if ($s =3D~ /$Ident:\*$/s) {
+
+			# Ignore functions being called
+			} elsif ($s =3D~ /^.\s*$Ident\s*\(/s) {
+
+			# declarations always start with types
+			} elsif ($prev_values eq 'E' && $s =3D~ /^.\s*(?:$Storage\s+)?(?:$Inlin=
e\s+)?(?:const\s+)?((?:\s*$Ident)+?)\b(?:\s+$Sparse)?\s*\**\s*(?:$Ident|\(\=
*[^\)]*\))(?:\s*$Modifier)?\s*(?:;|=3D|,|\()/s) {
+				my $type =3D $1;
+				$type =3D~ s/\s+/ /g;
+				possible($type, "A:" . $s);
+
+			# definitions in global scope can only start with types
+			} elsif ($s =3D~ /^.(?:$Storage\s+)?(?:$Inline\s+)?(?:const\s+)?($Ident=
)\b\s*(?!:)/s) {
+				possible($1, "B:" . $s);
+			}
+
+			# any (foo ... *) is a pointer cast, and foo is a type
+			while ($s =3D~ /\(($Ident)(?:\s+$Sparse)*[\s\*]+\s*\)/sg) {
+				possible($1, "C:" . $s);
+			}
+
+			# Check for any sort of function declaration.
+			# int foo(something bar, other baz);
+			# void (*store_gdt)(x86_descr_ptr *);
+			if ($prev_values eq 'E' && $s =3D~ /^(.(?:typedef\s*)?(?:(?:$Storage|$I=
nline)\s*)*\s*$Type\s*(?:\b$Ident|\(\*\s*$Ident\))\s*)\(/s) {
+				my ($name_len) =3D length($1);
+
+				my $ctx =3D $s;
+				substr($ctx, 0, $name_len + 1, '');
+				$ctx =3D~ s/\)[^\)]*$//;
+
+				for my $arg (split(/\s*,\s*/, $ctx)) {
+					if ($arg =3D~ /^(?:const\s+)?($Ident)(?:\s+$Sparse)*\s*\**\s*(:?\b$Id=
ent)?$/s || $arg =3D~ /^($Ident)$/s) {
+
+						possible($1, "D:" . $s);
+					}
+				}
+			}
+
+		}
+
+#
+# Checks which may be anchored in the context.
+#
+
+# Check for switch () and associated case and default
+# statements should be at the same indent.
+		if ($line=3D~/\bswitch\s*\(.*\)/) {
+			my $err =3D '';
+			my $sep =3D '';
+			my @ctx =3D ctx_block_outer($linenr, $realcnt);
+			shift(@ctx);
+			for my $ctx (@ctx) {
+				my ($clen, $cindent) =3D line_stats($ctx);
+				if ($ctx =3D~ /^\+\s*(case\s+|default:)/ &&
+							$indent !=3D $cindent) {
+					$err .=3D "$sep$ctx\n";
+					$sep =3D '';
+				} else {
+					$sep =3D "[...]\n";
+				}
+			}
+			if ($err ne '') {
+				ERROR("switch and case should be at the same indent\n$hereline$err");
+			}
+		}
+
+# if/while/etc brace do not go on next line, unless defining a do while lo=
op,
+# or if that brace on the next line is for something else
+		if ($line =3D~ /(.*)\b((?:if|while|for|switch)\s*\(|do\b|else\b)/ && $li=
ne !~ /^.\s*\#/) {
+			my $pre_ctx =3D "$1$2";
+
+			my ($level, @ctx) =3D ctx_statement_level($linenr, $realcnt, 0);
+			my $ctx_cnt =3D $realcnt - $#ctx - 1;
+			my $ctx =3D join("\n", @ctx);
+
+			my $ctx_ln =3D $linenr;
+			my $ctx_skip =3D $realcnt;
+
+			while ($ctx_skip > $ctx_cnt || ($ctx_skip =3D=3D $ctx_cnt &&
+					defined $lines[$ctx_ln - 1] &&
+					$lines[$ctx_ln - 1] =3D~ /^-/)) {
+				##print "SKIP<$ctx_skip> CNT<$ctx_cnt>\n";
+				$ctx_skip-- if (!defined $lines[$ctx_ln - 1] || $lines[$ctx_ln - 1] !~=
 /^-/);
+				$ctx_ln++;
+			}
+
+			#print "realcnt<$realcnt> ctx_cnt<$ctx_cnt>\n";
+			#print "pre<$pre_ctx>\nline<$line>\nctx<$ctx>\nnext<$lines[$ctx_ln - 1]=
>\n";
+
+			if ($ctx !~ /{\s*/ && defined($lines[$ctx_ln -1]) && $lines[$ctx_ln - 1=
] =3D~ /^\+\s*{/) {
+				ERROR("that open brace { should be on the previous line\n" .
+					"$here\n$ctx\n$lines[$ctx_ln - 1]\n");
+			}
+			if ($level =3D=3D 0 && $pre_ctx !~ /}\s*while\s*\($/ &&
+			    $ctx =3D~ /\)\s*\;\s*$/ &&
+			    defined $lines[$ctx_ln - 1])
+			{
+				my ($nlength, $nindent) =3D line_stats($lines[$ctx_ln - 1]);
+				if ($nindent > $indent) {
+					WARN("trailing semicolon indicates no statements, indent implies othe=
rwise\n" .
+						"$here\n$ctx\n$lines[$ctx_ln - 1]\n");
+				}
+			}
+		}
+
+# Check relative indent for conditionals and blocks.
+		if ($line =3D~ /\b(?:(?:if|while|for)\s*\(|do\b)/ && $line !~ /^.\s*#/ &=
& $line !~ /\}\s*while\s*/) {
+			my ($s, $c) =3D ($stat, $cond);
+
+			substr($s, 0, length($c), '');
+
+			# Make sure we remove the line prefixes as we have
+			# none on the first line, and are going to readd them
+			# where necessary.
+			$s =3D~ s/\n./\n/gs;
+
+			# Find out how long the conditional actually is.
+			my @newlines =3D ($c =3D~ /\n/gs);
+			my $cond_lines =3D 1 + $#newlines;
+
+			# We want to check the first line inside the block
+			# starting at the end of the conditional, so remove:
+			#  1) any blank line termination
+			#  2) any opening brace { on end of the line
+			#  3) any do (...) {
+			my $continuation =3D 0;
+			my $check =3D 0;
+			$s =3D~ s/^.*\bdo\b//;
+			$s =3D~ s/^\s*{//;
+			if ($s =3D~ s/^\s*\\//) {
+				$continuation =3D 1;
+			}
+			if ($s =3D~ s/^\s*?\n//) {
+				$check =3D 1;
+				$cond_lines++;
+			}
+
+			# Also ignore a loop construct at the end of a
+			# preprocessor statement.
+			if (($prevline =3D~ /^.\s*#\s*define\s/ ||
+			    $prevline =3D~ /\\\s*$/) && $continuation =3D=3D 0) {
+				$check =3D 0;
+			}
+
+			my $cond_ptr =3D -1;
+			$continuation =3D 0;
+			while ($cond_ptr !=3D $cond_lines) {
+				$cond_ptr =3D $cond_lines;
+
+				# If we see an #else/#elif then the code
+				# is not linear.
+				if ($s =3D~ /^\s*\#\s*(?:else|elif)/) {
+					$check =3D 0;
+				}
+
+				# Ignore:
+				#  1) blank lines, they should be at 0,
+				#  2) preprocessor lines, and
+				#  3) labels.
+				if ($continuation ||
+				    $s =3D~ /^\s*?\n/ ||
+				    $s =3D~ /^\s*#\s*?/ ||
+				    $s =3D~ /^\s*$Ident\s*:/) {
+					$continuation =3D ($s =3D~ /^.*?\\\n/) ? 1 : 0;
+					$s =3D~ s/^.*?\n//;
+					$cond_lines++;
+				}
+			}
+
+			my (undef, $sindent) =3D line_stats("+" . $s);
+			my $stat_real =3D raw_line($linenr, $cond_lines);
+
+			# Check if either of these lines are modified, else
+			# this is not this patch's fault.
+			if (!defined($stat_real) ||
+			    $stat !~ /^\+/ && $stat_real !~ /^\+/) {
+				$check =3D 0;
+			}
+			if (defined($stat_real) && $cond_lines > 1) {
+				$stat_real =3D "[...]\n$stat_real";
+			}
+
+			#print "line<$line> prevline<$prevline> indent<$indent> sindent<$sinden=
t> check<$check> continuation<$continuation> s<$s> cond_lines<$cond_lines> =
stat_real<$stat_real> stat<$stat>\n";
+
+			if ($check && (($sindent % 8) !=3D 0 ||
+			    ($sindent <=3D $indent && $s ne ''))) {
+				WARN("suspect code indent for conditional statements ($indent, $sinden=
t)\n" . $herecurr . "$stat_real\n");
+			}
+		}
+
+		# Track the 'values' across context and added lines.
+		my $opline =3D $line; $opline =3D~ s/^./ /;
+		my ($curr_values, $curr_vars) =3D
+				annotate_values($opline . "\n", $prev_values);
+		$curr_values =3D $prev_values . $curr_values;
+		if ($dbg_values) {
+			my $outline =3D $opline; $outline =3D~ s/\t/ /g;
+			print "$linenr > .$outline\n";
+			print "$linenr > $curr_values\n";
+			print "$linenr >  $curr_vars\n";
+		}
+		$prev_values =3D substr($curr_values, -1);
+
+#ignore lines not being added
+		if ($line=3D~/^[^\+]/) {next;}
+
+# TEST: allow direct testing of the type matcher.
+		if ($dbg_type) {
+			if ($line =3D~ /^.\s*$Declare\s*$/) {
+				ERROR("TEST: is type\n" . $herecurr);
+			} elsif ($dbg_type > 1 && $line =3D~ /^.+($Declare)/) {
+				ERROR("TEST: is not type ($1 is)\n". $herecurr);
+			}
+			next;
+		}
+# TEST: allow direct testing of the attribute matcher.
+		if ($dbg_attr) {
+			if ($line =3D~ /^.\s*$Modifier\s*$/) {
+				ERROR("TEST: is attr\n" . $herecurr);
+			} elsif ($dbg_attr > 1 && $line =3D~ /^.+($Modifier)/) {
+				ERROR("TEST: is not attr ($1 is)\n". $herecurr);
+			}
+			next;
+		}
+
+# check for initialisation to aggregates open brace on the next line
+		if ($prevline =3D~ /$Declare\s*$Ident\s*=3D\s*$/ &&
+		    $line =3D~ /^.\s*{/) {
+			ERROR("that open brace { should be on the previous line\n" . $hereprev);
+		}
+
+#
+# Checks which are anchored on the added line.
+#
+
+# check for malformed paths in #include statements (uses RAW line)
+		if ($rawline =3D~ m{^.\s*\#\s*include\s+[<"](.*)[">]}) {
+			my $path =3D $1;
+			if ($path =3D~ m{//}) {
+				ERROR("malformed #include filename\n" .
+					$herecurr);
+			}
+		}
+
+# no C99 // comments
+		if ($line =3D~ m{//}) {
+			ERROR("do not use C99 // comments\n" . $herecurr);
+		}
+		# Remove C99 comments.
+		$line =3D~ s@//.*@@;
+		$opline =3D~ s@//.*@@;
+
+#EXPORT_SYMBOL should immediately follow its function closing }.
+		if (($line =3D~ /EXPORT_SYMBOL.*\((.*)\)/) ||
+		    ($line =3D~ /EXPORT_UNUSED_SYMBOL.*\((.*)\)/)) {
+			my $name =3D $1;
+			if ($prevline !~ /(?:
+				^.}|
+				^.DEFINE_$Ident\(\Q$name\E\)|
+				^.DECLARE_$Ident\(\Q$name\E\)|
+				^.LIST_HEAD\(\Q$name\E\)|
+				^.$Type\s*\(\s*\*\s*\Q$name\E\s*\)\s*\(|
+				\b\Q$name\E(?:\s+$Attribute)?\s*(?:;|=3D|\[)
+			    )/x) {
+				WARN("EXPORT_SYMBOL(foo); should immediately follow its function/varia=
ble\n" . $herecurr);
+			}
+		}
+
+# check for external initialisers.
+		if ($line =3D~ /^.$Type\s*$Ident\s*(?:\s+$Modifier)*\s*=3D\s*(0|NULL|fal=
se)\s*;/) {
+			ERROR("do not initialise externals to 0 or NULL\n" .
+				$herecurr);
+		}
+# check for static initialisers.
+		if ($line =3D~ /\bstatic\s.*=3D\s*(0|NULL|false)\s*;/) {
+			ERROR("do not initialise statics to 0 or NULL\n" .
+				$herecurr);
+		}
+
+# check for new typedefs, only function parameters and sparse annotations
+# make sense.
+		if ($line =3D~ /\btypedef\s/ &&
+		    $line !~ /\btypedef\s+$Type\s*\(\s*\*?$Ident\s*\)\s*\(/ &&
+		    $line !~ /\btypedef\s+$Type\s+$Ident\s*\(/ &&
+		    $line !~ /\b$typeTypedefs\b/ &&
+		    $line !~ /\b__bitwise(?:__|)\b/) {
+			WARN("do not add new typedefs\n" . $herecurr);
+		}
+
+# * goes on variable not on type
+		# (char*[ const])
+		if ($line =3D~ m{\($NonptrType(\s*(?:$Modifier\b\s*|\*\s*)+)\)}) {
+			my ($from, $to) =3D ($1, $1);
+
+			# Should start with a space.
+			$to =3D~ s/^(\S)/ $1/;
+			# Should not end with a space.
+			$to =3D~ s/\s+$//;
+			# '*'s should not have spaces between.
+			while ($to =3D~ s/\*\s+\*/\*\*/) {
+			}
+
+			#print "from<$from> to<$to>\n";
+			if ($from ne $to) {
+				ERROR("\"(foo$from)\" should be \"(foo$to)\"\n" .  $herecurr);
+			}
+		} elsif ($line =3D~ m{\b$NonptrType(\s*(?:$Modifier\b\s*|\*\s*)+)($Ident=
)}) {
+			my ($from, $to, $ident) =3D ($1, $1, $2);
+
+			# Should start with a space.
+			$to =3D~ s/^(\S)/ $1/;
+			# Should not end with a space.
+			$to =3D~ s/\s+$//;
+			# '*'s should not have spaces between.
+			while ($to =3D~ s/\*\s+\*/\*\*/) {
+			}
+			# Modifiers should have spaces.
+			$to =3D~ s/(\b$Modifier$)/$1 /;
+
+			#print "from<$from> to<$to> ident<$ident>\n";
+			if ($from ne $to && $ident !~ /^$Modifier$/) {
+				ERROR("\"foo${from}bar\" should be \"foo${to}bar\"\n" .  $herecurr);
+			}
+		}
+
+# # no BUG() or BUG_ON()
+# 		if ($line =3D~ /\b(BUG|BUG_ON)\b/) {
+# 			print "Try to use WARN_ON & Recovery code rather than BUG() or BUG_ON=
()\n";
+# 			print "$herecurr";
+# 			$clean =3D 0;
+# 		}
+
+		if ($line =3D~ /\bLINUX_VERSION_CODE\b/) {
+			WARN("LINUX_VERSION_CODE should be avoided, code should be for the vers=
ion to which it is merged\n" . $herecurr);
+		}
+
+# printk should use KERN_* levels.  Note that follow on printk's on the
+# same line do not need a level, so we use the current block context
+# to try and find and validate the current printk.  In summary the current
+# printk includes all preceeding printk's which have no newline on the end.
+# we assume the first bad printk is the one to report.
+		if ($line =3D~ /\bprintk\((?!KERN_)\s*"/) {
+			my $ok =3D 0;
+			for (my $ln =3D $linenr - 1; $ln >=3D $first_line; $ln--) {
+				#print "CHECK<$lines[$ln - 1]\n";
+				# we have a preceeding printk if it ends
+				# with "\n" ignore it, else it is to blame
+				if ($lines[$ln - 1] =3D~ m{\bprintk\(}) {
+					if ($rawlines[$ln - 1] !~ m{\\n"}) {
+						$ok =3D 1;
+					}
+					last;
+				}
+			}
+			if ($ok =3D=3D 0) {
+				WARN("printk() should include KERN_ facility level\n" . $herecurr);
+			}
+		}
+
+# function brace can't be on same line, except for #defines of do while,
+# or if closed on same line
+		if (($line=3D~/$Type\s*$Ident\(.*\).*\s{/) and
+		    !($line=3D~/\#\s*define.*do\s{/) and !($line=3D~/}/)) {
+			ERROR("open brace '{' following function declarations go on the next li=
ne\n" . $herecurr);
+		}
+
+# open braces for enum, union and struct go on the same line.
+		if ($line =3D~ /^.\s*{/ &&
+		    $prevline =3D~ /^.\s*(?:typedef\s+)?(enum|union|struct)(?:\s+$Ident)=
?\s*$/) {
+			ERROR("open brace '{' following $1 go on the same line\n" . $hereprev);
+		}
+
+# check for spacing round square brackets; allowed:
+#  1. with a type on the left -- int [] a;
+#  2.@the beginning of a line for slice initialisers -- [0...10] =3D 5,
+#  3. inside a curly brace -- =3D { [0...10] =3D 5 }
+		while ($line =3D~ /(.*?\s)\[/g) {
+			my ($where, $prefix) =3D ($-[1], $1);
+			if ($prefix !~ /$Type\s+$/ &&
+			    ($where !=3D 0 || $prefix !~ /^.\s+$/) &&
+			    $prefix !~ /{\s+$/) {
+				ERROR("space prohibited before open square bracket '['\n" . $herecurr);
+			}
+		}
+
+# check for spaces between functions and their parentheses.
+		while ($line =3D~ /($Ident)\s+\(/g) {
+			my $name =3D $1;
+			my $ctx_before =3D substr($line, 0, $-[1]);
+			my $ctx =3D "$ctx_before$name";
+
+			# Ignore those directives where spaces _are_ permitted.
+			if ($name =3D~ /^(?:
+				if|for|while|switch|return|case|
+				volatile|__volatile__|
+				__attribute__|format|__extension__|
+				asm|__asm__)$/x)
+			{
+
+			# cpp #define statements have non-optional spaces, ie
+			# if there is a space between the name and the open
+			# parenthesis it is simply not a parameter group.
+			} elsif ($ctx_before =3D~ /^.\s*\#\s*define\s*$/) {
+
+			# cpp #elif statement condition may start with a (
+			} elsif ($ctx =3D~ /^.\s*\#\s*elif\s*$/) {
+
+			# If this whole things ends with a type its most
+			# likely a typedef for a function.
+			} elsif ($ctx =3D~ /$Type$/) {
+
+			} else {
+				WARN("space prohibited between function name and open parenthesis '('\=
n" . $herecurr);
+			}
+		}
+# Check operator spacing.
+		if (!($line=3D~/\#\s*include/)) {
+			my $ops =3D qr{
+				<<=3D|>>=3D|<=3D|>=3D|=3D=3D|!=3D|
+				\+=3D|-=3D|\*=3D|\/=3D|%=3D|\^=3D|\|=3D|&=3D|
+				=3D>|->|<<|>>|<|>|=3D|!|~|
+				&&|\|\||,|\^|\+\+|--|&|\||\+|-|\*|\/|%|
+				\?|:
+			}x;
+			my @elements =3D split(/($ops|;)/, $opline);
+			my $off =3D 0;
+
+			my $blank =3D copy_spacing($opline);
+
+			for (my $n =3D 0; $n < $#elements; $n +=3D 2) {
+				$off +=3D length($elements[$n]);
+
+				# Pick up the preceeding and succeeding characters.
+				my $ca =3D substr($opline, 0, $off);
+				my $cc =3D '';
+				if (length($opline) >=3D ($off + length($elements[$n + 1]))) {
+					$cc =3D substr($opline, $off + length($elements[$n + 1]));
+				}
+				my $cb =3D "$ca$;$cc";
+
+				my $a =3D '';
+				$a =3D 'V' if ($elements[$n] ne '');
+				$a =3D 'W' if ($elements[$n] =3D~ /\s$/);
+				$a =3D 'C' if ($elements[$n] =3D~ /$;$/);
+				$a =3D 'B' if ($elements[$n] =3D~ /(\[|\()$/);
+				$a =3D 'O' if ($elements[$n] eq '');
+				$a =3D 'E' if ($ca =3D~ /^\s*$/);
+
+				my $op =3D $elements[$n + 1];
+
+				my $c =3D '';
+				if (defined $elements[$n + 2]) {
+					$c =3D 'V' if ($elements[$n + 2] ne '');
+					$c =3D 'W' if ($elements[$n + 2] =3D~ /^\s/);
+					$c =3D 'C' if ($elements[$n + 2] =3D~ /^$;/);
+					$c =3D 'B' if ($elements[$n + 2] =3D~ /^(\)|\]|;)/);
+					$c =3D 'O' if ($elements[$n + 2] eq '');
+					$c =3D 'E' if ($elements[$n + 2] =3D~ /^\s*\\$/);
+				} else {
+					$c =3D 'E';
+				}
+
+				my $ctx =3D "${a}x${c}";
+
+				my $at =3D "(ctx:$ctx)";
+
+				my $ptr =3D substr($blank, 0, $off) . "^";
+				my $hereptr =3D "$hereline$ptr\n";
+
+				# Pull out the value of this operator.
+				my $op_type =3D substr($curr_values, $off + 1, 1);
+
+				# Get the full operator variant.
+				my $opv =3D $op . substr($curr_vars, $off, 1);
+
+				# Ignore operators passed as parameters.
+				if ($op_type ne 'V' &&
+				    $ca =3D~ /\s$/ && $cc =3D~ /^\s*,/) {
+
+#				# Ignore comments
+#				} elsif ($op =3D~ /^$;+$/) {
+
+				# ; should have either the end of line or a space or \ after it
+				} elsif ($op eq ';') {
+					if ($ctx !~ /.x[WEBC]/ &&
+					    $cc !~ /^\\/ && $cc !~ /^;/) {
+						ERROR("space required after that '$op' $at\n" . $hereptr);
+					}
+
+				# // is a comment
+				} elsif ($op eq '//') {
+
+				# No spaces for:
+				#   ->
+				#   :   when part of a bitfield
+				} elsif ($op eq '->' || $opv eq ':B') {
+					if ($ctx =3D~ /Wx.|.xW/) {
+						ERROR("spaces prohibited around that '$op' $at\n" . $hereptr);
+					}
+
+				# , must have a space on the right.
+				} elsif ($op eq ',') {
+					if ($ctx !~ /.x[WEC]/ && $cc !~ /^}/) {
+						ERROR("space required after that '$op' $at\n" . $hereptr);
+					}
+
+				# '*' as part of a type definition -- reported already.
+				} elsif ($opv eq '*_') {
+					#warn "'*' is part of type\n";
+
+				# unary operators should have a space before and
+				# none after.  May be left adjacent to another
+				# unary operator, or a cast
+				} elsif ($op eq '!' || $op eq '~' ||
+					 $opv eq '*U' || $opv eq '-U' ||
+					 $opv eq '&U' || $opv eq '&&U') {
+					if ($ctx !~ /[WEBC]x./ && $ca !~ /(?:\)|!|~|\*|-|\&|\||\+\+|\-\-|\{)$=
/) {
+						ERROR("space required before that '$op' $at\n" . $hereptr);
+					}
+					if ($op eq '*' && $cc =3D~/\s*$Modifier\b/) {
+						# A unary '*' may be const
+
+					} elsif ($ctx =3D~ /.xW/) {
+						ERROR("Aspace prohibited after that '$op' $at\n" . $hereptr);
+					}
+
+				# unary ++ and unary -- are allowed no space on one side.
+				} elsif ($op eq '++' or $op eq '--') {
+					if ($ctx !~ /[WEOBC]x[^W]/ && $ctx !~ /[^W]x[WOBEC]/) {
+						ERROR("space required one side of that '$op' $at\n" . $hereptr);
+					}
+					if ($ctx =3D~ /Wx[BE]/ ||
+					    ($ctx =3D~ /Wx./ && $cc =3D~ /^;/)) {
+						ERROR("space prohibited before that '$op' $at\n" . $hereptr);
+					}
+					if ($ctx =3D~ /ExW/) {
+						ERROR("space prohibited after that '$op' $at\n" . $hereptr);
+					}
+
+
+				# << and >> may either have or not have spaces both sides
+				} elsif ($op eq '<<' or $op eq '>>' or
+					 $op eq '&' or $op eq '^' or $op eq '|' or
+					 $op eq '+' or $op eq '-' or
+					 $op eq '*' or $op eq '/' or
+					 $op eq '%')
+				{
+					if ($ctx =3D~ /Wx[^WCE]|[^WCE]xW/) {
+						ERROR("need consistent spacing around '$op' $at\n" .
+							$hereptr);
+					}
+
+				# A colon needs no spaces before when it is
+				# terminating a case value or a label.
+				} elsif ($opv eq ':C' || $opv eq ':L') {
+					if ($ctx =3D~ /Wx./) {
+						ERROR("space prohibited before that '$op' $at\n" . $hereptr);
+					}
+
+				# All the others need spaces both sides.
+				} elsif ($ctx !~ /[EWC]x[CWE]/) {
+					my $ok =3D 0;
+
+					# Ignore email addresses <foo@bar>
+					if (($op eq '<' &&
+					     $cc =3D~ /^\S+\@\S+>/) ||
+					    ($op eq '>' &&
+					     $ca =3D~ /<\S+\@\S+$/))
+					{
+					    	$ok =3D 1;
+					}
+
+					# Ignore ?:
+					if (($opv eq ':O' && $ca =3D~ /\?$/) ||
+					    ($op eq '?' && $cc =3D~ /^:/)) {
+					    	$ok =3D 1;
+					}
+
+					if ($ok =3D=3D 0) {
+						ERROR("spaces required around that '$op' $at\n" . $hereptr);
+					}
+				}
+				$off +=3D length($elements[$n + 1]);
+			}
+		}
+
+# check for multiple assignments
+		if ($line =3D~ /^.\s*$Lval\s*=3D\s*$Lval\s*=3D(?!=3D)/) {
+			CHK("multiple assignments should be avoided\n" . $herecurr);
+		}
+
+## # check for multiple declarations, allowing for a function declaration
+## # continuation.
+## 		if ($line =3D~ /^.\s*$Type\s+$Ident(?:\s*=3D[^,{]*)?\s*,\s*$Ident.*/ =
&&
+## 		    $line !~ /^.\s*$Type\s+$Ident(?:\s*=3D[^,{]*)?\s*,\s*$Type\s*$Ide=
nt.*/) {
+##
+## 			# Remove any bracketed sections to ensure we do not
+## 			# falsly report the parameters of functions.
+## 			my $ln =3D $line;
+## 			while ($ln =3D~ s/\([^\(\)]*\)//g) {
+## 			}
+## 			if ($ln =3D~ /,/) {
+## 				WARN("declaring multiple variables together should be avoided\n" . =
$herecurr);
+## 			}
+## 		}
+
+#need space before brace following if, while, etc
+		if (($line =3D~ /\(.*\){/ && $line !~ /\($Type\){/) ||
+		    $line =3D~ /do{/) {
+			ERROR("space required before the open brace '{'\n" . $herecurr);
+		}
+
+# closing brace should have a space following it when it has anything
+# on the line
+		if ($line =3D~ /}(?!(?:,|;|\)))\S/) {
+			ERROR("space required after that close brace '}'\n" . $herecurr);
+		}
+
+# check spacing on square brackets
+		if ($line =3D~ /\[\s/ && $line !~ /\[\s*$/) {
+			ERROR("space prohibited after that open square bracket '['\n" . $herecu=
rr);
+		}
+		if ($line =3D~ /\s\]/) {
+			ERROR("space prohibited before that close square bracket ']'\n" . $here=
curr);
+		}
+
+# check spacing on parentheses
+		if ($line =3D~ /\(\s/ && $line !~ /\(\s*(?:\\)?$/ &&
+		    $line !~ /for\s*\(\s+;/) {
+			ERROR("space prohibited after that open parenthesis '('\n" . $herecurr);
+		}
+		if ($line =3D~ /(\s+)\)/ && $line !~ /^.\s*\)/ &&
+		    $line !~ /for\s*\(.*;\s+\)/ &&
+		    $line !~ /:\s+\)/) {
+			ERROR("space prohibited before that close parenthesis ')'\n" . $herecur=
r);
+		}
+
+#goto labels aren't indented, allow a single space however
+		if ($line=3D~/^.\s+[A-Za-z\d_]+:(?![0-9]+)/ and
+		   !($line=3D~/^. [A-Za-z\d_]+:/) and !($line=3D~/^.\s+default:/)) {
+			WARN("labels should not be indented\n" . $herecurr);
+		}
+
+# Return is not a function.
+		if (defined($stat) && $stat =3D~ /^.\s*return(\s*)(\(.*);/s) {
+			my $spacing =3D $1;
+			my $value =3D $2;
+
+			# Flatten any parentheses
+			$value =3D~ s/\)\(/\) \(/g;
+			while ($value =3D~ s/\[[^\{\}]*\]/1/ ||
+			       $value !~ /(?:$Ident|-?$Constant)\s*
+					     $Compare\s*
+					     (?:$Ident|-?$Constant)/x &&
+			       $value =3D~ s/\([^\(\)]*\)/1/) {
+			}
+
+			if ($value =3D~ /^(?:$Ident|-?$Constant)$/) {
+				ERROR("return is not a function, parentheses are not required\n" . $he=
recurr);
+
+			} elsif ($spacing !~ /\s+/) {
+				ERROR("space required before the open parenthesis '('\n" . $herecurr);
+			}
+		}
+
+# Need a space before open parenthesis after if, while etc
+		if ($line=3D~/\b(if|while|for|switch)\(/) {
+			ERROR("space required before the open parenthesis '('\n" . $herecurr);
+		}
+
+# Check for illegal assignment in if conditional -- and check for trailing
+# statements after the conditional.
+		if ($line =3D~ /do\s*(?!{)/) {
+			my ($stat_next) =3D ctx_statement_block($line_nr_next,
+						$remain_next, $off_next);
+			$stat_next =3D~ s/\n./\n /g;
+			##print "stat<$stat> stat_next<$stat_next>\n";
+
+			if ($stat_next =3D~ /^\s*while\b/) {
+				# If the statement carries leading newlines,
+				# then count those as offsets.
+				my ($whitespace) =3D
+					($stat_next =3D~ /^((?:\s*\n[+-])*\s*)/s);
+				my $offset =3D
+					statement_rawlines($whitespace) - 1;
+
+				$suppress_whiletrailers{$line_nr_next +
+								$offset} =3D 1;
+			}
+		}
+		if (!defined $suppress_whiletrailers{$linenr} &&
+		    $line =3D~ /\b(?:if|while|for)\s*\(/ && $line !~ /^.\s*#/) {
+			my ($s, $c) =3D ($stat, $cond);
+
+			if ($c =3D~ /\bif\s*\(.*[^<>!=3D]=3D[^=3D].*/s) {
+				ERROR("do not use assignment in if condition\n" . $herecurr);
+			}
+
+			# Find out what is on the end of the line after the
+			# conditional.
+			substr($s, 0, length($c), '');
+			$s =3D~ s/\n.*//g;
+			$s =3D~ s/$;//g; 	# Remove any comments
+			if (length($c) && $s !~ /^\s*{?\s*\\*\s*$/ &&
+			    $c !~ /}\s*while\s*/)
+			{
+				# Find out how long the conditional actually is.
+				my @newlines =3D ($c =3D~ /\n/gs);
+				my $cond_lines =3D 1 + $#newlines;
+
+				my $stat_real =3D raw_line($linenr, $cond_lines);
+				if (defined($stat_real) && $cond_lines > 1) {
+					$stat_real =3D "[...]\n$stat_real";
+				}
+
+				ERROR("trailing statements should be on next line\n" . $herecurr . $st=
at_real);
+			}
+		}
+
+# Check for bitwise tests written as boolean
+		if ($line =3D~ /
+			(?:
+				(?:\[|\(|\&\&|\|\|)
+				\s*0[xX][0-9]+\s*
+				(?:\&\&|\|\|)
+			|
+				(?:\&\&|\|\|)
+				\s*0[xX][0-9]+\s*
+				(?:\&\&|\|\||\)|\])
+			)/x)
+		{
+			WARN("boolean test with hexadecimal, perhaps just 1 \& or \|?\n" . $her=
ecurr);
+		}
+
+# if and else should not have general statements after it
+		if ($line =3D~ /^.\s*(?:}\s*)?else\b(.*)/) {
+			my $s =3D $1;
+			$s =3D~ s/$;//g; 	# Remove any comments
+			if ($s !~ /^\s*(?:\sif|(?:{|)\s*\\?\s*$)/) {
+				ERROR("trailing statements should be on next line\n" . $herecurr);
+			}
+		}
+# if should not continue a brace
+		if ($line =3D~ /}\s*if\b/) {
+			ERROR("trailing statements should be on next line\n" .
+				$herecurr);
+		}
+# case and default should not have general statements after them
+		if ($line =3D~ /^.\s*(?:case\s*.*|default\s*):/g &&
+		    $line !~ /\G(?:
+			(?:\s*$;*)(?:\s*{)?(?:\s*$;*)(?:\s*\\)?\s*$|
+			\s*return\s+
+		    )/xg)
+		{
+			ERROR("trailing statements should be on next line\n" . $herecurr);
+		}
+
+		# Check for }<nl>else {, these must be at the same
+		# indent level to be relevant to each other.
+		if ($prevline=3D~/}\s*$/ and $line=3D~/^.\s*else\s*/ and
+						$previndent =3D=3D $indent) {
+			ERROR("else should follow close brace '}'\n" . $hereprev);
+		}
+
+		if ($prevline=3D~/}\s*$/ and $line=3D~/^.\s*while\s*/ and
+						$previndent =3D=3D $indent) {
+			my ($s, $c) =3D ctx_statement_block($linenr, $realcnt, 0);
+
+			# Find out what is on the end of the line after the
+			# conditional.
+			substr($s, 0, length($c), '');
+			$s =3D~ s/\n.*//g;
+
+			if ($s =3D~ /^\s*;/) {
+				ERROR("while should follow close brace '}'\n" . $hereprev);
+			}
+		}
+
+#studly caps, commented out until figure out how to distinguish between us=
e of existing and adding new
+#		if (($line=3D~/[\w_][a-z\d]+[A-Z]/) and !($line=3D~/print/)) {
+#		    print "No studly caps, use _\n";
+#		    print "$herecurr";
+#		    $clean =3D 0;
+#		}
+
+#no spaces allowed after \ in define
+		if ($line=3D~/\#\s*define.*\\\s$/) {
+			WARN("Whitepspace after \\ makes next lines useless\n" . $herecurr);
+		}
+
+#warn if <asm/foo.h> is #included and <linux/foo.h> is available (uses RAW=
 line)
+		if ($tree && $rawline =3D~ m{^.\s*\#\s*include\s*\<asm\/(.*)\.h\>}) {
+			my $file =3D "$1.h";
+			my $checkfile =3D "include/linux/$file";
+			if (-f "$root/$checkfile" &&
+			    $realfile ne $checkfile &&
+			    $1 ne 'irq')
+			{
+				if ($realfile =3D~ m{^arch/}) {
+					CHK("Consider using #include <linux/$file> instead of <asm/$file>\n" =
. $herecurr);
+				} else {
+					WARN("Use #include <linux/$file> instead of <asm/$file>\n" . $herecur=
r);
+				}
+			}
+		}
+
+# multi-statement macros should be enclosed in a do while loop, grab the
+# first statement and ensure its the whole macro if its not enclosed
+# in a known good container
+		if ($realfile !~ m@/vmlinux.lds.h$@ &&
+		    $line =3D~ /^.\s*\#\s*define\s*$Ident(\()?/) {
+			my $ln =3D $linenr;
+			my $cnt =3D $realcnt;
+			my ($off, $dstat, $dcond, $rest);
+			my $ctx =3D '';
+
+			my $args =3D defined($1);
+
+			# Find the end of the macro and limit our statement
+			# search to that.
+			while ($cnt > 0 && defined $lines[$ln - 1] &&
+				$lines[$ln - 1] =3D~ /^(?:-|..*\\$)/)
+			{
+				$ctx .=3D $rawlines[$ln - 1] . "\n";
+				$cnt-- if ($lines[$ln - 1] !~ /^-/);
+				$ln++;
+			}
+			$ctx .=3D $rawlines[$ln - 1];
+
+			($dstat, $dcond, $ln, $cnt, $off) =3D
+				ctx_statement_block($linenr, $ln - $linenr + 1, 0);
+			#print "dstat<$dstat> dcond<$dcond> cnt<$cnt> off<$off>\n";
+			#print "LINE<$lines[$ln-1]> len<" . length($lines[$ln-1]) . "\n";
+
+			# Extract the remainder of the define (if any) and
+			# rip off surrounding spaces, and trailing \'s.
+			$rest =3D '';
+			while ($off !=3D 0 || ($cnt > 0 && $rest =3D~ /\\\s*$/)) {
+				#print "ADDING cnt<$cnt> $off <" . substr($lines[$ln - 1], $off) . "> =
rest<$rest>\n";
+				if ($off !=3D 0 || $lines[$ln - 1] !~ /^-/) {
+					$rest .=3D substr($lines[$ln - 1], $off) . "\n";
+					$cnt--;
+				}
+				$ln++;
+				$off =3D 0;
+			}
+			$rest =3D~ s/\\\n.//g;
+			$rest =3D~ s/^\s*//s;
+			$rest =3D~ s/\s*$//s;
+
+			# Clean up the original statement.
+			if ($args) {
+				substr($dstat, 0, length($dcond), '');
+			} else {
+				$dstat =3D~ s/^.\s*\#\s*define\s+$Ident\s*//;
+			}
+			$dstat =3D~ s/$;//g;
+			$dstat =3D~ s/\\\n.//g;
+			$dstat =3D~ s/^\s*//s;
+			$dstat =3D~ s/\s*$//s;
+
+			# Flatten any parentheses and braces
+			while ($dstat =3D~ s/\([^\(\)]*\)/1/ ||
+			       $dstat =3D~ s/\{[^\{\}]*\}/1/ ||
+			       $dstat =3D~ s/\[[^\{\}]*\]/1/)
+			{
+			}
+
+			my $exceptions =3D qr{
+				$Declare|
+				module_param_named|
+				MODULE_PARAM_DESC|
+				DECLARE_PER_CPU|
+				DEFINE_PER_CPU|
+				__typeof__\(|
+				\.$Ident\s*=3D\s*
+			}x;
+			#print "REST<$rest> dstat<$dstat>\n";
+			if ($rest ne '') {
+				if ($rest !~ /while\s*\(/ &&
+				    $dstat !~ /$exceptions/)
+				{
+					ERROR("Macros with multiple statements should be enclosed in a do - w=
hile loop\n" . "$here\n$ctx\n");
+				}
+
+			} elsif ($ctx !~ /;/) {
+				if ($dstat ne '' &&
+				    $dstat !~ /^(?:$Ident|-?$Constant)$/ &&
+				    $dstat !~ /$exceptions/ &&
+				    $dstat !~ /^\.$Ident\s*=3D/ &&
+				    $dstat =3D~ /$Operators/)
+				{
+					ERROR("Macros with complex values should be enclosed in parenthesis\n=
" . "$here\n$ctx\n");
+				}
+			}
+		}
+
+# make sure symbols are always wrapped with VMLINUX_SYMBOL() ...
+# all assignments may have only one of the following with an assignment:
+#	.
+#	ALIGN(...)
+#	VMLINUX_SYMBOL(...)
+		if ($realfile eq 'vmlinux.lds.h' && $line =3D~ /(?:(?:^|\s)$Ident\s*=3D|=
=3D\s*$Ident(?:\s|$))/) {
+			WARN("vmlinux.lds.h needs VMLINUX_SYMBOL() around C-visible symbols\n" =
. $herecurr);
+		}
+
+# check for redundant bracing round if etc
+		if ($line =3D~ /(^.*)\bif\b/ && $1 !~ /else\s*$/) {
+			my ($level, $endln, @chunks) =3D
+				ctx_statement_full($linenr, $realcnt, 1);
+			#print "chunks<$#chunks> linenr<$linenr> endln<$endln> level<$level>\n";
+			#print "APW: <<$chunks[1][0]>><<$chunks[1][1]>>\n";
+			if ($#chunks > 0 && $level =3D=3D 0) {
+				my $allowed =3D 0;
+				my $seen =3D 0;
+				my $herectx =3D $here . "\n";
+				my $ln =3D $linenr - 1;
+				for my $chunk (@chunks) {
+					my ($cond, $block) =3D @{$chunk};
+
+					# If the condition carries leading newlines, then count those as offs=
ets.
+					my ($whitespace) =3D ($cond =3D~ /^((?:\s*\n[+-])*\s*)/s);
+					my $offset =3D statement_rawlines($whitespace) - 1;
+
+					#print "COND<$cond> whitespace<$whitespace> offset<$offset>\n";
+
+					# We have looked at and allowed this specific line.
+					$suppress_ifbraces{$ln + $offset} =3D 1;
+
+					$herectx .=3D "$rawlines[$ln + $offset]\n[...]\n";
+					$ln +=3D statement_rawlines($block) - 1;
+
+					substr($block, 0, length($cond), '');
+
+					$seen++ if ($block =3D~ /^\s*{/);
+
+					#print "cond<$cond> block<$block> allowed<$allowed>\n";
+					if (statement_lines($cond) > 1) {
+						#print "APW: ALLOWED: cond<$cond>\n";
+						$allowed =3D 1;
+					}
+					if ($block =3D~/\b(?:if|for|while)\b/) {
+						#print "APW: ALLOWED: block<$block>\n";
+						$allowed =3D 1;
+					}
+					if (statement_block_size($block) > 1) {
+						#print "APW: ALLOWED: lines block<$block>\n";
+						$allowed =3D 1;
+					}
+				}
+				if ($seen && !$allowed) {
+					WARN("braces {} are not necessary for any arm of this statement\n" . =
$herectx);
+				}
+			}
+		}
+		if (!defined $suppress_ifbraces{$linenr - 1} &&
+					$line =3D~ /\b(if|while|for|else)\b/) {
+			my $allowed =3D 0;
+
+			# Check the pre-context.
+			if (substr($line, 0, $-[0]) =3D~ /(\}\s*)$/) {
+				#print "APW: ALLOWED: pre<$1>\n";
+				$allowed =3D 1;
+			}
+
+			my ($level, $endln, @chunks) =3D
+				ctx_statement_full($linenr, $realcnt, $-[0]);
+
+			# Check the condition.
+			my ($cond, $block) =3D @{$chunks[0]};
+			#print "CHECKING<$linenr> cond<$cond> block<$block>\n";
+			if (defined $cond) {
+				substr($block, 0, length($cond), '');
+			}
+			if (statement_lines($cond) > 1) {
+				#print "APW: ALLOWED: cond<$cond>\n";
+				$allowed =3D 1;
+			}
+			if ($block =3D~/\b(?:if|for|while)\b/) {
+				#print "APW: ALLOWED: block<$block>\n";
+				$allowed =3D 1;
+			}
+			if (statement_block_size($block) > 1) {
+				#print "APW: ALLOWED: lines block<$block>\n";
+				$allowed =3D 1;
+			}
+			# Check the post-context.
+			if (defined $chunks[1]) {
+				my ($cond, $block) =3D @{$chunks[1]};
+				if (defined $cond) {
+					substr($block, 0, length($cond), '');
+				}
+				if ($block =3D~ /^\s*\{/) {
+					#print "APW: ALLOWED: chunk-1 block<$block>\n";
+					$allowed =3D 1;
+				}
+			}
+			if ($level =3D=3D 0 && $block =3D~ /^\s*\{/ && !$allowed) {
+				my $herectx =3D $here . "\n";;
+				my $cnt =3D statement_rawlines($block);
+
+				for (my $n =3D 0; $n < $cnt; $n++) {
+					$herectx .=3D raw_line($linenr, $n) . "\n";;
+				}
+
+				WARN("braces {} are not necessary for single statement blocks\n" . $he=
rectx);
+			}
+		}
+
+# don't include deprecated include files (uses RAW line)
+		for my $inc (@dep_includes) {
+			if ($rawline =3D~ m@^.\s*\#\s*include\s*\<$inc>@) {
+				ERROR("Don't use <$inc>: see Documentation/feature-removal-schedule.tx=
t\n" . $herecurr);
+			}
+		}
+
+# don't use deprecated functions
+		for my $func (@dep_functions) {
+			if ($line =3D~ /\b$func\b/) {
+				ERROR("Don't use $func(): see Documentation/feature-removal-schedule.t=
xt\n" . $herecurr);
+			}
+		}
+
+# no volatiles please
+		my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile__|volatile)\b};
+		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/) {
+			WARN("Use of volatile is usually wrong: see Documentation/volatile-cons=
idered-harmful.txt\n" . $herecurr);
+		}
+
+# SPIN_LOCK_UNLOCKED & RW_LOCK_UNLOCKED are deprecated
+		if ($line =3D~ /\b(SPIN_LOCK_UNLOCKED|RW_LOCK_UNLOCKED)/) {
+			ERROR("Use of $1 is deprecated: see Documentation/spinlocks.txt\n" . $h=
erecurr);
+		}
+
+# warn about #if 0
+		if ($line =3D~ /^.\s*\#\s*if\s+0\b/) {
+			CHK("if this code is redundant consider removing it\n" .
+				$herecurr);
+		}
+
+# check for needless kfree() checks
+		if ($prevline =3D~ /\bif\s*\(([^\)]*)\)/) {
+			my $expr =3D $1;
+			if ($line =3D~ /\bkfree\(\Q$expr\E\);/) {
+				WARN("kfree(NULL) is safe this check is probably not required\n" . $he=
reprev);
+			}
+		}
+# check for needless usb_free_urb() checks
+		if ($prevline =3D~ /\bif\s*\(([^\)]*)\)/) {
+			my $expr =3D $1;
+			if ($line =3D~ /\busb_free_urb\(\Q$expr\E\);/) {
+				WARN("usb_free_urb(NULL) is safe this check is probably not required\n=
" . $hereprev);
+			}
+		}
+
+# warn about #ifdefs in C files
+#		if ($line =3D~ /^.\s*\#\s*if(|n)def/ && ($realfile =3D~ /\.c$/)) {
+#			print "#ifdef in C files should be avoided\n";
+#			print "$herecurr";
+#			$clean =3D 0;
+#		}
+
+# warn about spacing in #ifdefs
+		if ($line =3D~ /^.\s*\#\s*(ifdef|ifndef|elif)\s\s+/) {
+			ERROR("exactly one space required after that #$1\n" . $herecurr);
+		}
+
+# check for spinlock_t definitions without a comment.
+		if ($line =3D~ /^.\s*(struct\s+mutex|spinlock_t)\s+\S+;/ ||
+		    $line =3D~ /^.\s*(DEFINE_MUTEX)\s*\(/) {
+			my $which =3D $1;
+			if (!ctx_has_comment($first_line, $linenr)) {
+				CHK("$1 definition without comment\n" . $herecurr);
+			}
+		}
+# check for memory barriers without a comment.
+		if ($line =3D~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wm=
b|smp_read_barrier_depends)\(/) {
+			if (!ctx_has_comment($first_line, $linenr)) {
+				CHK("memory barrier without comment\n" . $herecurr);
+			}
+		}
+# check of hardware specific defines
+		if ($line =3D~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x=
__)\b@ && $realfile !~ m(a)include/asm-@) {
+			CHK("architecture specific defines should be avoided\n" .  $herecurr);
+		}
+
+# check the location of the inline attribute, that it is between
+# storage class and type.
+		if ($line =3D~ /\b$Type\s+$Inline\b/ ||
+		    $line =3D~ /\b$Inline\s+$Storage\b/) {
+			ERROR("inline keyword should sit between storage class and type\n" . $h=
erecurr);
+		}
+
+# Check for __inline__ and __inline, prefer inline
+		if ($line =3D~ /\b(__inline__|__inline)\b/) {
+			WARN("plain inline is preferred over $1\n" . $herecurr);
+		}
+
+# check for new externs in .c files.
+		if ($realfile =3D~ /\.c$/ && defined $stat &&
+		    $stat =3D~ /^.\s*(?:extern\s+)?$Type\s+($Ident)(\s*)\(/s)
+		{
+			my $function_name =3D $1;
+			my $paren_space =3D $2;
+
+			my $s =3D $stat;
+			if (defined $cond) {
+				substr($s, 0, length($cond), '');
+			}
+			if ($s =3D~ /^\s*;/ &&
+			    $function_name ne 'uninitialized_var')
+			{
+				WARN("externs should be avoided in .c files\n" .  $herecurr);
+			}
+
+			if ($paren_space =3D~ /\n/) {
+				WARN("arguments for function declarations should follow identifier\n" =
. $herecurr);
+			}
+
+		} elsif ($realfile =3D~ /\.c$/ && defined $stat &&
+		    $stat =3D~ /^.\s*extern\s+/)
+		{
+			WARN("externs should be avoided in .c files\n" .  $herecurr);
+		}
+
+# checks for new __setup's
+		if ($rawline =3D~ /\b__setup\("([^"]*)"/) {
+			my $name =3D $1;
+
+			if (!grep(/$name/, @setup_docs)) {
+				CHK("__setup appears un-documented -- check Documentation/kernel-param=
eters.txt\n" . $herecurr);
+			}
+		}
+
+# check for pointless casting of kmalloc return
+		if ($line =3D~ /\*\s*\)\s*k[czm]alloc\b/) {
+			WARN("unnecessary cast may hide bugs, see http://c-faq.com/malloc/mallo=
cnocast.html\n" . $herecurr);
+		}
+
+# check for gcc specific __FUNCTION__
+		if ($line =3D~ /__FUNCTION__/) {
+			WARN("__func__ should be used instead of gcc specific __FUNCTION__\n"  =
. $herecurr);
+		}
+
+# check for semaphores used as mutexes
+		if ($line =3D~ /^.\s*(DECLARE_MUTEX|init_MUTEX)\s*\(/) {
+			WARN("mutexes are preferred for single holder semaphores\n" . $herecurr=
);
+		}
+# check for semaphores used as mutexes
+		if ($line =3D~ /^.\s*init_MUTEX_LOCKED\s*\(/) {
+			WARN("consider using a completion\n" . $herecurr);
+		}
+# recommend strict_strto* over simple_strto*
+		if ($line =3D~ /\bsimple_(strto.*?)\s*\(/) {
+			WARN("consider using strict_$1 in preference to simple_$1\n" . $herecur=
r);
+		}
+# check for __initcall(), use device_initcall() explicitly please
+		if ($line =3D~ /^.\s*__initcall\s*\(/) {
+			WARN("please use device_initcall() instead of __initcall()\n" . $herecu=
rr);
+		}
+# check for struct file_operations, ensure they are const.
+		if ($line !~ /\bconst\b/ &&
+		    $line =3D~ /\bstruct\s+(file_operations|seq_operations)\b/) {
+			WARN("struct $1 should normally be const\n" .
+				$herecurr);
+		}
+
+# use of NR_CPUS is usually wrong
+# ignore definitions of NR_CPUS and usage to define arrays as likely right
+		if ($line =3D~ /\bNR_CPUS\b/ &&
+		    $line !~ /^.\s*\s*#\s*if\b.*\bNR_CPUS\b/ &&
+		    $line !~ /^.\s*\s*#\s*define\b.*\bNR_CPUS\b/ &&
+		    $line !~ /^.\s*$Declare\s.*\[[^\]]*NR_CPUS[^\]]*\]/ &&
+		    $line !~ /\[[^\]]*\.\.\.[^\]]*NR_CPUS[^\]]*\]/ &&
+		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/)
+		{
+			WARN("usage of NR_CPUS is often wrong - consider using cpu_possible(), =
num_possible_cpus(), for_each_possible_cpu(), etc\n" . $herecurr);
+		}
+
+# check for %L{u,d,i} in strings
+		my $string;
+		while ($line =3D~ /(?:^|")([X\t]*)(?:"|$)/g) {
+			$string =3D substr($rawline, $-[1], $+[1] - $-[1]);
+			$string =3D~ s/%%/__/g;
+			if ($string =3D~ /(?<!%)%L[udi]/) {
+				WARN("\%Ld/%Lu are not-standard C, use %lld/%llu\n" . $herecurr);
+				last;
+			}
+		}
+
+# whine mightly about in_atomic
+		if ($line =3D~ /\bin_atomic\s*\(/) {
+			if ($realfile =3D~ m@^drivers/@) {
+				ERROR("do not use in_atomic in drivers\n" . $herecurr);
+			} elsif ($realfile !~ m@^kernel/@) {
+				WARN("use of in_atomic() is incorrect outside core kernel code\n" . $h=
erecurr);
+			}
+		}
+	}
+
+	# If we have no input@all, then there is nothing to report on
+	# so just keep quiet.
+	if ($#rawlines =3D=3D -1) {
+		exit(0);
+	}
+
+	# In mailback mode only produce a report in the negative, for
+	# things that appear to be patches.
+	if ($mailback && ($clean =3D=3D 1 || !$is_patch)) {
+		exit(0);
+	}
+
+	# This is not a patch, and we are are in 'no-patch' mode so
+	# just keep quiet.
+	if (!$chk_patch && !$is_patch) {
+		exit(0);
+	}
+
+	if (!$is_patch) {
+		ERROR("Does not appear to be a unified-diff format patch\n");
+	}
+	if ($is_patch && $chk_signoff && $signoff =3D=3D 0) {
+		ERROR("Missing Signed-off-by: line(s)\n");
+	}
+
+	print report_dump();
+	if ($summary && !($clean =3D=3D 1 && $quiet =3D=3D 1)) {
+		print "$filename " if ($summary_file);
+		print "total: $cnt_error errors, $cnt_warn warnings, " .
+			(($check)? "$cnt_chk checks, " : "") .
+			"$cnt_lines lines checked\n";
+		print "\n" if ($quiet =3D=3D 0);
+	}
+
+	if ($clean =3D=3D 1 && $quiet =3D=3D 0) {
+		print "$vname has no obvious style problems and is ready for submission.=
\n"
+	}
+	if ($clean =3D=3D 0 && $quiet =3D=3D 0) {
+		print "$vname has style problems, please review.  If any of these errors=
\n";
+		print "are false positives report them to the maintainer, see\n";
+		print "CHECKPATCH in MAINTAINERS.\n";
+	}
+
+	return $clean;
+}
-- =

1.7.0.4


--===============2574822054090171456==--


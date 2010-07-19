Content-Type: multipart/mixed; boundary="===============2288521560682754136=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 3/4] Add git commit header and description check
Date: Mon, 19 Jul 2010 14:19:28 +0800
Message-ID: <1279520369-13214-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1279520369-13214-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2288521560682754136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/checkpatch.pl |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/test/checkpatch.pl b/test/checkpatch.pl
index 2d5ece7..767670d 100755
--- a/test/checkpatch.pl
+++ b/test/checkpatch.pl
@@ -1260,6 +1260,24 @@ sub process {
 =

 		$cnt_lines++ if ($realcnt !=3D 0);
 =

+#check the commit header and description
+        if ($line =3D~ /Subject: \[PATCH.*\] (.*)/) {
+            my $header =3D $1;
+            if (length($header) > 50) {
+            	ERROR("Commit header exceeds the limitation of 50 characters\=
n");
+            }            =

+            my @desc;
+            my $desc_linenr =3D $linenr;
+            my $desc_line =3D $lines[$desc_linenr++];
+            while ($desc_line ne "---") {
+                if (length($desc_line) > 72) {               =

+                    ERROR("Commit description exceeds the limitation of 72=
 characters\n#".($desc_linenr-$linenr-1).": ".$desc_line."\n");   =

+                }
+                $desc_line =3D $lines[$desc_linenr++];
+            }
+            =

+        }
+
 #check the patch for a signoff:
 		if ($line =3D~ /^\s*signed-off-by:/i) {
 			# This is a signoff, if ugly, so do not double report.
-- =

1.7.0.4


--===============2288521560682754136==--


Content-Type: multipart/mixed; boundary="===============2636371049706566996=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 4/4] Dont check Signed-off-by by default
Date: Mon, 19 Jul 2010 14:19:29 +0800
Message-ID: <1279520369-13214-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1279520369-13214-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2636371049706566996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/checkpatch.pl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/checkpatch.pl b/test/checkpatch.pl
index 767670d..2a4faa0 100755
--- a/test/checkpatch.pl
+++ b/test/checkpatch.pl
@@ -16,7 +16,7 @@ use Getopt::Long qw(:config no_auto_abbrev);
 =

 my $quiet =3D 0;
 my $tree =3D 1;
-my $chk_signoff =3D 1;
+my $chk_signoff =3D 0;
 my $chk_patch =3D 1;
 my $tst_only;
 my $emacs =3D 0;
-- =

1.7.0.4


--===============2636371049706566996==--


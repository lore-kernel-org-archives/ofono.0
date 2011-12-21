Content-Type: multipart/mixed; boundary="===============0520490142203665149=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 2/2] Makefile: Add Speedup udev rules to EXTRA_DIST
Date: Wed, 21 Dec 2011 10:37:59 +0100
Message-ID: <1324460279-4434-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1324460279-4434-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0520490142203665149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 337aeb7..d41f03d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -564,7 +564,8 @@ testdir =3D $(pkglibdir)/test
 test_SCRIPTS =3D $(test_scripts)
 endif
 =

-EXTRA_DIST =3D src/genbuiltin plugins/ofono.rules $(doc_files) $(test_scri=
pts)
+EXTRA_DIST =3D src/genbuiltin plugins/ofono.rules plugins/ofono-speedup.ru=
les \
+				$(doc_files) $(test_scripts)
 =

 dist_man_MANS =3D doc/ofonod.8
 =

-- =

1.7.1


--===============0520490142203665149==--


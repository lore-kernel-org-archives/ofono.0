Content-Type: multipart/mixed; boundary="===============0693093165843371464=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [RFC 3/6] build: Add main.conf to the build
Date: Wed, 26 Jan 2011 10:56:23 +0200
Message-ID: <1296032186-21497-4-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296032186-21497-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0693093165843371464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f941a19..02ea2cb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -35,7 +35,7 @@ endif
 =

 confdir =3D $(sysconfdir)/ofono
 =

-conf_DATA =3D
+conf_DATA =3D src/main.conf
 =

 statedir =3D $(localstatedir)/lib/ofono
 =

@@ -477,7 +477,7 @@ testdir =3D $(pkglibdir)/test
 test_SCRIPTS =3D $(test_scripts)
 endif
 =

-conf_files =3D src/ofono.conf plugins/phonesim.conf
+conf_files =3D src/ofono.conf plugins/phonesim.conf src/main.conf
 =

 EXTRA_DIST =3D src/genbuiltin $(conf_files) $(udev_files) \
 					$(doc_files) $(test_scripts)
-- =

1.7.1


--===============0693093165843371464==--


Content-Type: multipart/mixed; boundary="===============5048053990579340539=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH 1/6] bugfix: distcheck fail due to rename of
 dataconnectionmanager-api.txt
Date: Fri, 13 Aug 2010 12:53:09 +0200
Message-ID: <1281696794-10891-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5048053990579340539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 83aa8f3..2f0b745 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -301,7 +301,7 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt \
 			doc/call-forwarding-api.txt doc/call-settings-api.txt \
 			doc/call-meter-api.txt \
 			doc/supplementaryservices-api.txt \
-			doc/dataconnectionmanager-api.txt
+			doc/connman-api.txt
 =

 test_scripts =3D test/activate-context \
 		test/create-context \
-- =

1.7.0.4


--===============5048053990579340539==--


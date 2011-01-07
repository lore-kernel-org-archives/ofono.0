Content-Type: multipart/mixed; boundary="===============2886913619493861792=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH] Makefile.am: fix missing line continuation
Date: Fri, 07 Jan 2011 11:49:31 -0300
Message-ID: <1294411771-27849-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2886913619493861792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 09dc9ad..679e4bf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -436,7 +436,7 @@ test_scripts =3D test/backtrace \
 		test/send-vcard \
 		test/set-tty \
 		test/set-gsm-band \
-		test/set-umts-band
+		test/set-umts-band \
 		test/lockdown-modem
 =

 if TEST
-- =

1.7.2.3


--===============2886913619493861792==--


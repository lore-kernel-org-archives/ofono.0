Content-Type: multipart/mixed; boundary="===============2243083366819152980=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] README: Annotate kernel dependencies
Date: Thu, 20 Jan 2011 17:03:33 -0200
Message-ID: <1295550213-25696-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2243083366819152980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 README |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/README b/README
index 176a2de..71c8c2d 100644
--- a/README
+++ b/README
@@ -20,3 +20,10 @@ Configure automatically searches for all required compon=
ents and packages.
 =

 To compile and install run:
 	make && make install
+
+
+Kernel Dependencies
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+In order to have the PPP stack working in oFono you need to enable CONFIG_=
TUN
+(Universal TUN/TAP device driver support) in your kernel .config.
-- =

1.7.4.rc2


--===============2243083366819152980==--


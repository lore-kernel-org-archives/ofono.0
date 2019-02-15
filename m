Content-Type: multipart/mixed; boundary="===============4506865358439878062=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 2/8] Makefile.am : include new u-blox serial modem driver
Date: Fri, 15 Feb 2019 14:11:36 +0200
Message-ID: <20190215121142.28163-3-philippedeswert@gmail.com>
In-Reply-To: <20190215121142.28163-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4506865358439878062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Philippe De Swert <philippe.deswert@digitalistgroup.com>

Make sure the new u-blox serial modem driver gets built.
---
 Makefile.am | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 6aa8f8fe..df7827d4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -596,6 +596,10 @@ builtin_sources +=3D plugins/quectel.c
 builtin_modules +=3D ublox
 builtin_sources +=3D plugins/ublox.c
 =

+
+builtin_modules +=3D ubloxserial
+builtin_sources +=3D plugins/ublox-serial.c
+
 builtin_modules +=3D xmm7xxx
 builtin_sources +=3D plugins/xmm7xxx.c
 =

-- =

2.20.1


--===============4506865358439878062==--


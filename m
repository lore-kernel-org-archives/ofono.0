Content-Type: multipart/mixed; boundary="===============2374968085601598133=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 3/4] build: Add n950 plugin to build
Date: Mon, 14 May 2012 21:03:10 +0300
Message-ID: <1337018591-6553-3-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1337018591-6553-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2374968085601598133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 9cb490d..2586f5d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -147,6 +147,9 @@ builtin_sources +=3D plugins/isiusb.c
 builtin_modules +=3D n900
 builtin_sources +=3D plugins/n900.c plugins/nokia-gpio.h plugins/nokia-gpi=
o.c
 =

+builtin_modules +=3D n950
+builtin_sources +=3D plugins/n950.c
+
 builtin_modules +=3D u8500
 builtin_sources +=3D plugins/u8500.c
 endif
-- =

1.7.5.4


--===============2374968085601598133==--


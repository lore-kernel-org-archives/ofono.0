Content-Type: multipart/mixed; boundary="===============6458116812133456151=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim v2 6/8] Make Qt detect fPIC flag correctly
Date: Sun, 27 Oct 2019 17:30:07 +0100
Message-ID: <20191027163009.13406-7-jbb.prv@gmx.de>
In-Reply-To: <20191027163009.13406-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6458116812133456151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 59fb421..74cf657 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -46,7 +46,7 @@ nodist_src_phonesim_SOURCES =3D src/ui_controlbase.h \

 src_phonesim_LDADD =3D $(QT_LIBS)

-AM_CXXFLAGS =3D -Wall $(QT_CFLAGS) -fPIC -fPIE
+AM_CXXFLAGS =3D -Wall $(QT_CFLAGS) -fPIC

 AM_CPPFLAGS =3D -I$(top_srcdir)/src -I$(top_builddir)/src

--
2.23.0

--===============6458116812133456151==--


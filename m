Content-Type: multipart/mixed; boundary="===============2970473378324859952=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim v2 4/8] Fix build with Qt 5.8
Date: Sun, 27 Oct 2019 17:30:05 +0100
Message-ID: <20191027163009.13406-5-jbb.prv@gmx.de>
In-Reply-To: <20191027163009.13406-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2970473378324859952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Jansa <Martin.Jansa@gmail.com>

../phonesim-1.20/src/qsmsmessage.cpp: In member function 'QCBSMessage QCBSD=
eliverMessage::unpack(QTextCodec*)':
../phonesim-1.20/src/qsmsmessage.cpp:2598:40: error: ambiguous overload for=
 'operator=3D=3D' (operand types are 'QCharRef' and 'char')
                          text[len - 1] =3D=3D '\0' ) ) {
                          ~~~~~~~~~~~~~~^~~~~~~
In file included from ../phonesim-1.20/src/qsmsmessage.h:23:0,
                 from ../phonesim-1.20/src/qsmsmessage.cpp:22:
/OE/build/owpb/webos-ports/tmp-glibc/work/i586-webos-linux/phonesim/1.20-r0=
/recipe-sysroot/usr/include/qt5/QtCore/qstring.h:1632:13: note: candidate: =
bool operator=3D=3D(QChar, const QStringRef&)
 inline bool operator=3D=3D(QChar lhs, const QStringRef &rhs) Q_DECL_NOTHROW
             ^~~~~~~~
/OE/build/owpb/webos-ports/tmp-glibc/work/i586-webos-linux/phonesim/1.20-r0=
/recipe-sysroot/usr/include/qt5/QtCore/qstring.h:1613:13: note: candidate: =
bool operator=3D=3D(QChar, const QString&)
 inline bool operator=3D=3D(QChar lhs, const QString &rhs) Q_DECL_NOTHROW
             ^~~~~~~~
In file included from /OE/build/owpb/webos-ports/tmp-glibc/work/i586-webos-=
linux/phonesim/1.20-r0/recipe-sysroot/usr/include/qt5/QtCore/qstring.h:48:0,
                 from ../phonesim-1.20/src/qsmsmessage.h:23,
                 from ../phonesim-1.20/src/qsmsmessage.cpp:22:
/OE/build/owpb/webos-ports/tmp-glibc/work/i586-webos-linux/phonesim/1.20-r0=
/recipe-sysroot/usr/include/qt5/QtCore/qchar.h:573:30: note: candidate: con=
stexpr bool operator=3D=3D(QChar, QChar)
 Q_DECL_CONSTEXPR inline bool operator=3D=3D(QChar c1, QChar c2) Q_DECL_NOT=
HROW { return c1.ucs =3D=3D c2.ucs; }
                              ^~~~~~~~
make: *** [Makefile:583: src/qsmsmessage.o] Error 1

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 src/qsmsmessage.cpp | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/qsmsmessage.cpp b/src/qsmsmessage.cpp
index 54885bd..63d6952 100644
--- a/src/qsmsmessage.cpp
+++ b/src/qsmsmessage.cpp
@@ -2594,8 +2594,8 @@ QCBSMessage QCBSDeliverMessage::unpack(QTextCodec *co=
dec)
     QString text =3D userData
         ( (QSMSDataCodingScheme)scheme, codec, headers, false, true );
     len =3D text.length();
-    while ( len > 0 && ( text[len - 1] =3D=3D '\r' || text[len - 1] =3D=3D=
 '\n' ||
-                         text[len - 1] =3D=3D '\0' ) ) {
+    while ( len > 0 && ( text.at(len - 1) =3D=3D QChar ('\r') || text.at(l=
en - 1) =3D=3D QChar ('\n') ||
+                         text.at(len - 1) =3D=3D QChar ('\0') ) ) {
         --len;
     }
     m.setText( text.left( len ) );
--
2.23.0

--===============2970473378324859952==--


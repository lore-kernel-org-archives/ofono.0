Content-Type: multipart/mixed; boundary="===============3772962098369967576=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 09/13] Require Qt5Widgets >= 5.10
Date: Tue, 12 Nov 2019 22:37:15 +0100
Message-ID: <20191112213719.9309-10-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3772962098369967576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I don't think it's possible to use preprocessor directives with Qt's ui fil=
es, so this is neccessary.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 0587f9f..da87afe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -22,7 +22,7 @@ AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-opt=
imization],
 	fi
 ])

-PKG_CHECK_MODULES(QT, Qt5Core Qt5Gui Qt5Xml Qt5Network Qt5Qml Qt5DBus Qt5W=
idgets, dummy=3Dyes,
+PKG_CHECK_MODULES(QT, Qt5Core Qt5Gui Qt5Xml Qt5Network Qt5Qml Qt5DBus [Qt5=
Widgets >=3D 5.10], dummy=3Dyes,
 						AC_MSG_ERROR(Qt is required))

 # Needed for qOverload
--
2.24.0

--===============3772962098369967576==--


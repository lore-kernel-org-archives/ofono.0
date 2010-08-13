Content-Type: multipart/mixed; boundary="===============5122410304681309853=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 1/2] Add --disable-n900modem to the configure script
Date: Fri, 13 Aug 2010 21:31:53 +0300
Message-ID: <1281724314-19465-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5122410304681309853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 configure.ac |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index e834077..6c303f7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -140,6 +140,13 @@ AC_ARG_ENABLE(isimodem, AC_HELP_STRING([--disable-isim=
odem],
 					[enable_isimodem=3D${enableval}])
 AM_CONDITIONAL(ISIMODEM, test "${enable_isimodem}" !=3D "no")
 =

+AC_ARG_ENABLE(n900modem, AC_HELP_STRING([--disable-n900modem],
+				[disable native Nokia N900 modem support]),
+					[enable_n900modem=3D${enableval}])
+AC_DEFINE([HAVE_N900MODEM], 1,
+ [Define to 1 if you have native N900 modem support.])
+AM_CONDITIONAL(N900MODEM, test "${enable_n900modem}" !=3D "no")
+
 AC_ARG_ENABLE(atmodem, AC_HELP_STRING([--disable-atmodem],
 				[disable ETSI AT modem support]),
 					[enable_atmodem=3D${enableval}])
-- =

1.7.0.4


--===============5122410304681309853==--


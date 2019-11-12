Content-Type: multipart/mixed; boundary="===============6242779214437559992=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 06/13] qwsppdu: Port to QLocale
Date: Tue, 12 Nov 2019 22:37:12 +0100
Message-ID: <20191112213719.9309-7-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6242779214437559992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qwsppdu.cpp | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/src/qwsppdu.cpp b/src/qwsppdu.cpp
index 26f450d..f3a1661 100644
--- a/src/qwsppdu.cpp
+++ b/src/qwsppdu.cpp
@@ -18,13 +18,15 @@
 **************************************************************************=
**/

 #include <qwsppdu.h>
-#include <qstringlist.h>
-#include <qtextcodec.h>
+
+#include <cstdlib>
+#include <netinet/in.h>
+#include <qbuffer.h>
 #include <qdatetime.h>
+#include <qlocale.h>
 #include <qiodevice.h>
-#include <qbuffer.h>
-#include <netinet/in.h>
-#include <cstdlib>
+#include <qstringlist.h>
+#include <qtextcodec.h>

 // Reference: WAP-230-WSP
 //            Wireless Application Protocol
@@ -409,9 +411,10 @@ QString QWspDateTime::dateString(QDateTime d)
 {
     QDate date =3D d.date();
     QTime time =3D d.time();
+    QLocale locale;
     QString str;
-    QByteArray dayName =3D date.shortDayName(date.dayOfWeek()).toUtf8();
-    QByteArray monthName =3D date.shortMonthName(date.month()).toUtf8();
+    QByteArray dayName =3D locale.dayName(date.dayOfWeek(), QLocale::Short=
Format).toUtf8();
+    QByteArray monthName =3D locale.monthName(date.month(), QLocale::Short=
Format).toUtf8();
     QByteArray utcOffs =3D secsToUTC(timeZoneDiff()).toUtf8();
     str.asprintf("%s, %.2d %s %d %.2d:%.2d:%.2d %s",
             dayName.constData(),
@@ -434,7 +437,7 @@ QString QWspDateTime::dateString(QDateTime d)
 QDateTime QWspDateTime::fromGmtTime_t(quint32 t)
 {
     QDateTime dt;
-    dt.setTime_t(t + timeZoneDiff());
+    dt.setSecsSinceEpoch(t + timeZoneDiff());
     return dt;
 }

--
2.24.0

--===============6242779214437559992==--


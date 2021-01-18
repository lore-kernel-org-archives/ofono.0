Content-Type: multipart/mixed; boundary="===============5877828025859244444=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 5/7] qwsppdu: Port QDateTime deprecations
Date: Mon, 18 Jan 2021 17:46:19 +0100
Message-ID: <20210118164621.52831-6-jbb.prv@gmx.de>
In-Reply-To: <20210118164621.52831-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5877828025859244444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qwsppdu.cpp | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/qwsppdu.cpp b/src/qwsppdu.cpp
index 897bac8..d636b5c 100644
--- a/src/qwsppdu.cpp
+++ b/src/qwsppdu.cpp
@@ -448,7 +448,11 @@ QDateTime QWspDateTime::fromGmtTime_t(quint32 t)
 */
 quint32 QWspDateTime::toTime_t(const QDateTime &dt)
 {
+#if QT_VERSION < QT_VERSION_CHECK(5, 14, 0)
     QDateTime st(QDate(1970, 1, 1));
+#else
+    QDateTime st =3D QDate(1970, 1, 1).startOfDay();
+#endif
     return st.secsTo(dt) - timeZoneDiff();
 }

@@ -459,7 +463,11 @@ quint32 QWspDateTime::toTime_t(const QDateTime &dt)
 */
 quint32 QWspDateTime::toGmtTime_t(const QDateTime &dt)
 {
+#if QT_VERSION < QT_VERSION_CHECK(5, 14, 0)
     QDateTime st(QDate(1970, 1, 1));
+#else
+    QDateTime st =3D QDate(1970, 1, 1).startOfDay();
+#endif
     return st.secsTo(dt) - 2*timeZoneDiff();
 }

--
2.29.2

--===============5877828025859244444==--


Content-Type: multipart/mixed; boundary="===============8144190944074952492=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/1] phonesim: add null text string case
Date: Mon, 03 Jan 2011 01:43:10 -0800
Message-ID: <1294047790-2465-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294047790-2465-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8144190944074952492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qsimcommand.cpp |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index f12b8ac..1af2b76 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -2813,12 +2813,18 @@ void _qtopiaphone_writeTextString( QByteArray& bina=
ry, const QString& str,
 void _qtopiaphone_writeTextString( QByteArray& binary, const QString& str,
                                    QSimCommand::ToPduOptions options, int =
tag )
 {
-    if ( str.isEmpty() && ( options & QSimCommand::EncodeEmptyStrings ) =
=3D=3D 0 ) {
-        // Special form for zero-length strings.
+    if ( str.isNull() ) {
         binary +=3D (char)tag;
         binary +=3D (char)0x00;
         return;
     }
+    if ( str.isEmpty() && ( options & QSimCommand::EncodeEmptyStrings ) =
=3D=3D 0 ) {
+        // Special form for empty strings.
+        binary +=3D (char)tag;
+        binary +=3D (char)0x01;
+        binary +=3D (char)options;
+        return;
+    }
     int schemeMask =3D ((tag & 0xFF00) >> 8);     // For USSD string outpu=
t.
     if ( ( options & QSimCommand::UCS2Strings ) =3D=3D 0 ) {
         QTextCodec *gsm =3D QAtUtils::codec( "gsm-noloss" );
-- =

1.7.0.4


--===============8144190944074952492==--


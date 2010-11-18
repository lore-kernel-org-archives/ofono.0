Content-Type: multipart/mixed; boundary="===============3193668844424227001=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] Add responses for TTY commands
Date: Thu, 18 Nov 2010 00:00:53 -0200
Message-ID: <1290045653-28404-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3193668844424227001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/default.xml |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/src/default.xml b/src/default.xml
index e16e18d..216b2b8 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -301,6 +301,9 @@
     <!-- CGSMS Bearer control -->
     <set name=3D"CGSMS" value=3D"3"/>
 =

+    <!-- TTY (hearing impared) state -->
+    <set name=3D"PTTY" value=3D"1" />
+
 <!-- Time -->
 <!-- Enable for testing
 <unsolicited delay=3D"3000" once=3D"true">*TTZ: 2, "11/25/2007, 12:12:12+4=
0", 0</unsolicited>
@@ -3207,6 +3210,19 @@ Z
 OK</response>
 </chat>
 =

+<chat>
+    <!-- Set TTY (hearing impaired) set -->
+    <command>AT+PTTY=3D*</command>
+    <response>OK</response>
+    <set name=3D"PTTY" value=3D"*"/>
+</chat>
+
+<chat>
+    <!-- Query TTY (hearing impaired) state -->
+    <command>AT+PTTY?</command>
+    <response>+PTTY: ${PTTY}\n\nOK</response>
+</chat>
+
 <!-- SIM filesystem definition, based on standard test strings
      presented in GSM 11.10-4.  This is primarily intended for
      testing icon definitions within SIM toolkit applications -->
-- =

1.7.3.2


--===============3193668844424227001==--


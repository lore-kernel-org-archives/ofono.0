Content-Type: multipart/mixed; boundary="===============9212549325608820013=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] Add support for TTY query
Date: Fri, 26 Nov 2010 22:06:16 -0200
Message-ID: <1290816376-16041-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9212549325608820013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/default.xml |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/default.xml b/src/default.xml
index ab1ed06..0fd0182 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -3222,6 +3222,12 @@ OK</response>
 </chat>
 =

 <chat>
+    <!-- Query supported TTY values -->
+    <command>AT+PTTY=3D?</command>
+    <response>+PTTY: (0-1)\n\nOK</response>
+</chat>
+
+<chat>
     <!-- Set TTY (hearing impaired) set -->
     <command>AT+PTTY=3D*</command>
     <response>OK</response>
-- =

1.7.3.2


--===============9212549325608820013==--


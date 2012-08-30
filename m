Content-Type: multipart/mixed; boundary="===============3167732053614059186=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] default.xml: accept SMS with SMSC num "123"
Date: Thu, 30 Aug 2012 16:18:17 +0200
Message-ID: <1346336297-13287-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3167732053614059186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reply to the SMS pdu with CMGS:0 when SMSC is set to "123".
This is used by Send SMS in Demo sim app
---
 src/default.xml |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/default.xml b/src/default.xml
index 568259b..78fc9ae 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -2757,6 +2757,13 @@
 	<response>+CMGS: 0\n\nOK</response>
 	<switch name=3D"default"/>
     </chat>
+
+    <chat>
+        <!-- Accept messages with SMSC set to 123 (STK app) -->
+        <command>038121F3*</command>
+        <response>+CMGS: 0\n\nOK</response>
+        <switch name=3D"default"/>
+    </chat>
 </state>
 =

 <chat>
-- =

1.7.9.5


--===============3167732053614059186==--


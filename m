Content-Type: multipart/mixed; boundary="===============4947044365455708199=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 6/6] phonesim: Add support for USSD session cancellation
Date: Wed, 27 Jun 2012 17:10:45 +0200
Message-ID: <1340809845-26595-7-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340809845-26595-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4947044365455708199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/default.xml |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/default.xml b/src/default.xml
index 9a6c8c6..9a1a8eb 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -2044,6 +2044,13 @@
 </chat>
 =

 <chat>
+    <!-- cancel USSD session -->
+    <command>AT+CUSD=3D2</command>
+    <response>OK</response>
+    <set name=3D"USD" value=3D"1"/>
+</chat>
+
+<chat>
     <!-- Enable unstructured supplementary service presentation mode -->
     <command>AT+CUSD=3D1</command>
     <response>OK</response>
-- =

1.7.9.5


--===============4947044365455708199==--


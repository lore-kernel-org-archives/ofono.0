Content-Type: multipart/mixed; boundary="===============7540129477977748496=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] TODO: mark CDIP task as done
Date: Tue, 18 Jan 2011 21:49:55 -0200
Message-ID: <1295394595-12483-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7540129477977748496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    7 -------
 doc/features.txt |    6 ++++++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/TODO b/TODO
index 012f73d..af22844 100644
--- a/TODO
+++ b/TODO
@@ -229,13 +229,6 @@ Supplementary Services
   Priority: Low
   Complexity: C2
 =

-- Called Line Identification.  This affects both call_settings and voiceca=
ll
-  atoms.  3GPP service is accessed by the +CDIP command.
-
-  Priority: Low
-  Complexity: C4
-  Owner: Lucas De Marchi <lucas.demarchi@profusion.mobi>
-
 - CPHS Support.  This includes ALS and CPHS specific elementary files.
 =

   Priority: Low
diff --git a/doc/features.txt b/doc/features.txt
index 0a3357f..b11d92d 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -302,3 +302,9 @@ Supplementary Services
   network by using the CallSettings property.  If the network reports the
   calling name, it is presented on the Voicecall interface using the Name
   property.  If no calling name is given, the Name is empty.
+
+- CDIP support.  The Called Line Presentation is supported by oFono. One c=
an
+  query whether the service is provisioned in the network by using the
+  CallSettings interface.  If the network supports this service, the number
+  dialed by the remote party is presented through the Voicecall interface =
using
+  the IncomingLine property.
-- =

1.7.3.5


--===============7540129477977748496==--


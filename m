Content-Type: multipart/mixed; boundary="===============7688682203998491732=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] TODO: Add task for GSMA name list support
Date: Fri, 03 Dec 2010 16:02:26 +0200
Message-ID: <1291384946-417-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7688682203998491732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 457c9a1..b63b834 100644
--- a/TODO
+++ b/TODO
@@ -507,3 +507,12 @@ Miscellaneous
   Priority: Medium
   Complexity: C1
   Owner: Aki Niemi <aki.niemi@nokia.com>
+
+- Add GSM Association (GSMA) name list support.  The GSMA publishes period=
ically
+  a spread sheet including all of the world's mobile operators and their so
+  called hard coded names.  This task adds machinery to use that list as b=
asis
+  of a database that the network registration atom uses in its display name
+  logic.
+
+  Priority: Low
+  Complexity: C2
-- =

1.7.1


--===============7688682203998491732==--


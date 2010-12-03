Content-Type: multipart/mixed; boundary="===============5263172736172381544=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] TODO: Add task for NITZ name support in netreg
Date: Fri, 03 Dec 2010 16:02:09 +0200
Message-ID: <1291384929-352-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5263172736172381544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 6cf7202..457c9a1 100644
--- a/TODO
+++ b/TODO
@@ -497,3 +497,13 @@ Miscellaneous
   Priority: Medium
   Complexity: C2
   Owner: Sjur Br=EF=BF=BD=EF=BF=BDndeland <sjur.brandeland@stericsson.co=
m>
+
+- Add NITZ name support to the network registration atom.  One of the many
+  inputs to the final display name on the UI is a name given in a NITZ
+  indication from the network.  This task adds a notify function to the ne=
twork
+  registration atom, and modifies the logic in get_operator_display_name()=
 to
+  use the NITZ name if available.
+
+  Priority: Medium
+  Complexity: C1
+  Owner: Aki Niemi <aki.niemi@nokia.com>
-- =

1.7.1


--===============5263172736172381544==--


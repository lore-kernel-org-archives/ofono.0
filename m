Content-Type: multipart/mixed; boundary="===============1870093818525579892=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] TODO: Add task for adding EFcsp support
Date: Thu, 13 Jan 2011 23:28:50 +0200
Message-ID: <1294954130-9885-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1870093818525579892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This task will add support for CPHS Customer Service Profile (CSP),
and specifically for the CSP PLMN mode bit therein.
---
 TODO |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 6ad972e..1c0392f 100644
--- a/TODO
+++ b/TODO
@@ -97,6 +97,19 @@ SIM / SIM File system
   Complexity: C1
   Owner: Marit Henriksen <marit.henriksen@stericsson.com>
 =

+- Add support for CPHS Customer Service Profile (CSP).  This task adds sup=
port
+  for reading the EFcsp file and in particular, interpreting the PLMN mode=
 bit
+  within the 'Value Added Services' service group.
+
+  Based on the PLMN mode value, manual network selection needs to either be
+  enabled or disabled in the netreg atom.  Also to accommodate this, there
+  probably needs to be a new 'forced' mode to indicate that manual network
+  selection is disabled.
+
+  Priority: Medium
+  Complexity: C1
+  Owner: Aki Niemi <aki.niemi@nokia.com>
+
 Modem Emulator
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.1


--===============1870093818525579892==--


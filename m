Content-Type: multipart/mixed; boundary="===============1516756810908977450=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] TODO: Mark Lockdown task as done
Date: Wed, 22 Dec 2010 18:18:19 -0200
Message-ID: <1293049099-25619-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1516756810908977450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |   12 ------------
 doc/features.txt |    4 ++++
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/TODO b/TODO
index 3c2ff15..a772e24 100644
--- a/TODO
+++ b/TODO
@@ -408,18 +408,6 @@ Miscellaneous
   Complexity: C8
   Owner: Jukka Saunam=C3=A4ki <jukka.saunamaki@nokia.com>
 =

-- Add support for Modem 'power down & lock' and 'unlock & power up'.  When=
 the
-  'power down & lock' is given, the calling application is noted and all
-  other applications are blocked from powering up the modem.  Only the cal=
ling
-  application can lift the lock.  Alternatively, if the calling application
-  exits prematurely the lock is lifted as well.
-
-  The proposed property name is "Lockdown" as part of the Modem interface.
-
-  Priority: Medium
-  Complexity: C2
-  Owner: Gustavo F Padovan <padovan@profusion.mobi>
-
 - Add support for GPS power control atom.  Many modem manufacturers provide
   a GPS unit with their modem hardware.  This unit can be turned on or off
   and frequently takes over one of the tty ports that the modem provides.
diff --git a/doc/features.txt b/doc/features.txt
index 5c7d6c1..3f741b7 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -165,6 +165,10 @@ Modem
   itself. Now oFono can be notified when a reset happens and do proper wor=
k to
   put the modem back to work restoring the state before the reset.
 =

+- Lockdown support. Through the Lockdown property on the Modem D-Bus API, =
one
+  can power down the modem and lock it disallowing any other application to
+  use that modem. Useful for firmware update and similar stuff.
+
 Short Messaging Service
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.3.4


--===============1516756810908977450==--


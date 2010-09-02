Content-Type: multipart/mixed; boundary="===============4251620985092374398=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [emergency RFC 1/2] TODO: added emergency mode proposal
Date: Thu, 02 Sep 2010 18:14:23 +0300
Message-ID: <1283440464-15409-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4251620985092374398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Collected emergency-related features into one section.
---
 TODO |   51 ++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/TODO b/TODO
index 97f43e1..5e97eec 100644
--- a/TODO
+++ b/TODO
@@ -510,8 +510,31 @@ Sim Toolkit
   Owner: Kristen Carlson Accardi <kristen@linux.intel.com>
 =

 =

-Miscellaneous
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Emergency Calls
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Modem Emergency mode.  Figure out how to support network registration and
+  online/offline mode during the emergency calls and related network
+  activity (e.g., network-initiated location request via supplementary
+  service channel).
+
+  The proposal is to introduce a new Emergency boolean property to the
+  Modem D-Bus interface and new functions to modem interface:
+
+  - ofono_modem_emergency_mode_inc()
+  - ofono_modem_emergency_mode_dec()
+  - ofono_modem_emergency_mode_get()
+  - ofono_modem_add_emergency_mode_watch()
+  - ofono_modem_remove_emergency_mode_watch()
+
+  When emergency mode is requested, modem is set to online (if needed) and
+  the watchers are notified. There can be multiple parties requesting
+  emergency mode.  When all of them have completed the emergency-related
+  operation and called ofono_modem_emergency_mode_dec(), modem is set to
+  offline (if needed) and the watchers are again notified.
+
+  Priority: High
+  Complexity: C2
 =

 - Country / Operator specific emergency numbers.  Figure out how to support
   countries / operators with specific mandated emergency numbers which are
@@ -520,8 +543,25 @@ Miscellaneous
   assumed to be managed by the modem.  If no such functionality is availab=
le,
   then the 3GPP mandated behavior is used.
 =

+  Priority: High
   Complexity: C2
+
+- Network updating the emergency number list. Figure out how to support
+  the list of emergency numbers dynamically updated by the network.
+
   Priority: High
+  Complexity: C2
+
+- Extend the voicecall interface with a property indicating whether this c=
all
+  is an emergency call (essentially the CLI matches one of the numbers on =
the
+  emergency calling codes list.)
+
+  Priority: High
+  Complexity: C1
+
+
+Miscellaneous
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

 - Bluetooth SAP Client support.  The Telit UC864-G devices support Bluetoo=
th
   SAP client mode.  This requires the use of a modem side-channel to read =
the
@@ -586,13 +626,6 @@ Miscellaneous
   Priority: High
   Complexity: C1
 =

-- Extend the voicecall interface with a property indicating whether this c=
all
-  is an emergency call (essentially the CLI matches one of the numbers on =
the
-  emergency calling codes list.)
-
-  Priority: High
-  Complexity: C1
-
 - TTY (hearing impaired) support.  Add a new oFono atom type that will ena=
ble
   the user to enable or disable the TTY support on the modem.  Support for
   automatic detection of TTY (signaled by the driver) is also desired.
-- =

1.7.0.4


--===============4251620985092374398==--


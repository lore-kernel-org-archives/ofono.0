Content-Type: multipart/mixed; boundary="===============5877848904468864336=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] doc: Mark SIM Refresh support as present.
Date: Thu, 31 Mar 2011 15:40:57 +0200
Message-ID: <1301578857-3790-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1301578857-3790-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5877848904468864336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |   35 -----------------------------------
 doc/features.txt |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/TODO b/TODO
index e18c5e6..207adf7 100644
--- a/TODO
+++ b/TODO
@@ -261,41 +261,6 @@ Voicecall
 Sim Toolkit
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- Support Refresh proactive command.  The specification defines 7 types
-  of Refresh types:
-	- NAA Initialization
-	- NAA File Change Notification
-	- NAA Initialization and File Change Notification
-	- NAA Initialization and Full File Change Notification
-	- UICC Reset
-	- NAA Application Reset (2G only)
-	- NAA Session Reset (3G only)
-
-  The 'NAA Initialization' type will be ignored by oFono, it is assumed
-  this is handled by the modem.
-
-  For 'UICC Reset', 'NAA Application Reset' and 'NAA Session Reset' oFono
-  will first check whether there are any calls or ussd operations active.
-  If there are, the appropriate response will be sent (e.g. busy on call
-  or screen busy terminal response.)  Otherwise a positive response will be
-  sent to the driver.  In the case of a 'UICC Reset' the driver / modem
-  can interpret this that it is safe to reset the UICC.
-
-  Alternatively, the driver / modem can notify the core of the SIM removal
-  / SIM insertion events without using the Refresh proactive command.  It
-  is up to the driver / modem to perform a warm reset.  In particular, 3GPP
-  31.111 mandates that any change to EFimsi is done by using 'UICC Reset',
-  'NAA Application Reset' or 'NAA Session Reset'.  Please see 3GPP 31.111
-  Section 6.4.7.1.
-
-  Other types will be handled by oFono flushing the EF cache of the files
-  affected (or the entire SIM cache in case of Full File Change Notificati=
ons)
-  and re-reading the affected files.  Any properties derived from these
-  Elementary Files will be updated and signaled using PropertyChanged.
-
-  Priority: High
-  Complexity: C8
-
 - Support of the BIP (Bearer Independent Protocol) proactive commands.
   The specification defines several bearer types. For now, only the packet=
 data
   service bearer is considered.
diff --git a/doc/features.txt b/doc/features.txt
index b905ae7..98a9fed 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -126,6 +126,40 @@ Supported Proactive Commands:
 =

   NOTE: This command can also be handled by the modem.
 =

+- Refresh proactive command.  The specification defines 7 types
+  of Refresh requests:
+	- NAA Initialization
+	- NAA File Change Notification
+	- NAA Initialization and File Change Notification
+	- NAA Initialization and Full File Change Notification
+	- UICC Reset
+	- NAA Application Reset (2G only)
+	- NAA Session Reset (3G only)
+
+  oFono can fully perform the the first four types of Refresh.  The
+  remaining three must be handled by the modem or its driver with a
+  notification sent to ofono.  Regardless of whether the command is
+  handled by the modem or not, oFono will check whether there are any
+  calls or ussd operations active.  If there are, the appropriate
+  response will be sent (e.g. busy on call or screen busy terminal
+  response.)  Otherwise a positive response will be sent to the driver.
+  In the case of a 'UICC Reset' the driver / modem can interpret this
+  that it is safe to reset the UICC.
+
+  Alternatively, the driver / modem can notify the core of the SIM removal
+  / SIM insertion events without using the Refresh proactive command.  It
+  is up to the driver / modem to perform a warm reset.  In particular, 3GPP
+  31.111 mandates that any change to EFimsi is done by using 'UICC Reset',
+  'NAA Application Reset' or 'NAA Session Reset'.  Please see 3GPP 31.111
+  Section 6.4.7.1.
+
+  Other types are handled by oFono flushing the EF cache of the files
+  affected (or the entire SIM cache in case of Full File Change Notificati=
ons)
+  and re-reading the affected files.  Any properties derived from these
+  Elementary Files will be updated and signaled using PropertyChanged.
+
+  NOTE: This command can also be handled by the modem.
+
 - Sim icon support.  oFono supports icons that are stored on the SIM.  If =
the
   SIM notifies oFono that an icon is available for a particular proactive
   command, oFono passes this information to the UI.  The UI is able to obt=
ain
-- =

1.7.1.86.g0e460.dirty


--===============5877848904468864336==--


Content-Type: multipart/mixed; boundary="===============4305517645529420797=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] TODO: Add STK class 'e' tasks
Date: Wed, 16 Feb 2011 18:24:29 +0100
Message-ID: <1297877069-9085-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4305517645529420797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 9bd21d6..80b68fb 100644
--- a/TODO
+++ b/TODO
@@ -337,6 +337,36 @@ Sim Toolkit
   Priority: High
   Complexity: C8
 =

+- Support of the BIP (Bearer Independent Protocol) proactive commands.
+  The specification defines several bearer types. For now, only the packet=
 data
+  service bearer is considered.
+
+	- OPEN CHANNEL: requests the terminal to open a data channel with
+	parameters indicated in the command. A user confirmation may be
+	requested by the SimToolkitAgent.
+	- CLOSE CHANNEL:requests the terminal to close the specified data
+	channel.
+	- RECEIVE DATA:requests the terminal to return to the UICC data
+	received on the specified channel.
+	- SEND DATA:requests the terminal to send on the specified channel data
+	provided by the UICC.
+	- GET CHANNEL STATUS: requests the terminal to return the current
+	status of all available data channels.
+
+  Priority: Medium
+  Complexity: C4
+  Owner: Philippe Nunes <philippe.nunes@linux.intel.com>
+
+- Support Setup Event List proactive command.
+  To fully support the class 'e', the following events
+    	-Data Available event
+  	-Channel status event
+  shall be monitored by oFono if part of the current event list.
+  This list is supplied by the last SETUP EVENT LIST command.
+
+  Priority: Medium
+  Complexity: C2
+  Owner: Philippe Nunes <philippe.nunes@linux.intel.com>
 =

 Emergency Calls
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-- =

1.7.1


--===============4305517645529420797==--


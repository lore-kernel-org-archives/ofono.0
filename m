Content-Type: multipart/mixed; boundary="===============8507671800628332155=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] doc: add emergency-call-handling.txt
Date: Wed, 13 Apr 2011 10:05:16 -0700
Message-ID: <1302714316-6801-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8507671800628332155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/emergency-call-handling.txt |  113 +++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 113 insertions(+), 0 deletions(-)
 create mode 100644 doc/emergency-call-handling.txt

diff --git a/doc/emergency-call-handling.txt b/doc/emergency-call-handling.=
txt
new file mode 100644
index 0000000..69b217d
--- /dev/null
+++ b/doc/emergency-call-handling.txt
@@ -0,0 +1,113 @@
+This document explains what is expected from applications and what oFono
+will do for an emergency call request in different states.
+
+Case 1: Call in offline and SIM present state
+
+Expected from UI/applications:
+
+	- Online property of org.ofono.Modem interface should be set to TRUE.
+	- Dial method should be called with the dialled number.
+
+What oFono will do:
+
+	- Modem will be set to online.
+	- Post online atoms will be created.
+	- Upon reception of Dial request, Emergency mode is activated.
+	- Once the call is ended, Emergency mode is deactivated.
+	- Modem remains in online mode with full funcationality.
+
+Case 2: Call in SIM Present and PIN required state
+
+Expected from UI/applications:
+
+	- If the user enters emergency number in the PIN entry dialog, then
+	  Online property on org.ofono.Modem interface should be set to TRUE.
+		- List of Emergency numbers can be known from the
+		  EmergencyNumbers property on the org.ofono.VoiceCallManager
+		  interface.
+	- Dial method should be called with the dialled number
+
+What oFono will do:
+
+	- Modem will be set to online.
+	- Upon reception of Dial request, Emergency mode is activated.
+	- Once the call is ended, Emergency mode is deactivated.
+	- Modem remains in online mode but the functionalities will be
+	  limited.
+
+Case 3: Call in SIM Present and PIN required state - Dial cancelled by user
+
+Expected from UI/applications:
+
+	- If the user enters emergency number in the PIN entry dialog, then
+	  Online property on org.ofono.Modem interface should be set to TRUE.
+		- List of Emergency numbers can be known from the
+		  EmergencyNumbers property on the org.ofono.VoiceCallManager
+		  interface.
+	- Dial method should be called with the dialled number
+	- Upon dial cancellation by user, HangupAll should be called.
+
+What oFono will do:
+
+	- Modem will be set to online.
+	- Post SIM and Post online atoms are not created.
+	- Upon reception of Dial request, Emergency mode is activated.
+	- Upon dial cancellation(HangupAll request), Emergency mode is
+	  deactivated.
+	- Modem remains in online mode but the functionalities will be
+	  limited.
+
+Case 4: Call in No SIM state
+
+Expected from UI/applications:
+
+	- Online property on org.ofono.Modem interface should be set to TRUE.
+	- Dial method should be called with the dialled number
+
+What oFono will do:
+
+	- Modem will be set to online.
+	- Post SIM and Post online atoms not created.
+	- If the dialed number is an Emergeny number, Emergency mode is
+	  activated.
+	- Once the call is ended, Emergency mode is deactivated.
+	- Modem remains in online mode but the functionalities will be
+	  limited.
+
+Case 5: Call in No SIM state - PIN disabled SIM inserted during emergency =
call
+
+Expected from UI/applications:
+
+	- Online property on org.ofono.Modem interface should be set to TRUE.
+	- Dial method should be called with the dialled number
+
+What oFono will do:
+
+	- Modem will be set to online.
+	- Post SIM and Post online atoms are not created.
+	- If the dialed number is an Emergeny number, Emergency mode is
+	  activated.
+	- Upon PIN disabled SIM detection, Post SIM and Post online
+	  atoms are created.
+	- Once the call is ended, Emergency mode is deactivated.
+	- Modem remains in online mode with full functionality.
+
+Case 6: Call in No SIM state - PIN enabled SIM inserted during emergency c=
all
+
+Expected from UI/applications:
+
+	- Online property on org.ofono.Modem interface should be set to TRUE.
+	- Dial method should be called with the dialled number
+
+What oFono will do:
+
+	- Modem will be set to online.
+	- Post SIM and Post online atoms are not created.
+	- If the dialed number is an Emergeny number, Emergency mode is
+	  activated.
+	- Upon PIN enabled SIM detection, applications will be informed
+	  of the pin status via PinRequired property on the
+	  org.ofono.SimManager interface.
+	- Once the call is ended, Emergency mode is deactivated.
+	- Modem remains in online mode but the functionalities will be
+	  limited.
-- =

1.7.0.4


--===============8507671800628332155==--


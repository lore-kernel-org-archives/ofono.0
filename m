Content-Type: multipart/mixed; boundary="===============8919921908912715264=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] doc: add emergency-call-handling.txt
Date: Tue, 19 Apr 2011 11:05:44 +0100
Message-ID: <A782C372B9527D44AB20BF45FEEBB14F75BFF7A97C@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1302714316-6801-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8919921908912715264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

One 'minor bug', I guess that there is a missing 'Post SIM and Post online =
atoms are not created.' For case 2.

And one question. For case 2 and 3, the 'Modem remains in online mode but t=
he functionalities will be limited.'. What is the procedure to activate all=
 functionalities? Do we just have to enter the PIN, to create post SIM and =
post online atoms?

Thanks for the information,

Bertrand.

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Jeevaka Badrappan
Sent: Wednesday, April 13, 2011 7:05 PM
To: ofono(a)ofono.org
Subject: [PATCH] doc: add emergency-call-handling.txt

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

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============8919921908912715264==--


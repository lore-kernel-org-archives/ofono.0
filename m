Content-Type: multipart/mixed; boundary="===============2453736380528551946=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Voicecall gaps.
Date: Mon, 05 Jul 2010 16:40:47 +0300
Message-ID: <1278337247-4391-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2453736380528551946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Missing voicecall functionality pieces from tp-ring point-of-view.
---
 TODO                         |   27 +++++++++++++++++++++++++++
 doc/voicecallmanager-api.txt |    8 ++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/TODO b/TODO
index 470d4a6..fc539a7 100644
--- a/TODO
+++ b/TODO
@@ -265,6 +265,33 @@ Supplementary Services
   Complexity: C8
 =

 =

+Voicecall
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Supplementary service notifications on remote party actions:
+  - call has been put on hold (+CSSU: 2)
+  - call has been retrieved (+CSSU: 3), and
+  - joining call to a multiparty conference (+CSSU: 4)
+
+  Priority: Medium
+  Complexity: C1
+  Owner: Pekka Pessi <pekka.pessi@nokia.com>
+
+- Dial strings. Include CLIR prefixes and 2nd stage dial strings in the
+  DialString call property. Add dialstring accessor method to C API.
+
+  Priority: Medium
+
+- Provide feedback of sent DTMF tones. Emit SendingTones signal if modem c=
an
+  provide approximate starting and stopping times for DTMF tones. Signal
+  argument contains a string of DTMF tones to be sent, or empty string when
+  all tones has been sent.
+
+  Priority: Medium
+  Complexity: C2
+  Owner: Pekka Pessi <pekka.pessi@nokia.com>
+
+
 Miscellaneous
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 7877ac5..bc79fc3 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -108,10 +108,10 @@ Methods		dict GetProperties()
 =

 		void SendTones(string tones)
 =

-			Sends the DTMF tones to the network.  Under GSM the
-			tones have a fixed duration.  Tones can be one of:
-			'0' - '9', '*', '#', 'A', 'B', 'C', 'D'. The last four
-			are typically not used in normal circumstances.
+			Sends the DTMF tones to the network.  The tones have
+			a fixed duration.  Tones can be one of: '0' - '9',
+			'*', '#', 'A', 'B', 'C', 'D'.  The last four are
+			typically not used in normal circumstances.
 =

 Signals		PropertyChanged(string property, variant value)
 =

-- =

1.7.0.4


--===============2453736380528551946==--


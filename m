Content-Type: multipart/mixed; boundary="===============2448990946906641533=="
MIME-Version: 1.0
From: ppessi@gmail.com
Subject: [PATCH 6/7] Added call-barring-api.txt.
Date: Thu, 18 Mar 2010 16:44:30 +0200
Message-ID: <1268923471-29059-6-git-send-email-ppessi@gmail.com>
In-Reply-To: <1268923471-29059-5-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2448990946906641533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>


Signed-off-by: Pekka Pessi <Pekka.Pessi@nokia.com>
---
 doc/call-barring-api.txt |   65 ++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 doc/call-barring-api.txt

diff --git a/doc/call-barring-api.txt b/doc/call-barring-api.txt
new file mode 100644
index 0000000..644415b
--- /dev/null
+++ b/doc/call-barring-api.txt
@@ -0,0 +1,65 @@
+Call Barring hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.CallBarring
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Contains the properties for this object.
+
+		void ChangePassword(string old_password, string new_password)
+
+			Register new network password for the barring
+			services.
+
+		void DisableAll(string password)
+
+			Disables all call barrings.
+
+		void DisableAllIncoming(string password)
+
+			Disables barrings for incoming calls.
+
+		void DisableAllOutgoing(string password)
+
+			Disables barrings for outgoing calls.
+
+		void SetProperty(string property, variant value)
+
+			Sets the given property value to that specified in
+			call parameter.
+
+Signals		PropertyChanged(string property, variant value)
+
+			Signal is emitted whenever a property has changed.  The new
+			value is passed as the signal argument.
+
+		IncomingBarringInEffect()
+		=

+			Signal is emitted when a call is made and an
+			incoming call barring supplementary service is in use.
+
+		OutgoingBarringInEffect()
+		=

+			Signal is emitted when a call is made and an
+			outgoing call barring supplementary service is in use.
+
+Properties	string VoiceIncoming [readwrite]
+
+			Contains the value of the barrings for the incoming
+			voice calls. The possible values are:
+			- "always" bar all incoming voice calls
+			- "whenroaming" bar incoming voice calls when roaming,
+			- "disabled" if no barring is active
+
+		string VoiceOutgoing [readwrite]
+
+			Contains the value of the barrings for the outgoing
+			voice calls. The possible values are:
+			- "all" bar all outgoing calls
+			- "international" bar all outgoing international calls
+			- "internationalnothome" bar all outgoing
+			  international calls except to home country
+			- "disabled" if no barring is active
-- =

1.6.3.3


--===============2448990946906641533==--


Content-Type: multipart/mixed; boundary="===============8233361734431910267=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC] voice call API changes (proposal)
Date: Mon, 31 Jan 2011 13:56:17 +0200
Message-ID: <f05c513a9ca1d1a296a8e1dfc6af633e2fb058a1.1296474033.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1296474033.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8233361734431910267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is a proposal for expanding the VoiceCallManager interface with =

call related Supplementary Services signals, and the VoiceCall
interface with new properties.

---
 doc/call-barring-api.txt     |   10 ----------
 doc/voicecall-api.txt        |   15 +++++++++++++++
 doc/voicecallmanager-api.txt |   21 +++++++++++++++++++++
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/doc/call-barring-api.txt b/doc/call-barring-api.txt
index 41ae4b1..1534494 100644
--- a/doc/call-barring-api.txt
+++ b/doc/call-barring-api.txt
@@ -37,16 +37,6 @@ Signals		PropertyChanged(string property, variant value)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

-		IncomingBarringInEffect()
-
-			Signal is emitted when a call is made and an
-			incoming call barring supplementary service is in use.
-
-		OutgoingBarringInEffect()
-
-			Signal is emitted when a call is made and an
-			outgoing call barring supplementary service is in use.
-
 Properties	string VoiceIncoming [readwrite]
 =

 			Contains the value of the barrings for the incoming
diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 047b8cb..e7276a3 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -145,3 +145,18 @@ Properties	string LineIdentification [readonly]
 =

 			Contains the indication if the voice call is an
 			emergency call or not.
+
+		boolean Forwarded
+
+			Contains the indication whether the voice call is a
+			forwarded call or not.
+
+		boolean RemoteHold
+
+			Contains the indication whether the voice call has been
+			put on hold by the remote party or not.
+
+		boolean Waiting
+
+			Contains the indication whether the outgoing voice call
+			is waiting or not.
diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 2bf9ded..bbd80db 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -144,6 +144,27 @@ Signals		CallAdded(object path, dict properties)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

+		UnconditionalForwardingInEffect
+
+			Signal is emitted when a call is made and unconditional
+			call forwarding supplementary service is active.
+
+		ConditionalForwardingInEffect
+
+			Signal is emitted when a call is made and some of the
+			conditional call forwarding supplementary services are
+			active.
+
+		IncomingBarringInEffect()
+
+			Signal is emitted when a call is made and an
+			incoming call barring supplementary service is in use.
+
+		OutgoingBarringInEffect()
+
+			Signal is emitted when a call is made and an
+			outgoing call barring supplementary service is in use.
+
 Properties	array{string} EmergencyNumbers [readonly]
 =

 			Contains the list of emergency numbers recognized
-- =

1.7.0.4


--===============8233361734431910267==--


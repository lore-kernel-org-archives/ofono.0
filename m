Content-Type: multipart/mixed; boundary="===============0553792354594803977=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC] voicecall API changes (proposal 2)
Date: Wed, 02 Feb 2011 20:16:08 +0200
Message-ID: <33f41837f16b650f6595e1004b82a7ea6ba2ed54.1296668679.git.Andras.Domokos@nokia.com>
In-Reply-To: <4D49790C.4010807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0553792354594803977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/call-barring-api.txt     |   10 ----------
 doc/voicecall-api.txt        |   17 +++++++++++++++++
 doc/voicecallmanager-api.txt |   28 ++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 10 deletions(-)

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
index 047b8cb..9e1d90f 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -145,3 +145,20 @@ Properties	string LineIdentification [readonly]
 =

 			Contains the indication if the voice call is an
 			emergency call or not.
+
+		boolean ForwardedCall
+
+			Contains the indication whether the incoming voice call
+			is a redirected call due to a call forwarding operation
+			or not.
+
+		boolean RemoteHoldActive
+
+			Contains the indication whether the voice call is put on
+			hold by the remote party or not.
+
+		boolean RemoteMultiparty
+
+			Contains the indication whether the voice call is joined
+			in a multiparty call by the remote party or not.
+
diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 5415345..7517a7c 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -144,6 +144,34 @@ Signals		CallAdded(object path, dict properties)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

+		RemoteCallBarringActive()
+
+			Signal is emitted when an outgoing voice call is made
+			and the call has been barred by the network due to the
+			remote party's "Call Barring" Supplementary Services
+			settings for incoming calls.
+
+		LocalCallBarringActive()
+
+			Signal is emitted when an outgoing voice call is made
+			and the call has been barred by the network due to the
+			local party's "Call Barring" Supplementary Services
+			settings for outgoing calls.
+
+		OutgoingCallCondForwarded()
+
+			Signal is emitted when an outgoing voice call is made
+			and the call has been redirected to another number due
+			to the remote party's conditional "Call Forwarding"
+			Supplementary Service settings.
+
+		OutgoingCallUncondForwarded()
+
+			Signal is emitted when an outgoing voice call is made
+			and the call has been redirected to another number due
+			to the remote party's unconditional "Call Forwarding"
+			Supplementary Service settings.
+
 Properties	array{string} EmergencyNumbers [readonly]
 =

 			Contains the list of emergency numbers recognized
-- =

1.7.0.4


--===============0553792354594803977==--


Content-Type: multipart/mixed; boundary="===============0331481458172252168=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC ssn PATCH 4/4] D-Bus API for Supplementary Service Notifications
Date: Fri, 08 Oct 2010 18:36:40 +0300
Message-ID: <1286552200-18282-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286552200-18282-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0331481458172252168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/call-barring-api.txt     |   10 -------
 doc/call-forwarding-api.txt  |    9 +++++++
 doc/voicecall-api.txt        |   55 ++++++++++++++++++++++++++++++++++++++=
+++-
 doc/voicecallmanager-api.txt |    5 ++++
 4 files changed, 68 insertions(+), 11 deletions(-)

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
diff --git a/doc/call-forwarding-api.txt b/doc/call-forwarding-api.txt
index 067531a..a97165b 100644
--- a/doc/call-forwarding-api.txt
+++ b/doc/call-forwarding-api.txt
@@ -26,6 +26,15 @@ Signals		PropertyChanged(string property, variant value)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

+		ForwardingInEffect(string condition)
+
+			This informational signal is emitted when an outgoing
+			call is made. It indicates that a voice call
+			forwarding for incoming calls is in use. Condition can
+			be either of:
+				"unconditional" - VoiceUnconditional is active
+				"conditional" - A conditional rule is active
+
 Properties	string VoiceUnconditional [readwrite]
 =

 			Contains the value of the voice unconditional call
diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index f0ba316..a6c0b42 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -73,6 +73,54 @@ Signals		PropertyChanged(string property, variant value)
 			of this signal as optional. This signal will be
 			emitted before the PropertyChanged signal.
 =

+		JoinedMultiparty()
+
+			Signal is emitted when remote party joins the
+			call into a multiparty conference.
+
+			Note that there is no corresponding event when
+			remote party splits call from the multiparty
+			conference.
+
+		Waiting()
+
+			Signal is emitted when an outgoing call is waiting.
+
+		OutgoingBarred()
+
+			Signal is emitted when caller's outgoing barring
+			services prevent call from being connected.
+
+			This signal can be emitted while call is being
+			disconnected or while a recorded announcement is
+			played.
+
+		IngomingBarred()
+
+			Signal is emitted when callee's incoming barring
+			services prevent call from being connected.
+
+			This signal can be emitted while call is being
+			disconnected or while a recorded announcement is
+			played.
+
+		IncomingRedirected(string)
+
+			Signal is emitted when network indicates that an
+			incoming call has been redirected.  The value
+			contains the phone number of the party that
+			redirected the call if available.
+
+		OutgoingRedirected()
+
+			Signal is emitted when an outgoing call has been
+			redirected.
+
+		CallerIDRestrictionRejected()
+
+			Signal is emitted when caller requested Caller
+			ID Restriction but network rejects it.
+
 Properties	string LineIdentification [readonly]
 =

 			Contains the Line Identification information returned
@@ -90,7 +138,7 @@ Properties	string LineIdentification [readonly]
 		boolean Multiparty [readonly]
 =

 			Contains the indication if the voice call is part
-			of a multiparty call or not.
+			of a multiparty call set up by user or not.
 =

 			Notifications if a call becomes part or leaves a
 			multipart call are sent.
@@ -115,6 +163,11 @@ Properties	string LineIdentification [readonly]
 			Client applications can use this to infer somewhat
 			reliable call duration information.
 =

+		boolean OnHold [readonly]
+
+			Contains the indication if the remote party has
+			put call on hold.
+
 		string Information [readonly, optional]
 =

 			Contains information related to the call for the
diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 11af23a..34ed9de 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -132,6 +132,11 @@ Signals		CallAdded(object path, dict properties)
 			released.  The object path is no longer accessible
 			after this signal and only emitted for reference.
 =

+		IncomingCallForwarded
+
+			This signal is sent when an incoming voice call
+			has been forwarded by the network.
+
 Properties	array{string} EmergencyNumbers
 =

 			Contains the list of emergency numbers recognized
-- =

1.7.0.4


--===============0331481458172252168==--


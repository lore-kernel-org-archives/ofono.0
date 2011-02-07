Content-Type: multipart/mixed; boundary="===============5489554077888292358=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC] voicecall API changes (proposal v3)
Date: Mon, 07 Feb 2011 19:09:32 +0200
Message-ID: <81add181a302fa6af74f4bc4e25a4db5f72085b0.1297098487.git.Andras.Domokos@nokia.com>
In-Reply-To: <4D502012.4050704@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5489554077888292358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/call-barring-api.txt     |   10 ----------
 doc/voicecall-api.txt        |   11 +++++++++++
 doc/voicecallmanager-api.txt |   25 +++++++++++++++++++++++++
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
index 047b8cb..6a72386 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -145,3 +145,14 @@ Properties	string LineIdentification [readonly]
 =

 			Contains the indication if the voice call is an
 			emergency call or not.
+
+		boolean RemoteHeld
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
index 5415345..06e7b4e 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -144,6 +144,31 @@ Signals		CallAdded(object path, dict properties)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

+		BarringActive(string type)
+
+			Signal emitted when an outgoing voice call is made and
+			the call has been barred by the network due to the
+			remote party's "Call Barring" Supplementary Services
+			settings for incoming calls. In this case the type
+			parameter in the signal set to "remote".
+			The signal is also emitted when an outgoing voice call
+			is made and the call has been barred by the network due
+			to the local "Call Barring" Supplementary Services
+			settings for outgoing calls. In this case the type
+			parameter in the signal is set to "local".
+
+		CallForwarded(string type)
+
+			Signal emitted when an outgoing voice call is made and
+			the call has been redirected to another number due to
+			the remote party's "Call Forwarding" Supplementary
+			Services settings. In this case the type parameter in
+			the signal is set to "outgoing".
+			The signal is also emitted when the incoming voice call
+			is a redirected call due to a call forwarding operation.
+			In this case the type parameter in the signal is set to
+			"incoming".
+
 Properties	array{string} EmergencyNumbers [readonly]
 =

 			Contains the list of emergency numbers recognized
-- =

1.7.0.4


--===============5489554077888292358==--


Content-Type: multipart/mixed; boundary="===============5922742866232236951=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH]doc: update cdma voice call manager api
Date: Tue, 28 Jun 2011 11:12:40 +0800
Message-ID: <1309230760-4139-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5922742866232236951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

(1) Add "Calls" property to monitor the current present calls.
(2) Remove original "State" property, add it as a parameter of "Calls" prop=
erty.
    and add possible value: "held" and "waiting"
(3) Remove original "CallWaiting" and "CallWaitingNumber" property(Can get =
these
    information from "Calls" property).
(4) Remove "ToneDuration" property as it is transparent to user, user don't=
 need
    change it.

---
 doc/cdma-voicecall-manager-api.txt |   80 ++++++++++++++++++++------------=
---
 1 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/doc/cdma-voicecall-manager-api.txt b/doc/cdma-voicecall-manage=
r-api.txt
index 535909a..d7d2409 100644
--- a/doc/cdma-voicecall-manager-api.txt
+++ b/doc/cdma-voicecall-manager-api.txt
@@ -13,7 +13,7 @@ Methods		dict GetProperties()
 		void Dial(string number)
 =

 			Initiates a new outgoing call.  This is usually
-			implemented using the ATD AT command.
+			implemented using the AT+CDV AT command.
 =

 			Possible Errors: [service].Error.InProgress
 					 [service].Error.InvalidArguments
@@ -60,7 +60,7 @@ Signals		PropertyChanged(string property, variant value)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

-		DisconnectReason(string reason)
+		DisconnectReason(string reason) [optional]
 =

 			This signal is emitted when the modem manager can
 			provide extra information about why the call was
@@ -77,48 +77,60 @@ Signals		PropertyChanged(string property, variant value)
 			of this signal as optional. This signal will be
 			emitted before the PropertyChanged signal.
 =

-Properties	string State [readonly]
+Properties	dict Calls [readonly]
 =

-			Contains the state of the current call.  The state
-			can be one of:
-				- "active" - The call is active
-				- "dialing" - The call is being dialed
-				- "alerting" - The remote party is being alerted
-				- "incoming" - Incoming call in progress
-				- "disconnected" - No call is connected
+			The currently present calls.
 =

-		boolean CallWaiting [readonly]
+			String Direction [readonly]
 =

-			Contains whether a call is waiting.
+				Contains the direction if the voice call. The
+				direction can be one of:
+				- "outgoing" - Mobile originated (MO) call
+				- "incoming" - Mobile terminated (MT) call
 =

-		string CallWaitingNumber [readonly, optional]
+			string State [readonly]
 =

-			Contains the call waiting number.
+				Contains the state of the call.  The state can
+				be one of:
+					- "active" - The call is active
+					- "held" - The call is held
+					- "dialing" - The call is being dialed
+					- "alerting" - The remote party is
+							being alerted
+					- "incoming" - Incoming call in
+							progress
+					- "disconnected" - No call is connected
+					- "waiting" - The call is waiting for
+							being accepted
 =

-		string ToneDuration [readwrite]
+			string LineIdentification [readonly]
 =

-			Contains the length of the DTMF tone duration.  The
-			currently supported values are:
-				"short",
-				"long"
+				Contains the Line Identification information
+				returned by the network, if present. For incoming
+				calls this is effectively the CLIP. For outgoing
+				calls this attribute will hold the dialed
+				number.
 =

-		string LineIdentification [readonly]
+				Please note that after sending flash this
+				property will be empty.
 =

-			Contains the Line Identification information returned
-			by the network, if present. For incoming calls this is
-			effectively the CLIP. For outgoing calls this attribute
-			will hold the dialed number.
+			string Name [readonly, optional]
 =

-			Please note that after sending flash this property
-			will be empty.
+				Contains the remote party name.
 =

-		string StartTime [readonly, optional]
+			string StartTime [readonly, optional]
 =

-			Contains the starting time of the call.  The time is
-			stamped when the call enters the "active" state.
-			Client applications can use this to infer somewhat
-			reliable call duration information.
+				Contains the starting time of the call.  The
+				time is stamped when the call enters the
+				"active" state. Client applications can use
+				this to infer somewhat reliable call duration
+				information.
 =

-			Please note that after sending Flash, there will not be
-			any StartTime property change for the Flash
-			string/number.
+				Please note that after sending Flash, there
+				will not be any StartTime property change for
+				the Flash string/number.
+
+			boolean Multiparty [readonly]
+
+				Contains the indication if the voice call is
+				part of a multiparty call or not.
-- =

1.7.5


--===============5922742866232236951==--


Content-Type: multipart/mixed; boundary="===============6888830592012878413=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/1] doc: Update possible errors
Date: Fri, 11 Feb 2011 03:34:31 -0800
Message-ID: <1297424071-5464-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1297424071-5464-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6888830592012878413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/audio-settings-api.txt         |    2 -
 doc/call-barring-api.txt           |   31 ++++++++++++++++++++++
 doc/call-forwarding-api.txt        |   16 +++++++++++
 doc/call-meter-api.txt             |   14 ++++++++++
 doc/call-settings-api.txt          |    8 ++++++
 doc/call-volume-api.txt            |    9 +++---
 doc/cdma-voicecall-manager-api.txt |   10 +++++++
 doc/cell-broadcast-api.txt         |    7 ++---
 doc/connman-api.txt                |   25 ++++++++++++++----
 doc/manager-api.txt                |    2 -
 doc/message-api.txt                |    2 -
 doc/message-waiting-api.txt        |    7 +++--
 doc/messagemanager-api.txt         |   14 ++++++++--
 doc/modem-api.txt                  |   10 ++++---
 doc/network-api.txt                |   16 +++++++----
 doc/phonebook-api.txt              |    2 +-
 doc/pushnotification-api.txt       |    8 ++++++
 doc/radio-settings-api.txt         |    9 +++---
 doc/sim-api.txt                    |   37 +++++++++++++++++++++++++-
 doc/stk-api.txt                    |   17 +++++++-----
 doc/supplementaryservices-api.txt  |   20 +++++++++++---
 doc/voicecall-api.txt              |   17 +++++++++++-
 doc/voicecallmanager-api.txt       |   49 ++++++++++++++++++++++++++++++++=
++-
 23 files changed, 273 insertions(+), 59 deletions(-)

diff --git a/doc/audio-settings-api.txt b/doc/audio-settings-api.txt
index 0f60306..49d7909 100644
--- a/doc/audio-settings-api.txt
+++ b/doc/audio-settings-api.txt
@@ -10,8 +10,6 @@ Methods		dict GetProperties()
 			Returns all audio settings properties. See the
 			properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 Signals		PropertyChanged(string property, variant value)
 =

 			This signal indicates a changed value of the given
diff --git a/doc/call-barring-api.txt b/doc/call-barring-api.txt
index 1534494..a80bf61 100644
--- a/doc/call-barring-api.txt
+++ b/doc/call-barring-api.txt
@@ -9,29 +9,60 @@ Methods		dict GetProperties()
 =

 			Contains the properties for this object.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+
 		void ChangePassword(string old_password, string new_password)
 =

 			Register new network password for the barring
 			services.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void DisableAll(string password)
 =

 			Disables all call barrings.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void DisableAllIncoming(string password)
 =

 			Disables barrings for incoming calls.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void DisableAllOutgoing(string password)
 =

 			Disables barrings for outgoing calls.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void SetProperty(string property, variant value, string pin2)
 =

 			Sets the given property value to that specified in
 			call parameter.  For all properties, the password
 			(typically PIN2) must be provided.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string property, variant value)
 =

 			Signal is emitted whenever a property has changed.
diff --git a/doc/call-forwarding-api.txt b/doc/call-forwarding-api.txt
index e8b4b9f..335637f 100644
--- a/doc/call-forwarding-api.txt
+++ b/doc/call-forwarding-api.txt
@@ -8,6 +8,9 @@ Methods		dict GetProperties()
 =

 			Contains the properties for this object.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+
 		void DisableAll(string type)
 =

 			Disables all call forwarding rules for type.
@@ -16,11 +19,24 @@ Methods		dict GetProperties()
 				"conditional" - Disables all conditional rules,
 					e.g. busy, no reply and not reachable.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void SetProperty(string property, variant value)
 =

 			Sets the given property value to that specified in
 			call parameter.
 =

+			Possible Errors: [service].Error.NotAvailable
+					 [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string property, variant value)
 =

 			Signal is emitted whenever a property has changed.
diff --git a/doc/call-meter-api.txt b/doc/call-meter-api.txt
index 045343b..b668f79 100644
--- a/doc/call-meter-api.txt
+++ b/doc/call-meter-api.txt
@@ -8,6 +8,8 @@ Methods		dict GetProperties()
 =

 			Contains the properties for this object.
 =

+			Possible Errors: [service].Error.InProgress
+
 		void SetProperty(string property, variant value,
 				 string password)
 =

@@ -16,12 +18,24 @@ Methods		dict GetProperties()
 			to pass the SIM PIN2 code which may be
 			required by the SIM.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void Reset(string password)
 =

 			Attempts to reset the Accumulated Call Meter.
 			Reseting this value requires SIM PIN2, provided
 			by the password parameter.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string property, variant value)
 =

 			Signal is emitted whenever a property has changed.
diff --git a/doc/call-settings-api.txt b/doc/call-settings-api.txt
index ed2a099..de9f314 100644
--- a/doc/call-settings-api.txt
+++ b/doc/call-settings-api.txt
@@ -8,11 +8,19 @@ Methods		dict GetProperties()
 =

 			Contains the properties for this object.
 =

+			Possible Errors: [service].Error.InProgress
+
 		void SetProperty(string property, variant value)
 =

 			Sets the given property value to that specified in
 			call parameter.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string property, variant value)
 =

 			Signal is emitted whenever a property has changed.
diff --git a/doc/call-volume-api.txt b/doc/call-volume-api.txt
index 6db0132..320b25f 100644
--- a/doc/call-volume-api.txt
+++ b/doc/call-volume-api.txt
@@ -10,8 +10,6 @@ Methods		dict GetProperties()
 			Returns properties for the CallVolume object. See
 			the properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		void SetProperty(string property, variant value)
 =

 			Changes the value of the specified property. Only
@@ -19,8 +17,11 @@ Methods		dict GetProperties()
 			changeable. On success a PropertyChanged signal
 			will be emitted.
 =

-			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.DoesNotExist
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
 =

 Signals		PropertyChanged(string name, variant value)
 =

diff --git a/doc/cdma-voicecall-manager-api.txt b/doc/cdma-voicecall-manage=
r-api.txt
index 2fd74da..535909a 100644
--- a/doc/cdma-voicecall-manager-api.txt
+++ b/doc/cdma-voicecall-manager-api.txt
@@ -15,10 +15,20 @@ Methods		dict GetProperties()
 			Initiates a new outgoing call.  This is usually
 			implemented using the ATD AT command.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		void Hangup()
 =

 			Hangup all active calls.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		void Answer()
 =

 			Answer the incoming call.  This only affects the
diff --git a/doc/cell-broadcast-api.txt b/doc/cell-broadcast-api.txt
index ec5f14c..52618eb 100644
--- a/doc/cell-broadcast-api.txt
+++ b/doc/cell-broadcast-api.txt
@@ -10,8 +10,6 @@ Methods		dict GetProperties()
 			Returns properties for the cell broadcast object. See
 			the properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		void SetProperty(string property, variant value)
 =

 			Changes the value of the specified property. Only
@@ -19,8 +17,9 @@ Methods		dict GetProperties()
 			changeable. On success a PropertyChanged signal
 			will be emitted.
 =

-			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.DoesNotExist
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.Failed
 =

 Signals		PropertyChanged(string name, variant value)
 =

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 22c59dc..ece5bd3 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -10,20 +10,23 @@ Methods		dict GetProperties()
 			Returns all global system properties. See the
 			properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		void SetProperty(string property, variant value)
 =

 			Sets the property to a desired value
 =

-			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.InvalidFormat
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
 					 [service].Error.Failed
 =

 		void DeactivateAll()
 =

 			Deactivates all active contexts.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.Failed
+
 		array{object,dict} GetContexts()
 =

 			Get array of context objects and properties.
@@ -41,12 +44,22 @@ Methods		dict GetProperties()
 			Type documentation of ConnectionContext interface.
 			Returns the object path of the created context.
 =

+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void RemoveContext(object context)
 =

 			Removes a primary context.  All secondary contexts, if
 			any, associated with the primary context are also
 			removed.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.NotFound
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string property, variant value)
 =

 			This signal indicates a changed value of the given
@@ -130,8 +143,6 @@ Object path	[variable]
 Methods		dict GetProperties()
 			Returns all properties for the context object.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		void SetProperty(string property, variant value)
 =

 			Sets the property to a desired value
@@ -139,8 +150,10 @@ Methods		dict GetProperties()
 			Possible Errors: [service].Error.InvalidArguments
 					 [service].Error.InvalidFormat
 					 [service].Error.Failed
+					 [service].Error.InProgress
 					 [service].Error.NotAttached
 					 [service].Error.AttachInProgress
+					 [service].Error.NotImplemented
 =

 Signals		PropertyChanged(string property, variant value)
 =

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index c231245..1cdedec 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -15,8 +15,6 @@ Methods		array{object,dict} GetModems()
 			and removal shall be monitored via ModemAdded and
 			ModemRemoved signals.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 Signals		ModemAdded(object path, dict properties)
 =

 			Signal that is sent when a new modem is added.  It
diff --git a/doc/message-api.txt b/doc/message-api.txt
index 1c68aee..8d962fd 100644
--- a/doc/message-api.txt
+++ b/doc/message-api.txt
@@ -10,8 +10,6 @@ Methods		dict GetProperties()
 			Returns properties for the message object. See
 			the properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 Signals		PropertyChanged(string name, variant value)
 =

 			This signal indicates a changed value of the given
diff --git a/doc/message-waiting-api.txt b/doc/message-waiting-api.txt
index e381923..83c030b 100644
--- a/doc/message-waiting-api.txt
+++ b/doc/message-waiting-api.txt
@@ -10,8 +10,6 @@ Methods		dict GetProperties()
 			Returns properties for the MessageWaiting object. See
 			the properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		void SetProperty(string property, variant value)
 =

 			Changes the value of the specified property. Only
@@ -20,7 +18,10 @@ Methods		dict GetProperties()
 			will be emitted.
 =

 			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.DoesNotExist
+					 [service].Error.InvalidFormat
+					 [service].Error.NotSupported
+					 [service].Error.SimNotReady
+					 [service].Error.Failed
 =

 Signals		PropertyChanged(string name, variant value)
 =

diff --git a/doc/messagemanager-api.txt b/doc/messagemanager-api.txt
index 848d6e3..43c4d07 100644
--- a/doc/messagemanager-api.txt
+++ b/doc/messagemanager-api.txt
@@ -10,7 +10,8 @@ Methods		dict GetProperties()
 			Returns properties for the manager object. See
 			the properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
 =

 		array{object,dict} GetMessages()
 =

@@ -29,8 +30,11 @@ Methods		dict GetProperties()
 			changeable. On success a PropertyChanged signal
 			will be emitted.
 =

-			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.DoesNotExist
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
 =

 		object SendMessage(string to, string text)
 =

@@ -38,6 +42,10 @@ Methods		dict GetProperties()
 			message could be queued successfully, this method
 			returns an object path to the created Message object.
 =

+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string name, variant value)
 =

 			This signal indicates a changed value of the given
diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index 45043b0..fa400a2 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -10,8 +10,6 @@ Methods		dict GetProperties()
 			Returns properties for the modem object. See
 			the properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		void SetProperty(string property, variant value)
 =

 			Changes the value of the specified property. Only
@@ -19,8 +17,12 @@ Methods		dict GetProperties()
 			changeable. On success a PropertyChanged signal
 			will be emitted.
 =

-			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.DoesNotExist
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.NotAvailable
+					 [service].Error.AccessDenied
+					 [service].Error.Failed
 =

 Signals		PropertyChanged(string name, variant value)
 =

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 4cb6366..159debc 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -10,8 +10,6 @@ Methods		dict GetProperties()
 			Returns all network registration properties. See the
 			properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		void SetProperty(string name, variant value)
 =

 			Changes the value of the specified property. Only
@@ -28,7 +26,9 @@ Methods		dict GetProperties()
 			default network is normally selected by the settings
 			from the SIM card.
 =

-			Possible Errors: [service].Error.InvalidArguments
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
 =

 		array{object,dict} GetOperators()
 =

@@ -56,6 +56,10 @@ Methods		dict GetProperties()
 			GPRS contexts.  Expect the context to be unavailable
 			for the duration of the operator scan.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string property, variant value)
 =

 			This signal indicates a changed value of the given
@@ -158,8 +162,6 @@ Methods		dict GetProperties()
 			Returns all network operator properties. See the
 			properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		void Register()
 =

 			Attempts to register to this network operator.
@@ -168,7 +170,9 @@ Methods		dict GetProperties()
 			be observed by tracking the NetworkRegistration Status
 			property.
 =

-			Possible Errors: [service].Error.InvalidArguments
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
 =

 Signals		PropertyChanged(string property, variant value)
 =

diff --git a/doc/phonebook-api.txt b/doc/phonebook-api.txt
index dc8b95d..92c0e0b 100644
--- a/doc/phonebook-api.txt
+++ b/doc/phonebook-api.txt
@@ -15,4 +15,4 @@ Methods		string Import()
 			The phonebook is returned as a single UTF8 encoded
 			string with zero or more VCard entries.
 =

-			Possible Errors: [service].Error.Failed
+			Possible Errors: [service].Error.InProgress
diff --git a/doc/pushnotification-api.txt b/doc/pushnotification-api.txt
index 942ba0f..6938826 100644
--- a/doc/pushnotification-api.txt
+++ b/doc/pushnotification-api.txt
@@ -10,10 +10,18 @@ Methods		void RegisterAgent(object path)
 			Registers an agent which will be called whenever a
 			new Smart Messaging based SMS arrives.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void UnregisterAgent(object path)
 =

 			Unregisters an agent.
 =

+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.Failed
+
 PushNotificationAgent Hierarchy [experimental]
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
index da46ffe..d2dd319 100644
--- a/doc/radio-settings-api.txt
+++ b/doc/radio-settings-api.txt
@@ -10,9 +10,8 @@ Methods		dict GetProperties()
 			Returns all radio access properties. See the
 			properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
+			Possible Errors: [service].Error.InProgress
 					 [service].Error.NotImplemented
-					 [service].Error.InProgress
 					 [service].Error.Failed
 =

 		void SetProperty(string name, variant value)
@@ -22,9 +21,9 @@ Methods		dict GetProperties()
 			changeable. On success a PropertyChanged signal
 			will be emitted.
 =

-			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.DoesNotExist
-					 [service].Error.InProgress
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
 					 [service].Error.Failed
 =

 Signals		PropertyChanged(string property, variant value)
diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index c8091f7..22fe22b 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -10,23 +10,39 @@ Methods		dict GetProperties()
 			Returns SIM properties for the modem object.  See
 			the properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		void ChangePin(string type, string oldpin, string newpin)
 =

 			Changes the pin given by string type.
 =

+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void EnterPin(string type, string pin)
 =

 			Enters the currently pending pin.  The type value must
 			match the pin type being asked in the PinRequired
 			property.
 =

+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void ResetPin(string type, string puk, string newpin)
 =

 			Provides the unblock key to the modem and if correct
 			resets the pin to the new value of newpin.
 =

+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void LockPin(string type, string pin)
 =

 			Activates the lock for the particular pin type.  The
@@ -35,17 +51,34 @@ Methods		dict GetProperties()
 			re-inserted.  The current PIN is required for the
 			operation to succeed.
 =

+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void UnlockPin(string type, string pin)
 =

 			Deactivates the lock for the particular pin type.  The
 			current PIN is required for the operation to succeed.
 =

+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		array{byte} GetIcon(byte id)
 =

 			Obtain the icon given by id.  Only ids greater than 1
 			are valid.  XPM format is currently used to return the
 			icon data.
 =

+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string name, variant value)
 =

 			This signal indicates a changed value of the given
diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 93a2434..054821b 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -10,8 +10,6 @@ Methods		dict GetProperties()
 			Returns properties for the SimToolkit object.  See the
 			properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		array{byte} GetIcon(byte id)
 =

 			Returns the icon data for icon identified by id.
@@ -27,6 +25,12 @@ Methods		dict GetProperties()
 			a new agent to be used for the duration of the
 			user session.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotSupported
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void RegisterAgent(object path)
 =

 			Registers a default agent to be used for SIM initiated
@@ -35,9 +39,10 @@ Methods		dict GetProperties()
 			received and might not involve interaction from the
 			user.
 =

-			Possible Errors: [service].Error.InvalidArguments
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
 					 [service].Error.InvalidFormat
-					 [service].Error.InUse
+					 [service].Error.Failed
 =

 		void UnregisterAgent(object path)
 =

@@ -46,9 +51,7 @@ Methods		dict GetProperties()
 			are rejected.
 =

 			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.InvalidFormat
-					 [service].Error.NotFound
-					 [service].Error.NotAuthorized
+					 [service].Error.Failed
 =

 Signals		PropertyChanged(string property, variant value)
 =

diff --git a/doc/supplementaryservices-api.txt b/doc/supplementaryservices-=
api.txt
index 820cce1..e855ead 100644
--- a/doc/supplementaryservices-api.txt
+++ b/doc/supplementaryservices-api.txt
@@ -23,8 +23,11 @@ Methods		string, variant Initiate(string command)
 			The output arguments are described in section
 			"Initiate method outptut arguments" below.
 =

-			Possible Errors: [service].Error.Timedout
-			Possible Errors: [service].Error.Canceled
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
 =

 		string Respond(string reply)
 =

@@ -32,14 +35,23 @@ Methods		string, variant Initiate(string command)
 			it is awaiting further input after Initiate()
 			was called or after a network-initiated request.
 =

-			Possible Errors: [service].Error.Timedout
-			Possible Errors: [service].Error.Canceled
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotActive
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
 =

 		void Cancel()
 =

 			Cancel an ongoing USSD session, mobile- or
 			network-initiated.
 =

+			Possible Errors: [service].Error.NotActive
+					 [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		dict GetProperties()
 =

 			Returns Supplementary Services related properties. See
diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 253c30d..7eb41aa 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -10,8 +10,6 @@ Methods		dict GetProperties()
 			Returns all properties for this object. See the
 			properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		void Deflect(string number)
 =

 			Deflects the incoming or waiting call to number given
@@ -25,6 +23,12 @@ Methods		dict GetProperties()
 			This method should not be confused with the Transfer()
 			method.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 		void Hangup()
 =

 			Hangs up the voice call.
@@ -43,6 +47,10 @@ Methods		dict GetProperties()
 			of a held multiparty call might not be possible on some
 			implementations.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.Failed
+					 [service].Error.NotImplemented
+
 		void Answer()
 =

 			Answers the incoming call.  Only valid if the state
@@ -51,6 +59,11 @@ Methods		dict GetProperties()
 			This functionality is generally implemented by ATA
 			AT command.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.Failed
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string property, variant value)
 =

 			Signal is emitted whenever a property has changed.
diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index ca8aaec..73205f0 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -10,8 +10,6 @@ Methods		dict GetProperties()
 			Returns properties for the VoiceCallManager Interface.
 			See the properties section for available properties.
 =

-			Possible Errors: [service].Error.InvalidArguments
-
 		array{object,dict} GetCalls()
 =

 			Get an array of call object paths and properties
@@ -37,6 +35,12 @@ Methods		dict GetProperties()
 =

 			This is usually implemented using the ATD AT command.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		void Transfer()
 =

 			Joins the currently Active (or Outgoing, depending
@@ -49,6 +53,10 @@ Methods		dict GetProperties()
 			This functionality is generally implemented by using
 			the +CHLD=3D4 AT command.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		void SwapCalls()
 =

 			Swaps Active and Held calls.  The effect of this
@@ -65,6 +73,10 @@ Methods		dict GetProperties()
 			This functionality is generally implemented by using
 			the +CHLD=3D2 AT command.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		void ReleaseAndAnswer()
 =

 			Releases currently active call (0 or more) and
@@ -72,6 +84,10 @@ Methods		dict GetProperties()
 			if the current call is a multiparty call, then all
 			parties in the multi-party call will be released.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		void HoldAndAnswer()
 =

 			Puts the current call (including multi-party calls) on
@@ -80,10 +96,18 @@ Methods		dict GetProperties()
 			Held calls is invalid, since in GSM a user can have
 			only a single Held call at a time.
 =

+                        Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		void HangupAll()
 =

 			Releases all calls.
 =

+                        Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		array{object} PrivateChat(object call)
 =

 			Places the multi-party call on hold and makes desired
@@ -97,6 +121,13 @@ Methods		dict GetProperties()
 =

 			This is usually implemented using the +CHLD=3D2X command.
 =

+                        Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.NotFound
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		array{object} CreateMultiparty()
 =

 			Joins active and held calls together into a multi-party
@@ -111,11 +142,19 @@ Methods		dict GetProperties()
 			This is usually implemented using the +CHLD=3D3 AT
 			command.
 =

+                        Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		void HangupMultiparty()
 =

 			Hangs up the multi-party call.  All participating
 			calls are released.
 =

+                        Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		void SendTones(string tones)
 =

 			Sends the DTMF tones to the network.  The tones have
@@ -123,6 +162,12 @@ Methods		dict GetProperties()
 			'*', '#', 'A', 'B', 'C', 'D'.  The last four are
 			typically not used in normal circumstances.
 =

+                        Possible Errors: [service].Error.InProgress
+					 [service].Error.NotImplemented
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
 Signals		CallAdded(object path, dict properties)
 =

 			Signal that is sent when a new call is added.  It
-- =

1.7.0.4


--===============6888830592012878413==--


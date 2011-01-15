Content-Type: multipart/mixed; boundary="===============4383986256989368140=="
MIME-Version: 1.0
From: Faiyaz Baxamusa <faiyaz.baxamusa@nokia.com>
Subject: [PATCHv2 1/2] doc: Add messagemanager-api and change message-api
Date: Fri, 14 Jan 2011 16:30:45 -0800
Message-ID: <1295051446-22150-2-git-send-email-faiyaz.baxamusa@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4383986256989368140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                                        |    4 +-
 ...message-api.txt =3D> cdma-messagemanager-api.txt} |    0
 doc/message-api.txt                                |   89 ----------------=
----
 doc/messagemanager-api.txt                         |   88 ++++++++++++++++=
+++
 4 files changed, 90 insertions(+), 91 deletions(-)
 rename doc/{cdma-message-api.txt =3D> cdma-messagemanager-api.txt} (100%)
 create mode 100644 doc/messagemanager-api.txt

diff --git a/Makefile.am b/Makefile.am
index ce4799e..c2e5706 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -388,11 +388,11 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt do=
c/release-faq.txt \
 			doc/pushnotification-api.txt \
 			doc/smartmessaging-api.txt \
 			doc/call-volume-api.txt doc/cell-broadcast-api.txt \
-			doc/message-api.txt doc/message-waiting-api.txt \
+			doc/messagemanager-api.txt doc/message-waiting-api.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
-			doc/calypso-modem.txt
+			doc/calypso-modem.txt doc/message-api.txt
 =

 =

 test_scripts =3D test/backtrace \
diff --git a/doc/cdma-message-api.txt b/doc/cdma-messagemanager-api.txt
similarity index 100%
rename from doc/cdma-message-api.txt
rename to doc/cdma-messagemanager-api.txt
diff --git a/doc/message-api.txt b/doc/message-api.txt
index f7ab22a..1c68aee 100644
--- a/doc/message-api.txt
+++ b/doc/message-api.txt
@@ -1,92 +1,3 @@
-Message Manager hierarchy
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Service		org.ofono
-Interface	org.ofono.MessageManager
-Object path	[variable prefix]/{modem0,modem1,...}
-
-Methods		dict GetProperties()
-
-			Returns properties for the manager object. See
-			the properties section for available properties.
-
-			Possible Errors: [service].Error.InvalidArguments
-
-		array{object,dict} GetMessages()
-
-			Get an array of message object paths and properties
-			that represents the currently pending messages.
-
-			This method call should only be used once when an
-			application starts up.  Further message additions
-			and removal shall be monitored via MessageAdded and
-			MessageRemoved signals.
-
-		void SetProperty(string name, variant value)
-
-			Changes the value of the specified property. Only
-			properties that are listed as readwrite are
-			changeable. On success a PropertyChanged signal
-			will be emitted.
-
-			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.DoesNotExist
-
-		object SendMessage(string to, string text)
-
-			Send the message in text to the number in to.  If the
-			message could be queued successfully, this method
-			returns an object path to the created Message object.
-
-Signals		PropertyChanged(string name, variant value)
-
-			This signal indicates a changed value of the given
-			property.
-
-		ImmediateMessage(string message, dict info)
-
-			New immediate (class 0) SMS received. Info has Sender,
-			LocalSentTime, and SentTime information.  Sender
-			address is given in string format.  LocalSentTime and
-			SentTime are given in string form using ISO8601 format.
-
-		IncomingMessage(string message, dict info)
-
-			New incoming text SMS received. Info has Sender,
-			LocalSentTime, and SentTime information.
-
-		MessageAdded(object path, dict properties)
-
-			This signal is emitted whenever a new Message object
-			has been created.
-
-		MessageRemoved(object path)
-
-			This signal is emitted whenever a Message object
-			has been removed, e.g. when it reaches a final state.
-
-Properties	string ServiceCenterAddress
-
-			Contains the number of the SMS service center.
-
-		boolean UseDeliveryReports
-
-			This property controls whether SMS Status Reports,
-			sometimes better known as Delivery Reports are to be
-			used.  If enabled, all outgoing SMS messages will be
-			flagged to request a status report from the SMSC.
-
-		string Bearer
-
-			Contains the bearer to use for SMS messages.  Possible
-			values are:
-				"cs-only" - Circuit Switched only
-				"ps-only" - Packet Domain only
-				"cs-preferred" - Use PS if CS is unavailable
-				"ps-preferred" - Use CS if PS is unavailable
-
-			By default oFono uses "cs-preferred" setting.
-
 Message hierarchy
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

diff --git a/doc/messagemanager-api.txt b/doc/messagemanager-api.txt
new file mode 100644
index 0000000..0723e9c
--- /dev/null
+++ b/doc/messagemanager-api.txt
@@ -0,0 +1,88 @@
+Message Manager hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.MessageManager
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns properties for the manager object. See
+			the properties section for available properties.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		array{object,dict} GetMessages()
+
+			Get an array of message object paths and properties
+			that represents the currently pending messages.
+
+			This method call should only be used once when an
+			application starts up.  Further message additions
+			and removal shall be monitored via MessageAdded and
+			MessageRemoved signals.
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as readwrite are
+			changeable. On success a PropertyChanged signal
+			will be emitted.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.DoesNotExist
+
+		object SendMessage(string to, string text)
+
+			Send the message in text to the number in to.  If the
+			message could be queued successfully, this method
+			returns an object path to the created Message object.
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+		ImmediateMessage(string message, dict info)
+
+			New immediate (class 0) SMS received. Info has Sender,
+			LocalSentTime, and SentTime information.  Sender
+			address is given in string format.  LocalSentTime and
+			SentTime are given in string form using ISO8601 format.
+
+		IncomingMessage(string message, dict info)
+
+			New incoming text SMS received. Info has Sender,
+			LocalSentTime, and SentTime information.
+
+		MessageAdded(object path, dict properties)
+
+			This signal is emitted whenever a new Message object
+			has been created.
+
+		MessageRemoved(object path)
+
+			This signal is emitted whenever a Message object
+			has been removed, e.g. when it reaches a final state.
+
+Properties	string ServiceCenterAddress
+
+			Contains the number of the SMS service center.
+
+		boolean UseDeliveryReports
+
+			This property controls whether SMS Status Reports,
+			sometimes better known as Delivery Reports are to be
+			used.  If enabled, all outgoing SMS messages will be
+			flagged to request a status report from the SMSC.
+
+		string Bearer
+
+			Contains the bearer to use for SMS messages.  Possible
+			values are:
+				"cs-only" - Circuit Switched only
+				"ps-only" - Packet Domain only
+				"cs-preferred" - Use PS if CS is unavailable
+				"ps-preferred" - Use CS if PS is unavailable
+
+			By default oFono uses "cs-preferred" setting.
-- =

1.7.0.4


--===============4383986256989368140==--


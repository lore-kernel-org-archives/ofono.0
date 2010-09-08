Content-Type: multipart/mixed; boundary="===============8617896497073545085=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [RFCv3] Add message agent API
Date: Wed, 08 Sep 2010 15:36:59 +0300
Message-ID: <1283949419-30222-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8617896497073545085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/message-api.txt |   72 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/doc/message-api.txt b/doc/message-api.txt
index 693a111..4b7c287 100644
--- a/doc/message-api.txt
+++ b/doc/message-api.txt
@@ -26,6 +26,43 @@ Methods		dict GetProperties()
 =

 			Send the message in text to the number in to.
 =

+		void RegisterAgent(object path, string type)
+
+			Registers an agent to handle received messages.
+
+			The object path defines the path of the agent that
+			will be called when a message is ready to be
+			dispatched.  The type parameters accepts a MIME
+			type of the messages this agent is willing to
+			accept.  Some common types include:
+
+				"text/plain" - Regular text messages
+				"text/x-vcard" - vCard objects
+				"text/calendar" - vCalendar objects
+				"application/vnd.oma.push" - WAP push
+				"application/x-sms-agent" - Any datagram
+
+			Wildcards are not allowed as the MIME subtype, but
+			registering an agent on a generic port is supported.
+			For instance, to listen on port 5678, the agent
+			would need to register using type:
+
+				"application/x-sms-agent;port=3D5678"
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.InUse
+
+		void UnregisterAgent(object path)
+
+			Unregisters an agent.  If no agents exist that
+			can handle an incoming message, it will be
+			silently dropped.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].NotFound
+
 Signals		PropertyChanged(string name, variant value)
 =

 			This signal indicates a changed value of the given
@@ -64,3 +101,38 @@ Properties	string ServiceCenterAddress
 				"ps-preferred" - Use CS if PS is unavailable
 =

 			By default oFono uses "cs-preferred" setting.
+
+
+MessageAgent Hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	org.ofono.MessageAgent
+Object path	freely definable
+
+Methods		void HandleTextMessage(string message, dict info)
+
+			New incoming text SMS received.  Info has Sender
+			LocalSentTime, and SentTime information.  Sender
+			address is given in string format.  LocalSentTime
+			and SentTime are given in string form using
+			ISO8601 format.
+
+		void HandleDatagram(array{byte}, dict info)
+
+			New incoming datagram SMS received.  Info has
+			Sender, LocalSentTime, SentTime, MediaType or
+			DestinationPort, and SourcePort information.
+			Sender address is given in string format.
+			LocalSentTime and SentTime are given in string
+			using ISO8601 format.  MediaType is given as
+			a MIME media type in string form, if it is
+			a known type.  Otherwise, DestinationPort is
+			given as a 16bit unsigned integer.  SourcePort
+			is always given as a 16bit unsigned integer.
+
+		void Release()
+
+			Agent is being released, possibly because of oFono
+			terminating, the MessageManager interface being
+			torn down or modem powering down.
-- =

1.7.0.4


--===============8617896497073545085==--


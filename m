Content-Type: multipart/mixed; boundary="===============4482779866729945068=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/5] Add message agent interface documentation
Date: Thu, 09 Sep 2010 11:08:24 +0300
Message-ID: <1284019708-11747-2-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1284019708-11747-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4482779866729945068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/message-api.txt |   63 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/doc/message-api.txt b/doc/message-api.txt
index 693a111..e1baf7a 100644
--- a/doc/message-api.txt
+++ b/doc/message-api.txt
@@ -26,6 +26,35 @@ Methods		dict GetProperties()
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
+			type in RFC 2045 format of the messages this agent
+			is willing to accept.  Currently supported types are:
+
+				"text/plain" - Regular text messages
+				"text/x-vcard" - vCard objects
+				"text/calendar" - vCalendar objects
+				"application/vnd.oma.push" - WAP push
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
@@ -64,3 +93,37 @@ Properties	string ServiceCenterAddress
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
+Methods		void HandleMessage(string message, dict info)
+
+			New incoming text SMS received.  Info has Sender
+			LocalSentTime, and SentTime information.  Sender
+			address is given in string format.  LocalSentTime
+			and SentTime are given in string form using
+			ISO8601 format.
+
+		void HandleDatagram(array{byte} message, dict info)
+
+			New incoming datagram SMS received.  Info has
+			Sender, LocalSentTime, SentTime, ContentType if known
+			or DestinationPort, and SourcePort information.  Sender
+			address is given in string format.  LocalSentTime
+			and SentTime are given in string using ISO8601 format.
+
+			ContentType is given as a MIME media type in string
+			format as defined in RFC 2045, and SourcePort and
+			DestinationPort are given as a 16bit unsigned integer.
+
+		void Release()
+
+			Agent is being released, possibly because of oFono
+			terminating, the MessageManager interface being
+			torn down or modem powering down.
-- =

1.7.0.4


--===============4482779866729945068==--


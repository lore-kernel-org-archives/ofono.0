Content-Type: multipart/mixed; boundary="===============0771463503732340420=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 3/7] Add message agent interface documentation
Date: Mon, 27 Sep 2010 19:54:15 +0300
Message-ID: <1285606459-1297-4-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1285606459-1297-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0771463503732340420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/message-api.txt |   51 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/doc/message-api.txt b/doc/message-api.txt
index 9e8d02f..5bdc98d 100644
--- a/doc/message-api.txt
+++ b/doc/message-api.txt
@@ -38,6 +38,29 @@ Methods		dict GetProperties()
 			message could be queued successfully, this method
 			returns an object path to the created Message object.
 =

+		void RegisterAgent(object path)
+
+			Registers an agent to handle received messages.
+
+			The object path defines the path of the agent that
+			will be called when either a text message, a vCard
+			object or a vCalendar object is ready to be
+			dispatched.
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
+					 [service].Error.NotFound
+
 Signals		PropertyChanged(string name, variant value)
 =

 			This signal indicates a changed value of the given
@@ -113,3 +136,31 @@ Properties	string State
 				"pending",
 				"sent",
 				"failed"
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
+			New incoming SMS received.  Info has Sender
+			LocalSentTime, SentTime and ContentType information.
+			Sender address is given in string format.  LocalSentTime
+			and SentTime are given in string form using
+			ISO8601 format.
+
+			The ContentType parameter is a string that indicates the
+			content type of	the message.  Possible values are:
+
+				"text" - Plain text message
+				"vcard" - vCard object
+				"vcal"  - vCalendar object
+
+		void Release()
+
+			Agent is being released, possibly because of oFono
+			terminating, the MessageManager interface being
+			torn down or modem powering down.
-- =

1.7.0.4


--===============0771463503732340420==--


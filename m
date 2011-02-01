Content-Type: multipart/mixed; boundary="===============0052869818466450892=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC 2/2] doc: Add description for history agent interface
Date: Tue, 01 Feb 2011 18:29:00 +0100
Message-ID: <1296581340-21570-2-git-send-email-marcel@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0052869818466450892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/history-agent-api.txt |   83 +++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 doc/history-agent-api.txt

diff --git a/doc/history-agent-api.txt b/doc/history-agent-api.txt
new file mode 100644
index 0000000..373974d
--- /dev/null
+++ b/doc/history-agent-api.txt
@@ -0,0 +1,83 @@
+History hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.History
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		void RegisterAgent(object path)
+
+			Registers an agent which will be called whenever a
+			new history update is available.
+
+			Possible Errors: [service].Error.InvalidArguments
+			                 [service].Error.InvalidFormat
+
+		void UnregisterAgent(object path)
+
+			Unregisters an agent.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+
+History Agent hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	org.ofono.HistoryAgent
+Object path	freely definable
+
+Methods		void CallEnded(dict info)
+
+			Call has been established and finished now.
+
+			The info dictionary contains 'Direction', 'Number',
+			'Name', 'StartTime' and 'EndTime' properties.
+
+			Possible Errors: None
+
+		void CallMissed(dict info)
+
+			Call has been missed.
+
+			The info dictionary contains 'Number', 'Name' and
+			'LocalTime' properties.
+
+			Possible Errors: None
+
+		void MessageReceived(dict info)
+
+			Incoming text message.
+
+			The info dictionary contains 'Identifier', 'Sender',
+			'Text', 'LocalTime' and 'RemoteTime' properties.
+
+			Possible Errors: None
+
+		void MessageSubmitted(dict info)
+
+			Outgoing text message that is currently queued up.
+
+			The info dictionary contains 'Identifier', 'Receiver',
+			'Text' and 'LocalTime' properties.
+
+			Possible Errors: None
+
+		void MessageStatus(dict info)
+
+			Update on the status of outgoing messages.
+
+			The info dictionary contains 'Identifier', 'Status'
+			and 'LocalTime'	properties.
+
+			Status can be 'pending', 'submitted', 'submit-failed',
+			'delivered' or 'deliver-failed'.
+
+			Possible Errors: None
+
+		void Release() [noreply]
+
+			Agent is being released, possibly because of daemon
+			terminating or modem being turned off.
+
+			No UnregisterAgent call is needed.
-- =

1.7.3.5


--===============0052869818466450892==--


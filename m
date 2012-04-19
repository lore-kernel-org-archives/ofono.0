Content-Type: multipart/mixed; boundary="===============9203336876125575644=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 1/7] doc: Add description for history agent interface
Date: Thu, 19 Apr 2012 11:20:50 +0300
Message-ID: <1334823656-3366-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334823656-3366-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9203336876125575644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marcel Holtmann <marcel@holtmann.org>

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

1.7.5.4


--===============9203336876125575644==--


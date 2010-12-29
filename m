Content-Type: multipart/mixed; boundary="===============2991863181853501307=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: [PATCH 3/9] SMS history plugin documentation.
Date: Wed, 29 Dec 2010 14:51:19 +0200
Message-ID: <1293627085-24428-4-git-send-email-oleg.zhurakivskyy@nokia.com>
In-Reply-To: <1293627085-24428-1-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2991863181853501307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/messaging-agent-api.txt |   49 +++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100644 doc/messaging-agent-api.txt

diff --git a/doc/messaging-agent-api.txt b/doc/messaging-agent-api.txt
new file mode 100644
index 0000000..956ec55
--- /dev/null
+++ b/doc/messaging-agent-api.txt
@@ -0,0 +1,49 @@
+Messaging hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.Messaging
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		void AgentRegister(object path)
+
+			Registers an agent which will be notified on SMS events.
+
+		void AgentUnregister(object path)
+
+			Unregisters an agent.
+
+MessagingAgent Hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	org.ofono.MessagingAgent
+Object path	freely definable
+
+Methods		void MessageReceived(array{byte} appointment, dict info)
+
+			Requests the agent to process incoming SMS.
+			The info dictionary contains 'Sender',
+			'LocalSentTime', 'SentTime' and 'UUID' properties.
+
+		void MessageSendPending(array{byte} card, dict info)
+
+			Requests the agent to process outgoing SMS.
+
+			The info dictionary contains 'Sender',
+			'LocalSentTime', 'SentTime' and 'UUID' properties.
+
+		void MessageSendStatus(array{byte} card, dict info)
+
+			Requests the agent to process an outgoing SMS
+			send status notification.
+
+			The info dictionary contains 'Sender',
+			'LocalSentTime', 'SentTime', 'UUID' and 'Status'
+			properties.
+
+		void Release()
+
+			Agent is being released, possibly because of oFono
+			terminating, SMS agent interface is being torn down
+			or modem off.  No UnregisterAgent call is needed.
-- =

1.7.1


--===============2991863181853501307==--


Content-Type: multipart/mixed; boundary="===============3320168078125977710=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v2 04/12] bluetooth: Add org.bluez.MediaTransport interface
Date: Mon, 26 Mar 2012 11:25:21 +0200
Message-ID: <1332753929-9711-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1332753929-9711-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3320168078125977710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index f81fc99..ee3c71e 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -30,6 +30,7 @@
 #define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
 #define	BLUEZ_TELEPHONY_INTERFACE	BLUEZ_SERVICE ".Telephony"
 #define	BLUEZ_TELEPHONY_AGENT_INTERFACE	BLUEZ_SERVICE ".TelephonyAgent"
+#define	BLUEZ_TRANSPORT_INTERFACE	BLUEZ_SERVICE ".MediaTransport"
 =

 #define DBUS_TIMEOUT 15
 =

-- =

1.7.1


--===============3320168078125977710==--


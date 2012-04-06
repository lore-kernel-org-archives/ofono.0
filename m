Content-Type: multipart/mixed; boundary="===============8129561949572737726=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v4 04/10] bluetooth: Add audio APIs for HFP AG
Date: Fri, 06 Apr 2012 15:17:06 +0200
Message-ID: <1333718232-8447-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333718232-8447-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8129561949572737726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index f81fc99..41ce112 100644
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

@@ -85,6 +86,9 @@ int bluetooth_sap_client_register(struct bluetooth_sap_dr=
iver *sap,
 					struct ofono_modem *modem);
 void bluetooth_sap_client_unregister(struct ofono_modem *modem);
 =

+void *bluetooth_set_audio_management(void *em, const char *path,
+							guint16 features);
+void bluetooth_free_audio_management(void *data);
 int bluetooth_parse_newconnection_message(DBusMessage *msg, const char **d=
evice,
 					const char **uuid, guint16 *version,
 					guint16 *features,
-- =

1.7.1


--===============8129561949572737726==--


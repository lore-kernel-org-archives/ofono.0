Content-Type: multipart/mixed; boundary="===============6147031814913417710=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v5 04/12] bluetooth: Add audio APIs for HFP AG
Date: Thu, 26 Apr 2012 16:26:56 +0200
Message-ID: <1335450424-19964-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1335450424-19964-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6147031814913417710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index f81fc99..87563e7 100644
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

@@ -59,6 +60,7 @@ struct bluetooth_sap_driver {
 };
 =

 struct server;
+struct bt_audio;
 =

 typedef void (*ConnectFunc)(GIOChannel *io, GError *err, gpointer user_dat=
a);
 =

@@ -85,6 +87,9 @@ int bluetooth_sap_client_register(struct bluetooth_sap_dr=
iver *sap,
 					struct ofono_modem *modem);
 void bluetooth_sap_client_unregister(struct ofono_modem *modem);
 =

+struct bt_audio *bluetooth_set_audio_management(void *em, const char *path,
+							guint16 features);
+void bluetooth_free_audio_management(struct bt_audio *audio);
 int bluetooth_parse_newconnection_message(DBusMessage *msg, const char **d=
evice,
 					const char **uuid, guint16 *version,
 					guint16 *features,
-- =

1.7.1


--===============6147031814913417710==--


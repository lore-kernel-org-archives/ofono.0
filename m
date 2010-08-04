Content-Type: multipart/mixed; boundary="===============1796647228146764709=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 1/5] bluetooth: define DBUS_TIMEOUT macro
Date: Wed, 04 Aug 2010 07:22:10 -0300
Message-ID: <1280917334-4519-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1796647228146764709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.h |    2 ++
 plugins/hfp.c       |    6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index fb0d841..b70bb0c 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -23,6 +23,8 @@
 #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
 #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
 =

+#define DBUS_TIMEOUT 15
+
 #define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
 =

 /* Profiles bitfield */
diff --git a/plugins/hfp.c b/plugins/hfp.c
index b6cd415..0337891 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -595,7 +595,7 @@ static int hfp_enable(struct ofono_modem *modem)
 	status =3D bluetooth_send_with_reply(data->handsfree_path,
 					BLUEZ_GATEWAY_INTERFACE, "Connect",
 					hfp_connect_reply, modem, NULL,
-					15, DBUS_TYPE_INVALID);
+					DBUS_TIMEOUT, DBUS_TYPE_INVALID);
 =

 	if (status < 0)
 		return -EINVAL;
@@ -636,8 +636,8 @@ static int hfp_disable(struct ofono_modem *modem)
 	if (data->agent_registered) {
 		status =3D bluetooth_send_with_reply(data->handsfree_path,
 					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
-					hfp_power_down, modem, NULL, 15,
-					DBUS_TYPE_INVALID);
+					hfp_power_down, modem, NULL,
+					DBUS_TIMEOUT, DBUS_TYPE_INVALID);
 =

 		if (status < 0)
 			return -EINVAL;
-- =

1.7.1.1


--===============1796647228146764709==--


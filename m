Content-Type: multipart/mixed; boundary="===============5958517290154243816=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 2/9] Remove hack around hfp agent interface
Date: Tue, 25 May 2010 04:18:01 -0300
Message-ID: <1274771888-2565-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1274771888-2565-2-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5958517290154243816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the past we did this dirty hack to quickly fix HFP for the release, now
fixing it in a proper way.
---
 drivers/hfpmodem/hfpmodem.h |    1 -
 plugins/hfp.c               |   12 +++---------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index c95ea3f..6ec8a7c 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -71,7 +71,6 @@ struct hfp_data {
 	unsigned int hf_features;
 	unsigned char cind_pos[HFP_INDICATOR_LAST];
 	unsigned int cind_val[HFP_INDICATOR_LAST];
-	gboolean agent_registered;
 };
 =

 extern void hfp_netreg_init();
diff --git a/plugins/hfp.c b/plugins/hfp.c
index e37c9fc..b253781 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -552,11 +552,9 @@ static DBusMessage *hfp_agent_release(DBusConnection *=
conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_modem *modem =3D data;
-	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
 	const char *obj_path =3D ofono_modem_get_path(modem);
 =

 	g_dbus_unregister_interface(connection, obj_path, HFP_AGENT_INTERFACE);
-	hfp_data->agent_registered =3D FALSE;
 =

 	ofono_modem_remove(modem);
 =

@@ -950,16 +948,10 @@ static int hfp_unregister_ofono_handsfree(struct ofon=
o_modem *modem)
 static int hfp_probe(struct ofono_modem *modem)
 {
 	const char *obj_path =3D ofono_modem_get_path(modem);
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-
-	if (!data)
-		return -EINVAL;
 =

 	g_dbus_register_interface(connection, obj_path, HFP_AGENT_INTERFACE,
 			agent_methods, NULL, NULL, modem, NULL);
 =

-	data->agent_registered =3D TRUE;
-
 	if (hfp_register_ofono_handsfree(modem) !=3D 0)
 		return -EINVAL;
 =

@@ -1062,13 +1054,15 @@ done:
 static int hfp_disable(struct ofono_modem *modem)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	const char *obj_path =3D ofono_modem_get_path(modem);
 	int status;
 =

 	DBG("%p", modem);
 =

 	clear_data(modem);
 =

-	if (data->agent_registered) {
+	if (g_dbus_interface_is_registered(connection, obj_path,
+						HFP_AGENT_INTERFACE)) {
 		status =3D send_method_call_with_reply(BLUEZ_SERVICE,
 					data->handsfree_path,
 					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
-- =

1.7.1


--===============5958517290154243816==--


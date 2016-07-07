Content-Type: multipart/mixed; boundary="===============0696053873944170776=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH] ril_sofia3gr: Add vendorize SoFiA to send modem shutdown
Date: Thu, 07 Jul 2016 10:51:02 +0530
Message-ID: <1467868862-12792-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0696053873944170776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

since ril_send_power request mapped with airplane mode, it should
be wrapped modem shutdown of oem hook.
---
 plugins/ril_sofia3gr.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/plugins/ril_sofia3gr.c b/plugins/ril_sofia3gr.c
index f8bf2bb..bba34df 100644
--- a/plugins/ril_sofia3gr.c
+++ b/plugins/ril_sofia3gr.c
@@ -554,6 +554,9 @@ static int ril_disable(struct ofono_modem *modem)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ril_data *rd =3D ofono_modem_get_data(modem);
 	const char *path =3D ofono_modem_get_path(modem);
+	struct parcel rilp;
+	int cmd_id;
+	char buf[4];
 =

 	DBG("%p", modem);
 =

@@ -562,7 +565,17 @@ static int ril_disable(struct ofono_modem *modem)
 		ofono_modem_remove_interface(modem,
 						THERMAL_MANAGEMENT_INTERFACE);
 =

-	ril_send_power(rd->ril, FALSE, ril_send_power_off_cb, modem, NULL);
+	/* RIL_OEM_HOOK_STRING_SET_MODEM_OFF =3D 0x000000CF */
+	cmd_id =3D 0x000000CF;
+	sprintf(buf, "%d", cmd_id);
+	parcel_init(&rilp);
+	parcel_w_int32(&rilp, 1);
+	parcel_w_string(&rilp, buf);
+
+	g_ril_append_print_buf(rd->ril, "{cmd_id=3D0x%02X}", cmd_id);
+
+	g_ril_send(rd->ril, RIL_REQUEST_OEM_HOOK_STRINGS, &rilp,
+					ril_send_power_off_cb, modem, NULL);
 =

 	return -EINPROGRESS;
 }
-- =

1.9.1


--===============0696053873944170776==--


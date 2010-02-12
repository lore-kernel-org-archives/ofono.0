Content-Type: multipart/mixed; boundary="===============4527985347329635160=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] hfp: don't call HandsfreeGateway.Disconnect() when Release()
 is called
Date: Fri, 12 Feb 2010 21:31:40 -0200
Message-ID: <1266017500-26219-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4527985347329635160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 219f268..aa4085a 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -934,19 +934,24 @@ done:
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

-	status =3D send_method_call_with_reply(BLUEZ_SERVICE,
-				data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "Disconnect",
-				hfp_power_down, modem, 15, DBUS_TYPE_INVALID);
+	if (g_dbus_unregister_interface(connection, obj_path,
+					HFP_AGENT_INTERFACE)) {
+		status =3D send_method_call_with_reply(BLUEZ_SERVICE,
+					data->handsfree_path,
+					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
+					hfp_power_down, modem, 15,
+					DBUS_TYPE_INVALID);
 =

-	if (status < 0)
-		return -EINVAL;
+		if (status < 0)
+			return -EINVAL;
+	}
 =

 	return -EINPROGRESS;
 }
-- =

1.6.4.4


--===============4527985347329635160==--


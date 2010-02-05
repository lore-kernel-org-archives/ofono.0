Content-Type: multipart/mixed; boundary="===============0034533031968982702=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] hfp: set timeout to service level connection procedure
Date: Fri, 05 Feb 2010 18:00:56 -0200
Message-ID: <1265400056-12904-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0034533031968982702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If it expires we call org.bluez.HandsfreeGateway.Disconnect()
---
 plugins/hfp.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index fe7b78b..02258b9 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -785,11 +785,31 @@ static int hfp_connect_ofono_handsfree(struct ofono_m=
odem *modem)
 				NULL, NULL, DBUS_TYPE_INVALID);
 }
 =

+static gboolean hfp_enable_timeout(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	int ret;
+
+	if (ofono_modem_get_powered(modem))
+		return FALSE;
+
+	ret =3D send_method_call(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "Disconnect",
+				NULL, NULL, DBUS_TYPE_INVALID);
+	if (ret < 0)
+		ofono_error("Disconnect failed(%d)", ret);
+
+	return FALSE;
+}
+
 /* power up hardware */
 static int hfp_enable(struct ofono_modem *modem)
 {
 	DBG("%p", modem);
 =

+	g_timeout_add_seconds(15, hfp_enable_timeout, modem);
+
 	if (hfp_connect_ofono_handsfree(modem) < 0)
 		return -EINVAL;
 =

-- =

1.6.4.4


--===============0034533031968982702==--


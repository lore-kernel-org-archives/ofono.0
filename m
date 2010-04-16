Content-Type: multipart/mixed; boundary="===============1054975473340755931=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix Let data device be optional for mbm driver
Date: Fri, 16 Apr 2010 13:33:55 +0800
Message-ID: <1271396035-15836-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1054975473340755931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dell 5530 modem has no data device port. So data device should be
optional in mbm drvier.
---
 plugins/mbm.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 439d3b9..aeea81d 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -84,7 +84,9 @@ static void mbm_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 =

-	g_at_chat_unref(data->data_port);
+	if (data->data_port)
+		g_at_chat_unref(data->data_port);
+
 	g_at_chat_unref(data->modem_port);
 	g_free(data);
 }
@@ -212,7 +214,7 @@ static int mbm_enable(struct ofono_modem *modem)
 =

 	DBG("%s, %s", modem_dev, data_dev);
 =

-	if (modem_dev =3D=3D NULL || data_dev =3D=3D NULL)
+	if (modem_dev =3D=3D NULL)
 		return -EINVAL;
 =

 	data->modem_port =3D create_port(modem_dev);
@@ -223,6 +225,9 @@ static int mbm_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->modem_port, mbm_debug, "Modem:");
 =

+	if (!data_dev)
+		goto done;
+
 	data->data_port =3D create_port(data_dev);
 =

 	if (data->data_port =3D=3D NULL) {
@@ -235,6 +240,7 @@ static int mbm_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->data_port, mbm_debug, "Data:");
 =

+done:
 	g_at_chat_register(data->modem_port, "*EMRDY:", emrdy_notifier,
 					FALSE, modem, NULL);
 =

@@ -257,9 +263,11 @@ static void cfun_disable(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	g_at_chat_unref(data->modem_port);
 	data->modem_port =3D NULL;
 =

-	g_at_chat_shutdown(data->data_port);
-	g_at_chat_unref(data->data_port);
-	data->data_port =3D NULL;
+	if (data->data_port) {
+		g_at_chat_shutdown(data->data_port);
+		g_at_chat_unref(data->data_port);
+		data->data_port =3D NULL;
+	}
 =

 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
-- =

1.6.6.1


--===============1054975473340755931==--


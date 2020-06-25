Content-Type: multipart/mixed; boundary="===============6355661806816149237=="
MIME-Version: 1.0
From: Jimmy Gysens <jimmy.gysens_ext@softathome.com>
Subject: [PATCH 2/2] huawei: reset function
Date: Thu, 25 Jun 2020 11:28:51 +0200
Message-ID: <20200625092851.4548-2-jimmy.gysens_ext@softathome.com>
In-Reply-To: <20200625092851.4548-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6355661806816149237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement the modem reset function for Huawei.

Huawei devices can be reset (reboot) by sending the AT^RESET command.
---
 plugins/huawei.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index bb876701..35195e2d 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -900,6 +900,30 @@ static void huawei_post_online(struct ofono_modem *mod=
em)
 	}
 }
 =

+static void reset_cb(gboolean ok, GAtResult *result,
+						gpointer user_data)
+{
+	if (!ok)
+		DBG("Failed to reset device");
+	else
+		DBG("Device resets shortly");
+}
+
+static int huawei_reset(struct ofono_modem *modem)
+{
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("Reset device: %p", modem);
+
+	if (g_at_chat_send(data->pcui, "AT^RESET", NULL,
+			reset_cb, NULL, NULL) =3D=3D FALSE) {
+		DBG("Failed to send reset command");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static struct ofono_modem_driver huawei_driver =3D {
 	.name		=3D "huawei",
 	.probe		=3D huawei_probe,
@@ -910,6 +934,7 @@ static struct ofono_modem_driver huawei_driver =3D {
 	.pre_sim	=3D huawei_pre_sim,
 	.post_sim	=3D huawei_post_sim,
 	.post_online	=3D huawei_post_online,
+	.reset		=3D huawei_reset,
 };
 =

 static int huawei_init(void)
-- =

2.17.1

--===============6355661806816149237==--


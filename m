Content-Type: multipart/mixed; boundary="===============7740004009250930138=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] plugins/ril: complete modem power off process
Date: Thu, 12 May 2016 13:51:03 +0800
Message-ID: <1463032263-6366-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7740004009250930138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: caiwen Zhang <caiwen.zhang@intel.com>

---
 plugins/ril.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/plugins/ril.c b/plugins/ril.c
index 2298bb6..2ea3fb5 100644
--- a/plugins/ril.c
+++ b/plugins/ril.c
@@ -409,15 +409,30 @@ int ril_enable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+static void power_off_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ril_data *rd =3D cbd->user;
+	struct ofono_modem *modem =3D cbd->data;
+
+	if (rd) {
+		g_ril_unref(rd->ril);
+		rd->ril =3D NULL;
+	}
+
+	ofono_modem_set_powered(modem, FALSE);
+}
+
 int ril_disable(struct ofono_modem *modem)
 {
 	struct ril_data *rd =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(NULL, modem, rd);
 =

 	DBG("%p", modem);
 =

-	ril_send_power(rd, FALSE, NULL, NULL);
+	ril_send_power(rd, FALSE, power_off_cb, cbd);
 =

-	return 0;
+	return -EINPROGRESS;
 }
 =

 static struct ofono_modem_driver ril_driver =3D {
-- =

2.7.4


--===============7740004009250930138==--


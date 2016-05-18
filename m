Content-Type: multipart/mixed; boundary="===============5848161068620065164=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] ril_sofia3gr: ril power off process extended
Date: Wed, 18 May 2016 20:02:38 +0530
Message-ID: <1463581958-6665-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5848161068620065164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ril_sofia3gr.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/plugins/ril_sofia3gr.c b/plugins/ril_sofia3gr.c
index 8631454..ce29d13 100644
--- a/plugins/ril_sofia3gr.c
+++ b/plugins/ril_sofia3gr.c
@@ -255,14 +255,24 @@ static int ril_enable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+static void ril_send_power_off_cb(struct ril_msg *message, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D (struct ofono_modem *) user_data;
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+
+	g_ril_unref(rd->ril);
+
+	ofono_modem_set_powered(modem, FALSE);
+}
+
 static int ril_disable(struct ofono_modem *modem)
 {
 	struct ril_data *rd =3D ofono_modem_get_data(modem);
 =

 	DBG("%p", modem);
-	ril_send_power(rd->ril, FALSE, NULL, NULL, NULL);
+	ril_send_power(rd->ril, FALSE, ril_send_power_off_cb, modem, NULL);
 =

-	return 0;
+	return -EINPROGRESS;
 }
 =

 static struct ofono_modem_driver ril_driver =3D {
-- =

1.9.1


--===============5848161068620065164==--


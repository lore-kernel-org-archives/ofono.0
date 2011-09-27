Content-Type: multipart/mixed; boundary="===============8516581249491201543=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 11/21] sap: add post_sim handling
Date: Tue, 27 Sep 2011 18:04:10 -0300
Message-ID: <1317157460-17012-11-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-10-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8516581249491201543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    1 +
 plugins/sap.c       |    4 ++++
 plugins/telit.c     |   13 +++++++++++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 257f092..8fe4093 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -47,6 +47,7 @@ struct bluetooth_sap_driver {
 	const char *name;
 	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem);
 	void (*pre_sim) (struct ofono_modem *modem);
+	void (*post_sim) (struct ofono_modem *modem);
 	void (*set_online) (struct ofono_modem *modem, ofono_bool_t online,
 				ofono_modem_online_cb_t cb, void *user_data);
 	int (*disable) (struct ofono_modem *modem);
diff --git a/plugins/sap.c b/plugins/sap.c
index 1713d4c..309028b 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -301,7 +301,11 @@ static void sap_pre_sim(struct ofono_modem *modem)
 =

 static void sap_post_sim(struct ofono_modem *modem)
 {
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
+
+	data->sap_driver->post_sim(data->hw_modem);
 }
 =

 static void sap_set_online(struct ofono_modem *modem, ofono_bool_t online,
diff --git a/plugins/telit.c b/plugins/telit.c
index da89b1c..7687162 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -378,6 +378,18 @@ static void telit_pre_sim(struct ofono_modem *modem)
 	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 }
 =

+static void telit_post_sim(struct ofono_modem *modem)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	if (data->sap_modem)
+		modem =3D data->sap_modem;
+
+	DBG("%p", modem);
+
+	ofono_sms_create(modem, 0, "atmodem", data->chat);
+}
+
 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
 	struct cb_data *cbd =3D user_data;
@@ -405,6 +417,7 @@ static struct bluetooth_sap_driver sap_driver =3D {
 	.name =3D "telit",
 	.enable =3D telit_sap_enable,
 	.pre_sim =3D telit_pre_sim,
+	.post_sim =3D telit_post_sim,
 	.set_online =3D telit_set_online,
 	.disable =3D telit_sap_disable,
 };
-- =

1.7.6.2


--===============8516581249491201543==--


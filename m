Content-Type: multipart/mixed; boundary="===============5067859374234794384=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 09/13] telit: add post_sim to SAP Client
Date: Wed, 28 Sep 2011 18:24:17 -0300
Message-ID: <1317245061-6312-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317245061-6312-8-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5067859374234794384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    1 +
 plugins/telit.c     |   22 +++++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 8e3fadd..a9d3683 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -48,6 +48,7 @@ struct bluetooth_sap_driver {
 	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem,
 								int bt_fd);
 	void (*pre_sim) (struct ofono_modem *modem);
+	void (*post_sim) (struct ofono_modem *modem);
 	int (*disable) (struct ofono_modem *modem);
 };
 =

diff --git a/plugins/telit.c b/plugins/telit.c
index 0d93a89..8fe421f 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -554,10 +554,23 @@ static void telit_pre_sim(struct ofono_modem *modem)
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
 static struct bluetooth_sap_driver sap_driver =3D {
 	.name =3D "telit",
 	.enable =3D telit_sap_enable,
 	.pre_sim =3D telit_pre_sim,
+	.post_sim =3D telit_post_sim,
 	.disable =3D telit_sap_disable,
 };
 =

@@ -617,15 +630,6 @@ static void telit_set_online(struct ofono_modem *modem=
, ofono_bool_t online,
 						cbd, g_free);
 }
 =

-static void telit_post_sim(struct ofono_modem *modem)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	ofono_sms_create(modem, 0, "atmodem", data->chat);
-}
-
 static void telit_post_online(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
-- =

1.7.6.2


--===============5067859374234794384==--


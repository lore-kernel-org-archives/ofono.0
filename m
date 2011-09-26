Content-Type: multipart/mixed; boundary="===============2318455965780290433=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 14/23] sap: add pre_sim handling
Date: Mon, 26 Sep 2011 14:27:07 -0300
Message-ID: <1317058036-32641-14-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317058036-32641-13-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2318455965780290433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    1 +
 plugins/sap.c       |    4 ++++
 plugins/telit.c     |   26 +++++++++++++++-----------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 1a7d120..ab81592 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -46,6 +46,7 @@ struct bluetooth_profile {
 struct bluetooth_sap_driver {
 	const char *name;
 	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem);
+	void (*pre_sim) (struct ofono_modem *modem);
 	int (*disable) (struct ofono_modem *modem);
 	int (*open) (struct ofono_modem *modem);
 };
diff --git a/plugins/sap.c b/plugins/sap.c
index 2caa10b..d9425d0 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -298,7 +298,11 @@ static int sap_disable(struct ofono_modem *modem)
 =

 static void sap_pre_sim(struct ofono_modem *modem)
 {
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
+
+	data->sap_driver->pre_sim(data->hw_modem);
 }
 =

 static void sap_post_sim(struct ofono_modem *modem)
diff --git a/plugins/telit.c b/plugins/telit.c
index 856230f..c116606 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -359,9 +359,24 @@ static int telit_sap_disable(struct ofono_modem *modem)
 	return 0;
 }
 =

+static void telit_pre_sim(struct ofono_modem *modem)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	if (data->sap_modem)
+		modem =3D data->sap_modem;
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
+	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
+	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+}
+
 static struct bluetooth_sap_driver sap_driver =3D {
 	.name =3D "telit",
 	.enable =3D telit_sap_enable,
+	.pre_sim =3D telit_pre_sim,
 	.disable =3D telit_sap_disable,
 	.open =3D telit_sap_open,
 };
@@ -454,17 +469,6 @@ static void telit_set_online(struct ofono_modem *modem=
, ofono_bool_t online,
 						cbd, g_free);
 }
 =

-static void telit_pre_sim(struct ofono_modem *modem)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
-	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
-}
-
 static void telit_post_sim(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
-- =

1.7.6.2


--===============2318455965780290433==--


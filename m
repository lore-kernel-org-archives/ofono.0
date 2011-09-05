Content-Type: multipart/mixed; boundary="===============5706937671220515869=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 14/20] sap: add pre_sim handling
Date: Mon, 05 Sep 2011 15:03:43 -0300
Message-ID: <1315245829-6887-15-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315245829-6887-14-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5706937671220515869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    1 +
 plugins/sap.c       |    9 +++++++++
 plugins/telit.c     |   26 +++++++++++++++-----------
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 26767b7..9850864 100644
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
index d92dc6a..53196f7 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -341,7 +341,16 @@ static int sap_disable(struct ofono_modem *modem)
 =

 static void sap_pre_sim(struct ofono_modem *modem)
 {
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+	struct bluetooth_sap_driver *sap_driver;
+
 	DBG("%p", modem);
+
+	sap_driver =3D g_hash_table_lookup(sap_hw_hash, data->hw_modem);
+	if (!sap_driver)
+		return;
+
+	sap_driver->pre_sim(data->hw_modem);
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

1.7.6.1


--===============5706937671220515869==--


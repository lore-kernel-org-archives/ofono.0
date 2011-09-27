Content-Type: multipart/mixed; boundary="===============6388739224094883913=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 09/21] sap: add pre_sim handling
Date: Tue, 27 Sep 2011 18:04:08 -0300
Message-ID: <1317157460-17012-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-8-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6388739224094883913==
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
index e66e179..740ecce 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -46,6 +46,7 @@ struct bluetooth_profile {
 struct bluetooth_sap_driver {
 	const char *name;
 	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem);
+	void (*pre_sim) (struct ofono_modem *modem);
 	int (*disable) (struct ofono_modem *modem);
 };
 =

diff --git a/plugins/sap.c b/plugins/sap.c
index 31b5f06..2a8b618 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -292,7 +292,11 @@ static int sap_disable(struct ofono_modem *modem)
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
index 55d01d6..6791c6e 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -364,9 +364,24 @@ static int telit_sap_disable(struct ofono_modem *modem)
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
 };
 =

@@ -458,17 +473,6 @@ static void telit_set_online(struct ofono_modem *modem=
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


--===============6388739224094883913==--


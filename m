Content-Type: multipart/mixed; boundary="===============1889312405395084836=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 08/13] telit: add pre_sim support to SAP Client
Date: Wed, 28 Sep 2011 18:24:16 -0300
Message-ID: <1317245061-6312-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317245061-6312-7-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1889312405395084836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    1 +
 plugins/telit.c     |   26 +++++++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index d38e72e..8e3fadd 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -47,6 +47,7 @@ struct bluetooth_sap_driver {
 	const char *name;
 	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem,
 								int bt_fd);
+	void (*pre_sim) (struct ofono_modem *modem);
 	int (*disable) (struct ofono_modem *modem);
 };
 =

diff --git a/plugins/telit.c b/plugins/telit.c
index f15a787..0d93a89 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -540,9 +540,24 @@ static int telit_sap_disable(struct ofono_modem *modem)
 	return -EINPROGRESS;
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

@@ -602,17 +617,6 @@ static void telit_set_online(struct ofono_modem *modem=
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


--===============1889312405395084836==--


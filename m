Content-Type: multipart/mixed; boundary="===============7508015532697487281=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 12/13] sap: add full support to SAP modem
Date: Wed, 28 Sep 2011 18:24:20 -0300
Message-ID: <1317245061-6312-12-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317245061-6312-11-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7508015532697487281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Add pre_sim, post_sim, set_online and post_online calls
---
 plugins/sap.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 7bb776a..1f760be 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -203,12 +203,39 @@ static int sap_disable(struct ofono_modem *modem)
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
 {
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->sap_driver->post_sim(data->hw_modem);
+}
+
+static void sap_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->sap_driver->set_online(data->hw_modem, online, cb, user_data);
+}
+
+static void sap_post_online(struct ofono_modem *modem)
+{
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
+
+	data->sap_driver->post_online(data->hw_modem);
 }
 =

 static int bluetooth_sap_probe(const char *device, const char *dev_addr,
@@ -288,6 +315,8 @@ static struct ofono_modem_driver sap_driver =3D {
 	.disable	=3D sap_disable,
 	.pre_sim	=3D sap_pre_sim,
 	.post_sim	=3D sap_post_sim,
+	.set_online	=3D sap_set_online,
+	.post_online	=3D sap_post_online,
 };
 =

 static struct bluetooth_profile sap =3D {
-- =

1.7.6.2


--===============7508015532697487281==--


Content-Type: multipart/mixed; boundary="===============6585394636254739502=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] mbm: add quirks for Dell D5530
Date: Wed, 25 Aug 2010 19:16:21 +0300
Message-ID: <1282752981-27284-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6585394636254739502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Dell D5530 is an OEM version of F3507g. It has an annoying habit of
announcing itself to world with its own name. It also crashes upon
processing received cbs messages.
---
 plugins/mbm.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
--
 1 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index c9b0ea4..1c2b9a8 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -53,9 +53,15 @@ static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

+enum mbm_variant {
+	MBM_GENERIC,
+	MBM_DELL_D5530,		/* OEM of F3507g */
+};
+
 struct mbm_data {
 	GAtChat *modem_port;
 	GAtChat *data_port;
+	enum mbm_variant variant;
 	guint poll_source;
 	guint poll_count;
 	gboolean have_sim;
@@ -137,9 +143,50 @@ static gboolean init_simpin_check(gpointer user_data)
 	return FALSE;
 }
 =

+static void d5530_notify(GAtResult *result, gpointer user_data)
+{
+	DBG("D5530");
+}
+
+static void mbm_quirk_d5530(struct ofono_modem *modem)
+{
+	struct mbm_data *data =3D ofono_modem_get_data(modem);
+
+	data->variant =3D MBM_DELL_D5530;
+
+	g_at_chat_register(data->modem_port, "D5530", d5530_notify,
+				FALSE, NULL, NULL);
+}
+
+static void mbm_check_model(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	GAtResultIter iter;
+	char const *model =3D "";
+
+	DBG("");
+
+	if (!ok)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, NULL)) {
+		if (!g_at_result_iter_next_unquoted_string(&iter, &model))
+			continue;
+
+		if (g_str_equal(model, "D5530"))
+			mbm_quirk_d5530(modem);
+	}
+
+done:
+	init_simpin_check(modem);
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct mbm_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("");
 =

@@ -148,7 +195,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		return;
 	}
 =

-	init_simpin_check(modem);
+	g_at_chat_send(data->modem_port, "AT+CGMM", NULL,
+			mbm_check_model, modem, NULL);
 }
 =

 static void cfun_query(gboolean ok, GAtResult *result, gpointer user_data)
@@ -426,7 +474,10 @@ static void mbm_post_online(struct ofono_modem *modem)
 					"atmodem", data->modem_port);
 =

 	ofono_sms_create(modem, 0, "atmodem", data->modem_port);
-	ofono_cbs_create(modem, 0, "atmodem", data->modem_port);
+
+	if (data->variant !=3D MBM_DELL_D5530)
+		ofono_cbs_create(modem, 0, "atmodem", data->modem_port);
+
 	ofono_ussd_create(modem, 0, "atmodem", data->modem_port);
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
-- =

1.7.0.4


--===============6585394636254739502==--


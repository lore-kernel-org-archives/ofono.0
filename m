Content-Type: multipart/mixed; boundary="===============0440800085302083765=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] mbm: add quirks for Dell D5530
Date: Wed, 25 Aug 2010 20:13:16 +0300
Message-ID: <1282756396-9714-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0440800085302083765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Dell D5530 is an OEM version of F3507g. It has an annoying habit of
announcing itself to world with its own name. Another problem is some weird
+CGAP messages at the same time. It also crashes upon processing received
CBS messages.
---
 plugins/mbm.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 8541aaf..cc3a0f5 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -52,12 +52,18 @@ static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
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
 	guint cpin_poll_source;
 	guint cpin_poll_count;
 	gboolean have_sim;
+	enum mbm_variant variant;
 };
 =

 static int mbm_probe(struct ofono_modem *modem)
@@ -136,9 +142,54 @@ static gboolean init_simpin_check(gpointer user_data)
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
+	/* This Dell modem sends some unsolicated messages when it boots. */
+	/* Try to ignore them. */
+	g_at_chat_register(data->modem_port, "D5530", d5530_notify,
+				FALSE, NULL, NULL);
+	g_at_chat_register(data->modem_port, "+CGAP:", d5530_notify,
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

@@ -147,7 +198,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
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
@@ -353,7 +405,15 @@ static void mbm_post_sim(struct ofono_modem *modem)
 					"atmodem", data->modem_port);
 =

 	ofono_sms_create(modem, 0, "atmodem", data->modem_port);
-	ofono_cbs_create(modem, 0, "atmodem", data->modem_port);
+
+	switch (data->variant) {
+	case MBM_DELL_D5530:
+		/* DELL D5530 crashes when it processes CBSs */
+		break;
+	default:
+		ofono_cbs_create(modem, 0, "atmodem", data->modem_port);
+	}
+
 	ofono_ussd_create(modem, 0, "atmodem", data->modem_port);
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
-- =

1.7.0.4


--===============0440800085302083765==--


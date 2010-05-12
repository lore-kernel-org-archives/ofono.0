Content-Type: multipart/mixed; boundary="===============1982404058372180888=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/4] mbm: Check there's a SIM card inserted.
Date: Wed, 12 May 2010 03:22:38 +0200
Message-ID: <1273627358-7408-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1982404058372180888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbm.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 3a87f79..bb9e212 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -55,11 +55,13 @@
 #include <drivers/atmodem/vendor.h>
 =

 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
+static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct mbm_data {
 	GAtChat *modem_port;
 	GAtChat *data_port;
+	gboolean have_sim;
 };
 =

 static int mbm_probe(struct ofono_modem *modem)
@@ -97,18 +99,51 @@ static void mbm_debug(const char *str, void *user_data)
 	ofono_info("%s %s", prefix, str);
 }
 =

-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+static void status_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct mbm_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	gint sw[2];
 =

 	DBG("");
 =

 	if (!ok)
-		ofono_modem_set_powered(modem, FALSE);
+		goto poweron;
+
+	/* Modem fakes a 94 04 response from card (File Id not found /
+	 * Pattern not found) when there's no card in the slot.
+	 */
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CRSM:"))
+		goto poweron;
+
+	g_at_result_iter_next_number(&iter, &sw[0]);
+	g_at_result_iter_next_number(&iter, &sw[1]);
 =

+	data->have_sim =3D sw[0] !=3D 0x94 || sw[1] !=3D 0x04;
+
+poweron:
 	ofono_modem_set_powered(modem, TRUE);
 }
 =

+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct mbm_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (!ok) {
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	g_at_chat_send(data->modem_port, "AT+CRSM=3D242", crsm_prefix,
+			status_check, modem, NULL);
+}
+
 static void cfun_query(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -134,7 +169,7 @@ static void cfun_query(gboolean ok, GAtResult *result, =
gpointer user_data)
 		return;
 	}
 =

-	ofono_modem_set_powered(modem, TRUE);
+	cfun_enable(TRUE, NULL, modem);
 }
 =

 static void emrdy_notifier(GAtResult *result, gpointer user_data)
@@ -293,7 +328,7 @@ static void mbm_pre_sim(struct ofono_modem *modem)
 	ofono_voicecall_create(modem, 0, "atmodem", data->modem_port);
 	ofono_stk_create(modem, 0, "mbmmodem", data->modem_port);
 =

-	if (sim)
+	if (data->have_sim && sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-- =

1.6.1


--===============1982404058372180888==--


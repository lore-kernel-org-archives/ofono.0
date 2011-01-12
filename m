Content-Type: multipart/mixed; boundary="===============1648318030820194772=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] atmodem: Use +CUAD to list SIM applications.
Date: Wed, 12 Jan 2011 13:12:45 +0100
Message-ID: <1294834365-11029-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1294834365-11029-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1648318030820194772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Note that +CUAD just returns the contents of EFdir and reading
EFdir may be available on more modems than AT+CUAD is.
---
 drivers/atmodem/sim.c |  112 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 112 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 1653ede..2fb97f2 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -38,6 +38,7 @@
 #include "gatresult.h"
 #include "simutil.h"
 #include "vendor.h"
+#include "util.h"
 =

 #include "atmodem.h"
 =

@@ -53,6 +54,7 @@ struct sim_data {
 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *clck_prefix[] =3D { "+CLCK:", NULL };
+static const char *cuad_prefix[] =3D { "+CUAD:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -827,6 +829,115 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

+static void at_sim_list_apps_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_apps_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	GSList *apps =3D NULL;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CUAD:")) {
+		const guint8 *obj_str;
+		gint len;
+		struct ber_tlv_iter dataobj_iter;
+
+		if (!g_at_result_iter_next_hexstring(&iter, &obj_str, &len))
+			goto error;
+
+		ber_tlv_iter_init(&dataobj_iter, obj_str, len);
+
+		/* Find application template entries */
+		while (ber_tlv_iter_next(&dataobj_iter)) {
+			struct ber_tlv_iter value_iter;
+			struct ofono_sim_app_record app;
+
+			if (ber_tlv_iter_get_short_tag(&dataobj_iter) !=3D 0x61)
+				continue;
+
+			ber_tlv_iter_recurse(&dataobj_iter, &value_iter);
+
+			/* Find the aid (mandatory) */
+			if (!ber_tlv_iter_next(&value_iter))
+				goto error;
+			if (ber_tlv_iter_get_short_tag(&value_iter) !=3D 0x4f)
+				goto error;
+
+			app.aid_len =3D ber_tlv_iter_get_length(&value_iter);
+			if (app.aid_len < 0x01 || app.aid_len > 0x10)
+				goto error;
+
+			memcpy(app.aid,  ber_tlv_iter_get_data(&value_iter),
+					app.aid_len);
+
+			/* Find the label (optional) */
+			while (ber_tlv_iter_next(&value_iter)) {
+				if (ber_tlv_iter_get_short_tag(&value_iter) !=3D
+						0x50)
+					continue;
+
+				if (ber_tlv_iter_get_length(&value_iter) =3D=3D 0)
+					break;
+
+				/*
+				 * Label field uses the extra complicated
+				 * encoding in 102.221 Annex A
+				 */
+				app.label =3D sim_string_to_utf8(
+					ber_tlv_iter_get_data(&value_iter),
+					ber_tlv_iter_get_length(&value_iter));
+				if (app.label =3D=3D NULL)
+					goto error;
+
+				break;
+			}
+
+			apps =3D g_slist_prepend(apps,
+						g_memdup(&app, sizeof(app)));
+		}
+	}
+
+	cb(&error, g_slist_reverse(apps), cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+
+	while (apps) {
+		GSList *t =3D apps;
+
+		g_free(((struct ofono_sim_app_record *) apps->data)->label);
+
+		apps =3D apps->next;
+		g_slist_free_1(t);
+	}
+}
+
+static void at_sim_list_apps(struct ofono_sim *sim, ofono_sim_apps_cb_t cb,
+				void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (cbd && g_at_chat_send(sd->chat, "AT+CUAD", cuad_prefix,
+					at_sim_list_apps_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
 static gboolean at_sim_register(gpointer user)
 {
 	struct ofono_sim *sim =3D user;
@@ -891,6 +1002,7 @@ static struct ofono_sim_driver driver =3D {
 	.lock			=3D at_pin_enable,
 	.change_passwd		=3D at_change_passwd,
 	.query_locked		=3D at_pin_query_enabled,
+	.list_apps		=3D at_sim_list_apps,
 };
 =

 void at_sim_init()
-- =

1.7.1.86.g0e460.dirty


--===============1648318030820194772==--


Content-Type: multipart/mixed; boundary="===============0457149192294848793=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v2 1/2] cbs: add a mechniasm to split the topics list.
Date: Tue, 02 Aug 2011 16:33:38 +0200
Message-ID: <1312295619-29778-2-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312295619-29778-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0457149192294848793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/cbs.c |   97 +++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index e2e1ca4..4696f57 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -47,8 +47,13 @@ struct cbs_data {
 	GAtChat *chat;
 	gboolean cscb_mode_1;
 	unsigned int vendor;
+	unsigned int string_limit;
+	gchar *r_topics; /* remaining topics */
 };
 =

+static void at_cscb_set_cb_split(gboolean ok, GAtResult *result,
+					gpointer user_data);
+
 static void at_cbm_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_cbs *cbs =3D user_data;
@@ -105,15 +110,82 @@ static void at_cscb_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	cb(&error, cbd->data);
 }
 =

+static guint send_topics(struct cbs_data *data, struct cb_data *cbd)
+{
+	char *buf;
+	unsigned int id;
+
+	if (strlen(data->r_topics) > data->string_limit) {
+		gchar *old_rt =3D data->r_topics;
+		gchar *topics_split =3D g_strndup(data->r_topics,
+							data->string_limit);
+
+		if (data->r_topics[data->string_limit] !=3D ',') {
+			char *token =3D strrchr(topics_split, ',');
+			*token =3D 0;
+		}
+
+		data->r_topics =3D g_strdup((char *) ((void *) old_rt +
+						strlen(topics_split) + 1));
+
+		g_free(old_rt);
+
+		buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", topics_split);
+
+		id =3D g_at_chat_send(data->chat, buf, none_prefix,
+				at_cscb_set_cb_split, cbd, NULL);
+
+		g_free(topics_split);
+	} else {
+		buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", data->r_topics);
+
+		id =3D g_at_chat_send(data->chat, buf, none_prefix,
+				at_cscb_set_cb, cbd, g_free);
+
+		g_free(data->r_topics);
+	}
+
+	g_free(buf);
+
+	return id;
+}
+
+static void at_cscb_set_cb_split(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_cbs_set_cb_t cb =3D cbd->cb;
+	struct cbs_data *data =3D ofono_cbs_get_data(cbd->user);
+	struct ofono_error error;
+
+	DBG("%s", data->r_topics);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		g_at_chat_send(data->chat, "AT+CSCB=3D1", none_prefix,
+				NULL, NULL, NULL);
+
+		cb(&error, cbd->data);
+		return;
+	}
+
+	if (send_topics(data, cbd) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
 static void at_cbs_set_topics(struct ofono_cbs *cbs, const char *topics,
 				ofono_cbs_set_cb_t cb, void *user_data)
 {
 	struct cbs_data *data =3D ofono_cbs_get_data(cbs);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	char *buf;
 	unsigned int id;
 =

-	DBG("");
+	DBG("%s", topics);
 =

 	/* For the Qualcomm based devices it is required to clear
 	 * the list of topics first.  Otherwise setting the new
@@ -128,16 +200,29 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, =
const char *topics,
 		g_at_chat_send(data->chat, "AT+CSCB=3D1", none_prefix,
 				NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_ZTE:
+		data->string_limit =3D 50;
+		g_at_chat_send(data->chat, "AT+CSCB=3D1", none_prefix,
+				NULL, NULL, NULL);
+		break;
 	default:
 		break;
 	}
 =

-	buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", topics);
+	if (data->string_limit && strlen(topics) > data->string_limit) {
+		data->r_topics =3D g_strdup(topics);
+
+		cbd->user =3D cbs;
 =

-	id =3D g_at_chat_send(data->chat, buf, none_prefix,
+		id =3D send_topics(data, cbd);
+	} else {
+		char *buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", topics);
+
+		id =3D g_at_chat_send(data->chat, buf, none_prefix,
 				at_cscb_set_cb, cbd, g_free);
 =

-	g_free(buf);
+		g_free(buf);
+	}
 =

 	if (id > 0)
 		return;
@@ -240,6 +325,8 @@ static int at_cbs_probe(struct ofono_cbs *cbs, unsigned=
 int vendor,
 	data =3D g_new0(struct cbs_data, 1);
 	data->chat =3D g_at_chat_clone(chat);
 	data->vendor =3D vendor;
+	data->string_limit =3D 0;
+	data->r_topics =3D NULL;
 =

 	ofono_cbs_set_data(cbs, data);
 =

-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============0457149192294848793==--


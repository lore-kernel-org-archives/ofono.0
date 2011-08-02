Content-Type: multipart/mixed; boundary="===============3889068305107720965=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 1/2] cbs: split the topics list for ZTE modem.
Date: Tue, 02 Aug 2011 09:35:24 +0200
Message-ID: <1312270525-14045-2-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312270525-14045-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3889068305107720965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/cbs.c |   86 +++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index e2e1ca4..3c250d2 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -47,6 +47,8 @@ struct cbs_data {
 	GAtChat *chat;
 	gboolean cscb_mode_1;
 	unsigned int vendor;
+	unsigned int string_limit;
+	gchar *rt; /* remaining topics */
 };
 =

 static void at_cbm_notify(GAtResult *result, gpointer user_data)
@@ -105,6 +107,56 @@ static void at_cscb_set_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	cb(&error, cbd->data);
 }
 =

+static void at_cscb_set_cb_split(gboolean ok, GAtResult *result, gpointer =
user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct cbs_data *data =3D ofono_cbs_get_data(cbd->user);
+	ofono_cbs_set_cb_t cb =3D cbd->cb;
+	char *buf;
+	unsigned int id;
+
+	DBG("%s", data->rt);
+
+	if (strlen(data->rt) > data->string_limit) {
+		gchar *topics_split  =3D g_strndup(data->rt, data->string_limit);
+		gchar *new_rt;
+
+		if (data->rt[data->string_limit] !=3D ',') {
+			char *token =3D strrchr(topics_split, ',');
+			*token =3D 0;
+		}
+
+		new_rt =3D g_strdup((char *) ((void *) data->rt +
+						strlen(topics_split) + 1));
+
+		g_free(data->rt);
+		data->rt =3D new_rt;
+
+		buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", topics_split);
+
+		id =3D g_at_chat_send(data->chat, buf, none_prefix,
+				at_cscb_set_cb_split, cbd, NULL);
+
+		g_free(topics_split);
+	} else {
+		buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", data->rt);
+
+		id =3D g_at_chat_send(data->chat, buf, none_prefix,
+				at_cscb_set_cb, cbd, NULL);
+
+		g_free(data->rt);
+	}
+
+	g_free(buf);
+
+	if (id > 0)
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
@@ -113,7 +165,7 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, co=
nst char *topics,
 	char *buf;
 	unsigned int id;
 =

-	DBG("");
+	DBG("%s", topics);
 =

 	/* For the Qualcomm based devices it is required to clear
 	 * the list of topics first.  Otherwise setting the new
@@ -128,14 +180,40 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, =
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
+		gchar *topics_split =3D g_strndup(topics, data->string_limit);
+
+		if (topics[data->string_limit] !=3D ',') {
+			char *token =3D strrchr(topics_split, ',');
+			*token =3D 0;
+		}
+
+		data->rt =3D g_strdup((char *) ((void *) topics +
+						strlen(topics_split) + 1));
+
+		cbd->user =3D cbs;
 =

-	id =3D g_at_chat_send(data->chat, buf, none_prefix,
+		buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", topics_split);
+
+		id =3D g_at_chat_send(data->chat, buf, none_prefix,
+				at_cscb_set_cb_split, cbd, NULL);
+
+		g_free(topics_split);
+	} else {
+		buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", topics);
+
+		id =3D g_at_chat_send(data->chat, buf, none_prefix,
 				at_cscb_set_cb, cbd, g_free);
+	}
 =

 	g_free(buf);
 =

@@ -240,6 +318,8 @@ static int at_cbs_probe(struct ofono_cbs *cbs, unsigned=
 int vendor,
 	data =3D g_new0(struct cbs_data, 1);
 	data->chat =3D g_at_chat_clone(chat);
 	data->vendor =3D vendor;
+	data->string_limit =3D 0;
+	data->rt =3D NULL;
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

--===============3889068305107720965==--


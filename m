Content-Type: multipart/mixed; boundary="===============7976719015630767199=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 1/2] cbs: send topics one by one for ZTE modem.
Date: Mon, 01 Aug 2011 11:27:01 +0200
Message-ID: <1312190822-30726-2-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312190822-30726-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7976719015630767199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/cbs.c |   58 ++++++++++++++++++++++++++++++++++++++++++---=
---
 1 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index e2e1ca4..4673a77 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -109,9 +109,9 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, co=
nst char *topics,
 				ofono_cbs_set_cb_t cb, void *user_data)
 {
 	struct cbs_data *data =3D ofono_cbs_get_data(cbs);
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 	char *buf;
-	unsigned int id;
+	unsigned int id =3D 0;
+	gboolean send_by_one =3D FALSE;
 =

 	DBG("");
 =

@@ -125,6 +125,7 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, co=
nst char *topics,
 	switch (data->vendor) {
 	case OFONO_VENDOR_GOBI:
 	case OFONO_VENDOR_QUALCOMM_MSM:
+	case OFONO_VENDOR_ZTE:
 		g_at_chat_send(data->chat, "AT+CSCB=3D1", none_prefix,
 				NULL, NULL, NULL);
 		break;
@@ -132,17 +133,58 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, =
const char *topics,
 		break;
 	}
 =

-	buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", topics);
+	/* Some ZTE modem doesn't support sending a long AT command
+	 * so we send topics one by one
+	 */
+	switch (data->vendor) {
+	case OFONO_VENDOR_ZTE:
+		send_by_one =3D TRUE;
+		break;
+	default:
+		break;
+	}
+
+	if (send_by_one) {
+		gchar **topic_list =3D NULL;
+		gchar **topic_list_orig =3D NULL;
+
+		topic_list =3D topic_list_orig =3D g_strsplit_set(topics, ",", -1);
+
+		for (; *topic_list; topic_list++) {
+			struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+			buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", *topic_list);
 =

-	id =3D g_at_chat_send(data->chat, buf, none_prefix,
+			id =3D g_at_chat_send(data->chat, buf, none_prefix,
 				at_cscb_set_cb, cbd, g_free);
 =

-	g_free(buf);
+			g_free(buf);
 =

-	if (id > 0)
-		return;
+			if (id > 0)
+				continue;
 =

-	g_free(cbd);
+			g_free(cbd);
+		}
+
+		g_strfreev(topic_list_orig);
+
+		if (id > 0)
+			return;
+	} else {
+		struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+		buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", topics);
+
+		id =3D g_at_chat_send(data->chat, buf, none_prefix,
+				at_cscb_set_cb, cbd, g_free);
+
+		g_free(buf);
+
+		if (id > 0)
+			return;
+
+		g_free(cbd);
+	}
 =

 	CALLBACK_WITH_FAILURE(cb, user_data);
 }
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

--===============7976719015630767199==--


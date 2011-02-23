Content-Type: multipart/mixed; boundary="===============7557977855168485913=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 13/18] isimodem: wgmodem2.5 added to call-forwarding
Date: Wed, 23 Feb 2011 12:43:24 +0100
Message-ID: <729f5e23ade7cf4d4de814b693996cb05b244a13.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7557977855168485913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/call-forwarding.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index 89a03dc..687f975 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -46,6 +46,7 @@
 =

 struct forw_data {
 	GIsiClient *client;
+	GIsiVersion version;
 };
 =

 struct forw_info {
@@ -230,11 +231,15 @@ static void isi_registration(struct ofono_call_forwar=
ding *cf, int type,
 	/* Followed by number in UCS-2, zero sub address bytes, and 0
 	 * to 3 bytes of filler */
 =

-	DBG("forwarding type %d class %d\n", type, cls);
 =

 	if (cbd =3D=3D NULL || fd =3D=3D NULL || strlen(number->number) > 28)
 		goto error;
 =

+	DBG("forwarding type %d class %d\n", type, cls);
+
+	if (fd->version.major =3D=3D 14 && fd->version.minor >=3D 1)
+		msg[10] =3D SS_UNDEFINED_TIME;
+
 	ss_code =3D forw_type_to_isi_code(type);
 	if (ss_code < 0)
 		goto error;
@@ -248,6 +253,10 @@ static void isi_registration(struct ofono_call_forward=
ing *cf, int type,
 =

 	msg[8]  =3D 6 + 2 * strlen(number->number) + num_filler;
 =

+	/* Time must not be set for any other than NoReply for ISI2.5 */
+	if (ss_code =3D=3D SS_GSM_FORW_NO_REPLY)
+		msg[10] =3D time;
+
 	ucs2 =3D g_convert(number->number, strlen(number->number), "UCS-2BE",
 				"UTF-8//TRANSLIT", NULL, NULL, NULL);
 	if (ucs2 =3D=3D NULL)
@@ -330,9 +339,10 @@ error:
 =

 static void query_resp_cb(const GIsiMessage *msg, void *data)
 {
-
 	struct isi_cb_data *cbd =3D data;
 	ofono_call_forwarding_query_cb_t cb =3D cbd->cb;
+	struct ofono_call_forwarding *cf =3D cbd->user;
+	struct forw_data *fd =3D ofono_call_forwarding_get_data(cf);
 	GIsiSubBlockIter iter;
 =

 	struct ofono_call_forwarding_condition list =3D {
@@ -366,8 +376,14 @@ static void query_resp_cb(const GIsiMessage *msg, void=
 *data)
 						&number))
 			goto error;
 =

-		/* As in 27.007 section 7.11 */
-		list.status =3D status & SS_GSM_ACTIVE;
+		if (fd->version.major =3D=3D 14 && fd->version.minor >=3D 1) {
+			list.status =3D status & (SS_GSM_ACTIVE |
+						SS_GSM_REGISTERED |
+						SS_GSM_PROVISIONED);
+		} else {
+			/* As in 27.007 section 7.11 */
+			list.status =3D status & SS_GSM_ACTIVE;
+		}
 		list.time =3D noreply;
 		list.phone_number.type =3D ton | 0x80;
 =

@@ -426,12 +442,16 @@ error:
 static void reachable_cb(const GIsiMessage *msg, void *data)
 {
 	struct ofono_call_forwarding *cf =3D data;
+	struct forw_data *fd =3D ofono_call_forwarding_get_data(cf);
 =

 	if (g_isi_msg_error(msg) < 0)
 		return;
 =

 	ISI_VERSION_DBG(msg);
 =

+	fd->version.major =3D g_isi_msg_version_major(msg);
+	fd->version.minor =3D g_isi_msg_version_minor(msg);
+
 	ofono_call_forwarding_register(cf);
 }
 =

@@ -447,6 +467,7 @@ static int isi_call_forwarding_probe(struct ofono_call_=
forwarding *cf,
 		return -ENOMEM;
 =

 	fd->client =3D g_isi_client_create(modem, PN_SS);
+
 	if (fd->client =3D=3D NULL) {
 		g_free(fd);
 		return -ENOMEM;
-- =

1.7.3.5


--===============7557977855168485913==--


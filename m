Content-Type: multipart/mixed; boundary="===============2908403925100472698=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 11/18] isimodem: wgmodem2.5 support in USSD
Date: Wed, 23 Feb 2011 12:43:22 +0100
Message-ID: <3c5684049496d2ce79407863042bee8dc2dcfe1e.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2908403925100472698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/ussd.c |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index d649484..ce402f1 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -55,6 +55,7 @@ struct ussd_info {
 =

 struct ussd_data {
 	GIsiClient *client;
+	GIsiVersion version;
 	int mt_session;
 };
 =

@@ -166,7 +167,10 @@ static void isi_request(struct ofono_ussd *ussd, int d=
cs,
 {
 	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(ussd, cb, data);
-	const uint8_t msg[] =3D {
+	const uint8_t padding_bytes[] =3D {0, 0, 0, 0, 0, 0, 0, 0};
+	uint8_t iov_size =3D 2;
+
+	uint8_t msg[] =3D {
 		SS_GSM_USSD_SEND_REQ,
 		ud->mt_session
 		? SS_GSM_USSD_MT_REPLY
@@ -178,15 +182,31 @@ static void isi_request(struct ofono_ussd *ussd, int =
dcs,
 		len,		/* string length */
 		/* USSD string goes here */
 	};
-	const struct iovec iov[2] =3D {
-		{ (uint8_t *) msg, sizeof(msg) },
-		{ (uint8_t *) pdu, len }
-	};
+	struct iovec iov[3] =3D { { 0, 0 }, { 0, 0 }, { 0, 0 } };
 =

 	if (cbd =3D=3D NULL || ud =3D=3D NULL)
 		goto error;
 =

-	if (g_isi_client_vsend(ud->client, iov, 2,
+	if (ud->version.major =3D=3D 14 && ud->version.minor >=3D 1) {
+		uint8_t filled_len =3D (4 + len + 3) & ~3;
+		struct iovec t_iov[3] =3D {
+			{ (uint8_t *) msg, sizeof(msg) },
+			{ (uint8_t *)pdu, len },
+			{ (uint8_t *) padding_bytes, (filled_len - len - 4) }
+		};
+		iov_size =3D 3;
+		memmove(iov, t_iov, sizeof(struct iovec) * iov_size);
+
+		msg[4] =3D filled_len;
+	} else {
+		struct iovec t_iov[2] =3D {
+			{ (uint8_t *) msg, sizeof(msg) },
+			{ (uint8_t *) pdu, len }
+		};
+		memmove(iov, t_iov, sizeof(struct iovec) * iov_size);
+	}
+
+	if (g_isi_client_vsend(ud->client, iov, iov_size,
 				ussd_send_resp_cb, cbd, g_free))
 		return;
 =

@@ -228,6 +248,9 @@ static void ussd_reachable_cb(const GIsiMessage *msg, v=
oid *data)
 =

 	ISI_VERSION_DBG(msg);
 =

+	ud->version.major =3D g_isi_msg_version_major(msg);
+	ud->version.minor =3D g_isi_msg_version_minor(msg);
+
 	g_isi_client_ind_subscribe(ud->client, SS_GSM_USSD_RECEIVE_IND,
 					ussd_ind_cb, ussd);
 =

@@ -241,6 +264,7 @@ static int isi_ussd_probe(struct ofono_ussd *ussd, unsi=
gned int vendor,
 	struct ussd_data *ud;
 =

 	ud =3D g_try_new0(struct ussd_data, 1);
+
 	if (ud =3D=3D NULL)
 		return -ENOMEM;
 =

-- =

1.7.3.5


--===============2908403925100472698==--


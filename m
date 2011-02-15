Content-Type: multipart/mixed; boundary="===============8978919057580371964=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 12/18] isimodem: wgmodem2.5 support in USSD
Date: Tue, 15 Feb 2011 13:31:06 +0100
Message-ID: <700976de94d8b99393efdd1e8c520ba41d69bba9.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8978919057580371964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/ussd.c |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index d649484..abc6e09 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -166,7 +166,11 @@ static void isi_request(struct ofono_ussd *ussd, int d=
cs,
 {
 	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(ussd, cb, data);
-	const uint8_t msg[] =3D {
+	const uint8_t padding_bytes[] =3D {0, 0, 0, 0, 0, 0, 0, 0};
+	GIsiModem *modem;
+	uint8_t iov_size =3D 2;
+
+	uint8_t msg[] =3D {
 		SS_GSM_USSD_SEND_REQ,
 		ud->mt_session
 		? SS_GSM_USSD_MT_REPLY
@@ -178,15 +182,34 @@ static void isi_request(struct ofono_ussd *ussd, int =
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
+	modem =3D g_isi_client_modem(ud->client);
+
+	if (g_isi_modem_version_major(modem) =3D=3D 2 &&
+		g_isi_modem_version_minor(modem) >=3D 0) {
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


--===============8978919057580371964==--


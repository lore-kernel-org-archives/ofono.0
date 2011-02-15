Content-Type: multipart/mixed; boundary="===============5459548138652430087=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 11/18] isimodem: gprs-context updates wgmodem2.5
Date: Tue, 15 Feb 2011 13:31:05 +0100
Message-ID: <79c722cc404870768dc3e5352fa9bc6d73074cde.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5459548138652430087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/gprs-context.c |   95 +++++++++++++++++++++++++----------=
---
 1 files changed, 62 insertions(+), 33 deletions(-)

diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index 6d579d8..f458fcc 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -347,32 +347,52 @@ static void send_context_authenticate(GIsiClient *cli=
ent, void *opaque)
 	struct context_data *cd =3D opaque;
 	size_t username_len =3D strlen(cd->username);
 	size_t password_len =3D strlen(cd->password);
+	size_t sb_user_info_len =3D (3 + username_len + 3) & ~3;
+	size_t fill_sb_user_info_count =3D
+			sb_user_info_len - (3 + username_len);
+	uint8_t *fill_sb_user_info_data =3D
+			g_try_malloc0(fill_sb_user_info_count);
+	size_t sb_password_info_len =3D (3 + password_len + 3) & ~3;
+	size_t fill_sb_password_info_count =3D
+			sb_user_info_len - (3 + password_len);
+	uint8_t *fill_sb_password_info_data =3D
+			g_try_malloc0(fill_sb_password_info_count);
 =

 	const unsigned char top[] =3D {
 		GPDS_CONTEXT_AUTH_REQ,
 		cd->handle,
 		2,	/* sub blocks */
 		GPDS_USER_NAME_INFO,
-		3 + username_len + 3,
+		sb_user_info_len,
 		username_len,
 		/* Username goes here */
 	};
 =

 	const unsigned char bottom[] =3D {
 		GPDS_PASSWORD_INFO,
-		3 + password_len + 3,
+		sb_password_info_len,
 		password_len,
 		/* Password goes here */
 	};
 =

-	const struct iovec iov[4] =3D {
-		{ (uint8_t *) top, sizeof(top) },
+	const struct iovec iov[6] =3D {
+		{ (uint8_t *)top, sizeof(top) },
 		{ cd->username, username_len },
-		{ (uint8_t *) bottom, sizeof(bottom) },
+		{ fill_sb_user_info_data, fill_sb_user_info_count },
+		{ (uint8_t *)bottom, sizeof(bottom) },
 		{ cd->password, password_len },
+		{ fill_sb_password_info_data, fill_sb_password_info_count},
 	};
 =

-	if (!g_isi_client_vsend(client, iov, 4, context_auth_cb, cd, NULL))
+	if (fill_sb_user_info_data =3D=3D NULL
+			&& fill_sb_user_info_count > 0)
+		gprs_up_fail(cd);
+
+	if (fill_sb_password_info_data =3D=3D NULL
+			&& fill_sb_password_info_count > 0)
+		gprs_up_fail(cd);
+
+	if (!g_isi_client_vsend(client, iov, 6, context_auth_cb, cd, NULL))
 		gprs_up_fail(cd);
 }
 =

@@ -393,34 +413,43 @@ static void link_conf_cb(const GIsiMessage *msg, void=
 *opaque)
 {
 	struct context_data *cd =3D opaque;
 	size_t apn_len =3D strlen(cd->apn);
+	size_t sb_apn_info_len =3D (3 + apn_len + 3) & ~3;
+	size_t fill_count =3D sb_apn_info_len - (3 + apn_len);
+	uint8_t *fill_data =3D g_try_malloc0(fill_count);
+
+	if (fill_data =3D=3D NULL && fill_count > 0)
+		return gprs_up_fail(cd);
+
+	if (check_resp(msg, GPDS_LL_CONFIGURE_RESP, 2, cd, gprs_up_fail)) {
+
+		const unsigned char msg[] =3D {
+			GPDS_CONTEXT_CONFIGURE_REQ,
+			cd->handle,	/* context ID */
+			cd->type,	/* PDP type */
+			GPDS_CONT_TYPE_NORMAL,
+			cd->handle,	/* primary context ID */
+			0x00,		/* filler */
+			2,		/* sub blocks */
+			GPDS_DNS_ADDRESS_REQ_INFO,
+			4,		/* subblock length */
+			0, 0,		/* padding */
+			GPDS_APN_INFO,
+			sb_apn_info_len,
+			apn_len,
+		};
+
+		const struct iovec iov[3] =3D {
+			{ (uint8_t *)msg, sizeof(msg) },
+			{ cd->apn, apn_len },
+			{ fill_data, fill_count}
+		};
+
+		if (!g_isi_client_vsend_with_timeout(cd->client, iov, 3,
+				GPDS_TIMEOUT, context_conf_cb, cd, NULL))
+			return gprs_up_fail(cd);
+	} else
+		return gprs_up_fail(cd);
 =

-	const unsigned char req[] =3D {
-		GPDS_CONTEXT_CONFIGURE_REQ,
-		cd->handle,	/* context ID */
-		cd->type,	/* PDP type */
-		GPDS_CONT_TYPE_NORMAL,
-		cd->handle,	/* primary context ID */
-		0x00,		/* filler */
-		2,		/* sub blocks */
-		GPDS_DNS_ADDRESS_REQ_INFO,
-		4,		/* subblock length */
-		0, 0,		/* padding */
-		GPDS_APN_INFO,
-		3 + apn_len + 3,
-		apn_len,
-	};
-
-	const struct iovec iov[2] =3D {
-		{ (uint8_t *) req, sizeof(req) },
-		{ cd->apn, apn_len },
-	};
-
-	if (!check_resp(msg, GPDS_LL_CONFIGURE_RESP, 2, cd, gprs_up_fail))
-		return;
-
-	if (!g_isi_client_vsend(cd->client, iov, 2,
-				context_conf_cb, cd, NULL))
-		gprs_up_fail(cd);
 }
 =

 static void create_context_cb(const GIsiMessage *msg, void *opaque)
-- =

1.7.3.5


--===============5459548138652430087==--


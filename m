Content-Type: multipart/mixed; boundary="===============4929108574261593590=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH] qmimodem: send authentication credentials
Date: Thu, 26 Jan 2017 08:49:05 +0100
Message-ID: <20170126074905.24644-1-gluedig@gmail.com>
In-Reply-To: <84af9113-4e2c-7b1a-557f-340749cffe2e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4929108574261593590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass authentication method, user and password
to QMI WDS service.
---
 drivers/qmimodem/gprs-context.c | 24 ++++++++++++++++++++++++
 drivers/qmimodem/wds.h          |  7 +++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index a39db5e8..2250eef9 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -151,6 +151,7 @@ static void qmi_activate_primary(struct ofono_gprs_cont=
ext *gc,
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 	struct qmi_param *param;
 	uint8_t ip_family;
+	uint8_t auth;
 =

 	DBG("cid %u", ctx->cid);
 =

@@ -178,6 +179,29 @@ static void qmi_activate_primary(struct ofono_gprs_con=
text *gc,
 =

 	qmi_param_append_uint8(param, QMI_WDS_PARAM_IP_FAMILY, ip_family);
 =

+	switch (ctx->auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		auth =3D QMI_WDS_AUTHENTICATION_CHAP;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		auth =3D QMI_WDS_AUTHENTICATION_PAP;
+		break;
+	default:
+		auth =3D QMI_WDS_AUTHENTICATION_NONE;
+		break;
+	}
+	qmi_param_append_uint8(param, QMI_WDS_PARAM_AUTHENTICATION_PREFERENCE,
+					auth);
+
+	if (ctx->username && strlen(ctx->username)) {
+		qmi_param_append(param, QMI_WDS_PARAM_USERNAME,
+					strlen(ctx->username), ctx->username);
+        }
+
+	if (ctx->password && strlen(ctx->password))
+		qmi_param_append(param, QMI_WDS_PARAM_PASSWORD,
+					strlen(ctx->password), ctx->password);
+
 	if (qmi_service_send(data->wds, QMI_WDS_START_NET, param,
 					start_net_cb, cbd, NULL) > 0)
 		return;
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 0da34ab9..4843f925 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -30,6 +30,13 @@
 /* Start WDS network interface */
 #define QMI_WDS_PARAM_APN			0x14	/* string */
 #define QMI_WDS_PARAM_IP_FAMILY			0x19	/* uint8 */
+#define QMI_WDS_PARAM_USERNAME			0x17	/* string */
+#define QMI_WDS_PARAM_PASSWORD			0x18	/* string */
+#define QMI_WDS_PARAM_AUTHENTICATION_PREFERENCE	0x16	/* uint8 */
+
+#define QMI_WDS_AUTHENTICATION_NONE		0x0
+#define QMI_WDS_AUTHENTICATION_PAP		0x1
+#define QMI_WDS_AUTHENTICATION_CHAP		0x2
 =

 #define QMI_WDS_RESULT_PKT_HANDLE		0x01	/* uint32 */
 =

-- =

2.11.0


--===============4929108574261593590==--


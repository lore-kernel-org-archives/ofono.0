Content-Type: multipart/mixed; boundary="===============0294089695037643784=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 5/5] drivers: support for auth NONE
Date: Sat, 06 Oct 2018 07:45:20 +0200
Message-ID: <20181006054520.26737-5-gciofono@gmail.com>
In-Reply-To: <20181006054520.26737-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0294089695037643784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added the explicit support for auth NONE.
It needs to be added in all drivers/*/gprs-context.c atoms.

This method is already supported by all atoms that support
authentication (ie, all but Sierra' swmodem driver).

The behavior is left unchanged in case of inconsistent parameters:
if username is empty, then fallback to auth NONE.
---
 drivers/atmodem/gprs-context.c        | 18 ++++++++++++----
 drivers/ifxmodem/gprs-context.c       | 10 +++++++--
 drivers/isimodem/gprs-context.c       | 14 ++++++++-----
 drivers/mbimmodem/gprs-context.c      | 16 +++++++++++---
 drivers/mbmmodem/gprs-context.c       | 11 +++++-----
 drivers/qmimodem/gprs-context.c       | 30 +++++++++++++++------------
 drivers/rilmodem/gprs-context.c       | 13 ++++++++----
 drivers/stemodem/gprs-context.c       |  9 ++++----
 drivers/telitmodem/gprs-context-ncm.c | 10 +++++++--
 drivers/ubloxmodem/gprs-context.c     |  7 ++++---
 10 files changed, 93 insertions(+), 45 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 79ac4c8e..2212af69 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -158,7 +158,10 @@ static gboolean setup_ppp(struct ofono_gprs_context *g=
c)
 		g_at_ppp_set_debug(gcd->ppp, ppp_debug, "PPP");
 =

 	g_at_ppp_set_auth_method(gcd->ppp, gcd->auth_method);
-	g_at_ppp_set_credentials(gcd->ppp, gcd->username, gcd->password);
+
+	if (gcd->auth_method !=3D G_AT_PPP_AUTH_METHOD_NONE)
+		g_at_ppp_set_credentials(gcd->ppp, gcd->username,
+								gcd->password);
 =

 	/* set connect and disconnect callbacks */
 	g_at_ppp_set_connect_function(gcd->ppp, ppp_connect, gc);
@@ -247,7 +250,7 @@ static void at_gprs_activate_primary(struct ofono_gprs_=
context *gc,
 	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
 	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
 =

-	/* We only support CHAP and PAP */
+	/* We support CHAP, PAP and NONE */
 	switch (ctx->auth_method) {
 	case OFONO_GPRS_AUTH_METHOD_CHAP:
 		gcd->auth_method =3D G_AT_PPP_AUTH_METHOD_CHAP;
@@ -255,8 +258,11 @@ static void at_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	case OFONO_GPRS_AUTH_METHOD_PAP:
 		gcd->auth_method =3D G_AT_PPP_AUTH_METHOD_PAP;
 		break;
-	default:
-		goto error;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		gcd->auth_method =3D G_AT_PPP_AUTH_METHOD_NONE;
+		memset(gcd->username, 0, sizeof(gcd->username));
+		memset(gcd->password, 0, sizeof(gcd->password));
+		break;
 	}
 =

 	gcd->state =3D STATE_ENABLING;
@@ -304,6 +310,10 @@ static void at_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 				snprintf(buf + len, sizeof(buf) - len - 3,
 						",\"PAP:%s\"", ctx->apn);
 				break;
+			case OFONO_GPRS_AUTH_METHOD_NONE:
+				snprintf(buf + len, sizeof(buf) - len - 3,
+						",\"%s\"", ctx->apn);
+				break;
 			}
 			break;
 		default:
diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 885e41bb..289b4341 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -466,8 +466,14 @@ static void ifx_gprs_activate_primary(struct ofono_gpr=
s_context *gc,
 	gcd->active_context =3D ctx->cid;
 	gcd->cb =3D cb;
 	gcd->cb_data =3D data;
-	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
-	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
+
+	if (ctx->auth_method =3D=3D OFONO_GPRS_AUTH_METHOD_NONE) {
+		memset(gcd->username, 0, sizeof(gcd->username));
+		memset(gcd->password, 0, sizeof(gcd->password));
+	} else {
+		memcpy(gcd->username, ctx->username, sizeof(ctx->username));
+		memcpy(gcd->password, ctx->password, sizeof(ctx->password));
+	}
 =

 	gcd->state =3D STATE_ENABLING;
 	gcd->proto =3D ctx->proto;
diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index ce53d022..4d2e7a12 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -538,11 +538,15 @@ static void isi_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
 	strncpy(cd->apn, ctx->apn, GPDS_MAX_APN_STRING_LENGTH);
 	cd->apn[GPDS_MAX_APN_STRING_LENGTH] =3D '\0';
 =

-	strncpy(cd->username, ctx->username, GPDS_MAX_USERNAME_LENGTH);
-	cd->username[GPDS_MAX_USERNAME_LENGTH] =3D '\0';
-
-	strncpy(cd->password, ctx->password, GPDS_MAX_PASSWORD_LENGTH);
-	cd->username[GPDS_MAX_PASSWORD_LENGTH] =3D '\0';
+	if (ctx->auth_method =3D=3D OFONO_GPRS_AUTH_METHOD_NONE) {
+		memset(cd->username, 0, sizeof(cd->username));
+		memset(cd->password, 0, sizeof(cd->password));
+	} else {
+		strncpy(cd->username, ctx->username, GPDS_MAX_USERNAME_LENGTH);
+		cd->username[GPDS_MAX_USERNAME_LENGTH] =3D '\0';
+		strncpy(cd->password, ctx->password, GPDS_MAX_PASSWORD_LENGTH);
+		cd->username[GPDS_MAX_PASSWORD_LENGTH] =3D '\0';
+	}
 =

 	cd->pep =3D g_isi_pep_create(cd->idx, NULL, NULL);
 	if (cd->pep =3D=3D NULL)
diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-cont=
ext.c
index 79793c92..be256e43 100644
--- a/drivers/mbimmodem/gprs-context.c
+++ b/drivers/mbimmodem/gprs-context.c
@@ -75,9 +75,11 @@ static uint32_t auth_method_to_auth_protocol(enum ofono_=
gprs_auth_method method)
 		return 2; /* MBIMAuthProtocolChap */
 	case OFONO_GPRS_AUTH_METHOD_PAP:
 		return 1; /* MBIMAuthProtocolPap */
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		return 0; /* MBIMAUthProtocolNone */
 	}
 =

-	return 0;
+	return 0; /* MBIMAUthProtocolNone */
 }
 =

 static void mbim_deactivate_cb(struct mbim_message *message, void *user)
@@ -345,6 +347,8 @@ static void mbim_gprs_activate_primary(struct ofono_gpr=
s_context *gc,
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct mbim_message *message;
+	const char username =3D NULL;
+	const char password =3D NULL;
 =

 	DBG("cid %u", ctx->cid);
 =

@@ -354,6 +358,12 @@ static void mbim_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
 	gcd->active_context =3D ctx->cid;
 	gcd->proto =3D ctx->proto;
 =

+	if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE && ctx->username[0])
+		username =3D ctx->username;
+
+	if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE && ctx->password[0])
+		password =3D ctx->password;
+
 	message =3D mbim_message_new(mbim_uuid_basic_connect,
 					MBIM_CID_CONNECT,
 					MBIM_COMMAND_TYPE_SET);
@@ -361,8 +371,8 @@ static void mbim_gprs_activate_primary(struct ofono_gpr=
s_context *gc,
 				ctx->cid,
 				1, /* MBIMActivationCommandActivate */
 				ctx->apn,
-				ctx->username[0] ? ctx->username : NULL,
-				ctx->password[0] ? ctx->password : NULL,
+				username,
+				password,
 				0, /*MBIMCompressionNone */
 				auth_method_to_auth_protocol(ctx->auth_method),
 				proto_to_context_ip_type(ctx->proto),
diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index e961afa1..fa8b44b6 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -394,11 +394,12 @@ static void mbm_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
 	 * Set username and password, this should be done after CGDCONT
 	 * or an error can occur.  We don't bother with error checking
 	 * here
-	 * */
-	snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
-			ctx->cid, ctx->username, ctx->password);
-
-	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+	 */
+	if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE) {
+		snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
+				ctx->cid, ctx->username, ctx->password);
+		g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+	}
 =

 	return;
 =

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index 9a22b89f..985bdd64 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -230,6 +230,20 @@ static void qmi_gprs_read_settings(struct ofono_gprs_c=
ontext* gc,
 	g_free(cbd);
 }
 =

+static uint8_t auth_method_to_qmi_auth(enum ofono_gprs_auth_method method)
+{
+	switch (method) {
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		return QMI_WDS_AUTHENTICATION_CHAP;
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		return QMI_WDS_AUTHENTICATION_PAP;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		return QMI_WDS_AUTHENTICATION_NONE;
+	}
+
+	return QMI_WDS_AUTHENTICATION_NONE;
+}
+
 static void qmi_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
 				ofono_gprs_context_cb_t cb, void *user_data)
@@ -266,26 +280,16 @@ static void qmi_activate_primary(struct ofono_gprs_co=
ntext *gc,
 =

 	qmi_param_append_uint8(param, QMI_WDS_PARAM_IP_FAMILY, ip_family);
 =

-	switch (ctx->auth_method) {
-	case OFONO_GPRS_AUTH_METHOD_CHAP:
-		auth =3D QMI_WDS_AUTHENTICATION_CHAP;
-		break;
-	case OFONO_GPRS_AUTH_METHOD_PAP:
-		auth =3D QMI_WDS_AUTHENTICATION_PAP;
-		break;
-	default:
-		auth =3D QMI_WDS_AUTHENTICATION_NONE;
-		break;
-	}
+	auth =3D auth_method_to_qmi_auth(ctx->auth_method);
 =

 	qmi_param_append_uint8(param, QMI_WDS_PARAM_AUTHENTICATION_PREFERENCE,
 					auth);
 =

-	if (ctx->username[0] !=3D '\0')
+	if (auth !=3D QMI_WDS_AUTHENTICATION_NONE && ctx->username[0] !=3D '\0')
 		qmi_param_append(param, QMI_WDS_PARAM_USERNAME,
 					strlen(ctx->username), ctx->username);
 =

-	if (ctx->password[0] !=3D '\0')
+	if (auth !=3D QMI_WDS_AUTHENTICATION_NONE &&  ctx->password[0] !=3D '\0')
 		qmi_param_append(param, QMI_WDS_PARAM_PASSWORD,
 					strlen(ctx->password), ctx->password);
 =

diff --git a/drivers/rilmodem/gprs-context.c b/drivers/rilmodem/gprs-contex=
t.c
index 1f476e23..ef62cba9 100644
--- a/drivers/rilmodem/gprs-context.c
+++ b/drivers/rilmodem/gprs-context.c
@@ -598,9 +598,12 @@ static void ril_gprs_context_activate_primary(struct o=
fono_gprs_context *gc,
 	 * We do the same as in $AOSP/frameworks/opt/telephony/src/java/com/
 	 * android/internal/telephony/dataconnection/DataConnection.java,
 	 * onConnect(), and use authentication or not depending on whether
-	 * the user field is empty or not.
+	 * the user field is empty or not,
+	 * on top of the verification for the authentication method.
 	 */
-	if (ctx->username[0] !=3D '\0')
+
+	if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE &&
+						ctx->username[0] !=3D '\0')
 		auth_type =3D RIL_AUTH_BOTH;
 	else
 		auth_type =3D RIL_AUTH_NONE;
@@ -615,8 +618,10 @@ static void ril_gprs_context_activate_primary(struct o=
fono_gprs_context *gc,
 		parcel_w_string(&rilp, buf);
 =

 		g_ril_append_print_buf(gcd->ril, "(%d,%s,%s,%s,%s,%d,%s,%u)",
-				tech, profile, ctx->apn, ctx->username,
-				ctx->password, auth_type,
+				tech, profile, ctx->apn,
+				auth_type =3D=3D RIL_AUTH_NONE ? "" : ctx->username,
+				auth_type =3D=3D RIL_AUTH_NONE ? "" : ctx->password,
+				auth_type,
 				ril_util_gprs_proto_to_ril_string(ctx->proto),
 				ctx->cid);
 	} else
diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 18b2bfa4..32facd8c 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -307,10 +307,11 @@ static void ste_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
 	 * or an error can occur.  We don't bother with error checking
 	 * here
 	 */
-	snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
-			ctx->cid, ctx->username, ctx->password);
-
-	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+	if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE) {
+		snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
+				ctx->cid, ctx->username, ctx->password);
+		g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+	}
 =

 	return;
 =

diff --git a/drivers/telitmodem/gprs-context-ncm.c b/drivers/telitmodem/gpr=
s-context-ncm.c
index 7139740c..9c9b9500 100644
--- a/drivers/telitmodem/gprs-context-ncm.c
+++ b/drivers/telitmodem/gprs-context-ncm.c
@@ -277,7 +277,8 @@ static void setup_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 		return;
 	}
 =

-	if (gcd->username[0] && gcd->password[0])
+	if (gcd->auth_method !=3D AUTH_METHOD_NONE &&
+					gcd->username[0] && gcd->password[0])
 		sprintf(buf, "AT#PDPAUTH=3D%u,%u,\"%s\",\"%s\"",
 			gcd->active_context, gcd->auth_method,
 			gcd->username, gcd->password);
@@ -320,7 +321,7 @@ static void telitncm_gprs_activate_primary(struct ofono=
_gprs_context *gc,
 	gcd->state =3D STATE_ENABLING;
 	gcd->proto =3D ctx->proto;
 =

-	/* We only support CHAP and PAP */
+	/* We support CHAP, PAP and NONE */
 	switch (ctx->auth_method) {
 	case OFONO_GPRS_AUTH_METHOD_CHAP:
 		gcd->auth_method =3D AUTH_METHOD_CHAP;
@@ -328,6 +329,11 @@ static void telitncm_gprs_activate_primary(struct ofon=
o_gprs_context *gc,
 	case OFONO_GPRS_AUTH_METHOD_PAP:
 		gcd->auth_method =3D AUTH_METHOD_PAP;
 		break;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		gcd->auth_method =3D AUTH_METHOD_NONE;
+		gcd->username[0] =3D 0;
+		gcd->password[0] =3D 0;
+		break;
 	default:
 		goto error;
 	}
diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 6fe2719f..7eb18f09 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -315,9 +315,10 @@ static void ublox_send_uauthreq(struct ofono_gprs_cont=
ext *gc,
 	case OFONO_GPRS_AUTH_METHOD_CHAP:
 		auth =3D 2;
 		break;
-	default:
-		ofono_error("Unsupported auth type %u", auth_method);
-		return;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		auth =3D 0;
+		username =3D password =3D "";
+		break;
 	}
 =

 	snprintf(buf, sizeof(buf), "AT+UAUTHREQ=3D%u,%u,\"%s\",\"%s\"",
-- =

2.17.1


--===============0294089695037643784==--


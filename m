Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55B2D3EDE
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351439; cv=none; b=JiKC9/KvY7+MUaDWp1qGoDnBUbceV+mc34618BxwEGhooJTyzaQLrGEOilDCGtRrJgxIF7HP9vjFzUnDMuK6bmIgew6RwDQ6UGhBUf2rQdLX8BqvPuZ5rb9pPA56PNja1YAhF+9EzWurJ4xL6BAulBeWKK8V4la1jfp0QaPuGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351439; c=relaxed/simple;
	bh=3xYccOLNcjG/DxtmeS8WW59xuiUXwjaJpt7PQErPqRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poD+ot/VAlgMMGw1asVw34EC1lO0SKw9kI3TXF6SSx5gk7XNB0QfGNNHdT3/JjeZfLITwtJCG/qoxIttzT0FWXXRf1QUaBC4XWCm4OU5yPPJk2T9OBVWc3wAKIBJpWczDHIirZdmlJvG7PG7NKEEbJY/r83YQxsZXcI/dD9Uq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=NRjzMtxo; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="NRjzMtxo"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=NRjzMtxo3GsihO378AnglxsURyYDW1E7WT5HwZjHN1We8WKXiwGhiDui/I37O23YMhc/QVIQuyzic0dEJcpq8m9nE/mr5gbFs7GCYoXGaz+w1SVUDPwFTMA4MQyYst/5wMZG+KFyIIMykE8zGMNguWwPssmqJI3HaT+YVHNFDZcMbvowfE5GtCejXTi7Ws7yLVSjPd9qjSl1zTE+Lk+sF4NmtY7Gg/svdnKwvEUi+rE2JTwwkkh8pOIoqwt1G1YlFaxNzkVzXUxQDxgimKeFZK8MoUp8Ku3q71ZpwcwmdfUzuFiwZov1Ff0a0/Z6al4u93/DJMc7839SnTQKOcDzQw==; s=purelymail2; d=purelymail.com; v=1; bh=3xYccOLNcjG/DxtmeS8WW59xuiUXwjaJpt7PQErPqRQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1079628981;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:37:13 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v7 03/10] mbimmodem: add support for MBIM extensions
Date: Fri, 28 Nov 2025 22:36:49 +0500
Message-ID: <20251128173656.55692-4-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
References: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

With MBIMEx 3.0, arguments for activating GPRS changed. Update as
needed.
---
 drivers/mbimmodem/gprs-context.c | 64 +++++++++++++++++++++++++-------
 drivers/mbimmodem/mbim.c         | 13 +++++++
 drivers/mbimmodem/mbim.h         |  6 +++
 drivers/mbimmodem/mbimmodem.h    |  1 +
 drivers/mbimmodem/sim.c          | 31 +++++++++++++---
 drivers/mbimmodem/util.c         |  1 -
 plugins/mbim.c                   | 39 +++++++++++++++++++
 7 files changed, 134 insertions(+), 21 deletions(-)

diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-cont=
ext.c
index c420e300..31bf6ef3 100644
--- a/drivers/mbimmodem/gprs-context.c
+++ b/drivers/mbimmodem/gprs-context.c
@@ -91,6 +91,8 @@ static void mbim_gprs_deactivate_primary(struct ofono_gpr=
s_context *gc,
 =09=09=09=09=09ofono_gprs_context_cb_t cb, void *data)
 {
 =09struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+=09struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+=09uint16_t mbimex_version =3D ofono_modem_get_integer(modem, "MBIMExVersi=
on");
 =09struct mbim_message *message;
=20
 =09DBG("cid %u", cid);
@@ -102,9 +104,16 @@ static void mbim_gprs_deactivate_primary(struct ofono_=
gprs_context *gc,
 =09message =3D mbim_message_new(mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_CONNECT,
 =09=09=09=09=09MBIM_COMMAND_TYPE_SET);
-=09mbim_message_set_arguments(message, "uusssuuu16y",
-=09=09=09=09=09cid, 0, NULL, NULL, NULL, 0, 0, 0,
-=09=09=09=09=09mbim_context_type_internet);
+
+=09if (mbim_device_mbimex_version_at_least(mbimex_version, 3, 0)) {
+=09=09mbim_message_set_arguments(message, "uuuuu16yussss",
+=09=09=09=09=09=09cid, 0, 0, 0, 0, mbim_context_type_internet,
+=09=09=09=09=09=090, NULL, NULL, NULL, NULL);
+=09} else {
+=09=09mbim_message_set_arguments(message, "uusssuuu16y",
+=09=09=09=09=09=09cid, 0, NULL, NULL, NULL, 0, 0, 0,
+=09=09=09=09=09=09mbim_context_type_internet);
+=09}
=20
 =09if (mbim_device_send(gcd->device, GPRS_CONTEXT_GROUP, message,
 =09=09=09=09mbim_deactivate_cb, gc, NULL) > 0)
@@ -121,6 +130,7 @@ static void mbim_ip_configuration_cb(struct mbim_messag=
e *message, void *user)
 =09struct ofono_gprs_context *gc =3D user;
 =09struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =09struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+=09uint16_t mbimex_version =3D ofono_modem_get_integer(modem, "MBIMExVersi=
on");
 =09const char *interface;
 =09uint32_t session_id;
 =09uint32_t ipv4_config_available;
@@ -288,10 +298,18 @@ error:
 =09message =3D mbim_message_new(mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_CONNECT,
 =09=09=09=09=09MBIM_COMMAND_TYPE_SET);
-=09mbim_message_set_arguments(message, "uusssuuu16y",
+
+=09if (mbim_device_mbimex_version_at_least(mbimex_version, 3, 0)) {
+=09=09mbim_message_set_arguments(message, "uuuuu16yussss",
+=09=09=09=09=09gcd->active_context, 0, 0, 0, 0,
+=09=09=09=09=09mbim_context_type_internet, 0, NULL,
+=09=09=09=09=09NULL, NULL, NULL);
+=09} else {
+=09=09mbim_message_set_arguments(message, "uusssuuu16y",
 =09=09=09=09=09gcd->active_context, 0,
 =09=09=09=09=09NULL, NULL, NULL, 0, 0, 0,
 =09=09=09=09=09mbim_context_type_internet);
+=09}
=20
 =09if (!mbim_device_send(gcd->device, GPRS_CONTEXT_GROUP, message,
 =09=09=09=09NULL, NULL, NULL))
@@ -331,6 +349,8 @@ static void mbim_gprs_activate_primary(struct ofono_gpr=
s_context *gc,
 =09=09=09=09ofono_gprs_context_cb_t cb, void *data)
 {
 =09struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+=09struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+=09uint16_t mbimex_version =3D ofono_modem_get_integer(modem, "MBIMExVersi=
on");
 =09struct mbim_message *message;
 =09const char *username =3D NULL;
 =09const char *password =3D NULL;
@@ -352,16 +372,32 @@ static void mbim_gprs_activate_primary(struct ofono_g=
prs_context *gc,
 =09message =3D mbim_message_new(mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_CONNECT,
 =09=09=09=09=09MBIM_COMMAND_TYPE_SET);
-=09mbim_message_set_arguments(message, "uusssuuu16y",
-=09=09=09=09ctx->cid,
-=09=09=09=091, /* MBIMActivationCommandActivate */
-=09=09=09=09ctx->apn,
-=09=09=09=09username,
-=09=09=09=09password,
-=09=09=09=090, /*MBIMCompressionNone */
-=09=09=09=09auth_method_to_auth_protocol(ctx->auth_method),
-=09=09=09=09proto_to_context_ip_type(ctx->proto),
-=09=09=09=09mbim_context_type_internet);
+
+=09if (mbim_device_mbimex_version_at_least(mbimex_version, 3, 0)) {
+=09=09mbim_message_set_arguments(message, "uuuuu16yussss",
+=09=09=09ctx->cid,
+=09=09=091, /* MBIMActivationCommandActivate */
+=09=09=090, /* MBIMCompressionNone */
+=09=09=09auth_method_to_auth_protocol(ctx->auth_method),
+=09=09=09proto_to_context_ip_type(ctx->proto),
+=09=09=09mbim_context_type_internet,
+=09=09=090, /* MBIMMediaTypeNone */
+=09=09=09ctx->apn,
+=09=09=09username,
+=09=09=09password,
+=09=09=09NULL);
+=09} else {
+=09=09mbim_message_set_arguments(message, "uusssuuu16y",
+=09=09=09ctx->cid,
+=09=09=091, /* MBIMActivationCommandActivate */
+=09=09=09ctx->apn,
+=09=09=09username,
+=09=09=09password,
+=09=09=090, /* MBIMCompressionNone */
+=09=09=09auth_method_to_auth_protocol(ctx->auth_method),
+=09=09=09proto_to_context_ip_type(ctx->proto),
+=09=09=09mbim_context_type_internet);
+=09}
=20
 =09if (mbim_device_send(gcd->device, GPRS_CONTEXT_GROUP, message,
 =09=09=09=09mbim_activate_cb, gc, NULL) > 0)
diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
index c405761d..cd642515 100644
--- a/drivers/mbimmodem/mbim.c
+++ b/drivers/mbimmodem/mbim.c
@@ -107,6 +107,11 @@ const uint8_t mbim_context_type_local[] =3D {
 =090x03, 0x3C, 0x39, 0xF6, 0x0D, 0xB9,
 };
=20
+const uint8_t mbim_ms_basic_connect_extensions[] =3D {
+=090x3D, 0x01, 0xDC, 0xC5, 0xFE, 0xF5, 0x4D, 0x05, 0x0D, 0x3A,
+=090xBE, 0xF7, 0x05, 0x8E, 0x9A, 0xAF,
+};
+
 struct message_assembly_node {
 =09struct mbim_message_header msg_hdr;
 =09struct mbim_fragment_header frag_hdr;
@@ -1039,6 +1044,14 @@ bool mbim_device_set_ready_handler(struct mbim_devic=
e *device,
 =09return true;
 }
=20
+bool mbim_device_mbimex_version_at_least(uint16_t mbimex_version,
+=09=09=09=09=09int version_major, int version_minor)
+{
+=09return ((mbimex_version >> 8) > version_major) ||
+=09=09=09(((mbimex_version >> 8) =3D=3D version_major) &&
+=09=09=09((mbimex_version & 0xFF) >=3D version_minor));
+}
+
 uint32_t mbim_device_send(struct mbim_device *device, uint32_t gid,
 =09=09=09=09struct mbim_message *message,
 =09=09=09=09mbim_device_reply_func_t function,
diff --git a/drivers/mbimmodem/mbim.h b/drivers/mbimmodem/mbim.h
index 5f15d0a2..7101d811 100644
--- a/drivers/mbimmodem/mbim.h
+++ b/drivers/mbimmodem/mbim.h
@@ -31,6 +31,8 @@ struct mbim_message;
 #define MBIM_CID_IP_PACKET_FILTERS=09=0923
 #define MBIM_CID_MULTICARRIER_PROVIDERS=09=0924
=20
+#define MBIM_CID_MS_BASIC_CONNECT_EXTENSIONS_VERSION=0915
+
 #define MBIM_CID_SMS_CONFIGURATION=09=091
 #define MBIM_CID_SMS_READ=09=09=092
 #define MBIM_CID_SMS_SEND=09=09=093
@@ -87,6 +89,7 @@ extern const uint8_t mbim_uuid_phonebook[];
 extern const uint8_t mbim_uuid_stk[];
 extern const uint8_t mbim_uuid_auth[];
 extern const uint8_t mbim_uuid_dss[];
+extern const uint8_t mbim_ms_basic_connect_extensions[];
=20
 extern const uint8_t mbim_context_type_none[];
 extern const uint8_t mbim_context_type_internet[];
@@ -118,6 +121,9 @@ bool mbim_device_set_ready_handler(struct mbim_device *=
device,
 =09=09=09=09=09void *user_data,
 =09=09=09=09=09mbim_device_destroy_func_t destroy);
=20
+bool mbim_device_mbimex_version_at_least(uint16_t mbimex_version,
+=09=09=09=09=09int version_major, int version_minor);
+
 uint32_t mbim_device_send(struct mbim_device *device, uint32_t gid,
 =09=09=09=09struct mbim_message *message,
 =09=09=09=09mbim_device_reply_func_t function,
diff --git a/drivers/mbimmodem/mbimmodem.h b/drivers/mbimmodem/mbimmodem.h
index 96432738..7cec3249 100644
--- a/drivers/mbimmodem/mbimmodem.h
+++ b/drivers/mbimmodem/mbimmodem.h
@@ -14,3 +14,4 @@ enum MBIM_GROUP {
 =09GPRS_GROUP =3D 4,
 =09GPRS_CONTEXT_GROUP =3D 101,
 };
+
diff --git a/drivers/mbimmodem/sim.c b/drivers/mbimmodem/sim.c
index df8d73ce..1e932b76 100644
--- a/drivers/mbimmodem/sim.c
+++ b/drivers/mbimmodem/sim.c
@@ -385,7 +385,9 @@ static void mbim_subscriber_ready_status_changed(struct=
 mbim_message *message,
 =09=09=09=09=09=09=09=09void *user)
 {
 =09struct ofono_sim *sim =3D user;
+=09struct ofono_modem *modem =3D ofono_sim_get_modem(sim);
 =09struct sim_data *sd =3D ofono_sim_get_data(sim);
+=09uint16_t mbimex_version =3D ofono_modem_get_integer(modem, "MBIMExVersi=
on");
 =09uint32_t ready_state;
 =09char *imsi;
 =09char *iccid;
@@ -393,9 +395,17 @@ static void mbim_subscriber_ready_status_changed(struc=
t mbim_message *message,
=20
 =09DBG("");
=20
-=09if (!mbim_message_get_arguments(message, "ussu",
-=09=09=09=09=09&ready_state, &imsi,
-=09=09=09=09=09&iccid, &ready_info))
+=09if (mbim_device_mbimex_version_at_least(mbimex_version, 3, 0)) {
+=09=09r =3D mbim_message_get_arguments(message, "uussu",
+=09=09=09=09=09=09&ready_state, &ready_flags, &imsi,
+=09=09=09=09=09=09&iccid, &ready_info);
+=09} else {
+=09=09r =3D mbim_message_get_arguments(message, "ussu",
+=09=09=09=09=09=09&ready_state, &imsi,
+=09=09=09=09=09=09&iccid, &ready_info);
+=09}
+
+=09if (!r)
 =09=09return;
=20
 =09l_free(sd->iccid);
@@ -413,7 +423,9 @@ static void mbim_subscriber_ready_status_cb(struct mbim=
_message *message,
 =09=09=09=09=09=09=09=09void *user)
 {
 =09struct ofono_sim *sim =3D user;
+=09struct ofono_modem *modem =3D ofono_sim_get_modem(sim);
 =09struct sim_data *sd =3D ofono_sim_get_data(sim);
+=09uint16_t mbimex_version =3D ofono_modem_get_integer(modem, "MBIMExVersi=
on");
 =09uint32_t ready_state;
 =09char *imsi;
 =09char *iccid;
@@ -426,9 +438,16 @@ static void mbim_subscriber_ready_status_cb(struct mbi=
m_message *message,
 =09=09goto error;
=20
 =09/* We don't bother parsing MSISDN/MDN array */
-=09r =3D mbim_message_get_arguments(message, "ussu",
-=09=09=09=09=09&ready_state, &imsi,
-=09=09=09=09=09&iccid, &ready_info);
+=09if (mbim_device_mbimex_version_at_least(mbimex_version, 3, 0)) {
+=09=09r =3D mbim_message_get_arguments(message, "uussu",
+=09=09=09=09=09=09&ready_state, &ready_flags, &imsi,
+=09=09=09=09=09=09&iccid, &ready_info);
+=09} else {
+=09=09r =3D mbim_message_get_arguments(message, "ussu",
+=09=09=09=09=09=09&ready_state, &imsi,
+=09=09=09=09=09=09&iccid, &ready_info);
+=09}
+
 =09if (!r)
 =09=09goto error;
=20
diff --git a/drivers/mbimmodem/util.c b/drivers/mbimmodem/util.c
index b4e61d69..4a3d9627 100644
--- a/drivers/mbimmodem/util.c
+++ b/drivers/mbimmodem/util.c
@@ -37,4 +37,3 @@ int mbim_data_class_to_tech(uint32_t n)
=20
 =09return -1;
 }
-
diff --git a/plugins/mbim.c b/plugins/mbim.c
index eeedfdac..6d75a106 100644
--- a/plugins/mbim.c
+++ b/plugins/mbim.c
@@ -281,6 +281,29 @@ error:
 =09mbim_device_shutdown(md->device);
 }
=20
+static void mbim_device_mbimex_version_cb(struct mbim_message *message,
+=09=09=09=09=09=09=09=09void *user)
+{
+=09struct ofono_modem *modem =3D user;
+=09uint16_t mbim_version, mbimex_version;
+
+=09if (mbim_message_get_error(message) !=3D 0) {
+=09=09/* Fallback to MBIM 1.0 with no extensions */
+=09=09mbim_version =3D (1 << 8) | 0;
+=09=09mbimex_version =3D (0 << 8) | 0;
+=09=09goto version_set;
+=09}
+
+=09mbim_message_get_arguments(message, "qq",
+=09=09&mbim_version, &mbimex_version);
+
+version_set:
+=09ofono_modem_set_integer(modem, "MBIMVersion",
+=09=09mbim_version);
+=09ofono_modem_set_integer(modem, "MBIMExVersion",
+=09=09mbimex_version);
+}
+
 static void mbim_device_closed(void *user_data)
 {
 =09struct ofono_modem *modem =3D user_data;
@@ -298,6 +321,22 @@ static void mbim_device_ready(void *user_data)
 =09struct mbim_data *md =3D ofono_modem_get_data(modem);
 =09struct mbim_message *message;
=20
+=09/* Version is formatted as (major version) << 8 | (minor version) */
+=09static const uint16_t mbim_version =3D (1 << 8) | 0;
+
+=09/* Always open with MBIMEx 3, devices not supporting it will fallback t=
o MBIMEx 2 */
+=09static const uint16_t mbimex_version =3D (3 << 8) | 0;
+
+=09message =3D mbim_message_new(mbim_ms_basic_connect_extensions,
+=09=09=09=09=09MBIM_CID_MS_BASIC_CONNECT_EXTENSIONS_VERSION,
+=09=09=09=09=09MBIM_COMMAND_TYPE_QUERY);
+=09mbim_message_set_arguments(message, "qq",
+=09=09=09=09=09mbim_version,
+=09=09=09=09=09mbimex_version);
+
+=09mbim_device_send(md->device, 0, message,
+=09=09=09=09mbim_device_mbimex_version_cb, modem, NULL);
+
 =09message =3D mbim_message_new(mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_DEVICE_CAPS,
 =09=09=09=09=09MBIM_COMMAND_TYPE_QUERY);
--=20
2.52.0


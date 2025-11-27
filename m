Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB01E4AB
	for <ofono@lists.linux.dev>; Thu, 27 Nov 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265811; cv=none; b=feQTfNmtLAIahL/xwQi/pkaxWn8L3xMmD/12ELNxymxC4BWwtD4eHFqVebXsk6k71nQC2B7j433l+P3xZkRfvCSFvRds6UKAswgV91L2ZGozt/FGXZv7cz6LBAlytniZ3xUQxQ7jiw3dELGFbz5lyoPABAcWaqJJfHdLTTOyFaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265811; c=relaxed/simple;
	bh=MK6KaZxkzgsCJDykp/dmIdzKdK48tS5fHdiF9bjAlCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxVA/P0HEnUZbfye4o+MapwgWOdveqJZIs6LH+8io/NBbBWSIbkaKRYrXKMmIKTBG+yW4dMjxmgU3aBVBDung0VNXV6MLjHS1m+qyRN1rMoRKtrXyHsYL4UtuC1hTLK1icHhhE1oJRYh6XDs9mGxALW+MGNQs1xtwJo6RIqdsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=OAe4x5Xz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="OAe4x5Xz"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=OAe4x5XzKPTnIx7ZvWsajUVf0UtDQd/dEV8fPV4cZaelC6ac/lElkOuVUD7o3YgNh06/U2zK9+i0KhOAofwRFHvruDacco43Kjrne5PEqo/sRjneTeZpExYe+4YkQLLNixIutBJWrk7yH4U09ADRn9q2DM0najirMVq1lkm3XJp0GKGDrM8qcjOrAd85P2S8rtcO36fRZZoJ3RihcMO1o03sqlMRBkL2XThsOqUbliJ3jr03AzxYE2QeN0vdkD+rjvk8LH3DcStPEjDNcgf3fGoBf+uFNvkEXqXyizPe5RakwvtK59GegfJbkLFmWZm2fJPFcasCir9CjLqFN0bF2Q==; s=purelymail2; d=purelymail.com; v=1; bh=MK6KaZxkzgsCJDykp/dmIdzKdK48tS5fHdiF9bjAlCI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 62202782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 27 Nov 2025 17:50:07 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v5 03/10] mbimmodem: add support for MBIM extensions * With MBIMEx 3.0, arguments for activating GPRS changed. Update as   needed.
Date: Thu, 27 Nov 2025 22:49:37 +0500
Message-ID: <20251127174946.89981-4-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
References: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

---
 drivers/mbimmodem/gprs-context.c | 64 +++++++++++++++++++++++++-------
 drivers/mbimmodem/mbim.c         | 13 +++++++
 drivers/mbimmodem/mbim.h         |  6 +++
 drivers/mbimmodem/mbimmodem.h    |  2 +-
 drivers/mbimmodem/sim.c          |  4 ++
 drivers/mbimmodem/util.c         |  1 -
 plugins/mbim.c                   | 40 ++++++++++++++++++++
 7 files changed, 114 insertions(+), 16 deletions(-)

diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-cont=
ext.c
index c420e300..4ef5e10f 100644
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
+=09if (mbim_device_mbimex_version_equal(mbimex_version, 3, 0)) {
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
+=09if (mbim_device_mbimex_version_equal(mbimex_version, 3, 0)) {
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
+=09if (mbim_device_mbimex_version_equal(mbimex_version, 3, 0)) {
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
index c405761d..646b8055 100644
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
+bool mbim_device_mbimex_version_equal(uint16_t mbimex_version,
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
index 5f15d0a2..6ef7150b 100644
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
+bool mbim_device_mbimex_version_equal(uint16_t mbimex_version,
+=09=09=09=09=09int version_major, int version_minor);
+
 uint32_t mbim_device_send(struct mbim_device *device, uint32_t gid,
 =09=09=09=09struct mbim_message *message,
 =09=09=09=09mbim_device_reply_func_t function,
diff --git a/drivers/mbimmodem/mbimmodem.h b/drivers/mbimmodem/mbimmodem.h
index 96432738..a517877e 100644
--- a/drivers/mbimmodem/mbimmodem.h
+++ b/drivers/mbimmodem/mbimmodem.h
@@ -13,4 +13,3 @@ enum MBIM_GROUP {
 =09SMS_GROUP =3D 3,
 =09GPRS_GROUP =3D 4,
 =09GPRS_CONTEXT_GROUP =3D 101,
-};
+};
diff --git a/drivers/mbimmodem/sim.c b/drivers/mbimmodem/sim.c
index df8d73ce..fb23609a 100644
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
@@ -413,7 +415,9 @@ static void mbim_subscriber_ready_status_cb(struct mbim=
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
index eeedfdac..1f82a3e4 100644
--- a/plugins/mbim.c
+++ b/plugins/mbim.c
@@ -281,6 +281,30 @@ error:
 =09mbim_device_shutdown(md->device);
 }
=20
+static void mbim_device_mbimex_version_cb(struct mbim_message *message,
+=09=09=09=09=09=09=09=09void *user)
+{
+=09struct ofono_modem *modem =3D user;
+=09struct mbim_data *md =3D ofono_modem_get_data(modem);
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
@@ -298,6 +322,22 @@ static void mbim_device_ready(void *user_data)
 =09struct mbim_data *md =3D ofono_modem_get_data(modem);
 =09struct mbim_message *message;
=20
+=09/* Version is formatted as (major version) << 8 | (minor version) */
+=09static const int mbim_version =3D 1 << 8 | 0;
+
+=09/* Always open with MBIMEx 3, devices not supporting it will fallback t=
o MBIMEx 2 */
+=09static const int mbimex_version =3D 3 << 8 | 0;
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


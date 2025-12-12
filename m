Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135EE19067C
	for <ofono@lists.linux.dev>; Fri, 12 Dec 2025 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573398; cv=none; b=diG5pEe2BTuYA1hiCwfJDaSTNCIHZLcpl0BaIMeVsvPF2HVu19EEUOfu/eXxVyDXXCPPMXc8jEqF0w5Z6d572vCIjwZ6WGsKyPHMVBCLM5k+2wBwdPdCasBnxqY7V/yRI9izcxbkTFh5AOdlDwlgJk2ymef98gAvDkvGJL6cge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573398; c=relaxed/simple;
	bh=NtLD6Fn8CKYGgSfFxYTJtAG/oi9tS6sAQB9VbmbA5wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4pLx32IOD8YVtdQ6S2sllIkLnjKWPQgsrrN6nU+/jCclFWA957Zd/4gQAwfSwLteze2fu11ZW5+k+3q2tSDE/ilEsmq6Pjnop+qbRlXZ3KZoxWZor/h8Uu2Dng4wG3hI2CPowODbbmkxkwvqKQMOYhRU2Yk7tuFCwrXCSK1Nbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=oiP292rr; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="oiP292rr"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=oiP292rrzZZh7fD1o/KGJBzAhYrtJkV9a4jR3tsi3bBWKLrxa7kpR7eNIt+ej7Xcm/zku+NUDZxA60Jy2YzJsrRC7qCIYOm1/K0aZnzGWuVL7xC5TKJ7s+q5kxygqCvdBeWdaPxEzbcROkc7shpLjlFSyn7cIEOQHhh/PTDiykDX9/NcXa+u+E3SzABxCvlu5YX2zqgPLTtI4TKHLbJzERqalMGoIvJP+bKR37ubnmAA7hxg2slrpui3dwDsCRaCyNrdLkZXNj9wX8HWODNR56NoYMqH0tXAE9wCf9oSBYj7TRJTmBUS2N0qktxa7vRvLIo+QT/gTK6GFRZ7NdsxiQ==; s=purelymail1; d=purelymail.com; v=1; bh=NtLD6Fn8CKYGgSfFxYTJtAG/oi9tS6sAQB9VbmbA5wk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 511728581;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 12 Dec 2025 21:03:12 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v8 3/8] mbimmodem: add support for MBIM extensions
Date: Sat, 13 Dec 2025 02:02:44 +0500
Message-ID: <20251212210249.95597-4-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212210249.95597-1-thevancedgamer@mentallysanemainliners.org>
References: <20251212210249.95597-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

With MBIMEx 3.0, arguments for different services and commands changed.
Update as needed.
---
 drivers/mbimmodem/gprs-context.c | 64 +++++++++++++++++++++++++-------
 drivers/mbimmodem/mbim.c         | 13 +++++++
 drivers/mbimmodem/mbim.h         |  6 +++
 drivers/mbimmodem/sim.c          | 34 ++++++++++++++---
 drivers/mbimmodem/util.c         |  1 -
 plugins/mbim.c                   | 36 ++++++++++++++++++
 6 files changed, 133 insertions(+), 21 deletions(-)

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
diff --git a/drivers/mbimmodem/sim.c b/drivers/mbimmodem/sim.c
index df8d73ce..9df34121 100644
--- a/drivers/mbimmodem/sim.c
+++ b/drivers/mbimmodem/sim.c
@@ -385,17 +385,29 @@ static void mbim_subscriber_ready_status_changed(stru=
ct mbim_message *message,
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
 =09uint32_t ready_info;
+=09uint32_t ready_flags;
+=09bool r;
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
@@ -413,11 +425,14 @@ static void mbim_subscriber_ready_status_cb(struct mb=
im_message *message,
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
 =09uint32_t ready_info;
+=09uint32_t ready_flags;
 =09bool r;
=20
 =09DBG("");
@@ -426,9 +441,16 @@ static void mbim_subscriber_ready_status_cb(struct mbi=
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
index eeedfdac..b5641cb6 100644
--- a/plugins/mbim.c
+++ b/plugins/mbim.c
@@ -281,6 +281,26 @@ error:
 =09mbim_device_shutdown(md->device);
 }
=20
+static void mbim_device_mbimex_version_cb(struct mbim_message *message,
+=09=09=09=09=09=09=09=09void *user)
+{
+=09struct ofono_modem *modem =3D user;
+=09uint16_t mbim_version, mbimex_version;
+
+=09if (mbim_message_get_error(message) !=3D 0 ||
+=09=09!mbim_message_get_arguments(message, "qq",
+=09=09=09&mbim_version, &mbimex_version)) {
+=09=09/* Fallback to MBIM 1.0 with no extensions */
+=09=09mbim_version =3D (1 << 8) | 0;
+=09=09mbimex_version =3D (0 << 8) | 0;
+=09}
+
+=09ofono_modem_set_integer(modem, "MBIMVersion",
+=09=09mbim_version);
+=09ofono_modem_set_integer(modem, "MBIMExVersion",
+=09=09mbimex_version);
+}
+
 static void mbim_device_closed(void *user_data)
 {
 =09struct ofono_modem *modem =3D user_data;
@@ -298,6 +318,22 @@ static void mbim_device_ready(void *user_data)
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


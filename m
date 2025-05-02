Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA341E25F2
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212667; cv=none; b=SMT3Fny/G3vD5LQrZi08OIMrkI43SFeZ2TpiDZ8AOrfZaQ9VlMKHVDHZgzXbyOatratKjuxP8Qcwq0iDO91iX6KcfglOocAI05oC0fNb8ygVXndnUk5bM/pOGKWId6Nk82HDooZO8ZN//Saa7Z5LBbCcpdnrXaxugG9aWc6fWpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212667; c=relaxed/simple;
	bh=qmge71woc4fFFxS4gcekvyfzuF+FfxUZWktJHFZ0E6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slfFT5trEyJ7V77PpYcjYVfSaP4TJt1xdCe4lzDVnmp//9RexZu+fPI8YYcbfx6fNXwTOO+gDKFRIbvvMs+dI7eEq+uTVpay7VsILroADht6XGtpBwvg4QnI5aTZC9A8LhMWytCLn5/3jpzwbz6S/B7uBbTexyooUbb4Y+gtarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=NsQNgn5j; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="NsQNgn5j"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=NsQNgn5jnywULRFAwy9DHiF/xOPnGd+ZecqbyFR39cZr4CwzHvk476xe6eBjKusm5IvrR7w1ntvW8gwz2/GXRh1LXz4fvHitmWV5meH15lQ6xayoblr8Kc9q5bU2wfuCSpuuk33MwDtVNN2WmZW4eGd69LIJl/STg1/qtMKIk087w0y7V1hGn581xZYM2JGK1KrieWYxgk636v6EEose2N3XgGJfgFup4B3bcq0hc/mh5pdIHbr9NcAnuv4w26bvpv0tAo3ITHJxY9hdhFjA9tnLKtaktNWpbprLw+mBfTHUQXqvNwowpG67nxxNsa8E5EhVNFNBYB06E7MMqLuDQA==; s=purelymail2; d=purelymail.com; v=1; bh=qmge71woc4fFFxS4gcekvyfzuF+FfxUZWktJHFZ0E6U=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1492705212;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 May 2025 19:03:53 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v3 2/5] mbimmodem: add support for MBIM extensions With MBIMEx 3.0, arguments for activating GPRS changed. Update as needed.
Date: Sat,  3 May 2025 00:03:15 +0500
Message-ID: <20250502190318.41366-3-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502190318.41366-1-thevancedgamer@mentallysanemainliners.org>
References: <20250502190318.41366-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

From: Muhammad <thevancedgamer@mentallysanemainliners.org>

---
 drivers/mbimmodem/gprs-context.c | 59 ++++++++++++++++++++++++--------
 drivers/mbimmodem/mbim.c         | 55 +++++++++++++++++++++++++++++
 drivers/mbimmodem/mbim.h         |  7 ++++
 3 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-cont=
ext.c
index c420e300..e912b6a5 100644
--- a/drivers/mbimmodem/gprs-context.c
+++ b/drivers/mbimmodem/gprs-context.c
@@ -102,9 +102,16 @@ static void mbim_gprs_deactivate_primary(struct ofono_=
gprs_context *gc,
 =09message =3D mbim_message_new(mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_CONNECT,
 =09=09=09=09=09MBIM_COMMAND_TYPE_SET);
-=09mbim_message_set_arguments(message, "uusssuuu16y",
-=09=09=09=09=09cid, 0, NULL, NULL, NULL, 0, 0, 0,
-=09=09=09=09=09mbim_context_type_internet);
+
+=09if (mbim_device_check_mbimex_version(gcd->device, 3, 0)) {
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
@@ -288,10 +295,18 @@ error:
 =09message =3D mbim_message_new(mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_CONNECT,
 =09=09=09=09=09MBIM_COMMAND_TYPE_SET);
-=09mbim_message_set_arguments(message, "uusssuuu16y",
+
+=09if (mbim_device_check_mbimex_version(gcd->device, 3, 0)) {
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
@@ -352,16 +367,32 @@ static void mbim_gprs_activate_primary(struct ofono_g=
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
+=09if (mbim_device_check_mbimex_version(gcd->device, 3, 0)) {
+=09=09mbim_message_set_arguments(message, "uuuuu16yussss",
+=09=09=09ctx->cid,
+=09=09=091, // Activate
+=09=09=090, // Compression
+=09=09=09auth_method_to_auth_protocol(ctx->auth_method),
+=09=09=09proto_to_context_ip_type(ctx->proto),
+=09=09=09mbim_context_type_internet,
+=09=09=090, // MbimMediaTypeNone
+=09=09=09ctx->apn,
+=09=09=09username,
+=09=09=09password,
+=09=09=09NULL);
+=09} else {
+=09=09mbim_message_set_arguments(message, "uusssuuu16y",
+=09=09=09ctx->cid,
+=09=09=091, // Activate
+=09=09=09ctx->apn,
+=09=09=09username,
+=09=09=09password,
+=09=09=090, // compression
+=09=09=09auth_method_to_auth_protocol(ctx->auth_method),
+=09=09=09proto_to_context_ip_type(ctx->proto),
+=09=09=09mbim_context_type_internet);
+=09}
=20
 =09if (mbim_device_send(gcd->device, GPRS_CONTEXT_GROUP, message,
 =09=09=09=09mbim_activate_cb, gc, NULL) > 0)
diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
index 43ff9704..be4df986 100644
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
@@ -253,6 +258,11 @@ struct mbim_device {
 =09struct message_assembly *assembly;
 =09struct l_idle *close_io;
=20
+=09uint8_t mbim_version_major;
+=09uint8_t mbim_version_minor;
+=09uint8_t mbimex_version_major;
+=09uint8_t mbimex_version_minor;
+
 =09bool is_ready : 1;
 =09bool in_notify : 1;
 };
@@ -875,6 +885,22 @@ static bool close_read_handler(struct l_io *io, void *=
user_data)
 =09return true;
 }
=20
+static void parse_mbim_version(struct mbim_message *message, void *user_da=
ta)
+{
+=09struct mbim_device *device =3D user_data;
+=09uint16_t mbim_version =3D 0, mbimex_version =3D 0;
+
+=09if (mbim_message_get_error(message) !=3D 0)
+=09=09return;
+
+=09mbim_message_get_arguments(message, "qq", &mbim_version, &mbimex_versio=
n);
+
+=09device->mbim_version_major =3D mbim_version >> 8;
+=09device->mbim_version_minor =3D mbim_version & 0xFF;
+=09device->mbimex_version_major =3D mbimex_version >> 8;
+=09device->mbimex_version_minor =3D mbimex_version & 0xFF;
+}
+
 struct mbim_device *mbim_device_new(int fd, uint32_t max_segment_size)
 {
 =09struct mbim_device *device;
@@ -1035,6 +1061,35 @@ bool mbim_device_set_ready_handler(struct mbim_devic=
e *device,
 =09return true;
 }
=20
+void mbim_device_get_version(struct mbim_device *device)
+{
+=09// Version is formatted as (major version) << 8 | (minor version)
+=09const int mbim_version =3D 1 << 8 | 0;
+
+=09// Always open with MBIMEx 3, devices not supporting it will fallback t=
o MBIMEx 2
+=09const int mbimex_version =3D 3 << 8 | 0;
+
+=09struct mbim_message *message =3D mbim_message_new(mbim_ms_basic_connect=
_extensions,
+=09=09=09=09=09MBIM_CID_MS_BASIC_CONNECT_EXTENSIONS_VERSION,
+=09=09=09=09=09MBIM_COMMAND_TYPE_QUERY);
+
+=09mbim_message_set_arguments(message, "qq",
+=09=09=09=09=09=09=09=09mbim_version,
+=09=09=09=09=09=09=09=09mbimex_version);
+
+=09// For some reason, sending a message will return an error code, even i=
f valid
+=09mbim_device_send(device, 0, message,
+=09=09=09=09=09=09parse_mbim_version, device, NULL);
+}
+
+bool mbim_device_check_mbimex_version(struct mbim_device *device,
+=09=09=09=09=09int version_major, int version_minor)
+{
+=09return (device->mbimex_version_major > version_major) ||
+=09=09=09((device->mbimex_version_major =3D=3D version_major) &&
+=09=09=09(device->mbimex_version_minor >=3D version_minor));
+}
+
 uint32_t mbim_device_send(struct mbim_device *device, uint32_t gid,
 =09=09=09=09struct mbim_message *message,
 =09=09=09=09mbim_device_reply_func_t function,
diff --git a/drivers/mbimmodem/mbim.h b/drivers/mbimmodem/mbim.h
index 5f15d0a2..4a6c8f47 100644
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
@@ -118,6 +121,10 @@ bool mbim_device_set_ready_handler(struct mbim_device =
*device,
 =09=09=09=09=09void *user_data,
 =09=09=09=09=09mbim_device_destroy_func_t destroy);
=20
+void mbim_device_get_version(struct mbim_device *device);
+bool mbim_device_check_mbimex_version(struct mbim_device *device,
+=09=09=09=09=09int version_major, int version_minor);
+
 uint32_t mbim_device_send(struct mbim_device *device, uint32_t gid,
 =09=09=09=09struct mbim_message *message,
 =09=09=09=09mbim_device_reply_func_t function,
--=20
2.49.0


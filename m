Content-Type: multipart/mixed; boundary="===============4459804433423982750=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 04/10] hfpmodem: Add support for storing the supported
 codecs
Date: Fri, 18 Jan 2013 20:21:50 -0300
Message-ID: <1358551316-27305-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358551316-27305-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4459804433423982750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

As informing the AG of the supported codecs is part of the setup
of the SLC, it makes sense to have this information inside the SLC
establishment part.

In case we have only one codec, we don't inform the other side that
we support the codec negotiation feature. From the spec: "If Wide
Band Speech is supported, Codec Negotiation shall also be supported."
HFP 1.6, Section 3, page 16.
---
 drivers/hfpmodem/slc.c  |  8 ++++++--
 drivers/hfpmodem/slc.h  | 10 +++++++++-
 plugins/hfp_hf_bluez4.c |  2 +-
 plugins/phonesim.c      |  6 +++++-
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 646befa..06153fc 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -52,7 +52,8 @@ struct slc_establish_data {
 	gpointer userdata;
 };
 =

-void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version)
+void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version,
+						unsigned char *codecs, int len)
 {
 	info->ag_features =3D 0;
 	info->ag_mpty_features =3D 0;
@@ -67,11 +68,14 @@ void hfp_slc_info_init(struct hfp_slc_info *info, guint=
16 version)
 	info->hf_features |=3D HFP_HF_FEATURE_ENHANCED_CALL_STATUS;
 	info->hf_features |=3D HFP_HF_FEATURE_ENHANCED_CALL_CONTROL;
 =

-	if (version < HFP_VERSION_1_6)
+	if (version < HFP_VERSION_1_6 || len <=3D 1)
 		goto done;
 =

 	info->hf_features |=3D HFP_HF_FEATURE_CODEC_NEGOTIATION;
 =

+	info->codecs =3D g_memdup(codecs, len);
+	info->codecs_len =3D len;
+
 done:
 	memset(info->cind_val, 0, sizeof(info->cind_val));
 	memset(info->cind_pos, 0, sizeof(info->cind_pos));
diff --git a/drivers/hfpmodem/slc.h b/drivers/hfpmodem/slc.h
index b71ffe9..d7c90a2 100644
--- a/drivers/hfpmodem/slc.h
+++ b/drivers/hfpmodem/slc.h
@@ -44,6 +44,11 @@ enum hfp_indicator {
 	HFP_INDICATOR_LAST
 };
 =

+enum hfp_codec {
+	HFP_CODEC_CVSD =3D 0x01,
+	HFP_CODEC_MSBC =3D 0x02,
+};
+
 typedef void (*hfp_slc_cb_t)(void *userdata);
 =

 struct hfp_slc_info {
@@ -53,9 +58,12 @@ struct hfp_slc_info {
 	unsigned int hf_features;
 	unsigned char cind_pos[HFP_INDICATOR_LAST];
 	unsigned int cind_val[HFP_INDICATOR_LAST];
+	unsigned char *codecs;
+	int codecs_len;
 };
 =

-void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version);
+void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version,
+					unsigned char *codecs, int len);
 void hfp_slc_info_free(struct hfp_slc_info *info);
 =

 void hfp_slc_establish(struct hfp_slc_info *info, hfp_slc_cb_t connect_cb,
diff --git a/plugins/hfp_hf_bluez4.c b/plugins/hfp_hf_bluez4.c
index 450c183..e7fce31 100644
--- a/plugins/hfp_hf_bluez4.c
+++ b/plugins/hfp_hf_bluez4.c
@@ -170,7 +170,7 @@ static DBusMessage *hfp_agent_new_connection(DBusConnec=
tion *conn,
 				DBUS_TYPE_UINT16, &version, DBUS_TYPE_INVALID))
 		return __ofono_error_invalid_args(msg);
 =

-	hfp_slc_info_init(&hfp_data->info, version);
+	hfp_slc_info_init(&hfp_data->info, version, NULL, 0);
 =

 	err =3D service_level_connection(modem, fd);
 	if (err < 0 && err !=3D -EINPROGRESS)
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 26f96d0..8631039 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -896,6 +896,7 @@ static int localhfp_enable(struct ofono_modem *modem)
 	GAtSyntax *syntax;
 	GAtChat *chat;
 	const char *address;
+	unsigned char codecs[1];
 	int sk, port;
 =

 	address =3D ofono_modem_get_string(modem, "Address");
@@ -929,7 +930,10 @@ static int localhfp_enable(struct ofono_modem *modem)
 =

 	g_at_chat_set_disconnect_function(chat, slc_failed, modem);
 =

-	hfp_slc_info_init(info, HFP_VERSION_LATEST);
+	memset(codecs, 0, sizeof(codecs));
+	codecs[0] =3D HFP_CODEC_CVSD;
+
+	hfp_slc_info_init(info, HFP_VERSION_LATEST, codecs, 1);
 	info->chat =3D chat;
 	hfp_slc_establish(info, slc_established, slc_failed, modem);
 =

-- =

1.7.11.7


--===============4459804433423982750==--


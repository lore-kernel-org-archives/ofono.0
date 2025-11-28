Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15343288537
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351449; cv=none; b=OQgJ2lzivsqTXKe0JAD1qewmS40rHdxTG9W1r2fotXzZW3k6Jht3jDFe72ATThJLuPx0bCGr4l2iR0DMo6bsvZAYBxP8ABn7pvdkN5O38dDOdltrAtnqAjLFY7d8DL84rA1jiiaHqHrKt27ZPsOV5YNMCEBBBaNtw0tkbJceVaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351449; c=relaxed/simple;
	bh=26KKxSMvEMG0YhI8afQvbNV/P/NijEZPSyDRIRbV2OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5fo5EJIid/2wt60EtBxMiQKeAOp4oub7OUfOuiD9o8EFpfFC/1BhmnaEXDaZPdoqsDqgq2CkY3uh4W1b7fTV2Iku09Pw68x7HBtd/td696dHPXTTpdsWNvXn0LdVskhkw1Qtiz5glMDyrlkRh2pFJghsDkJvDuTjEV04sHsIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=FCGtKgS2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="FCGtKgS2"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=FCGtKgS21meFYzwN6x2Lw3SrVvLzwCMY5sjw2z8IciQiYLxqXEhJ5ySlAtj2vw3iRVgVtEfLzH3rDNZL96gHVAA7fIWYZHJG7jx+5TqkoqIs8CxsDzFz6qGje2RvhEu+9Bio90WgN7k1c3niBYT5FvxCN/dVCyfSwv49bsw1YxM0Cpya2lqTgIr0FRfrFkXCoF2mz1i9HVVIz+vFSgvXOebn3xqBRMJTLIdWK2OxEieQ1WG497fbz0kd5HnbT+9MMkZi7NyV0TMHoNDVnW2Es3N4Dw6z2UKPb4GXOYsJ5uIZi/WTnJIbHeh9v3bV/aEaMtDTEcQwwPFgm0Vb7rkYag==; s=purelymail2; d=purelymail.com; v=1; bh=26KKxSMvEMG0YhI8afQvbNV/P/NijEZPSyDRIRbV2OA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1079628981;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:37:24 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v7 09/10] mbim: Add support for SIM I/O operations
Date: Fri, 28 Nov 2025 22:36:55 +0500
Message-ID: <20251128173656.55692-10-thevancedgamer@mentallysanemainliners.org>
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

Adds support for mostly complete SIM I/O operations, with no broken
master paths for now.
---
 drivers/mbimmodem/mbim.c |   5 +
 drivers/mbimmodem/mbim.h |  16 +++
 drivers/mbimmodem/sim.c  | 219 ++++++++++++++++++++++++++++++++++-----
 drivers/mbimmodem/util.c |  37 +++++++
 drivers/mbimmodem/util.h |   2 +
 5 files changed, 254 insertions(+), 25 deletions(-)

diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
index cd642515..6289497b 100644
--- a/drivers/mbimmodem/mbim.c
+++ b/drivers/mbimmodem/mbim.c
@@ -112,6 +112,11 @@ const uint8_t mbim_ms_basic_connect_extensions[] =3D {
 =090xBE, 0xF7, 0x05, 0x8E, 0x9A, 0xAF,
 };
=20
+const uint8_t mbim_ms_uicc_low_level_access[] =3D {
+=090xC2, 0xF6, 0x58, 0x8E, 0xF0, 0x37, 0x4B, 0xC9, 0x86, 0x65,
+=090xF4, 0xD4, 0x4B, 0xD0, 0x93, 0x67
+};
+
 struct message_assembly_node {
 =09struct mbim_message_header msg_hdr;
 =09struct mbim_fragment_header frag_hdr;
diff --git a/drivers/mbimmodem/mbim.h b/drivers/mbimmodem/mbim.h
index 7101d811..70142cc9 100644
--- a/drivers/mbimmodem/mbim.h
+++ b/drivers/mbimmodem/mbim.h
@@ -33,6 +33,11 @@ struct mbim_message;
=20
 #define MBIM_CID_MS_BASIC_CONNECT_EXTENSIONS_VERSION=0915
=20
+#define MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_APPLICATION_LIST 7
+#define MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_FILE_STATUS=098
+#define MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_READ_BINARY=099
+#define MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_READ_RECORD=0910
+
 #define MBIM_CID_SMS_CONFIGURATION=09=091
 #define MBIM_CID_SMS_READ=09=09=092
 #define MBIM_CID_SMS_SEND=09=09=093
@@ -75,6 +80,16 @@ enum mbim_data_class {
 =09MBIM_DATA_CLASS_CUSTOM=09=09=3D 0x80000000,
 };
=20
+enum mbim_app_type {
+=09MBIM_APP_UNKNOWN,
+=09MBIM_APP_MF,
+=09MBIM_APP_MF_SIM,
+=09MBIM_APP_MF_RUIM,
+=09MBIM_APP_USIM,
+=09MBIM_APP_CSIM,
+=09MBIM_APP_ISIM,
+};
+
 typedef void (*mbim_device_debug_func_t) (const char *str, void *user_data=
);
 typedef void (*mbim_device_disconnect_func_t) (void *user_data);
 typedef void (*mbim_device_destroy_func_t) (void *user_data);
@@ -90,6 +105,7 @@ extern const uint8_t mbim_uuid_stk[];
 extern const uint8_t mbim_uuid_auth[];
 extern const uint8_t mbim_uuid_dss[];
 extern const uint8_t mbim_ms_basic_connect_extensions[];
+extern const uint8_t mbim_ms_uicc_low_level_access[];
=20
 extern const uint8_t mbim_context_type_none[];
 extern const uint8_t mbim_context_type_internet[];
diff --git a/drivers/mbimmodem/sim.c b/drivers/mbimmodem/sim.c
index 15b5c91c..498629d2 100644
--- a/drivers/mbimmodem/sim.c
+++ b/drivers/mbimmodem/sim.c
@@ -25,14 +25,39 @@
 #include "drivers/mbimmodem/mbim-message.h"
 #include "drivers/mbimmodem/mbimmodem.h"
=20
+struct sim_app {
+=09enum mbim_app_type app_type;
+=09uint32_t aid_len;
+=09uint8_t *aid;
+=09char *label;
+=09uint32_t pin_key_references;
+};
+
 struct sim_data {
 =09struct mbim_device *device;
+=09uint32_t app_count;
+=09uint32_t active_app;
+=09struct sim_app *apps;
 =09char *iccid;
 =09char *imsi;
 =09uint32_t last_pin_type;
 =09bool present : 1;
 };
=20
+static uint32_t mbim_file_structure_to_ofono(uint32_t file_structure)
+{
+=09switch (file_structure) {
+=09case 1:
+=09=09return OFONO_SIM_FILE_STRUCTURE_TRANSPARENT;
+=09case 2:
+=09=09return OFONO_SIM_FILE_STRUCTURE_CYCLIC;
+=09case 3:
+=09=09return OFONO_SIM_FILE_STRUCTURE_FIXED;
+=09default:
+=09=09return OFONO_SIM_FILE_STRUCTURE_TRANSPARENT;
+=09}
+}
+
 static void mbim_sim_state_changed(struct ofono_sim *sim, uint32_t ready_s=
tate)
 {
 =09struct sim_data *sd =3D ofono_sim_get_data(sim);
@@ -79,43 +104,131 @@ static void mbim_read_imsi(struct ofono_sim *sim,
 =09CALLBACK_WITH_SUCCESS(cb, sd->imsi, user_data);
 }
=20
-static void mbim_read_file_info(struct ofono_sim *sim,
-=09=09=09=09=09int fileid, const unsigned char *path,
-=09=09=09=09=09unsigned int path_len,
-=09=09=09=09=09ofono_sim_file_info_cb_t cb, void *user_data)
+static void read_file_info_cb(struct mbim_message *message, void *user_dat=
a)
 {
+=09struct cb_data *cbd =3D user_data;
+=09ofono_sim_file_info_cb_t cb =3D cbd->cb;
 =09unsigned char access[3] =3D {0x0f, 0xff, 0xff};
+=09uint32_t version, status_word1, status_word2, file_accessibility;
+=09uint32_t file_type, file_structure, file_item_count, file_item_size;
+
+=09if (!mbim_message_get_error(message)) {
+=09=09mbim_message_get_arguments(message, "uuuuuuuu", &version, &status_wo=
rd1,
+=09=09=09=09=09&status_word2, &file_accessibility,
+=09=09=09=09=09&file_type, &file_structure,
+=09=09=09=09=09&file_item_count, &file_item_size);
+
+=09=09CALLBACK_WITH_SUCCESS(cb, file_item_size,
+=09=09=09=09=09mbim_file_structure_to_ofono(file_structure),
+=09=09=09=09=09file_item_size * file_item_count,
+=09=09=09=09=09access, file_accessibility, cbd->data);
+=09} else {
+=09=09CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, -1, cbd->data);
+=09}
+}
=20
-=09switch (fileid) {
-=09case SIM_EF_ICCID_FILEID:
-=09=09CALLBACK_WITH_SUCCESS(cb, 10, 0, 0, access, 1, user_data);
-=09=09break;
-=09default:
-=09=09CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, 0, user_data);
-=09=09break;
+static void mbim_read_file_info(struct ofono_sim *sim,
+=09=09=09=09int fileid, const unsigned char *path,
+=09=09=09=09unsigned int path_len,
+=09=09=09=09ofono_sim_file_info_cb_t cb, void *user_data)
+{
+=09struct sim_data *data =3D ofono_sim_get_data(sim);
+=09struct cb_data *cbd =3D cb_data_new(cb, user_data);
+=09struct mbim_message *message;
+=09uint8_t *file_id;
+
+=09message =3D mbim_message_new(mbim_ms_uicc_low_level_access,
+=09=09=09=09=09MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_FILE_STATUS,
+=09=09=09=09=09MBIM_COMMAND_TYPE_QUERY);
+
+=09file_id =3D mbim_get_fileid(fileid);
+=09mbim_message_set_arguments(message, "uayay", 1,
+=09=09=09=09=09data->apps[data->active_app].aid_len,
+=09=09=09=09=09data->apps[data->active_app].aid,
+=09=09=09=09=094, file_id);
+=09l_free(file_id);
+
+=09mbim_device_send(data->device, SIM_GROUP, message, read_file_info_cb, c=
bd, l_free);
+}
+
+static void read_file_cb(struct mbim_message *message, void *user_data)
+{
+=09struct cb_data *cbd =3D user_data;
+=09ofono_sim_read_cb_t cb =3D cbd->cb;
+=09struct mbim_message_iter iter;
+=09uint32_t version, status_word1, status_word2, data_size;
+=09uint8_t *data =3D NULL;
+=09int i =3D 0;
+
+=09if (!mbim_message_get_error(message)) {
+=09=09mbim_message_get_arguments(message, "uuuAy", &version,
+=09=09=09=09=09=09&status_word1, &status_word2, &iter);
+
+=09=09data_size =3D iter.n_elem;
+=09=09data =3D l_malloc(data_size);
+=09=09while (mbim_message_iter_next_entry(&iter, data + i))
+=09=09=09i++;
+
+=09=09CALLBACK_WITH_SUCCESS(cb, data, data_size, cbd->data);
+=09} else {
+=09=09CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
 =09}
+
+=09/* The data gets copied by ofono's sim driver, so we can free it */
+=09if (data)
+=09=09l_free(data);
 }
=20
 static void mbim_read_file_transparent(struct ofono_sim *sim,
-=09=09=09=09=09int fileid,=09int start, int length,
+=09=09=09=09=09int fileid, int start, int length,
 =09=09=09=09=09const unsigned char *path, unsigned int path_len,
 =09=09=09=09=09ofono_sim_read_cb_t cb, void *user_data)
 {
 =09struct sim_data *sd =3D ofono_sim_get_data(sim);
-=09unsigned char iccid[10];
-=09int iccid_len, len =3D strlen(sd->imsi);
+=09struct cb_data *cbd =3D cb_data_new(cb, user_data);
+=09struct mbim_message *message;
+=09uint8_t *file_id;
=20
-=09sim_encode_bcd_number(sd->iccid, iccid);
-=09iccid_len =3D len / 2;
+=09message =3D mbim_message_new(mbim_ms_uicc_low_level_access,
+=09=09=09=09=09MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_READ_BINARY,
+=09=09=09=09=09MBIM_COMMAND_TYPE_QUERY);
=20
-=09switch (fileid) {
-=09case SIM_EF_ICCID_FILEID:
-=09=09CALLBACK_WITH_SUCCESS(cb, iccid, iccid_len, user_data);
-=09=09break;
-=09default:
-=09=09CALLBACK_WITH_FAILURE(cb, NULL, 0, user_data);
-=09=09break;
-=09}
+=09file_id =3D mbim_get_fileid(fileid);
+=09mbim_message_set_arguments(message, "uayayuusay", 1,
+=09=09=09=09=09sd->apps[sd->active_app].aid_len,
+=09=09=09=09=09sd->apps[sd->active_app].aid,
+=09=09=09=09=094, file_id, start,
+=09=09=09=09=09length, "", 0, NULL);
+=09l_free(file_id);
+
+=09mbim_device_send(sd->device, SIM_GROUP, message,
+=09=09=09=09read_file_cb, cbd, l_free);
+}
+
+static void mbim_read_file_fixed_cyclic(struct ofono_sim *sim,
+=09=09=09=09=09int fileid, int record, int length,
+=09=09=09=09=09const unsigned char *path, unsigned int path_len,
+=09=09=09=09=09ofono_sim_read_cb_t cb, void *data)
+{
+=09struct sim_data *sd =3D ofono_sim_get_data(sim);
+=09struct cb_data *cbd =3D cb_data_new(cb, data);
+=09struct mbim_message *message;
+=09uint8_t *file_id;
+
+=09message =3D mbim_message_new(mbim_ms_uicc_low_level_access,
+=09=09=09=09=09MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_READ_RECORD,
+=09=09=09=09=09MBIM_COMMAND_TYPE_QUERY);
+
+=09file_id =3D mbim_get_fileid(fileid);
+=09mbim_message_set_arguments(message, "uayayusay", 1,
+=09=09=09=09=09sd->apps[sd->active_app].aid_len,
+=09=09=09=09=09sd->apps[sd->active_app].aid,
+=09=09=09=09=094, file_id, record,
+=09=09=09=09=09"", 0, NULL);
+=09l_free(file_id);
+
+=09mbim_device_send(sd->device, SIM_GROUP, message,
+=09=09=09=09read_file_cb, cbd, l_free);
 }
=20
 static enum ofono_sim_password_type mbim_pin_type_to_sim_password(
@@ -499,7 +612,6 @@ static void mbim_subscriber_ready_status_cb(struct mbim=
_message *message,
 =09sd->iccid =3D iccid;
 =09sd->imsi =3D imsi;
=20
-=09DBG("Got ICCID! %s", iccid);
 =09if (!mbim_device_register(sd->device, SIM_GROUP,
 =09=09=09=09=09mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_SUBSCRIBER_READY_STATUS,
@@ -516,6 +628,47 @@ error:
 =09ofono_sim_remove(sim);
 }
=20
+static void mbim_sim_list_apps_cb(struct mbim_message *message,
+=09=09=09=09=09void *user)
+{
+=09struct sim_data *data =3D ofono_sim_get_data(user);
+=09uint32_t version, count, active_app;
+=09uint32_t application_id, size, pin_key_references;
+=09char *aid_label;
+=09struct mbim_message_iter iter, aid_iter, pin_iter;
+=09int i =3D 0;
+
+=09if (mbim_message_get_error(message))
+=09=09return;
+
+=09if (!mbim_message_get_arguments(message, "uuuua(uAysuAy)", &version,
+=09=09=09=09=09&count, &active_app, &size, &iter)) {
+=09=09data->apps =3D NULL;
+=09=09data->app_count =3D 0;
+=09=09return;
+=09}
+
+=09data->apps =3D l_new(struct sim_app, count);
+=09data->active_app =3D active_app;
+=09data->app_count =3D count;
+
+=09while (mbim_message_iter_next_entry(&iter, &application_id, &aid_iter,
+=09=09=09=09=09&aid_label, &pin_key_references, &pin_iter)) {
+=09=09int j =3D 0;
+
+=09=09data->apps[i].app_type =3D application_id;
+=09=09data->apps[i].aid_len =3D aid_iter.n_elem;
+=09=09data->apps[i].aid =3D l_malloc(aid_iter.n_elem);
+
+=09=09while (mbim_message_iter_next_entry(&aid_iter,
+=09=09=09=09=09=09=09data->apps[i].aid + j))
+=09=09=09j++;
+
+=09=09data->apps[i].label =3D aid_label;
+=09=09i++;
+=09}
+}
+
 static int mbim_sim_probe(struct ofono_sim *sim, unsigned int vendor,
 =09=09=09=09void *data)
 {
@@ -523,6 +676,14 @@ static int mbim_sim_probe(struct ofono_sim *sim, unsig=
ned int vendor,
 =09struct mbim_message *message;
 =09struct sim_data *sd;
=20
+=09message =3D mbim_message_new(mbim_ms_uicc_low_level_access,
+=09=09=09=09=09MBIM_CID_MS_UICC_LOW_LEVEL_ACCESS_APPLICATION_LIST,
+=09=09=09=09=09MBIM_COMMAND_TYPE_QUERY);
+=09mbim_message_set_arguments(message, "");
+
+=09mbim_device_send(device, SIM_GROUP, message,
+=09=09=09mbim_sim_list_apps_cb, sim, NULL);
+
 =09message =3D mbim_message_new(mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_SUBSCRIBER_READY_STATUS,
 =09=09=09=09=09MBIM_COMMAND_TYPE_QUERY);
@@ -557,6 +718,12 @@ static void mbim_sim_remove(struct ofono_sim *sim)
=20
 =09l_free(sd->iccid);
 =09l_free(sd->imsi);
+
+=09for (int i =3D 0; i < sd->app_count; i++)
+=09=09l_free(sd->apps[i].label);
+
+=09l_free(sd->apps);
+
 =09l_free(sd);
 }
=20
@@ -565,6 +732,8 @@ static const struct ofono_sim_driver driver =3D {
 =09.remove=09=09=09=3D mbim_sim_remove,
 =09.read_file_info=09=09=3D mbim_read_file_info,
 =09.read_file_transparent=09=3D mbim_read_file_transparent,
+=09.read_file_cyclic=09=3D mbim_read_file_fixed_cyclic,
+=09.read_file_linear=09=3D mbim_read_file_fixed_cyclic,
 =09.read_imsi=09=09=3D mbim_read_imsi,
 =09.query_passwd_state=09=3D mbim_pin_query,
 =09.query_pin_retries=09=3D mbim_pin_retries_query,
diff --git a/drivers/mbimmodem/util.c b/drivers/mbimmodem/util.c
index 4a3d9627..731764fc 100644
--- a/drivers/mbimmodem/util.c
+++ b/drivers/mbimmodem/util.c
@@ -9,6 +9,7 @@
 #include <stdbool.h>
=20
 #include "src/common.h"
+#include "simutil.h"
 #include "mbim.h"
 #include "util.h"
=20
@@ -37,3 +38,39 @@ int mbim_data_class_to_tech(uint32_t n)
=20
 =09return -1;
 }
+
+uint8_t *mbim_get_fileid(uint32_t fileid)
+{
+=09/* TODO: Handle MF paths for different app types */
+
+=09/* File IDs are always 4 bytes */
+=09uint8_t *out =3D l_malloc(4);
+=09uint32_t mf_path;
+
+=09switch (fileid) {
+=09case SIM_EF_ICCID_FILEID:
+=09case SIM_EFPL_FILEID:
+=09=09mf_path =3D SIM_MF_FILEID;
+=09=09break;
+=09case SIM_EFIMG_FILEID:
+=09=09mf_path =3D 0x5F50;
+=09=09break;
+=09case SIM_EFADN_FILEID:
+=09=09mf_path =3D 0x7F10;
+=09=09break;
+=09case SIM_EFPHASE_FILEID:
+=09=09mf_path =3D 0x0000;
+=09=09break;
+=09default:
+=09=09mf_path =3D 0x7FFF;
+=09=09break;
+=09}
+
+=09/* Serialize the IDs into one byte array */
+=09out[0] =3D (mf_path >> 8) & 0xFF;
+=09out[1] =3D mf_path & 0xFF;
+=09out[2] =3D (fileid >> 8) & 0xFF;
+=09out[3] =3D fileid & 0xFF;
+
+=09return out;
+}
diff --git a/drivers/mbimmodem/util.h b/drivers/mbimmodem/util.h
index 2172cd9f..2d260fd5 100644
--- a/drivers/mbimmodem/util.h
+++ b/drivers/mbimmodem/util.h
@@ -43,3 +43,5 @@ static inline struct cb_data *cb_data_new(void *cb, void =
*data)
 =09} while (0)
=20
 int mbim_data_class_to_tech(uint32_t n);
+uint8_t *mbim_get_fileid(uint32_t fileid);
+
--=20
2.52.0


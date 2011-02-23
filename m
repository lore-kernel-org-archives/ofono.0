Content-Type: multipart/mixed; boundary="===============0483130766287778886=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 18/18] isimodem: initial support for UICC phonebook
Date: Wed, 23 Feb 2011 12:43:29 +0100
Message-ID: <690fd1e6cb2a24b39cb54a1172d9f6bc8895f5dd.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0483130766287778886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/phonebook.c | 1273 ++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 1243 insertions(+), 30 deletions(-)

diff --git a/drivers/isimodem/phonebook.c b/drivers/isimodem/phonebook.c
index 1f92d37..6b136b0 100644
--- a/drivers/isimodem/phonebook.c
+++ b/drivers/isimodem/phonebook.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) ST-Ericsson SA 2011.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -36,16 +37,40 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/phonebook.h>
+#include <ofono/sim.h>
 #include "util.h"
 =

 #include "isimodem.h"
 #include "isiutil.h"
 #include "sim.h"
+#include "simutil.h"
 #include "debug.h"
+#include "uicc.h"
 =

-struct pb_data {
-	GIsiClient *client;
-};
+/* File info parameters */
+#define FCP_TEMPLATE			0x62
+#define FCP_FILE_SIZE			0x80
+#define FCP_FILE_DESC			0x82
+#define FCP_FILE_ID			0x83
+#define FCP_FILE_LIFECYCLE		0x8A
+#define FCP_FILE_SECURITY_ARR		0x8B
+#define FCP_FILE_SECURITY_COMPACT	0x8C
+#define FCP_FILE_SECURITY_EXPANDED	0xAB
+
+#define UNUSED				0xFF
+
+#define EXT1_CP_SUBADDRESS		1
+#define EXT1_ADDITIONAL_DATA		2
+
+#define NAME_SIZE			64
+#define NUMBER_SIZE			256
+#define EMAIL_SIZE			128
+#define EXT_NUMBER_SIZE			24
+#define SNE_SIZE			64
+
+/* TON (Type Of Number) See TS 24.008 */
+#define TON_MASK 0x70
+#define TON_INTERNATIONAL 0x10
 =

 struct read_resp {
 	uint8_t service_type;
@@ -53,6 +78,81 @@ struct read_resp {
 	uint8_t data[];
 };
 =

+enum constructed_tag {
+	TYPE_1_TAG =3D	0xA8,
+	TYPE_2_TAG =3D	0xA9,
+	TYPE_3_TAG =3D	0xAA
+};
+
+enum file_type_tag {
+	TYPE_ADN =3D	0xC0,
+	TYPE_IAD =3D	0xC1,
+	TYPE_EXT1 =3D	0xC2,
+	TYPE_SNE =3D	0xC3,
+	TYPE_ANR =3D	0xC4,
+	TYPE_PBC =3D	0xC5,
+	TYPE_GPR =3D	0xC6,
+	TYPE_AAS =3D	0xC7,
+	TYPE_GAS =3D	0xC8,
+	TYPE_UID =3D	0xC9,
+	TYPE_EMAIL =3D	0xCA,
+	TYPE_CCP1 =3D	0xCB
+};
+
+struct pb_file_info {
+	int file_id;
+	uint8_t file_type;
+	uint8_t structure;
+	int file_length;
+	int record_length;
+	int record;
+	gboolean handled;
+};
+
+struct file_info {
+	int fileid;
+	int length;
+	int structure;
+	int record_length;
+	unsigned char access[3];
+};
+
+struct phonebook_entry {
+	int entry;
+	char *name;
+	char *number;
+	char *email;
+	char *anr;
+	char *sne;
+};
+
+struct pb_data {
+	GIsiClient *client;
+	GIsiClient *primary;
+	GIsiClient *secondary;
+	gint pb_entry;
+	struct pb_file_info pb_reference_file_info;
+	struct pb_file_info *extension_file_info;
+	uint8_t ext1_to_type;
+	uint8_t ext1_to_entry;
+};
+
+static GSList *pb_files;
+static GSList *pb_next;
+
+static GSList *phonebook_entry_start;
+static GSList *phonebook_entry_current;
+
+static void pb_reference_info_cb(const struct ofono_error *error,
+					int filelength,
+					enum ofono_sim_file_structure structure,
+					int recordlength,
+					const unsigned char access[3],
+					unsigned char file_status, void *data);
+static void pb_content_data_read(struct pb_data *pbd,
+					struct pb_file_info *file_info,
+					struct isi_cb_data *cbd);
+
 static gboolean parse_adn(GIsiSubBlockIter *iter, uint16_t *location,
 				char **name, char **number)
 {
@@ -194,6 +294,405 @@ error:
 	return success;
 }
 =

+static void handle_ext1(struct pb_data *pbd, const unsigned char *msg);
+
+static void handle_ext1(struct pb_data *pbd, const unsigned char *msg)
+{
+	uint8_t number_length =3D 0, i, next_extension_record;
+	static const char digit_to_utf8[] =3D "0123456789*#pwe\0";
+	struct pb_file_info *next_file =3D NULL;
+
+	char *ext_number =3D g_try_malloc0(EXT_NUMBER_SIZE);
+	if (ext_number !=3D NULL) {
+		number_length =3D msg[1];
+		for (i =3D 0; i < number_length; i++) {
+			ext_number[2 * i] =3D digit_to_utf8[msg[2 + i] & 0x0f];
+			ext_number[2 * i + 1] =3D
+					digit_to_utf8[(msg[2 + i] >> 4) &
+							0x0f];
+
+		}
+	}
+	next_extension_record =3D msg[number_length + 2];
+
+	DBG("Number extension %s number length %d extension_record %d",
+					ext_number,
+					number_length,
+					next_extension_record);
+
+	/* pb_entry is already incremented & g_slist_nth counts from 0 */
+	if (pbd->ext1_to_type =3D=3D TYPE_ADN) {
+		GSList *list_entry =3D g_slist_nth(phonebook_entry_start,
+							pbd->ext1_to_entry -
+							1);
+		DBG("Looking for ADN entry %d", pbd->ext1_to_entry);
+
+		if (list_entry !=3D NULL) {
+			struct phonebook_entry *entry =3D list_entry->data;
+
+			if (entry !=3D NULL)
+				strcat(entry->number, ext_number);
+			else if (pbd->ext1_to_type =3D=3D TYPE_ANR) {
+				GSList *list_entry =3D g_slist_nth(
+						phonebook_entry_start,
+						pbd->ext1_to_entry - 1);
+				DBG("Looking for ANR entry %d",
+						pbd->ext1_to_entry);
+
+				if (list_entry !=3D NULL) {
+					struct phonebook_entry *entry =3D
+							list_entry->data;
+
+					if (entry !=3D NULL)
+						strcat(entry->anr, ext_number);
+				}
+			}
+			g_free(ext_number);
+			/* Check if there is more extension data */
+			if (next_extension_record !=3D UNUSED) {
+				next_file =3D g_try_new0(struct pb_file_info,
+								1);
+
+				if (next_file !=3D NULL) {
+					if (pbd->extension_file_info) {
+						memmove(next_file,
+						pbd->extension_file_info,
+						sizeof(struct pb_file_info));
+					} else {
+						next_file->file_type =3D
+							TYPE_EXT1;
+						next_file->file_id =3D
+							SIM_EFEXT1_FILEID;
+					}
+					next_file->record =3D
+							next_extension_record;
+				}
+			}
+		}
+	}
+}
+
+static struct pb_file_info *decode_read_response(
+						struct pb_file_info *file_info,
+						const unsigned char *msg,
+						size_t len,
+						struct ofono_phonebook *pb)
+{
+	char *name =3D NULL;
+	char *number =3D NULL;
+	char *email =3D NULL;
+	char *sne =3D NULL;
+	char *anr =3D NULL;
+
+	static const char digit_to_utf8[] =3D "0123456789*#pwe\0";
+
+	struct pb_file_info *next_file =3D NULL;
+	int type =3D file_info->file_type;
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+
+	switch (type) {
+	case TYPE_ADN:{
+			const uint8_t name_length =3D len - 14;
+			const uint8_t number_start =3D name_length;
+			uint8_t number_length =3D 0;
+			uint8_t extension_record =3D UNUSED;
+			uint8_t i, prefix;
+			name =3D sim_string_to_utf8(msg, name_length);
+			/* Length contains also TON&NPI */
+			number_length =3D msg[number_start];
+
+			if ((number_length !=3D UNUSED) && (number_length !=3D 0)) {
+				number =3D g_try_malloc0(NUMBER_SIZE);
+				number_length--;
+
+				if (number) {
+					prefix =3D 0;
+
+					if ((msg[number_start + 1] & TON_MASK)
+							=3D=3D TON_INTERNATIONAL) {
+						number[0] =3D '+';
+						prefix =3D 1;
+					}
+
+					for (i =3D 0; i < number_length; i++) {
+
+						number[2 * i + prefix] =3D
+							digit_to_utf8[msg
+								[number_start
+								+ 2 +
+								i] & 0x0f];
+
+						number[2 * i + 1 + prefix] =3D
+							digit_to_utf8[(msg
+								[number_start
+								+ 2 +
+								i] >> 4) &
+								0x0f];
+					}
+					extension_record =3D msg[len - 1];
+				}
+			}
+			DBG("ADN name %s, number %s number \
+				length %d extension_record %d",
+				name, number, number_length, extension_record);
+
+			if (extension_record !=3D UNUSED) {
+				next_file =3D g_try_new0(struct pb_file_info, 1);
+
+				if (next_file !=3D NULL) {
+					if (pbd->extension_file_info) {
+						memmove(next_file,
+							pbd->
+							extension_file_info,
+							sizeof(struct
+								pb_file_info));
+					} else {
+						next_file->file_type =3D
+							TYPE_EXT1;
+						next_file->file_id =3D
+							SIM_EFEXT1_FILEID;
+					}
+
+					next_file->record =3D extension_record;
+					pbd->ext1_to_type =3D TYPE_ADN;
+					pbd->ext1_to_entry =3D pbd->pb_entry;
+				}
+			}
+
+			if (name || number) {
+				struct phonebook_entry *new_entry =3D
+					g_try_new0(struct phonebook_entry, 1);
+
+				if (new_entry !=3D NULL) {
+					new_entry->name =3D name;
+					new_entry->number =3D number;
+
+					DBG("Creating PB entry %d with \
+						name %s and number %s",
+						pbd->pb_entry,
+						new_entry->name,
+						new_entry->number);
+
+					phonebook_entry_current =3D
+						g_slist_insert
+						(phonebook_entry_start,
+							new_entry,
+							pbd->pb_entry);
+
+					if (!phonebook_entry_start)
+						phonebook_entry_start =3D
+						phonebook_entry_current;
+
+					pbd->pb_entry++;
+				}
+			}
+			break;
+		}
+	case TYPE_SNE:{
+			uint8_t sne_end =3D 0;
+			const uint8_t sne_length =3D len - 2;
+			uint8_t i =3D 0;
+			uint8_t phonebook_entry_nbr =3D msg[len - 1];
+
+			DBG("SNE");
+			for (i =3D 0; (msg[i] !=3D UNUSED) && (i < sne_length);
+					i++)
+				;
+
+			sne_end =3D i;
+			sne =3D sim_string_to_utf8(msg, sne_length);
+
+			if (sne !=3D NULL) {
+				/*
+				 * GSlist nth counts from 0,
+				 * PB entries from 1
+				 */
+				GSList *list_entry =3D
+					g_slist_nth(phonebook_entry_start,
+							phonebook_entry_nbr -
+							1);
+
+				DBG("SNE \'%s\' to PB entry %d", sne,
+					phonebook_entry_nbr);
+
+				if (list_entry !=3D NULL) {
+					struct phonebook_entry *entry =3D
+						list_entry->data;
+
+					if (entry !=3D NULL) {
+						/*
+						 * If one already exists,
+						 * delete it
+						 */
+						if (entry->sne !=3D NULL)
+							g_free(entry->sne);
+
+						DBG("Adding SNE to entry %d,\
+							name %s",
+							phonebook_entry_nbr,
+							entry->name);
+
+						entry->sne =3D sne;
+					} else {
+						g_free(sne);
+					}
+				}
+			}
+
+			break;
+		}
+	case TYPE_ANR:{
+			uint8_t number_length =3D 0;
+			uint8_t extension_record =3D UNUSED;
+			uint8_t aas_record =3D UNUSED;
+			uint8_t i, prefix;
+			uint8_t phonebook_entry_nbr =3D msg[len - 1];
+			GSList *list_entry;
+
+			DBG("ANR");
+			if (msg[0] =3D=3D UNUSED)
+				break;
+
+			aas_record =3D msg[0];
+			/* Length contains also TON&NPI */
+			number_length =3D msg[1];
+
+			if (number_length) {
+				number_length--;
+				anr =3D g_try_malloc0(NUMBER_SIZE);
+
+				if (anr !=3D NULL) {
+					prefix =3D 0;
+
+					if ((msg[2] & TON_MASK) =3D=3D
+					    TON_INTERNATIONAL) {
+						anr[0] =3D '+';
+						prefix =3D 1;
+					}
+
+					for (i =3D 0; i < number_length; i++) {
+						anr[2 * i + prefix] =3D
+							digit_to_utf8[
+								msg[3 + i] &
+								0x0f];
+						anr[2 * i + 1 + prefix] =3D
+							digit_to_utf8[
+								(msg[3 + i] >>
+								4) & 0x0f];
+					}
+
+					extension_record =3D msg[len - 3];
+				}
+			}
+
+			DBG("ANR to entry %d number %s number length %d\
+						extension_record %d aas %d",
+				phonebook_entry_nbr, anr, number_length,
+						extension_record, aas_record);
+
+			if (extension_record !=3D UNUSED) {
+				next_file =3D g_try_new0(struct pb_file_info, 1);
+
+				if (next_file !=3D NULL) {
+					if (pbd->extension_file_info) {
+						memmove(next_file,
+							pbd->
+							extension_file_info,
+							sizeof(struct
+								pb_file_info));
+					} else {
+						next_file->file_type =3D
+							TYPE_EXT1;
+						next_file->file_id =3D
+							SIM_EFEXT1_FILEID;
+					}
+
+					next_file->record =3D extension_record;
+					pbd->ext1_to_type =3D TYPE_ANR;
+					pbd->ext1_to_entry =3D
+						phonebook_entry_nbr;
+				}
+			}
+
+			/* GSlist nth counts from 0, PB entries from 1 */
+			list_entry =3D
+				g_slist_nth(phonebook_entry_start,
+					phonebook_entry_nbr - 1);
+
+			if (list_entry !=3D NULL) {
+				struct phonebook_entry *entry =3D
+					list_entry->data;
+
+				if (entry !=3D NULL) {
+					/* if one already exists, delete it */
+					if (entry->anr)
+						g_free(entry->anr);
+
+					DBG("Adding ANR to entry %d, name %s",
+							phonebook_entry_nbr,
+								entry->name);
+					entry->anr =3D anr;
+				}
+			} else {
+				g_free(anr);
+			}
+
+			break;
+		}
+	case TYPE_AAS:{
+			DBG("AAS");
+			break;
+		}
+	case TYPE_EMAIL:{
+			uint8_t phonebook_entry_nbr =3D msg[len - 1];
+			email =3D sim_string_to_utf8(msg, len - 2);
+
+			/* GSlist nth counts from 0, PB entries from 1 */
+			if (email !=3D NULL) {
+				GSList *list_entry =3D
+					g_slist_nth(phonebook_entry_start,
+						phonebook_entry_nbr - 1);
+
+				DBG("Email \'%s\' to PB entry %d", email,
+					phonebook_entry_nbr);
+				if (list_entry !=3D NULL) {
+					struct phonebook_entry *entry =3D
+						list_entry->data;
+
+					/* if one already exists, delete it */
+					if (entry !=3D NULL) {
+						if (entry->email)
+							g_free(entry->email);
+
+						DBG("Adding email to entry %d,\
+								 name %s",
+							phonebook_entry_nbr,
+								entry->name);
+
+						entry->email =3D email;
+					}
+				} else {
+					g_free(email);
+				}
+			}
+
+			break;
+		}
+	case TYPE_EXT1:{
+		if (msg[0] =3D=3D EXT1_ADDITIONAL_DATA)
+			handle_ext1(pbd, msg);
+		break;
+
+	}
+	default:{
+			DBG("Skipping type %02X", type);
+			break;
+		}
+	}
+
+	return next_file;
+}
+
 static void read_next_entry(GIsiClient *client, uint16_t location,
 				GIsiNotifyFunc notify, void *data)
 {
@@ -254,51 +753,751 @@ static void read_resp_cb(const GIsiMessage *msg, voi=
d *data)
 	g_free(cbd);
 }
 =

+struct pb_file_info *extension_file_info;
+
+static void pb_adn_sim_data_cb(const struct ofono_error *error,
+				const unsigned char *sdata,
+				int length, void *data)
+{
+	struct isi_cb_data *cbd_outer =3D data;
+	struct isi_cb_data *cbd =3D NULL;
+	struct pb_file_info *file_info;
+	struct ofono_phonebook *pb;
+	ofono_phonebook_cb_t cb;
+	struct pb_data *pbd;
+	struct ofono_sim_driver *sim_drv =3D get_sim_driver_func();
+	GIsiModem *modem;
+	struct ofono_sim *sim;
+
+	if (cbd_outer =3D=3D NULL)
+		goto out;
+
+	file_info =3D cbd_outer->user;
+	cbd =3D cbd_outer->data;
+
+	if (cbd =3D=3D NULL)
+		return;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+
+	pbd =3D ofono_phonebook_get_data(pb);
+
+	if (pbd =3D=3D NULL)
+		goto out;
+
+	modem =3D g_isi_client_modem(pbd->client);
+	sim =3D (struct ofono_sim *)g_isi_modem_get_sim(modem);
+
+	if (extension_file_info !=3D NULL)
+		file_info =3D
+			decode_read_response(extension_file_info, sdata,
+					length, pb);
+	else
+		file_info =3D decode_read_response(file_info, sdata, length, pb);
+
+	if (file_info !=3D NULL) {
+		DBG("Reading extension file %04X, record %d",
+			file_info->file_id, file_info->record);
+		sim_drv->read_file_linear(sim, file_info->file_id,
+						file_info->record,
+						file_info->record_length,
+						pb_adn_sim_data_cb, cbd_outer);
+
+		/* Delete if there is a previous one */
+		g_free(extension_file_info);
+		extension_file_info =3D file_info;
+		return;
+	} else {
+		g_free(extension_file_info);
+		extension_file_info =3D NULL;
+		file_info =3D cbd_outer->user;
+
+		if (file_info->record <
+			(file_info->file_length / file_info->record_length)) {
+
+			file_info->record++;
+			DBG("Same file, next record %d", file_info->record);
+			sim_drv->read_file_linear(sim, file_info->file_id,
+							file_info->record,
+							file_info->
+							record_length,
+							pb_adn_sim_data_cb,
+							cbd_outer);
+		} else {
+			GSList *list_entry =3D
+				g_slist_nth(phonebook_entry_start, 0);
+			DBG("All data requested, start vCard creation");
+			g_free(file_info);
+
+			while (list_entry !=3D NULL) {
+				struct phonebook_entry *entry =3D
+					list_entry->data;
+
+				if (entry !=3D NULL) {
+					DBG("vCard:\nname=3D%s\nnumber=3D%s\n\
+						email=3D%s\nanr=3D%s\nsne=3D%s",
+						entry->name, entry->number,
+						entry->email, entry->anr,
+								entry->sne);
+
+					ofono_phonebook_entry(pb, -1,
+								entry->number,
+								-1,
+								entry->name,
+								-1,
+								NULL,
+								entry->anr, -1,
+								entry->sne,
+								entry->email,
+								NULL, NULL);
+					g_free(entry->number);
+					g_free(entry->name);
+					g_free(entry->anr);
+					g_free(entry->sne);
+					g_free(entry->email);
+					g_free(entry);
+				}
+
+				list_entry =3D g_slist_next(list_entry);
+			}
+
+			g_slist_free(phonebook_entry_start);
+			g_slist_free(pb_files);
+			g_free(cbd_outer);
+			DBG("Finally all PB data read");
+			CALLBACK_WITH_SUCCESS(cb, cbd->data);
+			goto out;
+		}
+	}
+
+	return;
+out:
+	g_free(cbd);
+}
+
+static void pb_adn_sim_info_cb(const struct ofono_error *error,
+				int filelength,
+				enum ofono_sim_file_structure structure,
+				int recordlength,
+				const unsigned char access[3],
+				unsigned char file_status, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_phonebook *pb =3D cbd->user;
+	ofono_phonebook_cb_t cb =3D cbd->cb;
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+	struct pb_file_info *file_info =3D NULL;
+	struct isi_cb_data *cbd_outer;
+	int records =3D 0;
+	struct ofono_sim_driver *sim_drv =3D get_sim_driver_func();
+	GIsiModem *modem;
+	struct ofono_sim *sim;
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+	pbd =3D ofono_phonebook_get_data(pb);
+	file_info =3D NULL;
+
+	if (pbd =3D=3D NULL)
+		goto error;
+
+	modem =3D g_isi_client_modem(pbd->client);
+	sim =3D g_isi_modem_get_sim(modem);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR ||
+			structure !=3D OFONO_SIM_FILE_STRUCTURE_FIXED ||
+			sim_drv->read_file_linear =3D=3D NULL)
+		goto error;
+
+	records =3D filelength / recordlength;
+
+	if (records =3D=3D 0)
+		goto error;
+
+	file_info =3D g_try_new0(struct pb_file_info, 1);
+
+	if (file_info =3D=3D NULL)
+		goto error;
+
+	file_info->file_id =3D SIM_EFADN_FILEID;
+	file_info->file_type =3D TYPE_ADN;
+	file_info->structure =3D structure;
+	file_info->file_length =3D filelength;
+	file_info->record_length =3D recordlength;
+	file_info->record =3D 1;
+
+	/* Regenerate cbd (include file_info) */
+	cbd_outer =3D isi_cb_data_new(file_info, cb, cbd);
+	sim_drv->read_file_linear(sim, file_info->file_id, file_info->record,
+					file_info->record_length,
+					pb_adn_sim_data_cb, cbd_outer);
+	return;
+error:
+
+	if (cbd !=3D NULL)
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static gboolean is_reading_required(uint8_t file_type)
+{
+	switch (file_type) {
+	case TYPE_ADN:
+	case TYPE_EMAIL:
+	case TYPE_SNE:
+	case TYPE_ANR:
+		return TRUE;
+	default:
+		return FALSE;
+	}
+}
+
+static void pb_content_data_cb(const struct ofono_error *error,
+				const unsigned char *sdata,
+				int length, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_phonebook *pb;
+	ofono_phonebook_cb_t cb;
+	struct pb_data *pbd;
+	struct pb_file_info *file_info =3D NULL;
+
+	if (cbd =3D=3D NULL)
+		goto out;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+	pbd =3D ofono_phonebook_get_data(pb);
+
+	if (extension_file_info !=3D NULL)
+		file_info =3D decode_read_response(extension_file_info, sdata,
+						 length, pb);
+	else
+		file_info =3D
+			decode_read_response(pb_next->data, sdata, length, pb);
+
+	if (file_info !=3D NULL) {
+		DBG("Reading extension file %04X, record %d, structure %d",
+			file_info->file_id, file_info->record,
+			file_info->structure);
+		pb_content_data_read(pbd, file_info, cbd);
+		/* Delete if there is a previous one */
+		g_free(extension_file_info);
+		extension_file_info =3D file_info;
+		return;
+	} else {
+		g_free(extension_file_info);
+		extension_file_info =3D NULL;
+		file_info =3D pb_next->data;
+
+		if (((file_info->structure =3D=3D
+		      OFONO_SIM_FILE_STRUCTURE_FIXED) ||
+			(file_info->structure =3D=3D
+			 OFONO_SIM_FILE_STRUCTURE_CYCLIC))
+			&& (file_info->record <
+			(file_info->file_length / file_info->record_length))) {
+
+			file_info->record++;
+			DBG("Same file, next record %d", file_info->record);
+		} else {
+			g_free(file_info);
+			pb_next =3D g_slist_next(pb_next);
+			DBG("Next file in list");
+
+			if (pb_next !=3D NULL) {
+				file_info =3D pb_next->data;
+
+				while ((pb_next !=3D NULL) &&
+						(!is_reading_required(
+						file_info->file_type))) {
+					DBG("Skipping file type %02X",
+						file_info->file_type);
+					g_free(file_info);
+					pb_next =3D g_slist_next(pb_next);
+
+					if (pb_next)
+						file_info =3D pb_next->data;
+				}
+			}
+
+			if (pb_next =3D=3D NULL) {
+				GSList *list_entry =3D
+					g_slist_nth(phonebook_entry_start, 0);
+
+				DBG("All data requested, start vCard creation");
+				while (list_entry !=3D NULL) {
+					struct phonebook_entry *entry =3D
+					    list_entry->data;
+
+					if (entry !=3D NULL) {
+						DBG("vCard:\nname=3D%s\n \
+							number=3D%s\nemail=3D%s\n \
+							anr=3D%s\nsne=3D%s",
+							entry->name,
+							entry->number,
+							entry->email,
+							entry->anr,
+							entry->sne);
+
+						ofono_phonebook_entry(pb, -1,
+								entry->number,
+								-1,
+								entry->name,
+								-1,
+								NULL,
+								entry->anr,
+								-1,
+								entry->sne,
+								entry->email,
+								NULL,
+								NULL);
+
+						g_free(entry->number);
+						g_free(entry->name);
+						g_free(entry->anr);
+						g_free(entry->sne);
+						g_free(entry->email);
+						g_free(entry);
+					}
+
+					list_entry =3D g_slist_next(list_entry);
+				}
+
+				g_slist_free(phonebook_entry_start);
+				g_slist_free(pb_files);
+				DBG("Finally all PB data read");
+				CALLBACK_WITH_SUCCESS(cb, cbd->data);
+				goto out;
+			}
+
+			file_info =3D pb_next->data;
+		}
+	}
+
+	pb_content_data_read(pbd, file_info, cbd);
+	return;
+out:
+	g_free(cbd);
+}
+
+static void pb_content_data_read(struct pb_data *pbd,
+					struct pb_file_info *file_info,
+					struct isi_cb_data *cbd)
+{
+	ofono_phonebook_cb_t cb;
+	struct ofono_sim_driver *sim_drv =3D get_sim_driver_func();
+	GIsiModem *modem;
+	struct ofono_sim *sim;
+
+	if (pbd =3D=3D NULL || file_info =3D=3D NULL || cbd =3D=3D NULL)
+		return;
+
+	modem =3D g_isi_client_modem(pbd->client);
+	sim =3D g_isi_modem_get_sim(modem);
+
+	cb =3D cbd->cb;
+	DBG("Reading content of file type=3D%02X, file ID=3D%04X, structure=3D%d",
+		file_info->file_type, file_info->file_id, file_info->structure);
+
+	switch (file_info->structure) {
+	case OFONO_SIM_FILE_STRUCTURE_FIXED:
+
+		if (sim_drv->read_file_linear =3D=3D NULL)
+			goto error;
+
+		sim_drv->read_file_linear(sim, file_info->file_id,
+						file_info->record,
+						file_info->record_length,
+						pb_content_data_cb, cbd);
+		break;
+	case OFONO_SIM_FILE_STRUCTURE_CYCLIC:
+
+		if (sim_drv->read_file_cyclic =3D=3D NULL)
+			goto error;
+
+		sim_drv->read_file_cyclic(sim, file_info->file_id,
+						file_info->record,
+						file_info->record_length,
+						pb_content_data_cb, cbd);
+		break;
+	case OFONO_SIM_FILE_STRUCTURE_TRANSPARENT:
+
+		if (sim_drv->read_file_transparent =3D=3D NULL)
+			goto error;
+
+		sim_drv->read_file_transparent(sim, file_info->file_id, 0,
+							file_info->file_length,
+							pb_content_data_cb,
+							cbd);
+		break;
+	}
+
+	return;
+error:
+	if (cbd !=3D NULL)
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+}
+
+static void pb_content_info_cb(const struct ofono_error *error,
+				int filelength,
+				enum ofono_sim_file_structure structure,
+				int recordlength,
+				const unsigned char access[3],
+				unsigned char file_status, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_phonebook *pb;
+	ofono_phonebook_cb_t cb;
+	struct pb_data *pbd;
+	struct pb_file_info *file_info =3D NULL;
+	struct ofono_sim_driver *sim_drv =3D get_sim_driver_func();
+	GIsiModem *modem;
+	struct ofono_sim *sim;
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+	pbd =3D ofono_phonebook_get_data(pb);
+
+	if (pbd =3D=3D NULL)
+		goto error;
+
+	modem =3D g_isi_client_modem(pbd->client);
+	sim =3D g_isi_modem_get_sim(modem);
+
+	file_info =3D pb_next->data;
+
+	if (file_info =3D=3D NULL)
+		goto error;
+
+	file_info->structure =3D structure;
+	file_info->file_length =3D filelength;
+	file_info->record_length =3D recordlength;
+	file_info->record =3D 1;
+
+	DBG("File type=3D%02X, File ID=3D%04X, Struct=3D%d, File len=3D%d, Rec le=
n=3D%d",
+		file_info->file_type, file_info->file_id, file_info->structure,
+		file_info->file_length, file_info->record_length);
+
+	if (file_info->file_type =3D=3D TYPE_EXT1)
+		/* Save for quick access */
+		pbd->extension_file_info =3D file_info;
+
+	pb_next =3D g_slist_next(pb_next);
+
+	if (pb_next =3D=3D NULL) {
+		DBG("All info requested, start content reading");
+
+		/* Re-start from beginning */
+		pb_next =3D g_slist_nth(pb_files, 0);
+		file_info =3D pb_next->data;
+
+		DBG("Calling pb_content_data_read pb=3D%p, list=3D%p, type=3D%02X",
+			cbd->user, pb_next, file_info->file_type);
+
+		pb_content_data_read(pbd, file_info, cbd);
+		return;
+	}
+
+	file_info =3D pb_next->data;
+
+	DBG("Reading next content info %04X", file_info->file_id);
+	sim_drv->read_file_info(sim, file_info->file_id,
+					pb_content_info_cb, cbd);
+	return;
+error:
+
+	if (cbd !=3D NULL) {
+		DBG("Error cbd=3D%p, pbd=3D%p, file_info=3D%p", cbd, pbd, file_info);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+
+	g_free(cbd);
+}
+
+static void pb_reference_data_cb(const struct ofono_error *error,
+					const unsigned char *sdata,
+					int length, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_phonebook *pb;
+	ofono_phonebook_cb_t cb;
+	struct pb_data *pbd;
+	const unsigned char *ptr =3D sdata;
+	int typelen =3D 0;
+	int i =3D 0;
+	int file_id =3D 0;
+	gboolean finished =3D FALSE;
+	struct ofono_sim_driver *sim_drv =3D get_sim_driver_func();
+	GIsiModem *modem;
+	struct ofono_sim *sim;
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+
+	if (cb =3D=3D NULL || pb =3D=3D NULL)
+		goto out;
+
+	pbd =3D ofono_phonebook_get_data(pb);
+
+	if (pbd =3D=3D NULL)
+		goto error;
+
+	modem =3D g_isi_client_modem(pbd->client);
+	sim =3D g_isi_modem_get_sim(modem);
+
+	while ((ptr < sdata + length) && (finished =3D=3D FALSE)) {
+		switch (*ptr) {
+		case TYPE_1_TAG:
+		case TYPE_2_TAG:
+		case TYPE_3_TAG:
+			typelen =3D *(ptr + 1);
+			DBG("File type=3D%02X, len=3D%d", *ptr, typelen);
+			ptr +=3D 2;
+			i =3D 0;
+
+			while (i < typelen) {
+				struct pb_file_info *file_info =3D
+					g_try_new0(struct pb_file_info, 1);
+				file_id =3D (ptr[i + 2] << 8) + ptr[i + 3];
+
+				DBG("creating file info for File type=3D%02X,\
+								File ID=3D%04X",
+								ptr[i],
+								file_id);
+
+				if (file_info =3D=3D NULL)
+					goto error;
+
+				file_info->file_type =3D ptr[i];
+				file_info->file_id =3D file_id;
+				pb_files =3D
+					g_slist_append(pb_files,
+							(void *)file_info);
+				i +=3D ptr[i + 1] + 2;
+			}
+
+			ptr +=3D typelen;
+			break;
+		default:
+			DBG("All handled %02x", *ptr);
+			finished =3D TRUE;
+			break;
+		}
+	}
+
+	if (pbd->pb_reference_file_info.record <
+			(pbd->pb_reference_file_info.file_length /
+			pbd->pb_reference_file_info.record_length)) {
+		pbd->pb_reference_file_info.record++;
+		DBG("Next EFpbr record %d", pbd->pb_reference_file_info.record);
+		sim_drv->read_file_linear(sim,
+				pbd->pb_reference_file_info.file_id,
+				pbd->pb_reference_file_info.record,
+				pbd->pb_reference_file_info.record_length,
+				pb_reference_data_cb, cbd);
+	} else {
+		struct pb_file_info *file_info;
+		DBG("All EFpbr records read");
+		pb_next =3D g_slist_nth(pb_files, 0);
+
+		if (pb_next =3D=3D NULL)
+			goto error;
+
+		file_info =3D pb_next->data;
+
+		if ((file_info =3D=3D NULL)) /*|| !pbd->sim_func)*/
+			goto error;
+
+		sim_drv->read_file_info(sim, file_info->file_id,
+						pb_content_info_cb, cbd);
+	}
+
+	return;
+error:
+	if (cbd !=3D NULL)
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+}
+
+static void pb_reference_info_cb(const struct ofono_error *error,
+		int filelength,
+		enum ofono_sim_file_structure structure,
+		int recordlength,
+		const unsigned char access[3],
+		unsigned char file_status,
+		void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_phonebook *pb;
+	ofono_phonebook_cb_t cb;
+	struct pb_data *pbd;
+	int records =3D 0;
+	struct ofono_sim_driver *sim_drv =3D get_sim_driver_func();
+	GIsiModem *modem;
+	struct ofono_sim *sim;
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+	pbd =3D ofono_phonebook_get_data(pb);
+
+	if (pbd =3D=3D NULL)
+		goto error;
+
+	modem =3D g_isi_client_modem(pbd->client);
+	sim =3D g_isi_modem_get_sim(modem);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		goto error;
+
+	if (structure !=3D OFONO_SIM_FILE_STRUCTURE_FIXED)
+		goto error;
+
+	if (sim_drv =3D=3D NULL || sim_drv->read_file_linear =3D=3D NULL)
+		goto error;
+
+	records =3D filelength / recordlength;
+
+	if (records =3D=3D 0)
+		goto error;
+
+	DBG("EFpbr size %d, record length %d, records %d",
+		filelength, recordlength, records);
+	pbd->pb_reference_file_info.file_id =3D SIM_EFPBR_FILEID;
+	pbd->pb_reference_file_info.file_length =3D filelength;
+	pbd->pb_reference_file_info.record_length =3D recordlength;
+	pbd->pb_reference_file_info.record =3D 1;	/* Current record, not amount*/
+	pbd->pb_reference_file_info.structure =3D OFONO_SIM_FILE_STRUCTURE_FIXED;
+	sim_drv->read_file_linear(sim, SIM_EFPBR_FILEID, 1, recordlength,
+					pb_reference_data_cb, cbd);
+	return;
+error:
+
+	if ((cb !=3D NULL) && (cbd !=3D NULL))
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
 static void isi_export_entries(struct ofono_phonebook *pb, const char *sto=
rage,
 				ofono_phonebook_cb_t cb, void *data)
 {
 	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(pb, cb, data);
-	const uint8_t msg[] =3D {
-		SIM_PB_REQ_SIM_PB_READ,
-		SIM_PB_READ,
-		2,				/* number of subblocks */
-		0, SIM_PB_LOCATION,		/* subblock id */
-		0, 8,				/* subblock size */
-		0, SIM_PB_ADN,
-		0xFF, 0xFF,			/* read first entry in pb */
-		0, SIM_PB_INFO_REQUEST,		/* subblock id */
-		0, 16,				/* subblock size */
-		4,				/* number of tags */
-		0,				/* filler */
-		0, SIM_PB_ADN,			/* tags */
-		0, SIM_PB_SNE,
-		0, SIM_PB_ANR,
-		0, SIM_PB_EMAIL,
-		0, 0				/* filler */
-	};
-	size_t len =3D sizeof(msg);
+	GIsiModem *modem =3D g_isi_client_modem(pbd->client);
+	struct ofono_sim *sim =3D g_isi_modem_get_sim(modem);
+	struct ofono_sim_driver *sim_drv =3D get_sim_driver_func();
 =

-	if (cbd =3D=3D NULL || pbd =3D=3D NULL || strcmp(storage, "SM") !=3D 0)
+	if (cbd =3D=3D NULL || pbd =3D=3D NULL)
 		goto error;
 =

-	if (g_isi_client_send(pbd->client, msg, len, read_resp_cb, cbd, NULL))
-		return;
-
+	if (g_isi_client_resource(pbd->client) =3D=3D PN_UICC) {
+		pbd->pb_entry =3D 1;
+		pb_files =3D NULL;
+		pb_next =3D NULL;
+		phonebook_entry_current =3D NULL;
+		phonebook_entry_start =3D NULL;
+
+		switch (get_app_type(modem)) {
+		case UICC_APPL_TYPE_ICC_SIM:
+			DBG("SIM application");
+			sim_drv->read_file_info(sim,
+					SIM_EFADN_FILEID,
+					pb_adn_sim_info_cb,
+					cbd);
+			break;
+		case UICC_APPL_TYPE_UICC_USIM:
+			DBG("USIM application");
+			sim_drv->read_file_info(sim,
+					SIM_EFPBR_FILEID,
+					pb_reference_info_cb,
+					cbd);
+			break;
+		default:
+			DBG("UICC application type not unknown or supported");
+			goto error;
+			break;
+		}
+	} else {
+
+		const uint8_t msg[] =3D {
+			SIM_PB_REQ_SIM_PB_READ,
+			SIM_PB_READ,
+			2,			/* number of subblocks */
+			0, SIM_PB_LOCATION,	/* subblock id */
+			0, 8,			/* subblock size */
+			0, SIM_PB_ADN,
+			0xFF, 0xFF,		/* read first entry in pb */
+			0, SIM_PB_INFO_REQUEST,	/* subblock id */
+			0, 16,			/* subblock size */
+			4,			/* number of tags */
+			0,			/* filler */
+			0, SIM_PB_ADN,		/* tags */
+			0, SIM_PB_SNE,
+			0, SIM_PB_ANR,
+			0, SIM_PB_EMAIL,
+			0, 0			/* filler */
+		};
+		size_t len =3D sizeof(msg);
+
+		if (strcmp(storage, "SM") !=3D 0)
+			goto error;
+
+		if (g_isi_client_send(pbd->client, msg, len, read_resp_cb,
+				cbd, NULL))
+			return;
+	}
+	return;
 error:
 	CALLBACK_WITH_FAILURE(cb, data);
 	g_free(cbd);
 }
 =

-static void reachable_cb(const GIsiMessage *msg, void *data)
+static void primary_reachable_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_phonebook *pb =3D data;
+	struct pb_data *pd =3D ofono_phonebook_get_data(pb);
+
+	if (g_isi_msg_error(msg) < 0)
+		return;
+
+	ISI_VERSION_DBG(msg);
+	pd->client =3D pd->primary;
+
+	g_isi_client_destroy(pd->secondary);
+
+	ofono_phonebook_register(pb);
+}
+
+static void secondary_reachable_cb(const GIsiMessage *msg, void *data)
 {
 	struct ofono_phonebook *pb =3D data;
+	struct pb_data *pd =3D ofono_phonebook_get_data(pb);
 =

 	if (g_isi_msg_error(msg) < 0)
 		return;
 =

 	ISI_VERSION_DBG(msg);
 =

+	pd->client =3D pd->secondary;
+
+	g_isi_client_destroy(pd->primary);
+
 	ofono_phonebook_register(pb);
 }
 =

@@ -312,15 +1511,23 @@ static int isi_phonebook_probe(struct ofono_phoneboo=
k *pb, unsigned int vendor,
 	if (data =3D=3D NULL)
 		return -ENOMEM;
 =

-	data->client =3D g_isi_client_create(modem, PN_SIM);
-	if (data->client =3D=3D NULL) {
+	data->primary =3D g_isi_client_create(modem, PN_UICC);
+	if (data->primary =3D=3D NULL) {
+		g_free(data);
+		return -ENOMEM;
+	}
+
+	data->secondary =3D g_isi_client_create(modem, PN_SIM);
+	if (data->secondary =3D=3D NULL) {
+		g_isi_client_destroy(data->primary);
 		g_free(data);
 		return -ENOMEM;
 	}
 =

 	ofono_phonebook_set_data(pb, data);
 =

-	g_isi_client_verify(data->client, reachable_cb, pb, NULL);
+	g_isi_client_verify(data->primary, primary_reachable_cb, pb, NULL);
+	g_isi_client_verify(data->secondary, secondary_reachable_cb, pb, NULL);
 =

 	return 0;
 }
@@ -329,12 +1536,18 @@ static void isi_phonebook_remove(struct ofono_phoneb=
ook *pb)
 {
 	struct pb_data *data =3D ofono_phonebook_get_data(pb);
 =

+	pb_files =3D NULL;
+	pb_next =3D NULL;
+	phonebook_entry_start =3D NULL;
+	phonebook_entry_current =3D NULL;
+
 	ofono_phonebook_set_data(pb, NULL);
 =

 	if (data =3D=3D NULL)
 		return;
 =

 	g_isi_client_destroy(data->client);
+
 	g_free(data);
 }
 =

-- =

1.7.3.5


--===============0483130766287778886==--


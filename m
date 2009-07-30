Content-Type: multipart/mixed; boundary="===============6818871068108916203=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/4] Add a MessageWaiting interface to track message waiting
 indications.
Date: Thu, 30 Jul 2009 10:05:42 +0200
Message-ID: <1248941142-13236-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6818871068108916203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Comments are welcome about how the interface should look.  The state of the
indications is kept in memory and written back to the SIM after any
changes.

Patch is untested because write ofono_sim_write is unimplemented, I'll add
it as a separate patch.  Should it take a callback parameter?
---
 src/Makefile.am       |    3 +-
 src/driver.h          |    3 +
 src/message-waiting.c |  512 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/message-waiting.h |   33 ++++
 src/modem.h           |    1 +
 src/simutil.h         |    3 +
 src/sms.c             |  216 ++++++++++++++++++++-
 src/smsutil.h         |    1 +
 8 files changed, 765 insertions(+), 7 deletions(-)
 create mode 100644 src/message-waiting.c
 create mode 100644 src/message-waiting.h

diff --git a/src/Makefile.am b/src/Makefile.am
index 2fb3f06..144b872 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -13,7 +13,8 @@ ofonod_SOURCES =3D main.c ofono.h log.c plugin.c \
 		network.c voicecall.c ussd.h ussd.c sms.c \
 		call-settings.c call-forwarding.c call-meter.c \
 		smsutil.h smsutil.c cssn.h cssn.c call-barring.c sim.h sim.c \
-		phonebook.c history.c simutil.h simutil.c
+		phonebook.c history.c simutil.h simutil.c \
+		message-waiting.c message-waiting.h
 =

 ofonod_LDADD =3D $(top_builddir)/plugins/libbuiltin.la \
 		$(top_builddir)/drivers/libbuiltin.la \
diff --git a/src/driver.h b/src/driver.h
index 928c20a..51e5587 100644
--- a/src/driver.h
+++ b/src/driver.h
@@ -439,3 +439,6 @@ void ofono_phonebook_entry(struct ofono_modem *modem, i=
nt index,
 				const char *adnumber, int adtype,
 				const char *secondtext, const char *email,
 				const char *sip_uri, const char *tel_uri);
+
+int ofono_message_waiting_register(struct ofono_modem *modem);
+void ofono_message_waiting_unregister(struct ofono_modem *modem);
diff --git a/src/message-waiting.c b/src/message-waiting.c
new file mode 100644
index 0000000..564961a
--- /dev/null
+++ b/src/message-waiting.c
@@ -0,0 +1,512 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+#include <stdio.h>
+
+#include <dbus/dbus.h>
+#include <glib.h>
+#include <gdbus.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include "ofono.h"
+
+#include "dbus-gsm.h"
+#include "modem.h"
+#include "driver.h"
+#include "common.h"
+#include "util.h"
+#include "sim.h"
+#include "simutil.h"
+#include "smsutil.h"
+#include "message-waiting.h"
+
+#define MESSAGE_WAITING_INTERFACE "org.ofono.MessageWaiting"
+
+struct message_waiting_data {
+	int pending;
+
+	int messages[5];
+	int efmwis_length;
+	int efmbdn_length;
+
+	struct ofono_phone_number mailbox_number[5];
+
+	char *last_message;
+};
+
+static struct message_waiting_data *message_waiting_create()
+{
+	return g_try_new0(struct message_waiting_data, 1);
+}
+
+static void message_waiting_destroy(gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct message_waiting_data *data =3D modem->message_waiting;
+
+	if (data->last_message)
+		g_free(data->last_message);
+
+	g_free(data);
+
+	modem->network_registration =3D NULL;
+}
+
+static const char *mw_messages_property_name[5] =3D {
+	"VoicemailMessages",
+#if 0
+	"FaxMessages",
+	"EmailMessages",
+	"OtherMessages",
+	"VideomailMessages",
+#endif
+};
+
+static const char *mw_mailbox_property_name[5] =3D {
+	"VoicemailMailboxNumber",
+#if 0
+	"FaxMailboxNumber",
+	"EmailMailboxNumber",
+	"OtherMailboxNumber",
+	"VideomailMailboxNumber",
+#endif
+};
+
+static DBusMessage *mw_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct message_waiting_data *mw =3D modem->message_waiting;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	int i;
+	unsigned char value;
+	const char *number;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+						PROPERTIES_ARRAY_SIGNATURE,
+						&dict);
+
+	for (i =3D 0; i < 5; i++)
+		if (mw_messages_property_name[i]) {
+			value =3D mw->messages[i];
+
+			dbus_gsm_dict_append(&dict,
+					mw_messages_property_name[i],
+					DBUS_TYPE_BYTE, &value);
+		}
+
+	for (i =3D 0; i < 5; i++)
+		if (mw_mailbox_property_name[i]) {
+			number =3D phone_number_to_string(&mw->mailbox_number[i]);
+
+			dbus_gsm_dict_append(&dict,
+					mw_mailbox_property_name[i],
+					DBUS_TYPE_STRING, &number);
+		}
+
+	dbus_gsm_dict_append(&dict, "LastNotificationText",
+			DBUS_TYPE_STRING, &mw->last_message);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static gboolean mw_mwis_update(gpointer user);
+
+static DBusMessage *mw_set_property(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct message_waiting_data *mw =3D modem->message_waiting;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *name;
+	int i;
+	unsigned char value;
+
+	if (mw->efmwis_length =3D=3D 0)
+		return dbus_gsm_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return dbus_gsm_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return dbus_gsm_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &name);
+
+	for (i =3D 0; i < 5; i++)
+		if (mw_messages_property_name[i] &&
+				!strcmp(name, mw_messages_property_name[i]))
+			break;
+	if (i =3D=3D 5)
+		return dbus_gsm_invalid_args(msg);
+
+	dbus_message_iter_next(&iter);
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return dbus_gsm_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+	if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BYTE)
+		return dbus_gsm_invalid_format(msg);
+
+	dbus_message_iter_get_basic(&var, &value);
+
+	if (mw->messages[i] !=3D value) {
+		mw->messages[i] =3D value;
+
+		if (!mw->pending)
+			mw->pending =3D g_timeout_add(0, mw_mwis_update, modem);
+
+		dbus_gsm_signal_property_changed(conn, modem->path,
+				MESSAGE_WAITING_INTERFACE,
+				mw_messages_property_name[i],
+				DBUS_TYPE_BYTE, &value);
+	}
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable message_waiting_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",	mw_get_properties	},
+	{ "SetProperty",	"sv",	"",		mw_set_property,	},
+	{ }
+};
+
+static GDBusSignalTable message_waiting_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+static void mw_mwis_read_cb(struct ofono_modem *modem, int ok,
+		enum ofono_sim_file_structure structure, int total_length,
+		int record, const unsigned char *data, int record_length,
+		void *userdata)
+{
+	int i, status, messages[5];
+	unsigned char value;
+	DBusConnection *conn =3D dbus_gsm_connection();
+	struct message_waiting_data *mw =3D modem->message_waiting;
+
+	/* Handle only current identity (TODO: currently assumes first) */
+	if (record !=3D 1)
+		return;
+
+	if (!ok ||
+		structure !=3D OFONO_SIM_FILE_STRUCTURE_FIXED ||
+		record_length < 5) {
+		ofono_error("Unable to read waiting messages numbers "
+			"from SIM");
+		return;
+	}
+
+	status =3D data[0];
+	data++;
+
+	for (i =3D 0; i < 5 && i < record_length - 1; i++) {
+		messages[i] =3D ((status >> i) & 1) ? data[i] : 0;
+
+		if (mw->messages[i] !=3D messages[i]) {
+			mw->messages[i] =3D messages[i];
+			value =3D messages[i];
+
+			if (!mw_messages_property_name[i])
+				continue;
+
+			dbus_gsm_signal_property_changed(conn, modem->path,
+					MESSAGE_WAITING_INTERFACE,
+					mw_messages_property_name[i],
+					DBUS_TYPE_BYTE, &value);
+		}
+	}
+
+	mw->efmwis_length =3D record_length;
+}
+
+static void mw_mbdn_read_cb(struct ofono_modem *modem, int ok,
+		enum ofono_sim_file_structure structure, int total_length,
+		int record, const unsigned char *data, int record_length,
+		void *userdata)
+{
+	int i, *ids =3D userdata;
+	DBusConnection *conn =3D dbus_gsm_connection();
+	struct message_waiting_data *mw =3D modem->message_waiting;
+
+	if (!ok ||
+		structure !=3D OFONO_SIM_FILE_STRUCTURE_FIXED ||
+		record_length < 14 || total_length < record_length) {
+		ofono_error("Unable to read mailbox dialling numbers "
+			"from SIM");
+		g_free(ids);
+		return;
+	}
+
+	for (i =3D 0; i < 5; i++)
+		if (record =3D=3D ids[i])
+			break;
+	if (i =3D=3D 5)
+		goto final;
+
+	if (sim_adn_parse(data, record_length, &mw->mailbox_number[i]) =3D=3D
+			FALSE)
+		mw->mailbox_number[i].number[0] =3D '\0';
+
+	mw->efmbdn_length =3D record_length;
+
+final:
+	/* Is this the last MBDN record? */
+	if (record =3D=3D total_length / record_length)
+		g_free(ids);
+}
+
+static void mw_mbi_read_cb(struct ofono_modem *modem, int ok,
+		enum ofono_sim_file_structure structure, int total_length,
+		int record, const unsigned char *data, int record_length,
+		void *userdata)
+{
+	int i, err, *ids =3D userdata;
+	DBusConnection *conn =3D dbus_gsm_connection();
+	struct message_waiting_data *mw =3D modem->message_waiting;
+
+	/* Handle only current identity (TODO: currently assumes first) */
+	if (record !=3D 1)
+		return;
+
+	if (!ok ||
+		structure !=3D OFONO_SIM_FILE_STRUCTURE_FIXED ||
+		record_length < 4) {
+		ofono_error("Unable to read mailbox identifies "
+			"from SIM");
+
+		g_free(ids);
+		return;
+	}
+
+	for (i =3D 0; i < 5 && i < record_length; i++)
+		ids[i] =3D data[i];
+
+	err =3D ofono_sim_read(modem, SIM_EFMBDN_FILEID, mw_mbdn_read_cb, ids);
+	if (err !=3D 0) {
+		ofono_error("Unable to read EF-MBDN from SIM");
+
+		g_free(ids);
+	}
+}
+
+/* Loads MWI states from SIM */
+static gboolean mw_mwis_load(struct ofono_modem *modem)
+{
+	int err;
+	int *ids;
+
+	err =3D ofono_sim_read(modem, SIM_EFMWIS_FILEID, mw_mwis_read_cb, NULL);
+	if (err !=3D 0)
+		return FALSE;
+
+	/* Alloc space for mailbox identifiers */
+	ids =3D g_malloc0(5);
+
+	err =3D ofono_sim_read(modem, SIM_EFMBI_FILEID, mw_mbi_read_cb, ids);
+	if (err !=3D 0) {
+		g_free(ids);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+/* Writes MWI states back to SIM */
+static gboolean mw_mwis_update(gpointer user)
+{
+	struct ofono_modem *modem =3D user;
+	struct message_waiting_data *mw =3D modem->message_waiting;
+	unsigned char *file;
+	int i;
+
+	mw->pending =3D 0;
+
+	if (mw->efmwis_length =3D=3D 0)
+		return FALSE;
+
+	file =3D g_malloc0(mw->efmwis_length);
+
+	/* Fill in numbers of messages in bytes 1 to X of EF-MWIS */
+	for (i =3D 0; i < 5 && i < mw->efmwis_length - 1; i++)
+		file[i + 1] =3D mw->messages[i];
+
+	/* Fill in indicator state bits in byte 0 */
+	for (i =3D 0; i < 5 && i < mw->efmwis_length - 1; i++)
+		if (file[i + 1] > 0)
+			file[0] |=3D 1 << i;
+
+	if (ofono_sim_write(modem, SIM_EFMWIS_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_FIXED, 1,
+				file, mw->efmwis_length) !=3D 0) {
+		ofono_error("Writing MWI states to SIM failed");
+	}
+
+	g_free(file);
+
+	return FALSE;
+}
+
+void ofono_message_waiting_notify(struct ofono_modem *modem, int informati=
on,
+					enum sms_mwi_type type, int profile)
+{
+	struct message_waiting_data *mw =3D modem->message_waiting;
+	DBusConnection *conn =3D dbus_gsm_connection();
+	int invalidate =3D 0;
+	unsigned char value;
+
+	if (mw =3D=3D NULL)
+		return;
+
+	/* Handle only current identity (TODO: currently assumes first) */
+	if (profile !=3D 1)
+		return;
+
+	/* Ignore the unspecified type of notification.  It probably means
+	 * that the (voicemail) indication should become active but there's
+	 * no way to know when to deactivate it.  It's used for the obsolete
+	 * Return Call type of indication in SMS PDUs which also carry text
+	 * and we provide this text instead.  */
+	if (information =3D=3D MWI_UNSPECIFIED)
+		return;
+
+	if (information =3D=3D MWI_MESSAGES_WAITING) {
+		if (mw->messages[type] =3D=3D 0) {
+			mw->messages[type] =3D 1;
+			invalidate =3D 1;
+		}
+	} else if (information =3D=3D MWI_NO_MESSAGES_WAITING) {
+		if (mw->messages[type] > 0) {
+			mw->messages[type] =3D 0;
+			invalidate =3D 1;
+		}
+	} else {
+		if (mw->messages[type] !=3D information) {
+			mw->messages[type] =3D information;
+			invalidate =3D 1;
+		}
+	}
+
+	if (invalidate) {
+		if (mw_messages_property_name[type]) {
+			value =3D mw->messages[type];
+
+			dbus_gsm_signal_property_changed(conn, modem->path,
+					MESSAGE_WAITING_INTERFACE,
+					mw_messages_property_name[type],
+					DBUS_TYPE_BYTE, &value);
+		}
+
+		if (!mw->pending)
+			mw->pending =3D g_timeout_add(0, mw_mwis_update, modem);
+	}
+}
+
+void ofono_message_waiting_message(struct ofono_modem *modem, const char *=
msg)
+{
+	struct message_waiting_data *mw =3D modem->message_waiting;
+	DBusConnection *conn =3D dbus_gsm_connection();
+
+	if (!mw)
+		return;
+
+	if (mw->last_message && !strcmp(mw->last_message, msg))
+		return;
+
+	if (mw->last_message)
+		g_free(mw->last_message);
+
+	mw->last_message =3D g_strdup(msg);
+
+	dbus_gsm_signal_property_changed(conn, modem->path,
+			MESSAGE_WAITING_INTERFACE, "LastNotificationText",
+			DBUS_TYPE_STRING, &mw->last_message);
+}
+
+static void initialize_message_waiting(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D dbus_gsm_connection();
+
+	if (!mw_mwis_load(modem)) {
+		ofono_error("Could not register MessageWaiting interface");
+		message_waiting_destroy(modem);
+
+		return;
+	}
+
+	if (!g_dbus_register_interface(conn, modem->path,
+					MESSAGE_WAITING_INTERFACE,
+					message_waiting_methods,
+					message_waiting_signals,
+					NULL, modem,
+					message_waiting_destroy)) {
+		ofono_error("Could not register MessageWaiting interface");
+		message_waiting_destroy(modem);
+
+		return;
+	}
+
+	ofono_debug("MessageWaiting interface for modem: %s created",
+			modem->path);
+
+	modem_add_interface(modem, MESSAGE_WAITING_INTERFACE);
+}
+
+int ofono_message_waiting_register(struct ofono_modem *modem)
+{
+	if (modem =3D=3D NULL)
+		return -1;
+
+	modem->message_waiting =3D message_waiting_create();
+
+	ofono_sim_ready_notify_register(modem, initialize_message_waiting);
+	if (ofono_sim_get_ready(modem))
+		initialize_message_waiting(modem);
+
+	return 0;
+}
+
+void ofono_message_waiting_unregister(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D dbus_gsm_connection();
+
+	g_dbus_unregister_interface(conn, modem->path,
+					MESSAGE_WAITING_INTERFACE);
+	modem_remove_interface(modem, MESSAGE_WAITING_INTERFACE);
+}
diff --git a/src/message-waiting.h b/src/message-waiting.h
new file mode 100644
index 0000000..cad4c40
--- /dev/null
+++ b/src/message-waiting.h
@@ -0,0 +1,33 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+enum mwi_information_type {
+	MWI_UNSPECIFIED =3D -1,
+	MWI_MESSAGES_WAITING =3D -2,
+	MWI_NO_MESSAGES_WAITING =3D -3,
+};
+
+/* information either a positive (or zero) message count or a
+ * partial information using one of mwi_information_type constants
+ */
+void ofono_message_waiting_notify(struct ofono_modem *modem, int informati=
on,
+					enum sms_mwi_type type, int profile);
+void ofono_message_waiting_message(struct ofono_modem *modem, const char *=
msg);
diff --git a/src/modem.h b/src/modem.h
index d322df8..90993ca 100644
--- a/src/modem.h
+++ b/src/modem.h
@@ -43,6 +43,7 @@ struct ofono_modem {
 	struct sim_manager_data *sim_manager;
 	struct sms_manager_data *sms_manager;
 	struct phonebook_data *phonebook;
+	struct message_waiting_data *message_waiting;
 =

 	GSList *history_contexts;
 };
diff --git a/src/simutil.h b/src/simutil.h
index 6572e72..c2b1e20 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -24,6 +24,9 @@ enum sim_fileid {
 	SIM_EFSPN_FILEID =3D 0x6f46,
 	SIM_EFPNN_FILEID =3D 0x6fc5,
 	SIM_EFOPL_FILEID =3D 0x6fc6,
+	SIM_EFMBDN_FILEID =3D 0x6fc7,
+	SIM_EFMBI_FILEID =3D 0x6fc9,
+	SIM_EFMWIS_FILEID =3D 0x6fca,
 	SIM_EFSPDI_FILEID =3D 0x6fcd,
 };
 =

diff --git a/src/sms.c b/src/sms.c
index ef039d9..caab2e0 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -39,6 +39,7 @@
 #include "util.h"
 #include "sim.h"
 #include "smsutil.h"
+#include "message-waiting.h"
 =

 #define uninitialized_var(x) x =3D x
 =

@@ -658,9 +659,196 @@ static void handle_deliver(struct ofono_modem *modem,
 	g_slist_free(l);
 }
 =

-static void handle_mwi(struct ofono_modem *modem, struct sms *mwi)
+static void handle_special_sms_iei(struct ofono_modem *modem,
+		const guint8 *iei, int *set, int *store)
 {
-	ofono_error("MWI information not yet handled");
+	enum sms_mwi_type type;
+	int profile;
+
+	/* Parse type & storage byte */
+	*set =3D 0;
+	if (iei[0] & (1 << 7))
+		*store =3D 1;
+
+	type =3D iei[0] & 0x1f;
+	if (type > SMS_MWI_TYPE_OTHER) {
+		if (type =3D=3D (SMS_MWI_TYPE_OTHER | 4))
+			type =3D SMS_MWI_TYPE_VIDEO;
+		else
+			/* 23.040 9.2.3.24.2: "Terminals should be capable of
+			 * receiving any values in octet 1, even including
+			 * those marked as Reserved."  Treat Reserved as
+			 * "Other".  */
+			type =3D SMS_MWI_TYPE_OTHER;
+	}
+
+	profile =3D ((iei[0] >> 5) & 3) + 1;
+
+	ofono_message_waiting_notify(modem, iei[1], type, profile);
+}
+
+static void handle_enhanced_voicemail_iei(struct ofono_modem *modem,
+		const guint8 *iei, int *set, int *store, int length)
+{
+	int profile, n;
+
+	if (length < 3)
+		return;
+
+	/* ENHANCED_VOICE_MAIL_PDU_TYPE */
+	if (!(iei[0] & 1)) {
+		/* 9.2.3.24.13.1 Enhanced Voice Mail Notification */
+
+		/* MULTIPLE_SUBSCRIBER_PROFILE */
+		profile =3D (iei[0] >> 2) & 3;
+
+		/* SM_STORAGE */
+		*set =3D 0;
+		if (iei[0] & (1 << 4))
+			*store =3D 1;
+
+		/* TODO: VM_MAILBOX_ACCESS_ADDRESS */
+		n =3D 2 + (iei[1] + 1) / 2;
+		if (length < n + 11)
+			return;
+
+		/* TODO: VM_MESSAGE_PRIORITY_INDICATION */
+
+		/* Other parameters currently not supported */
+
+		ofono_message_waiting_notify(modem, iei[2 + n],
+				SMS_MWI_TYPE_VOICE, profile);
+	} else {
+		/* 9.2.3.24.13.2 Enhanced Voice Delete Confirmation */
+
+		/* MULTIPLE_SUBSCRIBER_PROFILE */
+		profile =3D (iei[0] >> 2) & 3;
+
+		/* SM_STORAGE */
+		*set =3D 0;
+		if (iei[0] & (1 << 4))
+			*store =3D 1;
+
+		/* TODO: VM_MAILBOX_ACCESS_ADDRESS */
+		n =3D 2 + (iei[1] + 1) / 2;
+		if (length < n + 11)
+			return;
+
+		/* Other parameters currently not supported */
+
+		ofono_message_waiting_notify(modem, iei[2 + n],
+				SMS_MWI_TYPE_VOICE, profile);
+	}
+}
+
+static void handle_mwi(struct ofono_modem *modem,
+			struct sms *sms, gboolean *out_discard)
+{
+	gboolean active, discard;
+	enum sms_mwi_type type;
+	char *message;
+	int profile =3D 1;
+	GSList *sms_list;
+
+	/* "Store" bits are ORed if multiple MWI types are present
+	 * but if neither Special SMS Message Indication nor DCS based
+	 * indication is present, the bit must remain set.  */
+	int set =3D 1, store =3D 0;
+
+	/* Check MWI types in the order from lowest to highest priority
+	 * because they will override one another.  */
+
+	if (sms->deliver.pid =3D=3D SMS_PID_TYPE_RETURN_CALL) {
+		ofono_message_waiting_notify(modem, MWI_UNSPECIFIED,
+				SMS_MWI_TYPE_VOICE, profile);
+	}
+
+	if (sms_mwi_dcs_decode(sms->deliver.dcs, &type,
+				NULL, &active, &discard)) {
+		set =3D 0;
+		store =3D (discard =3D=3D FALSE);
+
+		if (active)
+			ofono_message_waiting_notify(modem,
+				MWI_MESSAGES_WAITING, type, profile);
+		else
+			ofono_message_waiting_notify(modem,
+				MWI_NO_MESSAGES_WAITING, type, profile);
+	}
+
+	if (sms_dcs_decode(sms->deliver.dcs, NULL, NULL, NULL, NULL) &&
+			sms->deliver.udhi) {
+		guint8 special_iei[4], *evm_iei;
+		struct sms_udh_iter iter;
+		enum sms_iei iei;
+
+		if (!sms_udh_iter_init(sms, &iter))
+			goto final;
+
+		while ((iei =3D sms_udh_iter_get_ie_type(&iter)) !=3D
+				SMS_IEI_INVALID) {
+			switch (iei) {
+			case SMS_IEI_SPECIAL_MESSAGE_INDICATION:
+				if (sms_udh_iter_get_ie_length(&iter) !=3D 2)
+					break;
+				sms_udh_iter_get_ie_data(&iter, special_iei);
+
+				handle_special_sms_iei(modem, special_iei,
+						&set, &store);
+				break;
+			}
+
+			sms_udh_iter_next(&iter);
+		}
+
+		/* Go through the UDH again because Enhanced Voice Mail
+		 * Notification takes precedence over both DCS based
+		 * indication and Special SMS Message indication
+		 * (23.040 9.2.3.24.13.1).  */
+
+		if (!sms_udh_iter_init(sms, &iter))
+			goto final;
+
+		while ((iei =3D sms_udh_iter_get_ie_type(&iter)) !=3D
+				SMS_IEI_INVALID) {
+			switch (iei) {
+			case SMS_IEI_ENHANCED_VOICE_MAIL_INFORMATION:
+				evm_iei =3D g_malloc0(
+						sms_udh_iter_get_ie_length(
+							&iter));
+				sms_udh_iter_get_ie_data(&iter, evm_iei);
+
+				handle_enhanced_voicemail_iei(modem, evm_iei,
+						&set, &store,
+						sms_udh_iter_get_ie_length(
+							&iter));
+
+				g_free(evm_iei);
+				break;
+			}
+
+			sms_udh_iter_next(&iter);
+		}
+	}
+
+final:
+	/* Only bother the Message Waiting interface with textual
+	 * notifications that are not to be stored together with other
+	 * Short Messages in ME.  The other messages will be delivered
+	 * to the user through normal SMS store.  */
+	if (!store) {
+		sms_list =3D g_slist_append(NULL, sms);
+		message =3D sms_decode_text(sms_list);
+		g_slist_free(sms_list);
+
+		if (message) {
+			ofono_message_waiting_message(modem, message);
+			g_free(message);
+		}
+	}
+
+	if (out_discard)
+		*out_discard =3D !(set || store);
 }
 =

 void ofono_sms_deliver_notify(struct ofono_modem *modem, unsigned char *pd=
u,
@@ -688,14 +876,18 @@ void ofono_sms_deliver_notify(struct ofono_modem *mod=
em, unsigned char *pdu,
 	/* This is an older style MWI notification, process MWI
 	 * headers and handle it like any other message */
 	if (sms.deliver.pid =3D=3D SMS_PID_TYPE_RETURN_CALL) {
-		handle_mwi(modem, &sms);
+		handle_mwi(modem, &sms, &discard);
+
+		if (discard)
+			return;
+
 		goto out;
 	}
 =

 	/* The DCS indicates this is an MWI notification, process it
 	 * and then handle the User-Data as any other message */
-	if (sms_mwi_dcs_decode(sms.deliver.dcs, NULL, NULL, NULL, &discard)) {
-		handle_mwi(modem, &sms);
+	if (sms_mwi_dcs_decode(sms.deliver.dcs, NULL, NULL, NULL, NULL)) {
+		handle_mwi(modem, &sms, &discard);
 =

 		if (discard)
 			return;
@@ -760,7 +952,14 @@ void ofono_sms_deliver_notify(struct ofono_modem *mode=
m, unsigned char *pdu,
 			switch (iei) {
 			case SMS_IEI_SPECIAL_MESSAGE_INDICATION:
 			case SMS_IEI_ENHANCED_VOICE_MAIL_INFORMATION:
-				handle_mwi(modem, &sms);
+				/* TODO: ignore if not in the very first
+				 * segment of a concatenated SM so as not
+				 * to repeat the indication.  */
+				handle_mwi(modem, &sms, &discard);
+
+				if (discard)
+					return;
+
 				goto out;
 			case SMS_IEI_WCMP:
 				ofono_error("No support for WCMP, ignoring");
@@ -792,6 +991,9 @@ int ofono_sms_manager_register(struct ofono_modem *mode=
m,
 	if (ops =3D=3D NULL)
 		return -1;
 =

+	if (ofono_message_waiting_register(modem))
+		return -1;
+
 	modem->sms_manager =3D sms_manager_create();
 =

 	if (!modem->sms_manager)
@@ -827,4 +1029,6 @@ void ofono_sms_manager_unregister(struct ofono_modem *=
modem)
 					SMS_MANAGER_INTERFACE);
 =

 	modem_remove_interface(modem, SMS_MANAGER_INTERFACE);
+
+	ofono_message_waiting_unregister(modem);
 }
diff --git a/src/smsutil.h b/src/smsutil.h
index 89da973..d362aa9 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -158,6 +158,7 @@ enum sms_mwi_type {
 	SMS_MWI_TYPE_FAX =3D 1,
 	SMS_MWI_TYPE_EMAIL =3D 2,
 	SMS_MWI_TYPE_OTHER =3D 3,
+	SMS_MWI_TYPE_VIDEO =3D 4,
 };
 =

 enum sms_pid_type {
-- =

1.6.1


--===============6818871068108916203==--


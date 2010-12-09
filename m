Content-Type: multipart/mixed; boundary="===============2288081004990672269=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH 2/5] cdma-sms: Add CDMA SMS Support
Date: Wed, 08 Dec 2010 16:35:48 -0800
Message-ID: <1291854951-2378-3-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2288081004990672269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am        |    3 +-
 src/cdma-sms.c     |  342 ++++++++++++++++++++++++++++++++++++++
 src/cdma-smsutil.c |  467 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/cdma-smsutil.h |  264 +++++++++++++++++++++++++++++
 4 files changed, 1075 insertions(+), 1 deletions(-)
 create mode 100644 src/cdma-sms.c
 create mode 100644 src/cdma-smsutil.c
 create mode 100644 src/cdma-smsutil.h

diff --git a/Makefile.am b/Makefile.am
index 13cbc37..b7dc5ee 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -319,7 +319,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
-			src/smsagent.c src/smsagent.h src/ctm.c
+			src/smsagent.c src/smsagent.h src/ctm.c \
+			src/cdma-sms.c src/cdma-smsutil.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/cdma-sms.c b/src/cdma-sms.c
new file mode 100644
index 0000000..1271345
--- /dev/null
+++ b/src/cdma-sms.c
@@ -0,0 +1,342 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation. All rights reserved.
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
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+#include <sys/time.h>
+
+#include "ofono.h"
+
+#include "cdma-smsutil.h"
+#include "cdma-sms.h"
+
+static GSList *g_drivers;
+
+struct ofono_cdmasms {
+	const struct ofono_cdmasms_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static GDBusMethodTable cdmasms_manager_methods[] =3D {
+	/* TODO */
+	{ }
+};
+
+static GDBusSignalTable cdmasms_manager_signals[] =3D {
+	{ "IncomingMessage",	"sa{sv}"	},
+	/* TODO */
+	{ }
+};
+
+static void cdma_dispatch_text_message(struct ofono_cdmasms *cdmasms,
+										const char *message,
+										const char *oaddr)
+{
+	const char *path =3D ofono_cdmasms_get_path(cdmasms);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *signal_name;
+
+	/* TODO: Support ImmediateMessage */
+	signal_name =3D "IncomingMessage";
+
+	signal =3D dbus_message_new_signal(path,
+				OFONO_CDMA_MESSAGE_MANAGER_INTERFACE,
+				signal_name);
+	if (signal =3D=3D NULL)
+		return;
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
+			&(message));
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			OFONO_PROPERTIES_ARRAY_SIGNATURE, &dict);
+
+	ofono_dbus_dict_append(&dict, "Sender", DBUS_TYPE_STRING,
+			&oaddr);
+
+	/* TODO: Other property not supported yet */
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(conn, signal);
+
+    /*TODO: Add the message to history*/
+}
+
+static void ofono_cdmasms_process_wmt_deliver(struct ofono_cdmasms *cdmasm=
s,
+												struct cdma_sms *incoming)
+{
+	char *message;
+	char *oaddr;
+
+	message =3D cdmasms_decode_text(&incoming->p2p_msg.bearer_data.ud);
+	if (message =3D=3D NULL)
+		return;
+
+	oaddr =3D cdmasms_address_to_string(&incoming->p2p_msg.oaddr);
+	if (oaddr =3D=3D NULL) {
+		g_free(message);
+		return;
+	}
+
+	cdma_dispatch_text_message(cdmasms, message, oaddr);
+
+	g_free(message);
+	g_free(oaddr);
+}
+
+static void ofono_cdmasms_process_wmt(struct ofono_cdmasms *cdmasms,
+		struct cdma_sms *incoming)
+{
+	if (!check_bitmap(incoming->p2p_msg.bearer_data.subparam_bitmap,
+				SMS_SUBPARAM_ID_MESSAGE_ID))
+		return;
+
+	/* TODO: Add duplicate detection support */
+
+	switch (incoming->p2p_msg.bearer_data.id.msg_type) {
+	case CDMASMS_RESERVED:
+		break;
+	case CDMASMS_DELIVER:
+		ofono_cdmasms_process_wmt_deliver(cdmasms, incoming);
+		break;
+	case CDMASMS_SUBMIT:
+	case CDMASMS_CANCEL:
+	case CDMASMS_DELIVER_ACK:
+	case CDMASMS_USER_ACK:
+	case CDMASMS_READ_ACK:
+		break; /* TODO */
+	}
+}
+
+static void ofono_cdmasms_process_p2p(struct ofono_cdmasms *cdmasms,
+										struct cdma_sms *incoming)
+{
+	/* Check validity of incoming message, per Table 3.4.2.1-1 */
+	if (!(check_bitmap(incoming->p2p_msg.bearer_data.subparam_bitmap,
+					SMS_PARAM_ID_TELESERVICE_IDENTIFIER)
+			&&
+			check_bitmap(incoming->p2p_msg.param_bitmap,
+				SMS_PARAM_ID_ORIGINATING_ADDRESS)
+			))
+		return;
+
+	switch (incoming->p2p_msg.teleservice_id) {
+	case TELESERVICE_CMT91:
+	case TELESERVICE_WPT:
+		break; /* TODO: Not supported yet */
+	case TELESERVICE_WMT:
+		ofono_cdmasms_process_wmt(cdmasms, incoming);
+		break;
+	case TELESERVICE_VMN:
+	case TELESERVICE_WAP:
+	case TELESERVICE_WEMT:
+	case TELESERVICE_SCPT:
+	case TELESERVICE_CATPT:
+		break; /* TODO: Not supported yet */
+	}
+}
+
+void ofono_cdmasms_deliver_notify(struct ofono_cdmasms *cdmasms,
+									unsigned char *pdu, int pdu_len)
+{
+	struct cdma_sms s;
+	gboolean ret;
+
+	DBG("pdu len %d", pdu_len);
+
+	memset(&s, 0, sizeof(struct cdma_sms));
+
+	ret =3D cdmasms_decode(pdu, pdu_len, &s);
+	if (!ret)
+		return;
+
+	switch (s.type) {
+	case CDMASMS_P2P:
+		ofono_cdmasms_process_p2p(cdmasms, &s);
+		break;
+	case CDMASMS_BCAST:
+	case CDMASMS_ACK:
+		/*
+		 * TODO: Support SMS Broadcast Message and SMS
+		 * Acknowledge Message.
+		 */
+		break;
+	}
+}
+
+int ofono_cdmasms_driver_register(const struct ofono_cdmasms_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+
+	return 0;
+}
+
+void ofono_cdmasms_driver_unregister(const struct ofono_cdmasms_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+}
+
+static void cdmasms_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	g_dbus_unregister_interface(conn, path,
+					OFONO_CDMA_MESSAGE_MANAGER_INTERFACE);
+
+	ofono_modem_remove_interface(modem,
+		OFONO_CDMA_MESSAGE_MANAGER_INTERFACE);
+}
+
+static void cdmasms_remove(struct ofono_atom *atom)
+{
+	struct ofono_cdmasms *cdmasms =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (cdmasms =3D=3D NULL)
+		return;
+
+	if (cdmasms->driver && cdmasms->driver->remove)
+		cdmasms->driver->remove(cdmasms);
+
+	g_free(cdmasms);
+}
+
+/*
+ * Create a CDMA SMS driver
+ *
+ * This creates a CDMA SMS driver that is hung off a @modem
+ * object. However, for the driver to be used by the system, it has to
+ * be registered with the oFono core using ofono_sms_register().
+ *
+ * This is done once the modem driver determines that SMS is properly
+ * supported by the hardware.
+ */
+struct ofono_cdmasms *ofono_cdmasms_create(struct ofono_modem *modem,
+											unsigned int vendor,
+											const char *driver,
+											void *data)
+{
+	struct ofono_cdmasms *cdmasms;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	cdmasms =3D g_try_new0(struct ofono_cdmasms, 1);
+	if (cdmasms =3D=3D NULL)
+		return NULL;
+
+	cdmasms->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_SMS,
+						cdmasms_remove, cdmasms);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_cdmasms_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(cdmasms, vendor, data) < 0)
+			continue;
+
+		cdmasms->driver =3D drv;
+		break;
+	}
+
+	return cdmasms;
+}
+
+/*
+ * Indicate oFono that a CDMA SMS driver is ready for operation
+ *
+ * This is called after ofono_cdmasms_create() was done and the modem
+ * driver determined that a modem supports SMS correctly. Once this
+ * call succeeds, the D-BUS interface for SMS goes live.
+ */
+void ofono_cdmasms_register(struct ofono_cdmasms *cdmasms)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(cdmasms->atom);
+	const char *path =3D __ofono_atom_get_path(cdmasms->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_CDMA_MESSAGE_MANAGER_INTERFACE,
+					cdmasms_manager_methods,
+					cdmasms_manager_signals,
+					NULL, cdmasms, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_CDMA_MESSAGE_MANAGER_INTERFACE);
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_CDMA_MESSAGE_MANAGER_INTERFACE);
+
+	__ofono_atom_register(cdmasms->atom, cdmasms_unregister);
+}
+
+void ofono_cdmasms_remove(struct ofono_cdmasms *cdmasms)
+{
+	__ofono_atom_free(cdmasms->atom);
+}
+
+void ofono_cdmasms_set_data(struct ofono_cdmasms *cdmasms, void *data)
+{
+	cdmasms->driver_data =3D data;
+}
+
+void *ofono_cdmasms_get_data(struct ofono_cdmasms *cdmasms)
+{
+	return cdmasms->driver_data;
+}
+
+struct ofono_atom *ofono_cdmasms_get_atom(struct ofono_cdmasms *cdmasms)
+{
+	return cdmasms->atom;
+}
+
+const char *ofono_cdmasms_get_path(struct ofono_cdmasms *cdmasms)
+{
+	return __ofono_atom_get_path(cdmasms->atom);
+}
diff --git a/src/cdma-smsutil.c b/src/cdma-smsutil.c
new file mode 100644
index 0000000..e140d60
--- /dev/null
+++ b/src/cdma-smsutil.c
@@ -0,0 +1,467 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation. All rights reserved.
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
+#define _GNU_SOURCE
+#include <string.h>
+#include <dirent.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include "cdma-smsutil.h"
+
+/*
+ * Mapping from binary DTMF code to the digit it represents.
+ * As defined in Table 2.7.1.3.2.4-4 of 3GPP2 C.S0005-E v2.0.
+ * Note, 0 is NOT a valid value and not mapped to
+ * any valid DTMF digit.
+ */
+const char cdmasms_dtmf_digits[13] =3D {0, '1', '2', '3', '4', '5', '6', '=
7',
+		'8', '9', '0', '*', '#'};
+
+
+/* Unpacks the byte stream. */
+static guint32 bit_field_unpack(const guint8 *buf,
+								guint32 offset,
+								guint32 nbit)
+{
+	guint32    val =3D 0;
+	guint32    byteIndex;
+	guint32    remainder;
+
+	if (buf =3D=3D NULL)
+		return 0;
+
+	byteIndex =3D  offset >> 3;
+	remainder =3D (offset & 0x7);
+
+	if (remainder !=3D 0) {
+		/* The field to be unpacked does not start at the byte boundary.
+		 * Retrieve those bits first. */
+		if (nbit >=3D (8 - remainder)) {
+			/* The field at least spans till the end of the byte. */
+			val =3D  buf[byteIndex]  & ((1 << (8 - remainder)) - 1);
+			nbit -=3D  (8 - remainder);
+			byteIndex++;
+		} else {
+			val =3D (buf[byteIndex]  &
+				((1 << (8 - remainder)) - 1)) >> (8 - remainder - nbit);
+			return val;
+		}
+	}
+
+	/* Unpack rest of the bits in the field in 8-bit chunk. */
+	while (nbit >=3D 8) {
+		val =3D (val << 8) | buf[byteIndex];
+		nbit -=3D 8;
+		byteIndex++;
+	}
+
+	/* If still some left, unpack the last remaining bits. */
+	if (nbit > 0)
+		val =3D (val << nbit) | (buf[byteIndex]  >> (8 - nbit));
+
+	return val;
+}
+
+/* Convert CDMA DTMF digits into a string */
+static gboolean cdmasms_dtmf_to_ascii(char *buf, const char *addr,
+										guint8 num_fields)
+{
+	guint8 index;
+	guint8 value;
+
+	if (buf =3D=3D NULL || addr =3D=3D NULL)
+		return FALSE;
+
+	for (index =3D 0; index < num_fields; index++) {
+		if ((addr[index] <=3D 0) || (addr[index] > 12))
+			return FALSE;  /* Invalid digit in address field */
+
+		value =3D (guint8) addr[index];
+		buf[index] =3D cdmasms_dtmf_digits[value];
+	}
+
+	buf[index] =3D 0; /* Make it NULL terminated string */
+
+	return TRUE;
+}
+
+char *cdmasms_address_to_string(const struct cdmasms_address *addr)
+{
+	char *buf;
+
+	if (addr =3D=3D NULL)
+		return NULL;
+
+	if (addr->digit_mode !=3D DTMF_4_BIT)
+		return NULL; /* TODO: Only support DTMF_4_BIT currently */
+
+	buf =3D g_new(char, addr->num_fields + 1);
+	if (buf =3D=3D NULL)
+		return NULL;
+
+	if (!cdmasms_dtmf_to_ascii(buf, addr->address, addr->num_fields)) {
+		g_free(buf);
+		return NULL;
+    }
+
+	return buf;
+}
+
+/* Decode Address parameter record */
+static gboolean cdmasms_decode_addr(const unsigned char *buf, int len,
+										struct cdmasms_address *addr)
+{
+	guint32 bit_offset =3D 0;
+	guint8  chari_len;
+	guint32 total_num_bits =3D len * 8;
+	guint8  index;
+
+	if (len <=3D 0 || buf =3D=3D NULL || addr =3D=3D NULL)
+		return FALSE;
+
+	addr->digit_mode =3D (enum cdmasms_digit_mode) bit_field_unpack(buf, 0, 1=
);
+	bit_offset +=3D 1;
+	addr->number_mode =3D (guint8) bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	if (addr->digit_mode =3D=3D CODE_8_BIT) {
+		addr->number_type =3D (guint8) bit_field_unpack(buf, bit_offset, 3);
+		bit_offset +=3D 3;
+
+		if (addr->number_mode =3D=3D 0) {
+			if (bit_offset + 4 > total_num_bits)
+				return FALSE;
+
+			addr->number_plan =3D (enum cdmasms_numbering_plan)
+									bit_field_unpack(buf, bit_offset, 4);
+			bit_offset +=3D 4;
+		}
+	}
+
+	if ((bit_offset + 8) > total_num_bits)
+		return FALSE;
+
+	addr->num_fields =3D (guint8) bit_field_unpack(buf, bit_offset, 8);
+	bit_offset +=3D 8;
+
+	if (addr->digit_mode =3D=3D DTMF_4_BIT)
+		chari_len =3D 4;
+	else
+		chari_len =3D 8;
+
+	if ((bit_offset + (chari_len * addr->num_fields)) > total_num_bits)
+		return FALSE;
+
+	for (index =3D 0; index < addr->num_fields; index++) {
+		addr->address[index] =3D (char) bit_field_unpack(buf, bit_offset,
+														chari_len);
+		bit_offset +=3D chari_len;
+	}
+
+	return TRUE;
+}
+
+char *cdmasms_decode_text(struct cdmasms_ud *ud)
+{
+	char *buf;
+
+	if (ud =3D=3D NULL)
+		return NULL;
+
+	/* TODO: Only support MSG_ENCODING_7BIT_ASCII currently */
+	if (ud->msg_encoding !=3D MSG_ENCODING_7BIT_ASCII)
+		return NULL;
+
+	buf =3D g_new(char, ud->num_fields + 1);
+	if (buf =3D=3D NULL)
+		return NULL;
+
+	memcpy(buf, ud->chari, ud->num_fields);
+	buf[ud->num_fields] =3D 0; /* Make it NULL terminated string */
+
+	return buf;
+}
+
+/* Decode User Data */
+static gboolean cdmasms_decode_ud(const unsigned char *buf,
+									int len, struct cdmasms_ud *ud)
+{
+	guint32 bit_offset =3D 0;
+	guint8  chari_len =3D 0;
+	guint32 total_num_bits =3D len * 8;
+	guint8  index;
+	enum cdmasms_message_encoding  msg_encoding;
+
+	if (buf =3D=3D NULL || ud =3D=3D NULL)
+		return FALSE;
+
+	if (total_num_bits < 13)
+		return FALSE;
+
+	msg_encoding =3D (enum cdmasms_message_encoding)
+					bit_field_unpack(buf, bit_offset, 5);
+	ud->msg_encoding =3D  msg_encoding;
+	bit_offset +=3D 5;
+
+	if (ud->msg_encoding =3D=3D MSG_ENCODING_EXTENDED_PROTOCOL_MSG ||
+			ud->msg_encoding =3D=3D MSG_ENCODING_GSM_DATA_CODING) {
+		/* Skip message type field */
+		/* TODO: Add support for message type field */
+		bit_offset +=3D 8;
+	}
+
+	if (bit_offset + 8 > total_num_bits)
+		return FALSE;
+
+	ud->num_fields =3D (guint8) bit_field_unpack(buf, bit_offset, 8);
+	bit_offset +=3D 8;
+
+	switch (msg_encoding) {
+	case MSG_ENCODING_OCTET:
+		chari_len =3D 8;
+		break;
+	case MSG_ENCODING_EXTENDED_PROTOCOL_MSG:
+		return FALSE; /* TODO */
+	case MSG_ENCODING_7BIT_ASCII:
+	case MSG_ENCODING_IA5:
+		chari_len =3D 7;
+		break;
+	case MSG_ENCODING_UNICODE:
+	case MSG_ENCODING_SHIFT_JIS:
+	case MSG_ENCODING_KOREAN:
+		return FALSE; /* TODO */
+	case MSG_ENCODING_LATIN_HEBREW:
+	case MSG_ENCODING_LATIN:
+		chari_len =3D 8;
+		break;
+	case MSG_ENCODING_GSM_7BIT:
+		chari_len =3D 7;
+		break;
+	case MSG_ENCODING_GSM_DATA_CODING:
+		return FALSE; /* TODO */
+	}
+
+	if (chari_len =3D=3D 0)
+		return FALSE;
+
+	if (bit_offset + chari_len * ud->num_fields > total_num_bits)
+		return FALSE;
+
+	for (index =3D 0; index < ud->num_fields; index++) {
+		ud->chari[index] =3D (guint8) bit_field_unpack(buf, bit_offset,
+										chari_len);
+		bit_offset +=3D chari_len;
+	}
+
+	return TRUE;
+}
+
+/* Decode Message Identifier */
+static gboolean cdmasms_decode_message_id(const unsigned char *buf,
+											int len,
+											struct cdmasms_identifier *id)
+{
+	guint32 bit_offset =3D 0;
+
+	if (buf =3D=3D NULL || id =3D=3D NULL)
+		return FALSE;
+
+    if (len !=3D 3)
+		return FALSE;
+
+	id->msg_type =3D (enum cdmasms_msg_type) bit_field_unpack(buf, bit_offset=
, 4);
+	bit_offset +=3D 4;
+	id->msg_id =3D (guint16) bit_field_unpack(buf, bit_offset, 16);
+	bit_offset +=3D 16;
+	id->header_ind =3D (gboolean) bit_field_unpack(buf, bit_offset, 1);
+
+	return TRUE;
+}
+
+/* Decode Bearer Data */
+static gboolean cdmasms_decode_bearer_data(const unsigned char *buf, int l=
en,
+									struct cdmasms_bearer_data *bearer_data)
+{
+	gboolean ret =3D TRUE;
+	enum cdmasms_subparam_id subparam_id;
+	guint8 subparam_len;
+
+	if (buf =3D=3D NULL || bearer_data =3D=3D NULL)
+		return FALSE;
+
+	while (len !=3D 0) {
+
+		if (len < 2)
+			return FALSE;
+
+		subparam_id =3D (enum cdmasms_subparam_id) bit_field_unpack(buf, 0, 8);
+		buf +=3D 1;
+		subparam_len =3D (guint8) bit_field_unpack(buf, 0, 8);
+		buf +=3D 1;
+		len -=3D 2;
+
+		if (len < subparam_len)
+			return FALSE;
+
+		switch (subparam_id) {
+		case SMS_SUBPARAM_ID_MESSAGE_ID:
+			ret =3D cdmasms_decode_message_id(buf, subparam_len,
+										&bearer_data->id);
+			set_bitmap(&bearer_data->subparam_bitmap,
+					SMS_SUBPARAM_ID_MESSAGE_ID);
+			break;
+		case SMS_SUBPARAM_ID_USER_DATA:
+			ret =3D cdmasms_decode_ud(buf, subparam_len, &bearer_data->ud);
+			set_bitmap(&bearer_data->subparam_bitmap,
+					SMS_SUBPARAM_ID_USER_DATA);
+			break;
+		case SMS_SUBPARAM_ID_USER_RESPONSE_CODE:
+		case SMS_SUBPARAM_ID_MC_TIME_STAMP:
+		case SMS_SUBPARAM_ID_VALIDITY_PERIOD_ABSOLUTE:
+		case SMS_SUBPARAM_ID_VALIDITY_PERIOD_RELATIVE:
+		case SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_ABSOLUTE:
+		case SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_RELATIVE:
+		case SMS_SUBPARAM_ID_PRIORITY_INDICATOR:
+		case SMS_SUBPARAM_ID_PRIVACY_INDICATOR:
+		case SMS_SUBPARAM_ID_REPLY_OPTION:
+		case SMS_SUBPARAM_ID_NUMBER_OF_MESSAGES:
+		case SMS_SUBPARAM_ID_ALERT_ON_MESSAGE_DELIVERY:
+		case SMS_SUBPARAM_ID_LANGUAGE_INDICATOR:
+		case SMS_SUBPARAM_ID_CALL_BACK_NUMBER:
+		case SMS_SUBPARAM_ID_MESSAGE_DISPLAY_MODE:
+		case SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA:
+		case SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX:
+		case SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_DATA:
+		case SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_RESULT:
+		case SMS_SUBPARAM_ID_MESSAGE_STATUS:
+		case SMS_SUBPARAM_ID_TP_FAILURE_CAUSE:
+		case SMS_SUBPARAM_ID_ENHANCED_VMN:
+		case SMS_SUBPARAM_ID_ENHANCED_VMN_ACK:
+			/* TODO */
+			/* Ignore any other unsupported/un-recognized parameter */
+			break;
+		}
+
+		if (ret =3D=3D FALSE)
+			return FALSE;
+
+		len -=3D subparam_len;
+		buf +=3D subparam_len;
+	}
+
+	return TRUE;
+}
+
+static gboolean cdmasms_p2p_decode(const unsigned char *pdu, int len,
+									struct cdma_sms *incoming)
+{
+	gboolean ret =3D TRUE;
+	enum cdmasms_param_id rec_id;
+	guint8 rec_len;
+
+	if (pdu =3D=3D NULL || incoming =3D=3D NULL)
+		return FALSE;
+
+	while (len !=3D 0) {
+
+		if (len <=3D 2)
+			return FALSE;
+
+		rec_id =3D (enum cdmasms_param_id) bit_field_unpack(pdu, 0, 8);
+		pdu +=3D 1;
+		rec_len =3D (guint8) bit_field_unpack(pdu, 0, 8);
+		pdu +=3D 1;
+		len -=3D 2;
+
+		if (len < rec_len)
+			return FALSE;
+
+		switch (rec_id) {
+		case SMS_PARAM_ID_TELESERVICE_IDENTIFIER:
+			incoming->p2p_msg.teleservice_id =3D (enum cdmasms_teleservice_id)
+												bit_field_unpack(pdu, 0, 16);
+			set_bitmap(&incoming->p2p_msg.param_bitmap,
+					SMS_PARAM_ID_TELESERVICE_IDENTIFIER);
+			break;
+		case SMS_PARAM_ID_SERVICE_CATEGORY:
+			break; /* TODO */
+		case SMS_PARAM_ID_ORIGINATING_ADDRESS:
+			ret =3D cdmasms_decode_addr(pdu, rec_len, &incoming->p2p_msg.oaddr);
+			set_bitmap(&incoming->p2p_msg.param_bitmap,
+					SMS_PARAM_ID_ORIGINATING_ADDRESS);
+			break;
+		case SMS_PARAM_ID_ORIGINATING_SUBADDRESS:
+		case SMS_PARAM_ID_DESTINATION_ADDRESS:
+		case SMS_PARAM_ID_DESTINATION_SUBADDRESS:
+		case SMS_PARAM_ID_BEARER_REPLY_OPTION:
+		case SMS_PARAM_ID_CAUSE_CODE:
+			break; /* TODO */
+		case SMS_PARAM_ID_BEARER_DATA:
+			ret =3D cdmasms_decode_bearer_data(pdu, rec_len,
+											&incoming->p2p_msg.bearer_data);
+			set_bitmap(&incoming->p2p_msg.param_bitmap,
+					SMS_PARAM_ID_BEARER_DATA);
+			break;
+		}
+
+		if (!ret)
+			return FALSE;
+
+		len -=3D rec_len;
+		pdu +=3D rec_len;
+	}
+
+	return TRUE;
+}
+
+gboolean cdmasms_decode(const unsigned char *pdu, int len,
+						struct cdma_sms *incoming)
+{
+	gboolean ret =3D FALSE;
+
+	if ((len =3D=3D 0) || (pdu =3D=3D NULL) || (incoming =3D=3D NULL))
+		return FALSE;
+
+	incoming->type =3D (enum cdmasms_tp_msg_type) bit_field_unpack(pdu, 0, 8);
+	pdu +=3D 1;
+	len -=3D 1;
+
+	switch (incoming->type) {
+	case CDMASMS_P2P:
+		ret =3D cdmasms_p2p_decode(pdu, len, incoming);
+		break;
+	case CDMASMS_BCAST:
+	case CDMASMS_ACK:
+		/* TODO: Not supported yet */
+		ret =3D FALSE;
+		break;
+	}
+
+	return ret;
+}
diff --git a/src/cdma-smsutil.h b/src/cdma-smsutil.h
new file mode 100644
index 0000000..5188378
--- /dev/null
+++ b/src/cdma-smsutil.h
@@ -0,0 +1,264 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation. All rights reserved.
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
+/* 3GPP2 C.S0015-B v2.0, Table 3.4-1 */
+enum cdmasms_tp_msg_type {
+	CDMASMS_P2P =3D		0,
+	CDMASMS_BCAST =3D		1,
+	CDMASMS_ACK =3D		2
+};
+
+/* 3GPP2 X.S0004-550-E, Section 2.256 */
+enum cdmasms_teleservice_id {
+	TELESERVICE_CMT91 =3D	4096,
+	TELESERVICE_WPT =3D	4097,
+	TELESERVICE_WMT =3D	4098,
+	TELESERVICE_VMN =3D	4099,
+	TELESERVICE_WAP =3D	4100,
+	TELESERVICE_WEMT =3D	4101,
+	TELESERVICE_SCPT =3D	4102,
+	TELESERVICE_CATPT =3D	4103
+};
+
+/* 3GPP2 C.S0005-E v2.0 Table 2.7.1.3.2.4-2 */
+enum cdmasms_digi_number_type {
+	CDMASMS_NUM_TYPE_UNKNOWN =3D					0,
+	CDMASMS_NUM_TYPE_INTERNATIONAL_NUMBER =3D		1,
+	CDMASMS_NUM_TYPE_NATIONAL_NUMBER =3D			2,
+	CDMASMS_NUM_TYPE_NETWORK_SPECIFIC_NUMBER =3D	3,
+	CDMASMS_NUM_TYPE_SUBSCRIBER_NUMBER =3D		4,
+	/* Reserved 5 */
+	CDMASMS_NUM_TYPE_ABBREVIATED_NUMBER =3D		6
+	/* Reserved 7 */
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 3.4.3.3-1 */
+enum cdmasms_data_network_number_type {
+	CDMASMS_NETWORK_NUM_TYPE_UNKNOWN =3D				0,
+	CDMASMS_NETWORK_TYPE_INTERNET_PROTOCOL =3D		1,
+	CDMASMS_NETWORK_TYPE_INTERNET_EMAIL_ADDRESS =3D	2,
+	/* All Other Values Reserved */
+};
+
+/* 3GPP2 C.S0005-E v2.0 Table 2.7.1.3.2.4-3 */
+enum cdmasms_numbering_plan {
+	CDMASMS_NUMBERING_PLAN_UNKNOWN =3D	0,
+	CDMASMS_NUMBERING_PLAN_ISDN =3D		1,
+	CDMASMS_NUMBERING_PLAN_DATA =3D		3,
+	CDMASMS_NUMBERING_PLAN_TELEX =3D		4,
+	CDMASMS_NUMBERING_PLAN_PRIVATE =3D	9,
+	CDMASMS_NUMBERING_PLAN_RESERVED =3D	15
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 4.5.1-1 */
+enum cdmasms_msg_type {
+	CDMASMS_RESERVED =3D		0,
+	CDMASMS_DELIVER =3D		1,
+	CDMASMS_SUBMIT =3D		2,
+	CDMASMS_CANCEL =3D		3,
+	CDMASMS_DELIVER_ACK =3D	4,
+	CDMASMS_USER_ACK =3D		5,
+	CDMASMS_READ_ACK =3D		6,
+};
+
+/* C.R1001-G_v1.0 Table 9.1-1 */
+enum cdmasms_message_encoding {
+	MSG_ENCODING_OCTET =3D					0,
+	MSG_ENCODING_EXTENDED_PROTOCOL_MSG =3D	1,
+	MSG_ENCODING_7BIT_ASCII =3D				2,
+	MSG_ENCODING_IA5 =3D						3,
+	MSG_ENCODING_UNICODE =3D					4,
+	MSG_ENCODING_SHIFT_JIS =3D				5,
+	MSG_ENCODING_KOREAN =3D					6,
+	MSG_ENCODING_LATIN_HEBREW =3D				7,
+	MSG_ENCODING_LATIN =3D					8,
+	MSG_ENCODING_GSM_7BIT =3D					9,
+	MSG_ENCODING_GSM_DATA_CODING =3D			10
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 3.4.3-1 */
+enum cdmasms_param_id {
+	SMS_PARAM_ID_TELESERVICE_IDENTIFIER  =3D	0x00,
+	SMS_PARAM_ID_SERVICE_CATEGORY =3D			0x01,
+	SMS_PARAM_ID_ORIGINATING_ADDRESS =3D		0x02,
+	SMS_PARAM_ID_ORIGINATING_SUBADDRESS =3D	0x03,
+	SMS_PARAM_ID_DESTINATION_ADDRESS =3D		0x04,
+	SMS_PARAM_ID_DESTINATION_SUBADDRESS =3D	0x05,
+	SMS_PARAM_ID_BEARER_REPLY_OPTION =3D		0x06,
+	SMS_PARAM_ID_CAUSE_CODE =3D				0x07,
+	SMS_PARAM_ID_BEARER_DATA =3D				0x08
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 4.5-1 */
+enum cdmasms_subparam_id {
+	SMS_SUBPARAM_ID_MESSAGE_ID =3D						0x00,
+	SMS_SUBPARAM_ID_USER_DATA =3D							0x01,
+	SMS_SUBPARAM_ID_USER_RESPONSE_CODE =3D				0x02,
+	SMS_SUBPARAM_ID_MC_TIME_STAMP =3D						0x03,
+	SMS_SUBPARAM_ID_VALIDITY_PERIOD_ABSOLUTE =3D			0x04,
+	SMS_SUBPARAM_ID_VALIDITY_PERIOD_RELATIVE =3D 			0x05,
+	SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_ABSOLUTE =3D	0x06,
+	SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_RELATIVE =3D	0x07,
+	SMS_SUBPARAM_ID_PRIORITY_INDICATOR =3D				0x08,
+	SMS_SUBPARAM_ID_PRIVACY_INDICATOR =3D					0x09,
+	SMS_SUBPARAM_ID_REPLY_OPTION =3D						0x0A,
+	SMS_SUBPARAM_ID_NUMBER_OF_MESSAGES =3D				0x0B,
+	SMS_SUBPARAM_ID_ALERT_ON_MESSAGE_DELIVERY =3D			0x0C,
+	SMS_SUBPARAM_ID_LANGUAGE_INDICATOR =3D				0x0D,
+	SMS_SUBPARAM_ID_CALL_BACK_NUMBER =3D					0x0E,
+	SMS_SUBPARAM_ID_MESSAGE_DISPLAY_MODE =3D				0x0F,
+	SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA =3D		0x10,
+	SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX =3D				0x11,
+	SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_DATA =3D		0x12,
+	SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_RESULT =3D	0x13,
+	SMS_SUBPARAM_ID_MESSAGE_STATUS =3D					0x14,
+	SMS_SUBPARAM_ID_TP_FAILURE_CAUSE =3D					0x15,
+	SMS_SUBPARAM_ID_ENHANCED_VMN =3D						0x16,
+	SMS_SUBPARAM_ID_ENHANCED_VMN_ACK =3D					0x17
+};
+
+/* 3GPP2 C.R1001-G Table 9.3.1-1 */
+enum cdmasms_service_category {
+	SERVICE_CAT_EMERGENCY_BROADCAST =3D					1,
+	SERVICE_CAT_ADMINISTRATIVE =3D						2,
+	SERVICE_CAT_MAINTENANCE =3D							3,
+	SERVICE_CAT_GENERALNEWSLOCAL =3D						4,
+	SERVICE_CAT_GENERALNEWSREGIONAL =3D					5,
+	SERVICE_CAT_GENERALNEWSNATIONAL =3D					6,
+	SERVICE_CAT_GENERALNEWSINTERNATIONAL =3D				7,
+	SERVICE_CAT_BUSINESSFINALNEWSLOCAL =3D				8,
+	SERVICE_CAT_BUSINESSFINALNEWSREGIONAL =3D				9,
+	SERVICE_CAT_BUSINESSFINALNEWSNATIONAL =3D				10,
+	SERVICE_CAT_BUSINESSFINALNEWSINTNL =3D				11,
+	SERVICE_CAT_SPORTSNEWSLOCAL =3D						12,
+	SERVICE_CAT_SPORTSNEWSREGIONAL =3D					13,
+	SERVICE_CAT_SPORTSNEWSNATIONAL =3D					14,
+	SERVICE_CAT_SPORTSNEWSINTERNATIONAL =3D				15,
+	SERVICE_CAT_ENTERTAINMENTNEWSLOCAL =3D				16,
+	SERVICE_CAT_ENTERTAINMENTNEWSREGIONAL =3D				17,
+	SERVICE_CAT_ENTERTAINMENTNEWSNATIONAL =3D				18,
+	SERVICE_CAT_ENTERTAINMENTNEWSINTERNATIONAL =3D		19,
+	SERVICE_CAT_ENTERTAINMENTNEWSLOCALWEATHER =3D			20,
+	SERVICE_CAT_AREATRAFFICREPORTS =3D					21,
+	SERVICE_CAT_LOCALAIRTPORTFLIGHTSCHEDULES =3D			22,
+	SERVICE_CAT_RESTURANTS =3D							23,
+	SERVICE_CAT_LODGINGS =3D								24,
+	SERVICE_CAT_RETAILDIRECTORYADVERTISEMENTS =3D			25,
+	SERVICE_CAT_ADVERTISEMENTS =3D						26,
+	SERVICE_CAT_STOCKQUOTES =3D							27,
+	SERVICE_CAT_EMPLOYMENTOPPORTUNITIES =3D				28,
+	SERVICE_CAT_MEDICALHEALTHHOSPITALS =3D				29,
+	SERVICE_CAT_TECHNOLOGYNEWS =3D						30,
+	SERVICE_CAT_MULTICATEGORY =3D							31,
+	SERVICE_CAT_CAPT =3D									32
+};
+
+enum cdmasms_digit_mode {
+	DTMF_4_BIT =3D	0,
+	CODE_8_BIT =3D	1
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.3 */
+struct cdmasms_address {
+	enum cdmasms_digit_mode digit_mode;
+	guint8 number_mode;
+	guint8 number_type;
+	enum cdmasms_numbering_plan number_plan;
+	guint8 num_fields;
+	char address[256];
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.6 */
+struct cdmasms_cause_code {
+	guint8 reply_seq;
+	guint8 error_class;
+	guint8 cause_code;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.1 */
+struct cdmasms_identifier {
+	enum cdmasms_msg_type msg_type;
+	guint16 msg_id;
+	gboolean header_ind;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.2 */
+struct cdmasms_ud {
+	enum cdmasms_message_encoding msg_encoding;
+	guint8  num_fields;
+	guint8  chari[512];
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5 */
+struct cdmasms_bearer_data {
+	guint32 subparam_bitmap;
+	struct cdmasms_identifier id;
+	struct cdmasms_ud ud;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 3.4.2.1-1. */
+struct cdmasms_p2p_msg {
+	guint32 param_bitmap;
+	enum cdmasms_teleservice_id teleservice_id;
+	struct cdmasms_address oaddr;
+	struct cdmasms_bearer_data bearer_data;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 3.4.2.2-1 */
+struct cdmasms_broadcast_msg {
+	enum cdmasms_service_category service_category;
+	struct cdmasms_bearer_data bearer_data;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 3.4.2.3-1 */
+struct cdmasms_ack_msg {
+	struct cdmasms_address daddr;
+	struct cdmasms_cause_code cause_code;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 3.4.1 */
+struct cdma_sms {
+	enum cdmasms_tp_msg_type type;
+	union {
+		struct cdmasms_p2p_msg p2p_msg;
+		struct cdmasms_broadcast_msg broadcast_msg;
+		struct cdmasms_ack_msg ack_msg;
+	};
+};
+
+static inline gboolean check_bitmap(guint32 bitmap, guint32 pos)
+{
+	guint32 mask =3D 0x1 << pos;
+	return bitmap & mask ? TRUE : FALSE;
+}
+
+static inline void set_bitmap(guint32 *bitmap, guint32 pos)
+{
+	if (bitmap =3D=3D NULL)
+		return;
+
+	*bitmap =3D *bitmap | (1 << pos);
+}
+
+gboolean cdmasms_decode(const unsigned char *pdu, int len,
+	struct cdma_sms *out);
+char *cdmasms_decode_text(struct cdmasms_ud *ud);
+char *cdmasms_address_to_string(const struct cdmasms_address *addr);
-- =

1.7.0.4


--===============2288081004990672269==--


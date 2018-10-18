Content-Type: multipart/mixed; boundary="===============2247565242726740353=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v7 6/7] gemalto/lte: Gemalto vendor lte atom
Date: Thu, 18 Oct 2018 20:49:51 +0200
Message-ID: <20181018184952.10797-7-gciofono@gmail.com>
In-Reply-To: <20181018184952.10797-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2247565242726740353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added a vendor-specific lte atom, for handling PDP context creation
and authentication, using the actual formats for the vendor.

The code for PDP context and authentication command formating
is in a separate file, gemaltoutil, because in the future it can be
shared with the gprs-context atom.

Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>
Co-authored-by: Sebastian Arnd <sebastianarnd@gmail.com>
---
 Makefile.am                         |   5 +-
 drivers/gemaltomodem/gemaltomodem.c |   2 +
 drivers/gemaltomodem/gemaltomodem.h |   4 +
 drivers/gemaltomodem/gemaltoutil.c  | 106 +++++++++++++
 drivers/gemaltomodem/gemaltoutil.h  |  31 ++++
 drivers/gemaltomodem/lte.c          | 221 ++++++++++++++++++++++++++++
 6 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gemaltomodem/gemaltoutil.c
 create mode 100644 drivers/gemaltomodem/gemaltoutil.h
 create mode 100644 drivers/gemaltomodem/lte.c

diff --git a/Makefile.am b/Makefile.am
index e8e4ed95..dd0bc0bb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -397,8 +397,11 @@ builtin_modules +=3D gemaltomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/gemaltomodem/gemaltomodem.h \
 			drivers/gemaltomodem/gemaltomodem.c \
+			drivers/gemaltomodem/gemaltoutil.h \
+			drivers/gemaltomodem/gemaltoutil.c \
 			drivers/gemaltomodem/location-reporting.c \
-			drivers/gemaltomodem/voicecall.c
+			drivers/gemaltomodem/voicecall.c \
+			drivers/gemaltomodem/lte.c
 =

 builtin_modules +=3D xmm7modem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/gem=
altomodem.c
index 4818ac66..459c3583 100644
--- a/drivers/gemaltomodem/gemaltomodem.c
+++ b/drivers/gemaltomodem/gemaltomodem.c
@@ -37,12 +37,14 @@ static int gemaltomodem_init(void)
 {
 	gemalto_location_reporting_init();
 	gemalto_voicecall_init();
+	gemalto_lte_init();
 =

 	return 0;
 }
 =

 static void gemaltomodem_exit(void)
 {
+	gemalto_lte_exit();
 	gemalto_voicecall_exit();
 	gemalto_location_reporting_exit();
 }
diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/gem=
altomodem.h
index 27b1460e..9f285563 100644
--- a/drivers/gemaltomodem/gemaltomodem.h
+++ b/drivers/gemaltomodem/gemaltomodem.h
@@ -21,9 +21,13 @@
  */
 =

 #include <drivers/atmodem/atutil.h>
+#include "gemaltoutil.h"
 =

 extern void gemalto_location_reporting_init();
 extern void gemalto_location_reporting_exit();
 =

 extern void gemalto_voicecall_init();
 extern void gemalto_voicecall_exit();
+
+extern void gemalto_lte_init();
+extern void gemalto_lte_exit();
diff --git a/drivers/gemaltomodem/gemaltoutil.c b/drivers/gemaltomodem/gema=
ltoutil.c
new file mode 100644
index 00000000..d8c08e16
--- /dev/null
+++ b/drivers/gemaltomodem/gemaltoutil.c
@@ -0,0 +1,106 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2018 Gemalto M2M
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
+#include <glib.h>
+#include <gatchat.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/log.h>
+#include <ofono/types.h>
+
+#include "ofono.h"
+#include "gemaltomodem.h"
+
+enum gemalto_auth_option {
+	GEMALTO_AUTH_DEFAULTS		=3D 0x00,
+	GEMALTO_AUTH_USE_SGAUTH		=3D 0x01,
+	GEMALTO_AUTH_ORDER_PWD_USR	=3D 0x02,
+	GEMALTO_AUTH_ALW_ALL_PARAMS	=3D 0x04,
+};
+
+char *gemalto_get_auth_command(struct ofono_modem *modem, int cid,
+				enum ofono_gprs_auth_method auth_method,
+				const char *username, const char *password)
+{
+	int gemalto_auth =3D ofono_modem_get_integer(modem, "GemaltoAuthType");
+	int len;
+	int auth_type =3D at_get_auth_type(auth_method);
+	size_t buflen =3D 32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
+					OFONO_GPRS_MAX_PASSWORD_LENGTH  + 1;
+	char *buf =3D g_new(char, buflen);
+
+	/* for now. Later to consider modules where the LTE attach CID=3D3 */
+	if (cid=3D=3D0)
+		cid=3D1;
+
+	if (gemalto_auth & GEMALTO_AUTH_USE_SGAUTH)
+		len =3D snprintf(buf, buflen, "AT^SGAUTH=3D%d,%d", cid, auth_type);
+	else
+		len =3D snprintf(buf, buflen, "AT+CGAUTH=3D%d,%d", cid, auth_type);
+
+	buflen -=3D len;
+
+	switch(auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+
+		if (gemalto_auth & GEMALTO_AUTH_ALW_ALL_PARAMS)
+			snprintf(buf+len, buflen, ",\"\",\"\"");
+
+		break;
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+
+		if (gemalto_auth & GEMALTO_AUTH_ORDER_PWD_USR)
+			snprintf(buf+len, buflen, ",\"%s\",\"%s\"",
+							password, username);
+		else
+			snprintf(buf+len, buflen, ",\"%s\",\"%s\"",
+							username, password);
+
+		break;
+	}
+
+	return buf;
+}
+
+char *gemalto_get_cgdcont_command(struct ofono_modem *modem, guint cid,
+				enum ofono_gprs_proto proto, const char *apn)
+{
+	/*
+	 * For future extension: verify if the module supports automatic
+	 * context provisioning and if so, also if there is a manual override
+	 * This is an ofono_modem_get_integer property
+	 */
+
+	/* for now. Later to consider modules where the LTE attach CID=3D3 */
+	if (cid=3D=3D0)
+		cid=3D1;
+
+	return at_get_cgdcont_command(cid, proto, apn);
+}
diff --git a/drivers/gemaltomodem/gemaltoutil.h b/drivers/gemaltomodem/gema=
ltoutil.h
new file mode 100644
index 00000000..d653f61d
--- /dev/null
+++ b/drivers/gemaltomodem/gemaltoutil.h
@@ -0,0 +1,31 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2018 Gemalto M2M
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
+struct ofono_modem;
+
+char *gemalto_get_auth_command(struct ofono_modem *modem, int cid,
+				enum ofono_gprs_auth_method auth_method,
+				const char *username, const char *password);
+
+
+char *gemalto_get_cgdcont_command(struct ofono_modem *modem, guint cid,
+				enum ofono_gprs_proto proto, const char *apn);
+
diff --git a/drivers/gemaltomodem/lte.c b/drivers/gemaltomodem/lte.c
new file mode 100644
index 00000000..1c72173f
--- /dev/null
+++ b/drivers/gemaltomodem/lte.c
@@ -0,0 +1,221 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
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
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+#include <ofono/log.h>
+#include <ofono/lte.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "gemaltomodem.h"
+
+struct gemalto_lte_driver_data {
+	GAtChat *chat;
+};
+
+struct gemalto_lte_cbd {
+	gint ref_count; /* Ref count */
+	ofono_lte_cb_t cb;
+	void *data;
+	GAtChat *chat;
+	const struct ofono_lte_default_attach_info *info;
+	struct ofono_modem *modem;
+};
+
+static struct gemalto_lte_cbd *gemalto_lte_cb_data_new0(void *cb, void *da=
ta,
+		GAtChat *chat, const struct ofono_lte_default_attach_info *info,
+		struct ofono_modem *modem)
+{
+	struct gemalto_lte_cbd *cbd =3D g_new0(struct gemalto_lte_cbd, 1);
+
+	cbd->ref_count =3D 1;
+	cbd->cb =3D cb;
+	cbd->data =3D data;
+	cbd->chat =3D chat;
+	cbd->info =3D info;
+	cbd->modem =3D modem;
+
+	return cbd;
+}
+
+static inline struct gemalto_lte_cbd *gemalto_lte_cb_data_ref(
+						struct gemalto_lte_cbd *cbd)
+{
+	if (cbd =3D=3D NULL)
+		return NULL;
+
+	g_atomic_int_inc(&cbd->ref_count);
+
+	return cbd;
+}
+
+static void gemalto_lte_cb_data_unref(gpointer user_data)
+{
+	gboolean is_zero;
+	struct gemalto_lte_cbd *cbd =3D user_data;
+
+	if (cbd =3D=3D NULL)
+		return;
+
+	is_zero =3D g_atomic_int_dec_and_test(&cbd->ref_count);
+
+	if (is_zero =3D=3D TRUE)
+		g_free(cbd);
+}
+
+static void gemalto_lte_set_auth_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
+{
+	struct gemalto_lte_cbd *cbd =3D user_data;
+	ofono_lte_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void gemalto_lte_set_default_attach_info_cb(gboolean ok,
+					GAtResult *result, gpointer user_data)
+{
+	struct gemalto_lte_cbd *cbd =3D user_data;
+	ofono_lte_cb_t cb =3D cbd->cb;
+	void *data =3D cbd->data;
+	struct ofono_error error;
+	char *buf;
+	enum ofono_gprs_auth_method auth_method;
+
+	if (!ok) {
+		gemalto_lte_cb_data_unref(cbd);
+		decode_at_error(&error, g_at_result_final_response(result));
+		cb(&error, data);
+		return;
+	}
+
+	auth_method =3D cbd->info->auth_method;
+
+	/* change the authentication method if the  parameters are invalid */
+	if (!*cbd->info->username || !*cbd->info->password)
+		auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
+
+	buf =3D gemalto_get_auth_command(cbd->modem, 0, auth_method,
+			cbd->info->username, cbd->info->password);
+	cbd =3D gemalto_lte_cb_data_ref(cbd);
+
+	if (g_at_chat_send(cbd->chat, buf, NULL,
+				gemalto_lte_set_auth_cb, cbd,
+				gemalto_lte_cb_data_unref) > 0)
+		goto end;
+
+	gemalto_lte_cb_data_unref(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+end:
+	g_free(buf);
+}
+
+static void gemalto_lte_set_default_attach_info(const struct ofono_lte *lt=
e,
+			const struct ofono_lte_default_attach_info *info,
+			ofono_lte_cb_t cb, void *data)
+{
+	struct gemalto_lte_driver_data *ldd =3D ofono_lte_get_data(lte);
+	struct ofono_modem *modem =3D ofono_lte_get_modem(lte);
+	struct gemalto_lte_cbd *cbd =3D gemalto_lte_cb_data_new0(cb, data,
+					ldd->chat, info, modem);
+	char *buf =3D gemalto_get_cgdcont_command(modem, 0, info->proto,
+								info->apn);
+
+	if (g_at_chat_send(ldd->chat, buf, NULL,
+					gemalto_lte_set_default_attach_info_cb,
+					cbd, gemalto_lte_cb_data_unref) > 0)
+		goto end;
+
+	gemalto_lte_cb_data_unref(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+end:
+	g_free(buf);
+}
+
+static gboolean gemalto_lte_delayed_register(gpointer user_data)
+{
+	struct ofono_lte *lte =3D user_data;
+
+	ofono_lte_register(lte);
+
+	return FALSE;
+}
+
+static int gemalto_lte_probe(struct ofono_lte *lte, unsigned int vendor,
+								void *data)
+{
+	GAtChat *chat =3D data;
+	struct gemalto_lte_driver_data *ldd;
+
+	ldd =3D g_new0(struct gemalto_lte_driver_data, 1);
+
+	ldd->chat =3D g_at_chat_clone(chat);
+
+	ofono_lte_set_data(lte, ldd);
+
+	g_idle_add(gemalto_lte_delayed_register, lte);
+
+	return 0;
+}
+
+static void gemalto_lte_remove(struct ofono_lte *lte)
+{
+	struct gemalto_lte_driver_data *ldd =3D ofono_lte_get_data(lte);
+
+	g_at_chat_unref(ldd->chat);
+
+	ofono_lte_set_data(lte, NULL);
+
+	g_free(ldd);
+}
+
+static const struct ofono_lte_driver driver =3D {
+	.name				=3D "gemaltomodem",
+	.probe				=3D gemalto_lte_probe,
+	.remove				=3D gemalto_lte_remove,
+	.set_default_attach_info	=3D gemalto_lte_set_default_attach_info,
+};
+
+void gemalto_lte_init(void)
+{
+	ofono_lte_driver_register(&driver);
+}
+
+void gemalto_lte_exit(void)
+{
+	ofono_lte_driver_unregister(&driver);
+}
-- =

2.17.1


--===============2247565242726740353==--


Content-Type: multipart/mixed; boundary="===============4723497777882488976=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH 3/5] cdma-atmodem: Add CDMA SMS Support
Date: Wed, 08 Dec 2010 16:35:49 -0800
Message-ID: <1291854951-2378-4-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4723497777882488976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                    |    7 ++
 configure.ac                   |    5 ++
 drivers/cdma-atmodem/atmodem.c |   47 ++++++++++++
 drivers/cdma-atmodem/atmodem.h |   23 ++++++
 drivers/cdma-atmodem/atutil.c  |   45 ++++++++++++
 drivers/cdma-atmodem/atutil.h  |   64 +++++++++++++++++
 drivers/cdma-atmodem/sms.c     |  151 ++++++++++++++++++++++++++++++++++++=
++++
 7 files changed, 342 insertions(+), 0 deletions(-)
 create mode 100644 drivers/cdma-atmodem/atmodem.c
 create mode 100644 drivers/cdma-atmodem/atmodem.h
 create mode 100644 drivers/cdma-atmodem/atutil.c
 create mode 100644 drivers/cdma-atmodem/atutil.h
 create mode 100644 drivers/cdma-atmodem/sms.c

diff --git a/Makefile.am b/Makefile.am
index b7dc5ee..400d4c0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -242,6 +242,13 @@ conf_DATA +=3D plugins/phonesim.conf
 endif
 endif
 =

+if CDMA_ATMODEM
+builtin_modules +=3D cdma_atmodem
+builtin_sources +=3D drivers/cdma-atmodem/atmodem.h \
+			drivers/cdma-atmodem/atmodem.c \
+			drivers/cdma-atmodem/sms.c
+endif
+
 builtin_modules +=3D g1
 builtin_sources +=3D plugins/g1.c
 =

diff --git a/configure.ac b/configure.ac
index 5c18f68..abbd8cc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -166,6 +166,11 @@ AC_ARG_ENABLE(phonesim, AC_HELP_STRING([--disable-phon=
esim],
 AM_CONDITIONAL(PHONESIM, test "${enable_phonesim}" !=3D "no" &&
 					test "${enable_atmodem}" !=3D "no")
 =

+AC_ARG_ENABLE(cdmaatmodem, AC_HELP_STRING([--disable-cdma-atmodem],
+				[disable CDMA AT modem support]),
+					[enable_cdma_atmodem=3D${enableval}])
+AM_CONDITIONAL(CDMA_ATMODEM, test "${enable_cdma_atmodem}" !=3D "no")
+
 AC_ARG_ENABLE(isimodem, AC_HELP_STRING([--disable-isimodem],
 				[disable PhoNet/ISI modem support]),
 					[enable_isimodem=3D${enableval}])
diff --git a/drivers/cdma-atmodem/atmodem.c b/drivers/cdma-atmodem/atmodem.c
new file mode 100644
index 0000000..fac9069
--- /dev/null
+++ b/drivers/cdma-atmodem/atmodem.c
@@ -0,0 +1,47 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+
+#include "atmodem.h"
+
+static int cdma_atmodem_init(void)
+{
+	cdma_at_sms_init();
+
+	return 0;
+}
+
+static void cdma_atmodem_exit(void)
+{
+	cdma_at_sms_exit();
+}
+
+OFONO_PLUGIN_DEFINE(cdma_atmodem, "CDMA AT modem driver", VERSION,
+	OFONO_PLUGIN_PRIORITY_DEFAULT, cdma_atmodem_init, cdma_atmodem_exit)
diff --git a/drivers/cdma-atmodem/atmodem.h b/drivers/cdma-atmodem/atmodem.h
new file mode 100644
index 0000000..28d3d63
--- /dev/null
+++ b/drivers/cdma-atmodem/atmodem.h
@@ -0,0 +1,23 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
+extern void cdma_at_sms_init();
+extern void cdma_at_sms_exit();
diff --git a/drivers/cdma-atmodem/atutil.c b/drivers/cdma-atmodem/atutil.c
new file mode 100644
index 0000000..f0da2d0
--- /dev/null
+++ b/drivers/cdma-atmodem/atutil.c
@@ -0,0 +1,45 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+
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
+#include <string.h>
+#include <stdlib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/log.h>
+#include <ofono/types.h>
+
+#include "atutil.h"
+
+void decode_at_error(struct ofono_error *error, const char *final)
+{
+	if (!strcmp(final, "OK")) {
+		error->type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		error->error =3D 0;
+	} else {
+		error->type =3D OFONO_ERROR_TYPE_FAILURE;
+		error->error =3D 0;
+	}
+}
diff --git a/drivers/cdma-atmodem/atutil.h b/drivers/cdma-atmodem/atutil.h
new file mode 100644
index 0000000..6b5c77a
--- /dev/null
+++ b/drivers/cdma-atmodem/atutil.h
@@ -0,0 +1,64 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
+#ifndef __AT_UTIL_H
+#define __AT_UTIL_H
+
+void decode_at_error(struct ofono_error *error, const char *final);
+
+struct cb_data {
+	void *cb;
+	void *data;
+	void *user;
+};
+
+static inline struct cb_data *cb_data_new(void *cb, void *data)
+{
+	struct cb_data *ret;
+
+	ret =3D g_try_new0(struct cb_data, 1);
+	if (ret =3D=3D NULL)
+		return ret;
+
+	ret->cb =3D cb;
+	ret->data =3D data;
+
+	return ret;
+}
+
+#define CALLBACK_WITH_FAILURE(cb, args...)		\
+	do {						\
+		struct ofono_error cb_e;		\
+		cb_e.type =3D OFONO_ERROR_TYPE_FAILURE;	\
+		cb_e.error =3D 0;				\
+							\
+		cb(&cb_e, ##args);			\
+	} while (0)					\
+
+#define CALLBACK_WITH_SUCCESS(f, args...)		\
+	do {						\
+		struct ofono_error e;			\
+		e.type =3D OFONO_ERROR_TYPE_NO_ERROR;	\
+		e.error =3D 0;				\
+		f(&e, ##args);				\
+	} while (0)					\
+
+#endif /* __AT_UTIL_H */
diff --git a/drivers/cdma-atmodem/sms.c b/drivers/cdma-atmodem/sms.c
new file mode 100644
index 0000000..ffa371c
--- /dev/null
+++ b/drivers/cdma-atmodem/sms.c
@@ -0,0 +1,151 @@
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
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/cdma-sms.h>
+#include "util.h"
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "atmodem.h"
+
+struct cdmasms_data {
+	unsigned int vendor;
+	GAtChat *chat;
+};
+
+static gboolean cdma_at_parse_pdu_common(GAtResult *result, const char *pr=
efix,
+											const char **pdu, int *pdulen)
+{
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, prefix))
+		return FALSE;
+
+	if (!strcmp(prefix, "+CMT:") && !g_at_result_iter_skip_next(&iter))
+		return FALSE;
+
+	if (!g_at_result_iter_next_number(&iter, pdulen))
+		return FALSE;
+
+	*pdu =3D g_at_result_pdu(result);
+
+	return TRUE;
+}
+
+static void cdma_at_cmt_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdmasms *cdmasms =3D user_data;
+	const char *hexpdu;
+	long pdu_len;
+	int tpdu_len;
+	unsigned char pdu[256];
+
+	if (!cdma_at_parse_pdu_common(result, "+CMT:", &hexpdu, &tpdu_len)) {
+		ofono_error("Unable to parse CMT notification");
+		return;
+	}
+
+	if (strlen(hexpdu) > sizeof(pdu) * 2) {
+		ofono_error("Bad PDU length in CMT notification");
+		return;
+	}
+
+	DBG("Got new SMS Deliver PDU via CMT: %s, %d", hexpdu, tpdu_len);
+
+	decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
+	ofono_cdmasms_deliver_notify(cdmasms, pdu, pdu_len);
+}
+
+static void cdma_at_sms_initialized(struct ofono_cdmasms *cdmasms)
+{
+	struct cdmasms_data *data =3D ofono_cdmasms_get_data(cdmasms);
+
+	g_at_chat_register(data->chat, "+CMT:", cdma_at_cmt_notify, TRUE,
+				cdmasms, NULL);
+
+	ofono_cdmasms_register(cdmasms);
+}
+
+static int cdma_at_sms_probe(struct ofono_cdmasms *cdmasms, unsigned int v=
endor,
+								void *user)
+{
+	GAtChat *chat =3D user;
+	struct cdmasms_data *data;
+
+	data =3D g_new0(struct cdmasms_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	data->chat =3D g_at_chat_clone(chat);
+	if (data->chat =3D=3D NULL)
+		return -ENOMEM;
+
+	data->vendor =3D vendor;
+
+	ofono_cdmasms_set_data(cdmasms, data);
+
+	cdma_at_sms_initialized(cdmasms);
+
+	return 0;
+}
+
+static void cdma_at_sms_remove(struct ofono_cdmasms *cdmasms)
+{
+	struct cdmasms_data *data =3D ofono_cdmasms_get_data(cdmasms);
+
+	ofono_cdmasms_set_data(cdmasms, NULL);
+
+	g_at_chat_unref(data->chat);
+	g_free(data);
+}
+
+static struct ofono_cdmasms_driver driver =3D {
+	.name		=3D "cdma-atmodem",
+	.probe		=3D cdma_at_sms_probe,
+	.remove		=3D cdma_at_sms_remove,
+};
+
+void cdma_at_sms_init()
+{
+	ofono_cdmasms_driver_register(&driver);
+}
+
+void cdma_at_sms_exit()
+{
+	ofono_cdmasms_driver_unregister(&driver);
+}
-- =

1.7.0.4


--===============4723497777882488976==--


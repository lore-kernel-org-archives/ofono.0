Content-Type: multipart/mixed; boundary="===============5549978696703972824=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH 1/2] G1: Add initial HTC G1 modem support
Date: Wed, 02 Sep 2009 19:03:00 -0400
Message-ID: <20090902190300.3dd38bf8@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5549978696703972824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is without SMS support; that'll come later.


From 32b333d82642af33a5de5867042248f271fcf1a1 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@collabora.co.uk>
Date: Tue, 25 Aug 2009 16:04:48 -0400
Subject: [PATCH 1/2] G1: Add initial HTC G1 modem support

G1 plugin is based on generic_at, with a bunch of stuff dropped
and simplified.  We use AT+CFUN=3D1 for powering on rather than having
a configurable init string.  We also manually set the default state
during init (the G1 appears to start in mode V0 by default).  The
device (/dev/smd0) is hardcoded.
---
 Makefile.am  |    3 +
 plugins/g1.c |  182 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 185 insertions(+), 0 deletions(-)
 create mode 100644 plugins/g1.c

diff --git a/Makefile.am b/Makefile.am
index 71b402b..c5103d7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -99,6 +99,9 @@ builtin_sources +=3D plugins/generic_at.c
 =

 builtin_modules +=3D mbm
 builtin_sources +=3D plugins/mbm.c
+
+builtin_modules +=3D g1
+builtin_sources +=3D plugins/g1.c
 endif
 =

 if MAINTAINER_MODE
diff --git a/plugins/g1.c b/plugins/g1.c
new file mode 100644
index 0000000..ab88e1c
--- /dev/null
+++ b/plugins/g1.c
@@ -0,0 +1,182 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2009  Collabora Ltd. All rights reserved.
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
+#include <errno.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gatsyntax.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-barring.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-meter.h>
+#include <ofono/call-settings.h>
+#include <ofono/devinfo.h>
+#include <ofono/message-waiting.h>
+#include <ofono/netreg.h>
+#include <ofono/phonebook.h>
+#include <ofono/sim.h>
+#include <ofono/sms.h>
+#include <ofono/ssn.h>
+#include <ofono/ussd.h>
+#include <ofono/voicecall.h>
+
+static void g1_debug(const char *str, void *data)
+{
+	DBG("%s", str);
+}
+
+/* Detect hardware, and initialize if found */
+static int g1_probe(struct ofono_modem *modem)
+{
+	GAtSyntax *syntax;
+	GAtChat *chat;
+
+	DBG("");
+
+	syntax =3D g_at_syntax_new_gsmv1();
+	chat =3D g_at_chat_new_from_tty("/dev/smd0", syntax);
+	g_at_syntax_unref(syntax);
+
+	if (chat =3D=3D NULL)
+		return -EIO;
+
+	if (getenv("OFONO_AT_DEBUG") !=3D NULL)
+		g_at_chat_set_debug(chat, g1_debug, NULL);
+
+	ofono_modem_set_data(modem, chat);
+
+	return 0;
+}
+
+static void g1_remove(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	ofono_modem_set_data(modem, NULL);
+	g_at_chat_unref(chat);
+}
+
+static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D user_data;
+ =

+	DBG("");
+
+	if (ok)
+		ofono_modem_set_powered(modem, TRUE);
+}
+
+/* power up hardware */
+static int g1_enable(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	/* ensure modem is in a known state; verbose on, echo/quiet off */
+	g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+
+	/* power up modem */
+	g_at_chat_send(chat, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem, NULL);
+
+	return 0;
+}
+
+static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+ =

+	DBG("");
+ =

+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static int g1_disable(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	/* power down modem */
+	g_at_chat_send(chat, "AT+CFUN=3D0", NULL, cfun_set_off_cb, modem, NULL);
+
+	return 0;
+}
+
+static void g1_populate(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+
+	DBG("");
+
+	ofono_devinfo_create(modem, 0, "atmodem", chat);
+	ofono_ussd_create(modem, 0, "atmodem", chat);
+	ofono_sim_create(modem, 0, "atmodem", chat);
+	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
+	ofono_call_settings_create(modem, 0, "atmodem", chat);
+	ofono_netreg_create(modem, 0, "atmodem", chat);
+	ofono_voicecall_create(modem, 0, "atmodem", chat);
+	ofono_call_meter_create(modem, 0, "atmodem", chat);
+	ofono_call_barring_create(modem, 0, "atmodem", chat);
+	ofono_ssn_create(modem, 0, "atmodem", chat);
+	ofono_phonebook_create(modem, 0, "atmodem", chat);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static struct ofono_modem_driver g1_driver =3D {
+	.name =3D "g1",
+	.probe =3D g1_probe,
+	.remove =3D g1_remove,
+	.enable =3D g1_enable,
+	.disable =3D g1_disable,
+	.populate =3D g1_populate,
+};
+
+static int g1_init(void)
+{
+	return ofono_modem_driver_register(&g1_driver);
+}
+
+static void g1_exit(void)
+{
+	ofono_modem_driver_unregister(&g1_driver);
+}
+
+OFONO_PLUGIN_DEFINE(g1, "HTC G1 modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			g1_init, g1_exit)
-- =

1.6.3.3


--===============5549978696703972824==--


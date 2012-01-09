Content-Type: multipart/mixed; boundary="===============3231352777634849304=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] speedupcdma: Delete unused plugin
Date: Mon, 09 Jan 2012 14:14:18 +0100
Message-ID: <1326114858-10289-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1326114660-10111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3231352777634849304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am           |    3 -
 plugins/speedupcdma.c |  247 ---------------------------------------------=
----
 2 files changed, 0 insertions(+), 250 deletions(-)
 delete mode 100644 plugins/speedupcdma.c

diff --git a/Makefile.am b/Makefile.am
index 9763d00..8addb39 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -340,9 +340,6 @@ builtin_sources +=3D plugins/alcatel.c
 builtin_modules +=3D speedup
 builtin_sources +=3D plugins/speedup.c
 =

-builtin_modules +=3D speedupcdma
-builtin_sources +=3D plugins/speedupcdma.c
-
 builtin_modules +=3D samsung
 builtin_sources +=3D plugins/samsung.c
 =

diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
deleted file mode 100644
index 8e5f324..0000000
--- a/plugins/speedupcdma.c
+++ /dev/null
@@ -1,247 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-#include <stdlib.h>
-
-#include <glib.h>
-#include <gatchat.h>
-#include <gattty.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/plugin.h>
-#include <ofono/modem.h>
-#include <ofono/devinfo.h>
-#include <ofono/cdma-netreg.h>
-#include <ofono/cdma-connman.h>
-#include <ofono/log.h>
-
-#include "drivers/atmodem/vendor.h"
-
-struct speedupcdma_data {
-	GAtChat *modem;
-	GAtChat *aux;
-};
-
-static void speedupcdma_debug(const char *str, void *data)
-{
-	const char *prefix =3D data;
-
-	ofono_info("%s%s", prefix, str);
-}
-
-static int speedupcdma_probe(struct ofono_modem *modem)
-{
-	struct speedupcdma_data *data;
-
-	DBG("%p", modem);
-
-	data =3D g_try_new0(struct speedupcdma_data, 1);
-	if (data =3D=3D NULL)
-		return -ENOMEM;
-
-	ofono_modem_set_data(modem, data);
-
-	return 0;
-}
-
-static void speedupcdma_remove(struct ofono_modem *modem)
-{
-	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	ofono_modem_set_data(modem, NULL);
-
-	/* Cleanup after hot-unplug */
-	g_at_chat_unref(data->aux);
-
-	g_free(data);
-}
-
-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("");
-
-	if (!ok) {
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
-
-		g_at_chat_unref(data->aux);
-		data->aux =3D NULL;
-	}
-
-	ofono_modem_set_powered(modem, ok);
-}
-
-static GAtChat *open_device(struct ofono_modem *modem,
-				const char *key, char *debug)
-{
-	const char *device;
-	GIOChannel *channel;
-	GAtSyntax *syntax;
-	GAtChat *chat;
-
-	device =3D ofono_modem_get_string(modem, key);
-	if (device =3D=3D NULL)
-		return NULL;
-
-	DBG("%s %s", key, device);
-
-	channel =3D g_at_tty_open(device, NULL);
-	if (channel =3D=3D NULL)
-		return NULL;
-
-	syntax =3D g_at_syntax_new_gsm_permissive();
-	chat =3D g_at_chat_new(channel, syntax);
-	g_at_syntax_unref(syntax);
-
-	g_io_channel_unref(channel);
-
-	if (chat =3D=3D NULL)
-		return NULL;
-
-	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(chat, speedupcdma_debug, debug);
-
-	return chat;
-}
-
-static int speedupcdma_enable(struct ofono_modem *modem)
-{
-	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("");
-
-	data->modem =3D open_device(modem, "Modem", "Modem: ");
-	if (data->modem =3D=3D NULL)
-		return -EINVAL;
-
-	data->aux =3D open_device(modem, "Aux", "Aux: ");
-	if (data->aux =3D=3D NULL) {
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
-		return -EIO;
-	}
-
-	g_at_chat_set_slave(data->modem, data->aux);
-
-	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
-
-	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL,
-					cfun_enable, modem, NULL);
-
-	return -EINPROGRESS;
-}
-
-static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("");
-
-	g_at_chat_unref(data->aux);
-	data->aux =3D NULL;
-
-	if (ok)
-		ofono_modem_set_powered(modem, FALSE);
-}
-
-static int speedupcdma_disable(struct ofono_modem *modem)
-{
-	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	g_at_chat_cancel_all(data->modem);
-	g_at_chat_unregister_all(data->modem);
-
-	g_at_chat_unref(data->modem);
-	data->modem =3D NULL;
-
-	g_at_chat_cancel_all(data->aux);
-	g_at_chat_unregister_all(data->aux);
-
-	g_at_chat_send(data->aux, "AT+CFUN=3D0", NULL,
-					cfun_disable, modem, NULL);
-
-	return -EINPROGRESS;
-}
-
-static void speedupcdma_pre_sim(struct ofono_modem *modem)
-{
-	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	ofono_devinfo_create(modem, 0, "cdmamodem", data->aux);
-}
-
-static void speedupcdma_post_sim(struct ofono_modem *modem)
-{
-	DBG("%p", modem);
-}
-
-static void speedupcdma_post_online(struct ofono_modem *modem)
-{
-	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	ofono_cdma_netreg_create(modem, 0, "huaweicdmamodem", data->aux);
-
-	ofono_cdma_connman_create(modem, OFONO_VENDOR_HUAWEI, "cdmamodem",
-					data->modem);
-}
-
-static struct ofono_modem_driver speedupcdma_driver =3D {
-	.name		=3D "speedupcdma",
-	.probe		=3D speedupcdma_probe,
-	.remove		=3D speedupcdma_remove,
-	.enable		=3D speedupcdma_enable,
-	.disable	=3D speedupcdma_disable,
-	.pre_sim	=3D speedupcdma_pre_sim,
-	.post_sim	=3D speedupcdma_post_sim,
-	.post_online	=3D speedupcdma_post_online,
-};
-
-static int speedupcdma_init(void)
-{
-	return ofono_modem_driver_register(&speedupcdma_driver);
-}
-
-static void speedupcdma_exit(void)
-{
-	ofono_modem_driver_unregister(&speedupcdma_driver);
-}
-
-OFONO_PLUGIN_DEFINE(speedupcdma, "Speed Up CDMA modem driver", VERSION,
-				OFONO_PLUGIN_PRIORITY_DEFAULT,
-				speedupcdma_init, speedupcdma_exit)
-- =

1.7.1


--===============3231352777634849304==--


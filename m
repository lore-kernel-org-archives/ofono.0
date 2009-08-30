Content-Type: multipart/mixed; boundary="===============5082030120134637107=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH 1/3] G1: Add initial HTC G1 modem support
Date: Sun, 30 Aug 2009 00:06:56 -0400
Message-ID: <20090830040656.GA28039@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5082030120134637107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series adds support for the HTC G1 phone (that is, the Google
phone).

G1 plugin is based on generic_at, with a bunch of stuff dropped
and simplified.  We use AT+CFUN=3D1 for powering on rather than having
a configurable init string.  We also manually set the default state
during init (the G1 appears to start in mode V0 by default).  The
device (/dev/smd0) is hardcoded.
---
 Makefile.am  |    5 +
 configure.ac |    8 ++-
 plugins/g1.c |  309 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 321 insertions(+), 1 deletions(-)
 create mode 100644 plugins/g1.c

diff --git a/Makefile.am b/Makefile.am
index 7ee6536..a2d3569 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -78,6 +78,11 @@ builtin_modules +=3D generic_at
 builtin_sources +=3D plugins/generic_at.c
 endif
 =

+if G1MODEM
+builtin_modules +=3D g1
+builtin_sources +=3D plugins/g1.c
+endif
+
 if MAINTAINER_MODE
 builtin_modules +=3D example_history
 builtin_sources +=3D plugins/example_history.c
diff --git a/configure.ac b/configure.ac
index a299a13..5deabb8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -65,10 +65,16 @@ AC_ARG_ENABLE(isimodem, AC_HELP_STRING([--disable-isimo=
dem],
 					[enable_isimodem=3D${enableval}])
 AM_CONDITIONAL(ISIMODEM, test "${enable_isimodem}" !=3D "no")
 =

+AC_ARG_ENABLE(g1, AC_HELP_STRING([--disable-g1],
+				[disable HTC G1 modem support]),
+					[enable_g1=3D${enableval}])
+AM_CONDITIONAL(G1MODEM, test "${enable_g1}" !=3D "no")
+
 AC_ARG_ENABLE(atmodem, AC_HELP_STRING([--disable-atmodem],
                                 [disable ETSI AT modem support]),
                                         [enable_atmodem=3D${enableval}])
-AM_CONDITIONAL(ATMODEM, test "${enable_atmodem}" !=3D "no")
+AM_CONDITIONAL(ATMODEM, [test "${enable_atmodem}" !=3D "no" ||
+			test "${enable_g1}" !=3D "no"])
 =

 AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
 			AC_MSG_ERROR(dynamic linking loader is required))
diff --git a/plugins/g1.c b/plugins/g1.c
new file mode 100644
index 0000000..70e4914
--- /dev/null
+++ b/plugins/g1.c
@@ -0,0 +1,309 @@
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
+#include <string.h>
+#include <sys/socket.h>
+#include <termios.h>
+#include <fcntl.h>
+#include <unistd.h>
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
+#define MODEM_DEVICE "/dev/smd0"
+
+static struct ofono_modem *g1_modem =3D NULL;
+
+struct g1_data {
+	GAtChat *chat;
+	GIOChannel *io;
+};
+
+static void connect_destroy(gpointer user)
+{
+	struct ofono_modem *modem =3D user;
+	struct g1_data *d =3D ofono_modem_get_data(modem);
+
+	d->io =3D NULL;
+}
+
+static void g1_debug(const char *str, void *data)
+{
+	DBG("%s", str);
+}
+
+static gboolean connect_cb(GIOChannel *io, GIOCondition cond, gpointer use=
r)
+{
+	struct ofono_modem *modem =3D user;
+	struct g1_data *d =3D ofono_modem_get_data(modem);
+	int err =3D 0;
+	gboolean success;
+	GAtSyntax *syntax;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	if (cond & G_IO_OUT) {
+		int sock =3D g_io_channel_unix_get_fd(io);
+		socklen_t len =3D sizeof(err);
+
+		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len) < 0)
+			err =3D errno =3D=3D ENOTSOCK ? 0 : errno;
+	} else if (cond & (G_IO_HUP | G_IO_ERR))
+		err =3D ECONNRESET;
+
+	success =3D !err;
+
+	DBG("io ref: %d", io->ref_count);
+
+	if (success =3D=3D FALSE)
+		goto error;
+
+	syntax =3D g_at_syntax_new_gsmv1();
+	d->chat =3D g_at_chat_new(io, syntax);
+	g_at_syntax_unref(syntax);
+
+	DBG("io ref: %d", io->ref_count);
+
+	if (!d->chat)
+		goto error;
+
+	if (getenv("OFONO_AT_DEBUG") !=3D NULL)
+		g_at_chat_set_debug(d->chat, g1_debug, NULL);
+
+	/* ensure modem is in a known state; verbose on, echo/quiet off */
+	g_at_chat_send(d->chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+
+	/* power up modem */
+	g_at_chat_send(d->chat, "AT+CFUN=3D1", NULL, NULL, NULL, NULL);
+
+	ofono_modem_set_powered(modem, TRUE);
+
+	return FALSE;
+
+error:
+	ofono_modem_set_powered(modem, FALSE);
+	return FALSE;
+}
+
+static GIOChannel *tty_connect(const char *tty)
+{
+	GIOChannel *io;
+	int sk;
+	struct termios newtio;
+
+	sk =3D open(tty, O_RDWR | O_NOCTTY);
+
+	if (sk < 0) {
+		ofono_error("Can't open TTY %s: %s(%d)",
+				tty, strerror(errno), errno);
+		return NULL;
+	}
+
+	newtio.c_cflag =3D B115200 | CRTSCTS | CLOCAL | CREAD;
+	newtio.c_iflag =3D IGNPAR;
+	newtio.c_oflag =3D 0;
+	newtio.c_lflag =3D 0;
+
+	newtio.c_cc[VTIME] =3D 1;
+	newtio.c_cc[VMIN] =3D 5;
+
+	tcflush(sk, TCIFLUSH);
+	if (tcsetattr(sk, TCSANOW, &newtio) < 0) {
+		ofono_error("Can't change serial settings: %s(%d)",
+				strerror(errno), errno);
+		close(sk);
+		return NULL;
+	}
+
+	io =3D g_io_channel_unix_new(sk);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	if (g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK,
+					NULL) !=3D G_IO_STATUS_NORMAL) {
+		g_io_channel_unref(io);
+		return NULL;
+	}
+
+	return io;
+}
+
+static int g1_probe(struct ofono_modem *modem)
+{
+	struct g1_data *d;
+
+	d =3D g_new0(struct g1_data, 1);
+	if (!d)
+		return -ENOMEM;
+	ofono_modem_set_data(modem, d);
+
+	return 0;
+}
+
+static int g1_remove(struct ofono_modem *modem)
+{
+	g_free(ofono_modem_get_data(modem));
+
+	return 0;
+}
+
+static int g1_enable(struct ofono_modem *modem)
+{
+	struct g1_data *d =3D ofono_modem_get_data(modem);
+	GIOChannel *io;
+	GIOCondition cond;
+
+	DBG("");
+
+	io =3D tty_connect(MODEM_DEVICE);
+	if (io =3D=3D NULL)
+		return -EINVAL;
+
+	DBG("io ref: %d", io->ref_count);
+
+	cond =3D G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, connect_cb,
+				modem, connect_destroy);
+
+	DBG("io ref: %d", io->ref_count);
+
+	g_io_channel_unref(io);
+
+	DBG("io ref: %d", io->ref_count);
+	d->io =3D io;
+
+	return -EINPROGRESS;
+}
+
+static int g1_disable(struct ofono_modem *modem)
+{
+	struct g1_data *d =3D ofono_modem_get_data(modem);
+
+	if (d->io) {
+		g_io_channel_close(d->io);
+		d->io =3D NULL;
+	}
+
+	if (d->chat) {
+		g_at_chat_unref(d->chat);
+		d->chat =3D NULL;
+	}
+
+	return 0;
+}
+
+static int g1_populate(struct ofono_modem *modem)
+{
+	struct g1_data *d =3D ofono_modem_get_data(modem);
+	GAtChat *chat =3D d->chat;
+	struct ofono_message_waiting *mw;
+
+	ofono_devinfo_create(modem, "generic_at", chat);
+	ofono_ussd_create(modem, "generic_at", chat);
+	ofono_sim_create(modem, "generic_at", chat);
+	ofono_call_forwarding_create(modem, "generic_at", chat);
+	ofono_call_settings_create(modem, "generic_at", chat);
+	ofono_netreg_create(modem, "generic_at", chat);
+	ofono_voicecall_create(modem, "generic_at", chat);
+	ofono_call_meter_create(modem, "generic_at", chat);
+	ofono_call_barring_create(modem, "generic_at", chat);
+	ofono_ssn_create(modem, "generic_at", chat);
+	ofono_sms_create(modem, "generic_at", chat);
+	ofono_phonebook_create(modem, "generic_at", chat);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+
+	return 0;
+}
+
+static struct ofono_modem_driver g1_driver =3D {
+	.name =3D "HTC G1",
+	.probe =3D g1_probe,
+	.remove =3D g1_remove,
+	.enable =3D g1_enable,
+	.disable =3D g1_disable,
+	.populate =3D g1_populate,
+};
+
+static int g1_init(void)
+{
+	int err;
+
+	err =3D ofono_modem_driver_register(&g1_driver);
+	if (err)
+		goto done;
+
+	g1_modem =3D ofono_modem_create("G1", "HTC G1");
+	if (!g1_modem) {
+		err =3D -EIO;
+		goto unreg;
+	}
+
+	err =3D ofono_modem_register(g1_modem);
+	if (err)
+		goto remove;
+
+	return 0;
+
+remove:
+	ofono_modem_remove(g1_modem);
+unreg:
+	ofono_modem_driver_unregister(&g1_driver);
+done:
+	return err;
+}
+
+static void g1_exit(void)
+{
+	ofono_modem_remove(g1_modem);
+	ofono_modem_driver_unregister(&g1_driver);
+}
+
+OFONO_PLUGIN_DEFINE(g1, "HTC G1 modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			g1_init, g1_exit)
-- =

1.6.3.3

--===============5082030120134637107==--


Content-Type: multipart/mixed; boundary="===============6655461567561285081=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Create cdmadial tool to work on CDMA data call support.
Date: Thu, 21 Jul 2011 04:38:29 +0200
Message-ID: <1311215909-11206-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6655461567561285081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am        |    6 +-
 gatchat/cdmadial.c |  520 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 525 insertions(+), 1 deletions(-)
 create mode 100644 gatchat/cdmadial.c

diff --git a/Makefile.am b/Makefile.am
index a4e6c95..bb712cb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -616,11 +616,15 @@ tools_lookup_apn_SOURCES =3D tools/lookup-apn.c
 tools_lookup_apn_LDADD =3D @GLIB_LIBS@
 endif
 =

-noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
+noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/cdmadial /
+			gatchat/test-server gatchat/test-qcdm
 =

 gatchat_gsmdial_SOURCES =3D gatchat/gsmdial.c $(gatchat_sources)
 gatchat_gsmdial_LDADD =3D @GLIB_LIBS@
 =

+gatchat_cdmadial_SOURCES =3D gatchat/cdmadial.c $(gatchat_sources)
+gatchat_cdmadial_LDADD =3D @GLIB_LIBS@
+
 gatchat_test_server_SOURCES =3D gatchat/test-server.c $(gatchat_sources)
 gatchat_test_server_LDADD =3D @GLIB_LIBS@ -lutil
 =

diff --git a/gatchat/cdmadial.c b/gatchat/cdmadial.c
new file mode 100644
index 0000000..f3f9686
--- /dev/null
+++ b/gatchat/cdmadial.c
@@ -0,0 +1,520 @@
+/*
+ *
+ *  AT chat library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/signalfd.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+#include <gatppp.h>
+
+#define IFCONFIG_PATH "/sbin/ifconfig"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
+
+static gchar *option_ip =3D NULL;
+static gint option_port =3D 0;
+static gchar *option_modem =3D NULL;
+static gchar *option_control =3D NULL;
+static gint option_cid =3D 0;
+static gchar *option_apn =3D NULL;
+static gint option_offmode =3D 0;
+static gchar *option_username =3D NULL;
+static gchar *option_password =3D NULL;
+static gchar *option_pppdump =3D NULL;
+static gboolean option_acfc =3D FALSE;
+static gboolean option_pfc =3D FALSE;
+
+static GAtPPP *ppp;
+static GAtChat *control;
+static GAtChat *modem;
+static GMainLoop *event_loop;
+
+
+static int oldmode =3D 0;
+
+static void cdmadial_debug(const char *str, void *data)
+{
+	g_print("%s: %s\n", (const char *) data, str);
+}
+
+static gboolean quit_eventloop(gpointer user_data)
+{
+	g_main_loop_quit(event_loop);
+	return FALSE;
+}
+
+static void power_down(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	g_main_loop_quit(event_loop);
+}
+
+static void kill_ppp(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	g_print("kill_ppp: %d\n", ok);
+
+	if (ok =3D=3D FALSE)
+		return;
+
+	g_at_ppp_unref(ppp);
+	ppp =3D NULL;
+}
+
+static void ppp_suspend_ath0(gpointer user_data)
+{
+	g_at_chat_resume(modem);
+	g_at_chat_send(modem, "ATH0", none_prefix, kill_ppp, NULL, NULL);
+}
+
+static void resume_ppp(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	g_print("resume_ppp: %d\n", ok);
+
+	if (ok =3D=3D FALSE)
+		return;
+
+	g_at_chat_suspend(modem);
+	g_at_ppp_resume(ppp);
+}
+
+static void ppp_suspend_ato0(gpointer user_data)
+{
+	g_at_chat_resume(modem);
+	g_at_chat_send(modem, "ATO0", none_prefix, resume_ppp, NULL, NULL);
+}
+
+static gboolean signal_cb(GIOChannel *channel, GIOCondition cond, gpointer=
 data)
+{
+	static int terminated =3D 0;
+	int signal_fd =3D GPOINTER_TO_INT(data);
+	struct signalfd_siginfo si;
+	ssize_t res;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR))
+		return FALSE;
+
+	res =3D read(signal_fd, &si, sizeof(si));
+	if (res !=3D sizeof(si))
+		return FALSE;
+
+	switch (si.ssi_signo) {
+	case SIGINT:
+	case SIGTERM:
+		if (terminated =3D=3D 0) {
+			g_timeout_add_seconds(10, quit_eventloop, NULL);
+
+			if (ppp =3D=3D NULL) {
+				char buf[64];
+				sprintf(buf, "AT+CFUN=3D%u", option_offmode);
+				g_at_chat_send(control, buf, none_prefix,
+						power_down, NULL, NULL);
+			} else
+				g_at_ppp_shutdown(ppp);
+		}
+
+		terminated++;
+		break;
+	case SIGUSR1:
+		if (ppp =3D=3D NULL)
+			break;
+
+		g_at_ppp_set_suspend_function(ppp, ppp_suspend_ato0, NULL);
+		g_at_ppp_suspend(ppp);
+		break;
+	case SIGUSR2:
+		if (ppp =3D=3D NULL)
+			break;
+
+		g_at_ppp_set_suspend_function(ppp, ppp_suspend_ath0, NULL);
+		g_at_ppp_suspend(ppp);
+		break;
+	default:
+		break;
+	}
+
+	return TRUE;
+}
+
+static gboolean execute(const char *cmd)
+{
+	int status;
+
+	status =3D system(cmd);
+	if (status < 0) {
+		g_print("Failed to execute command: %s\n", strerror(errno));
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void ppp_connect(const char *iface, const char *local, const char *=
peer,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
+{
+	char buf[512];
+
+	/* print out the negotiated address and dns server */
+	g_print("Network Device: %s\n", iface);
+	g_print("IP Address: %s\n", local);
+	g_print("Peer IP Address: %s\n", peer);
+	g_print("Primary DNS Server: %s\n", dns1);
+	g_print("Secondary DNS Server: %s\n", dns2);
+
+	if (getuid() !=3D 0) {
+		g_print("Need root privilege to config PPP interface\n");
+		return;
+	}
+
+	snprintf(buf, sizeof(buf), "%s %s up", IFCONFIG_PATH, iface);
+	execute(buf);
+
+	snprintf(buf, sizeof(buf), "%s %s %s pointopoint %s", IFCONFIG_PATH,
+				iface, local, peer);
+	execute(buf);
+}
+
+static void no_carrier_notify(GAtResult *result, gpointer user_data)
+{
+	char buf[64];
+
+	sprintf(buf, "AT+CFUN=3D%u", option_offmode);
+	g_at_chat_send(control, buf, none_prefix, power_down, NULL, NULL);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	g_print("PPP Link down: %d\n", reason);
+
+	g_at_ppp_unref(ppp);
+	ppp =3D NULL;
+
+	if (option_modem =3D=3D NULL)
+		g_at_chat_set_debug(modem, cdmadial_debug, "");
+	else
+		g_at_chat_set_debug(modem, cdmadial_debug, "Modem");
+
+	g_at_chat_register(modem, "NO CARRIER", no_carrier_notify,
+					FALSE, NULL, NULL);
+	g_at_chat_resume(modem);
+}
+
+static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	GAtIO *io;
+
+	if (!ok) {
+		g_print("Unable to start the data call\n");
+		exit(1);
+	}
+
+	/* get the data IO channel */
+	io =3D g_at_chat_get_io(modem);
+
+	/*
+	 * shutdown gatchat or else it tries to take all the input
+	 * from the modem and does not let PPP get it.
+	 */
+	g_at_chat_suspend(modem);
+
+	/* open ppp */
+	ppp =3D g_at_ppp_new();
+	if (ppp =3D=3D NULL) {
+		g_print("Unable to create PPP object\n");
+		exit(1);
+	}
+	g_at_ppp_set_debug(ppp, cdmadial_debug, "PPP");
+
+	if (option_pppdump)
+		g_at_ppp_set_recording(ppp, option_pppdump);
+
+	g_at_ppp_set_credentials(ppp, option_username, option_password);
+
+	g_at_ppp_set_acfc_enabled(ppp, option_acfc);
+	g_at_ppp_set_pfc_enabled(ppp, option_pfc);
+
+	/* set connect and disconnect callbacks */
+	g_at_ppp_set_connect_function(ppp, ppp_connect, NULL);
+	g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
+
+	/* open the ppp connection */
+	g_at_ppp_open(ppp, io);
+}
+
+static void start_dial(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	if (!ok) {
+		g_print("Turning on the modem failed\n");
+		exit(1);
+	}
+
+	g_at_chat_send(modem, "ATD#777", none_prefix, connect_cb, NULL, NULL);
+}
+
+static void check_mode(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	GAtResultIter iter;
+
+	if (!ok) {
+		g_print("Checking modem mode failed\n");
+		exit(1);
+	}
+
+	g_at_result_iter_init(&iter, result);
+	g_at_result_iter_next(&iter, "+CFUN:");
+	g_at_result_iter_next_number(&iter, &oldmode);
+
+	g_print("Current modem mode is %d\n", oldmode);
+
+	if (oldmode =3D=3D 1) {
+		start_dial(ok, result, user_data);
+		return;
+	}
+
+	g_at_chat_send(control, "AT+CFUN=3D1", NULL, start_dial, NULL, NULL);
+}
+
+static int open_serial(void)
+{
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+
+	channel =3D g_at_tty_open(option_control, NULL);
+	if (channel =3D=3D NULL)
+		return -EIO;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	control =3D g_at_chat_new(channel, syntax);
+	g_io_channel_unref(channel);
+	g_at_syntax_unref(syntax);
+
+	if (control =3D=3D NULL)
+		return -EIO;
+
+	if (option_modem =3D=3D NULL) {
+		g_at_chat_ref(control);
+		modem =3D control;
+		g_at_chat_set_debug(control, cdmadial_debug, "");
+	} else {
+		g_at_chat_set_debug(control, cdmadial_debug, "Control");
+
+		channel =3D g_at_tty_open(option_modem, NULL);
+		if (channel =3D=3D NULL)
+			return -EIO;
+
+		syntax =3D g_at_syntax_new_gsm_permissive();
+		modem =3D g_at_chat_new(channel, syntax);
+		g_io_channel_unref(channel);
+		g_at_syntax_unref(syntax);
+
+		if (modem =3D=3D NULL)
+			return -EIO;
+
+		g_at_chat_set_debug(modem, cdmadial_debug, "Modem");
+	}
+
+	return 0;
+}
+
+static int open_ip(void)
+{
+	int sk, err;
+	struct sockaddr_in addr;
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+
+	sk =3D socket(PF_INET, SOCK_STREAM, 0);
+	if (sk < 0)
+		return -EINVAL;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family =3D AF_INET;
+	addr.sin_addr.s_addr =3D inet_addr(option_ip);
+	addr.sin_port =3D htons(option_port);
+
+	err =3D connect(sk, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0) {
+		close(sk);
+		return err;
+	}
+
+	channel =3D g_io_channel_unix_new(sk);
+	if (channel =3D=3D NULL) {
+		close(sk);
+		return -ENOMEM;
+	}
+
+	syntax =3D g_at_syntax_new_gsmv1();
+	control =3D g_at_chat_new(channel, syntax);
+	g_io_channel_unref(channel);
+	g_at_syntax_unref(syntax);
+
+	if (control =3D=3D NULL)
+		return -ENOMEM;
+
+	g_at_chat_ref(control);
+	modem =3D control;
+	g_at_chat_set_debug(control, cdmadial_debug, "");
+
+	return 0;
+}
+
+static GOptionEntry options[] =3D {
+	{ "ip", 'i', 0, G_OPTION_ARG_STRING, &option_ip,
+				"Specify IP" },
+	{ "port", 'p', 0, G_OPTION_ARG_INT, &option_port,
+				"Specify IP Port" },
+	{ "control", 'n', 0, G_OPTION_ARG_FILENAME, &option_control,
+				"Specify Modem Control port" },
+	{ "modem", 'm', 0, G_OPTION_ARG_FILENAME, &option_modem,
+				"Specify Modem port (ppp), if not provided"
+				" the control port will be used" },
+	{ "cid", 'c', 0, G_OPTION_ARG_INT, &option_cid,
+				"Specify CID to use" },
+	{ "apn", 'a', 0, G_OPTION_ARG_STRING, &option_apn,
+				"Specify APN" },
+	{ "offmode", 'o', 0, G_OPTION_ARG_INT, &option_offmode,
+				"Specify CFUN offmode" },
+	{ "username", 'u', 0, G_OPTION_ARG_STRING, &option_username,
+				"Specify PPP username" },
+	{ "password", 'w', 0, G_OPTION_ARG_STRING, &option_password,
+				"Specify PPP password" },
+	{ "pppdump", 'D', 0, G_OPTION_ARG_STRING, &option_pppdump,
+				"Specify pppdump filename" },
+	{ "pfc", 0, 0, G_OPTION_ARG_NONE, &option_pfc,
+				"Use Protocol Field Compression" },
+	{ "acfc", 0, 0, G_OPTION_ARG_NONE, &option_acfc,
+				"Use Address & Control Field Compression" },
+	{ NULL },
+};
+
+int main(int argc, char **argv)
+{
+	GOptionContext *context;
+	GError *err =3D NULL;
+	sigset_t mask;
+	int signal_fd;
+	GIOChannel *signal_io;
+	int signal_source;
+
+	context =3D g_option_context_new(NULL);
+	g_option_context_add_main_entries(context, options, NULL);
+
+	if (g_option_context_parse(context, &argc, &argv, &err) =3D=3D FALSE) {
+		if (err !=3D NULL) {
+			g_printerr("%s\n", err->message);
+			g_error_free(err);
+			return 1;
+		}
+
+		g_printerr("An unknown error occurred\n");
+		return 1;
+	}
+
+	g_option_context_free(context);
+
+	if (option_control) {
+		int ret;
+
+		g_print("Control: %s\n", option_control);
+		if (option_modem)
+			g_print("Modem: %s\n", option_modem);
+
+		ret =3D open_serial();
+		g_free(option_control);
+		g_free(option_modem);
+
+		if (ret < 0)
+			goto out;
+	} else {
+		int ret;
+
+		g_print("IP: %s\n", option_ip);
+		g_print("Port: %d\n", option_port);
+		ret =3D open_ip();
+		g_free(option_ip);
+
+		if (ret < 0)
+			goto out;
+	}
+
+	g_print("APN: %s\n", option_apn);
+	g_print("CID: %d\n", option_cid);
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGTERM);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGUSR1);
+	sigaddset(&mask, SIGUSR2);
+	sigaddset(&mask, SIGPIPE);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
+		perror("Can't set signal mask");
+		return 1;
+	}
+
+	signal_fd =3D signalfd(-1, &mask, 0);
+	if (signal_fd < 0) {
+		perror("Can't create signal filedescriptor");
+		return 1;
+	}
+
+	signal_io =3D g_io_channel_unix_new(signal_fd);
+	g_io_channel_set_close_on_unref(signal_io, TRUE);
+	signal_source =3D g_io_add_watch(signal_io,
+			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			signal_cb, GINT_TO_POINTER(signal_fd));
+	g_io_channel_unref(signal_io);
+
+	event_loop =3D g_main_loop_new(NULL, FALSE);
+
+	g_at_chat_send(control, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(control, "AT+CFUN?", cfun_prefix,
+							check_mode, NULL, NULL);
+
+	g_main_loop_run(event_loop);
+	g_source_remove(signal_source);
+	g_main_loop_unref(event_loop);
+
+out:
+	if (ppp =3D=3D NULL) {
+		g_at_chat_unref(control);
+		g_at_chat_unref(modem);
+	} else
+		g_at_ppp_unref(ppp);
+
+	g_free(option_apn);
+
+	return 0;
+}
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============6655461567561285081==--


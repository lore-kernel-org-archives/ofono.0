Content-Type: multipart/mixed; boundary="===============6534999676065632508=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [patch 6/6] Allow gsmdial to use gatchat ppp support
Date: Tue, 16 Mar 2010 17:13:30 -0700
Message-ID: <20100316171330.5fea7878@kcaccard-MOBL3>
In-Reply-To: <20100317000824.420232401@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6534999676065632508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add option to use PPP to gsmdial.

---
 gatchat/gsmdial.c |   82 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++--
 1 file changed, 79 insertions(+), 3 deletions(-)

Index: ofono/gatchat/gsmdial.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gsmdial.c	2010-03-16 15:38:24.125469608 -0700
+++ ofono/gatchat/gsmdial.c	2010-03-16 17:02:49.664594529 -0700
@@ -29,10 +29,13 @@
 #include <errno.h>
 #include <unistd.h>
 #include <sys/signalfd.h>
+#include <arpa/inet.h>
+#include <net/if.h>
 =

 #include <glib.h>
 #include <gatchat.h>
 #include <gattty.h>
+#include <gatppp.h>
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
@@ -45,10 +48,14 @@
 static gchar *option_apn =3D NULL;
 static gint option_offmode =3D 0;
 static gboolean option_legacy =3D FALSE;
+static gboolean option_ppp =3D FALSE;
+static gchar *option_username =3D NULL;
+static gchar *option_password =3D NULL;
 =

 static GAtChat *control;
 static GAtChat *modem;
 static GMainLoop *event_loop;
+static GAtPPP *ppp;
 =

 enum state {
 	STATE_NONE =3D 0,
@@ -220,6 +227,69 @@
 	g_at_chat_send(modem, buf, none_prefix, NULL, NULL, NULL);
 }
 =

+static void print_ip_address(guint32 ip_addr)
+{
+	struct in_addr addr;
+	addr.s_addr =3D ip_addr;
+	g_print("%s\n", inet_ntoa(addr));
+}
+
+static void ppp_connect(GAtPPP *ppp, GAtPPPConnectStatus success,
+			guint32 ip_addr, guint32 dns1, guint32 dns2,
+			gpointer user_data)
+{
+	if (success !=3D G_AT_PPP_CONNECT_SUCCESS) {
+		g_print("Failed to create PPP interface!\n");
+		return;
+	}
+	/* print out the negotiated address and dns server */
+	g_print("Negotiated IP Address: ");
+	print_ip_address(ip_addr);
+
+	g_print("Primary DNS Server: ");
+	print_ip_address(dns1);
+
+	g_print("Secondary DNS Server: ");
+	print_ip_address(dns2);
+}
+
+static void ppp_disconnect(GAtPPP *ppp, gpointer user_data)
+{
+	g_print("PPP Link down\n");
+}
+
+static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	GIOChannel *channel;
+
+	if (!ok) {
+		g_print("Unable to define context\n");
+		exit(1);
+	}
+
+	if (option_ppp =3D=3D FALSE)
+		return;
+
+	/* get the data IO channel */
+	channel =3D g_at_chat_get_channel(modem);
+
+	/* open ppp */
+	ppp =3D g_at_ppp_new(channel);
+	if (!ppp) {
+		g_print("Unable to obtain PPP object\n");
+		return;
+	}
+	g_at_ppp_set_credentials(ppp, option_username,
+				option_password);
+
+	/* set connect and disconnect callbacks */
+	g_at_ppp_set_connect_function(ppp, ppp_connect, NULL);
+	g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
+
+	/* open the ppp connection */
+	g_at_ppp_open(ppp);
+}
+
 static void at_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
 	char buf[64];
@@ -230,9 +300,9 @@
 	}
 =

 	if (option_legacy =3D=3D TRUE) {
-			sprintf(buf, "ATD*99***%u#", option_cid);
-			g_at_chat_send(modem, buf, none_prefix,
-					NULL, NULL, NULL);
+		sprintf(buf, "ATD*99***%u#", option_cid);
+		g_at_chat_send(modem, buf, none_prefix,
+				connect_cb, NULL, NULL);
 	} else {
 		sprintf(buf, "AT+CGACT=3D1,%u", option_cid);
 		g_at_chat_send(control, buf, none_prefix,
@@ -406,6 +476,12 @@
 				"Specify CFUN offmode" },
 	{ "legacy", 'l', 0, G_OPTION_ARG_NONE, &option_legacy,
 				"Use ATD*99***<cid>#" },
+	{ "ppp", 'P', 0, G_OPTION_ARG_NONE, &option_ppp,
+				"Connect using PPP" },
+	{ "username", 'u', 0, G_OPTION_ARG_STRING, &option_username,
+				"Specify PPP username" },
+	{ "password", 'w', 0, G_OPTION_ARG_STRING, &option_password,
+				"Specifiy PPP password" },
 	{ NULL },
 };
 =



--===============6534999676065632508==--


Content-Type: multipart/mixed; boundary="===============2848908112413030504=="
MIME-Version: 1.0
From: kristen@linux.intel.com
Subject: [patch 6/6] Allow gsmdial to use gatchat ppp support
Date: Thu, 11 Mar 2010 14:00:50 -0800
Message-ID: <20100311140050.41e3e763@kcaccard-MOBL3>
In-Reply-To: <20100311214022.838696145@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2848908112413030504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add option to use PPP to gsmdial.

Index: ofono/gatchat/gsmdial.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gsmdial.c	2010-03-10 16:58:09.773080389 -0800
+++ ofono/gatchat/gsmdial.c	2010-03-10 17:06:45.071975512 -0800
@@ -33,6 +33,9 @@
 #include <glib.h>
 #include <gatchat.h>
 #include <gattty.h>
+#include <arpa/inet.h>
+#include <net/if.h>
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
+static gchar *option_passwd =3D NULL;
 =

 static GAtChat *control;
 static GAtChat *modem;
 static GMainLoop *event_loop;
+static struct ppp_link *ppp;
 =

 enum state {
 	STATE_NONE =3D 0,
@@ -220,6 +227,70 @@
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
+static void ppp_connect(struct ppp_link *link, gint success, guint32 ip_ad=
dr,
+		 guint32 dns1, guint32 dns2, gpointer user_data)
+{
+	if (success =3D=3D PPP_CONNECT_SUCCESS) {
+		/* print out the negotiated address and dns server */
+		g_print("Negotiated IP Address: ");
+		print_ip_address(ip_addr);
+
+		g_print("Primary DNS Server: ");
+		print_ip_address(dns1);
+
+		g_print("Secondary DNS Server: ");
+		print_ip_address(dns2);
+	} else {
+		g_print("Failed to create PPP interface!\n");
+	}
+}
+
+static void ppp_disconnect(struct ppp_link *link, gpointer user_data)
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
+	/* get the data IO channel */
+	channel =3D g_at_chat_get_channel(modem);
+	channel =3D g_io_channel_ref(channel);
+
+	/* shutdown gatchat */
+	g_at_chat_unref(control);
+	g_at_chat_unref(modem);
+
+	/* open ppp */
+	ppp =3D g_at_ppp_new(channel);
+	if (ppp) {
+		g_print("Setting PPP Credentials to %s, %s\n", option_username,
+				option_passwd);
+		g_at_ppp_set_credentials(ppp, option_username,
+					option_passwd);
+
+		/* set connect and disconnect callbacks */
+		g_at_ppp_set_connect_function(ppp, ppp_connect, NULL);
+		g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
+
+		/* open the ppp connection */
+		g_at_ppp_open(ppp);
+	}
+}
+
 static void at_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
 	char buf[64];
@@ -231,8 +302,14 @@
 =

 	if (option_legacy =3D=3D TRUE) {
 			sprintf(buf, "ATD*99***%u#", option_cid);
-			g_at_chat_send(modem, buf, none_prefix,
-					NULL, NULL, NULL);
+			if (option_ppp =3D=3D TRUE) {
+				g_print("Option PPP enabled\n");
+				g_at_chat_send(modem, buf, none_prefix,
+						connect_cb, NULL, NULL);
+			}
+			else
+				g_at_chat_send(modem, buf, none_prefix,
+						NULL, NULL, NULL);
 	} else {
 		sprintf(buf, "AT+CGACT=3D1,%u", option_cid);
 		g_at_chat_send(control, buf, none_prefix,
@@ -406,6 +483,12 @@
 				"Specify CFUN offmode" },
 	{ "legacy", 'l', 0, G_OPTION_ARG_NONE, &option_legacy,
 				"Use ATD*99***<cid>#" },
+	{ "ppp", 'P', 0, G_OPTION_ARG_NONE, &option_ppp,
+				"Connect using PPP" },
+	{ "username", 'u', 0, G_OPTION_ARG_STRING, &option_username,
+				"Specify PPP Username" },
+	{ "password", 'w', 0, G_OPTION_ARG_STRING, &option_passwd,
+				"Specifiy PPP Password" },
 	{ NULL },
 };
 =



--===============2848908112413030504==--


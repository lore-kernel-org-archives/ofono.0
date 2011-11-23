Content-Type: multipart/mixed; boundary="===============5567063268545574978=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 2/6] gsmdial: Add IPv6 CP option
Date: Wed, 23 Nov 2011 14:57:48 +0200
Message-ID: <1322053072-20252-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322053072-20252-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5567063268545574978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   41 +++++++++++++++++++++++++++++++++++------
 1 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index be159eb..87541d1 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -59,6 +59,7 @@ static gchar *option_pppdump =3D NULL;
 static gboolean option_bluetooth =3D FALSE;
 static gboolean option_acfc =3D FALSE;
 static gboolean option_pfc =3D FALSE;
+static gchar **option_type =3D NULL;
 =

 static GAtPPP *ppp;
 static GAtChat *control;
@@ -343,6 +344,26 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user_data)
 	g_at_chat_resume(modem);
 }
 =

+static GAtPPP *ppp_new(gchar **type)
+{
+	gboolean ipv4 =3D FALSE;
+	gboolean ipv6 =3D FALSE;
+	int i;
+
+	for (i =3D 0; type !=3D NULL && type[i]; i++)
+		if (g_str_equal(type[i], "4"))
+			ipv4 =3D TRUE;
+		else if (g_str_equal(type[i], "6"))
+			ipv6 =3D TRUE;
+
+	if (ipv4 && ipv6)
+		return g_at_ppp_ipv4v6_new(NULL);
+	else if (ipv6)
+		return g_at_ppp_ipv6_new(NULL);
+	else
+		return g_at_ppp_new();
+}
+
 static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	GAtIO *io;
@@ -362,7 +383,7 @@ static void connect_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	g_at_chat_suspend(modem);
 =

 	/* open ppp */
-	ppp =3D g_at_ppp_new();
+	ppp =3D ppp_new(option_type);
 	if (ppp =3D=3D NULL) {
 		g_print("Unable to create PPP object\n");
 		exit(1);
@@ -374,12 +395,14 @@ static void connect_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	g_at_ppp_set_credentials(ppp, option_username, option_password);
 =

-	g_at_ppp_set_acfc_enabled(ppp, option_acfc);
-	g_at_ppp_set_pfc_enabled(ppp, option_pfc);
+	if (g_at_ppp_get_proto(ppp) & G_AT_PPP_PROTO_IP) {
+		g_at_ppp_set_acfc_enabled(ppp, option_acfc);
+		g_at_ppp_set_pfc_enabled(ppp, option_pfc);
 =

-	/* set connect and disconnect callbacks */
-	g_at_ppp_set_connect_function(ppp, ppp_connect, NULL);
-	g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
+		/* set connect and disconnect callbacks */
+		g_at_ppp_set_connect_function(ppp, ppp_connect, NULL);
+		g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
+	}
 =

 	/* open the ppp connection */
 	g_at_ppp_open(ppp, io);
@@ -687,6 +710,12 @@ static GOptionEntry options[] =3D {
 				"Use Protocol Field Compression" },
 	{ "acfc", 0, 0, G_OPTION_ARG_NONE, &option_acfc,
 				"Use Address & Control Field Compression" },
+	{ "type", 't', 0, G_OPTION_ARG_STRING_ARRAY, &option_type,
+				"Specify Context type. Type:\n\n"
+				"\t-t 4\t\t- IPv4 only (default)\n"
+				"\t-t 6\t\t- IPv6 only\n"
+				"\t-t 4 -t 6\t- IPv4 and IPv6",
+				"Type" },
 	{ NULL },
 };
 =

-- =

1.7.5.4


--===============5567063268545574978==--


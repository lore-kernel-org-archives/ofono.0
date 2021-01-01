Content-Type: multipart/mixed; boundary="===============3481308132345314922=="
MIME-Version: 1.0
From: s.e.golubtsov@gmail.com
Subject: [PATCH] gsmdial: add support for different authentication methods
 selection
Date: Sat, 02 Jan 2021 00:12:15 +0300
Message-ID: <20210101211215.28129-1-s.e.golubtsov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3481308132345314922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sergei Golubtsov <s.e.golubtsov@gmail.com>

Selection capability for authentication method via a command line
argument has been added
---
 gatchat/gsmdial.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 60e4f245..0407f97c 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -53,6 +53,7 @@ static gint option_cid =3D 0;
 static gchar *option_apn =3D NULL;
 static gint option_offmode =3D 0;
 static gboolean option_legacy =3D FALSE;
+static gchar *option_auth_method;
 static gchar *option_username =3D NULL;
 static gchar *option_password =3D NULL;
 static gchar *option_pppdump =3D NULL;
@@ -369,6 +370,14 @@ static void connect_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	}
 	g_at_ppp_set_debug(ppp, gsmdial_debug, "PPP");
 =

+	GAtPPPAuthMethod auth_method =3D G_AT_PPP_AUTH_METHOD_CHAP;
+	if (strcmp(option_auth_method, "PAP") =3D=3D 0) {
+		auth_method =3D G_AT_PPP_AUTH_METHOD_PAP;
+	} else if (strcmp(option_auth_method, "NONE") =3D=3D 0) {
+		auth_method =3D G_AT_PPP_AUTH_METHOD_NONE;
+	}
+	g_at_ppp_set_auth_method(ppp, auth_method);
+
 	g_at_ppp_set_credentials(ppp, option_username, option_password);
 =

 	g_at_ppp_set_acfc_enabled(ppp, option_acfc);
@@ -677,6 +686,10 @@ static GOptionEntry options[] =3D {
 				"Use ATD*99***<cid>#" },
 	{ "bluetooth", 'b', 0, G_OPTION_ARG_NONE, &option_bluetooth,
 				"Use only ATD*99" },
+	{ "auth", 'A', 0, G_OPTION_ARG_STRING, &option_auth_method,
+				"Specify the authentication method for the PPP"
+				" connection: CHAP, PAP or NONE. CHAP is used"
+				" by default." },
 	{ "username", 'u', 0, G_OPTION_ARG_STRING, &option_username,
 				"Specify PPP username" },
 	{ "password", 'w', 0, G_OPTION_ARG_STRING, &option_password,
-- =

2.17.1

--===============3481308132345314922==--


Content-Type: multipart/mixed; boundary="===============7570287282896289146=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v5 2/3] gsmdial: add new option to test escape sequence
Date: Tue, 10 May 2011 10:34:15 +0200
Message-ID: <1305016456-24542-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305016456-24542-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7570287282896289146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index a10e7cb..31bb910 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -57,6 +57,7 @@ static gchar *option_username =3D NULL;
 static gchar *option_password =3D NULL;
 static gchar *option_pppdump =3D NULL;
 static gboolean option_bluetooth =3D FALSE;
+static gboolean option_esc =3D FALSE;
 =

 static GAtPPP *ppp;
 static GAtChat *control;
@@ -237,6 +238,23 @@ static gboolean execute(const char *cmd)
 	return TRUE;
 }
 =

+static void ppp_suspend(gpointer user_data)
+{
+	g_at_chat_resume(modem);
+}
+
+static void start_test_sequence(gpointer data)
+{
+	/* Delete the write done CB */
+	g_at_io_set_write_done(g_at_chat_get_io(modem), NULL, NULL);
+
+	/*
+	 * We are sure there are no more PPP packets to be written,
+	 * we can suspend PPP client and send escape sequence
+	 */
+	g_at_ppp_suspend(ppp);
+}
+
 static void ppp_connect(const char *iface, const char *local, const char *=
peer,
 			const char *dns1, const char *dns2,
 			gpointer user_data)
@@ -261,6 +279,14 @@ static void ppp_connect(const char *iface, const char =
*local, const char *peer,
 	snprintf(buf, sizeof(buf), "%s %s %s pointopoint %s", IFCONFIG_PATH,
 				iface, local, peer);
 	execute(buf);
+
+	/*
+	 * As soon as a PPP packet is written by the client, we start
+	 * test sequence.
+	 */
+	if (option_esc)
+		g_at_io_set_write_done(g_at_chat_get_io(modem),
+					start_test_sequence, NULL);
 }
 =

 static void no_carrier_notify(GAtResult *result, gpointer user_data)
@@ -327,6 +353,7 @@ static void connect_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	/* set connect and disconnect callbacks */
 	g_at_ppp_set_connect_function(ppp, ppp_connect, NULL);
 	g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
+	g_at_ppp_set_suspend_function(ppp, ppp_suspend, NULL);
 =

 	/* open the ppp connection */
 	g_at_ppp_open(ppp);
@@ -624,6 +651,8 @@ static GOptionEntry options[] =3D {
 				"Use ATD*99***<cid>#" },
 	{ "bluetooth", 'b', 0, G_OPTION_ARG_NONE, &option_bluetooth,
 				"Use only ATD*99" },
+	{ "esc_seq", 'e', 0, G_OPTION_ARG_NONE, &option_esc,
+				"Send escape sequence test" },
 	{ "username", 'u', 0, G_OPTION_ARG_STRING, &option_username,
 				"Specify PPP username" },
 	{ "password", 'w', 0, G_OPTION_ARG_STRING, &option_password,
-- =

1.7.1


--===============7570287282896289146==--


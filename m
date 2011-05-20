Content-Type: multipart/mixed; boundary="===============1098108835010408034=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v6 5/5] gsmdial: add escape sequence/ATH0/ATO0 testing option
Date: Fri, 20 May 2011 11:38:16 +0200
Message-ID: <1305884296-2601-6-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305884296-2601-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1098108835010408034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index a10e7cb..3fb6dfe 100644
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
@@ -237,6 +238,67 @@ static gboolean execute(const char *cmd)
 	return TRUE;
 }
 =

+static void power_down_ppp(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	if (!ok)
+		return;
+
+	g_at_ppp_unref(ppp);
+	ppp =3D NULL;
+}
+
+static void ppp_suspend_ath0(gpointer user_data)
+{
+	g_at_chat_resume(modem);
+	g_at_chat_send(modem, "ATH0", none_prefix, power_down_ppp, NULL, NULL);
+}
+
+static void continue_test_sequence(gpointer data)
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
+static void resume_ppp(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	if (!ok)
+		return;
+
+	g_at_chat_suspend(modem);
+	g_at_ppp_set_suspend_function(ppp, ppp_suspend_ath0, NULL);
+	g_at_ppp_resume(ppp);
+	/*
+	 * As soon as a PPP packet is written by the client, we start
+	 * test sequence.
+	 */
+	g_at_io_set_write_done(g_at_chat_get_io(modem),
+					continue_test_sequence, NULL);
+}
+
+static void ppp_suspend_ato0(gpointer user_data)
+{
+	g_at_chat_resume(modem);
+	g_at_chat_send(modem, "ATO0", none_prefix, resume_ppp, NULL, NULL);
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
@@ -261,6 +323,14 @@ static void ppp_connect(const char *iface, const char =
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
@@ -327,6 +397,7 @@ static void connect_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	/* set connect and disconnect callbacks */
 	g_at_ppp_set_connect_function(ppp, ppp_connect, NULL);
 	g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
+	g_at_ppp_set_suspend_function(ppp, ppp_suspend_ato0, NULL);
 =

 	/* open the ppp connection */
 	g_at_ppp_open(ppp);
@@ -624,6 +695,8 @@ static GOptionEntry options[] =3D {
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


--===============1098108835010408034==--


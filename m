Content-Type: multipart/mixed; boundary="===============5502896653291354424=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 26/26] gsmdial: implement test sequence +++-ATO0-+++-ATH0
Date: Fri, 01 Apr 2011 10:56:28 +0200
Message-ID: <1301648188-7208-27-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5502896653291354424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 92a7ff2..7e6eec9 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -238,6 +238,76 @@ static gboolean execute(const char *cmd)
 	return TRUE;
 }
 =

+static void ppp_suspend(void)
+{
+	/* Delete the write done CB */
+	g_at_io_set_write_done(g_at_chat_get_io(modem), NULL, NULL);
+
+	/*
+	 * We are sure there are no more PPP packets to be written,
+	 * we can suspend PPP client
+	 */
+	g_at_ppp_suspend(ppp);
+	g_at_chat_send_escape_sequence(modem);
+}
+
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
+static gboolean send_ATH0(gpointer user_data)
+{
+	/* Resume AT chat to send ATH0 */
+	g_at_chat_resume(modem);
+	g_at_chat_send(modem, "ATH0", none_prefix, power_down_ppp, NULL, NULL);
+
+	return FALSE;
+}
+
+static void continue_test_sequence(gpointer data)
+{
+	ppp_suspend();
+	g_timeout_add_seconds(5, send_ATH0, NULL);
+}
+
+static void suspend_gat_chat(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	/*
+	 * As soon as the command is treated by AT server
+	 * we can suspend AT chat and resume PPP client
+	 */
+	g_at_chat_suspend(modem);
+	g_at_ppp_resume(ppp);
+
+	/*
+	 * As soon as a PPP packet is written by the client, we continue
+	 * test sequence.
+	 */
+	g_at_io_set_write_done(g_at_chat_get_io(modem),
+				continue_test_sequence, NULL);
+}
+
+static gboolean send_ATO0(gpointer user_data)
+{
+	g_at_chat_resume(modem);
+	g_at_chat_send(modem, "ATO0", none_prefix,
+			suspend_gat_chat, NULL, NULL);
+
+	return FALSE;
+}
+
+static void start_test_sequence(gpointer data)
+{
+	ppp_suspend();
+	g_timeout_add_seconds(5, send_ATO0, NULL);
+}
+
 static void ppp_connect(const char *iface, const char *local, const char *=
peer,
 			const char *dns1, const char *dns2,
 			gpointer user_data)
@@ -262,6 +332,14 @@ static void ppp_connect(const char *iface, const char =
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
-- =

1.7.1


--===============5502896653291354424==--


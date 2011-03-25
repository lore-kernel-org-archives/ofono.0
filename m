Content-Type: multipart/mixed; boundary="===============5869771154066466193=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 18/18] gsmdial: implement mechanism to send +++ -> ATO0 -> +++
 -> ATH0
Date: Fri, 25 Mar 2011 16:25:49 +0100
Message-ID: <1301066749-12052-19-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5869771154066466193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |  164 ++++++++++++++++++++++++++++++++++++++++++++-----=
---
 1 files changed, 138 insertions(+), 26 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 92a7ff2..f1b485e 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -40,6 +40,8 @@
 =

 #define IFCONFIG_PATH "/sbin/ifconfig"
 =

+#define GUARD_TIMEOUTS 1500
+
 static const char *none_prefix[] =3D { NULL };
 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
 static const char *creg_prefix[] =3D { "+CREG:", NULL };
@@ -238,32 +240,6 @@ static gboolean execute(const char *cmd)
 	return TRUE;
 }
 =

-static void ppp_connect(const char *iface, const char *local, const char *=
peer,
-			const char *dns1, const char *dns2,
-			gpointer user_data)
-{
-	char buf[512];
-
-	/* print out the negotiated address and dns server */
-	g_print("Network Device: %s\n", iface);
-	g_print("IP Address: %s\n", local);
-	g_print("Peer IP Address: %s\n", peer);
-	g_print("Primary DNS Server: %s\n", dns1);
-	g_print("Secondary DNS Server: %s\n", dns2);
-
-	if (getuid() !=3D 0) {
-		g_print("Need root privilege to config PPP interface\n");
-		return;
-	}
-
-	snprintf(buf, sizeof(buf), "%s %s up", IFCONFIG_PATH, iface);
-	execute(buf);
-
-	snprintf(buf, sizeof(buf), "%s %s %s pointopoint %s", IFCONFIG_PATH,
-				iface, local, peer);
-	execute(buf);
-}
-
 static void no_carrier_notify(GAtResult *result, gpointer user_data)
 {
 	char buf[64];
@@ -294,6 +270,142 @@ static void ppp_disconnect(GAtPPPDisconnectReason rea=
son, gpointer user_data)
 	g_at_chat_resume(modem);
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
+static gboolean send_ATH0(gpointer user_data)
+{
+	/* Resume AT chat to send ATH0 */
+	g_at_chat_resume(modem);
+	g_at_chat_send(modem, "ATH0", none_prefix, power_down_ppp, NULL, NULL);
+
+	return FALSE;
+}
+
+static gboolean suspend_and_close(gpointer user_data)
+{
+	g_print("Send +++\n");
+	/* Send the escape sequence to suspend PPP server*/
+	g_at_io_write(g_at_chat_get_io(modem), "+++", 3);
+	=

+	/*
+	 * Wait GUARD_TIMEOUTS ms before sending ATH0 cmd
+	 * according to guard timeouts
+	 */
+	g_timeout_add(GUARD_TIMEOUTS, send_ATH0, NULL);
+
+	return FALSE;
+}
+
+static void ppp_suspend_close(gpointer data)
+{
+	/* Delete the write done CB */
+	g_at_io_set_write_done(g_at_chat_get_io(modem), NULL, NULL);
+
+	/*
+	 * We are sure there are no more PPP packets to be written,
+	 * we can suspend PPP client
+	 */
+	g_at_ppp_suspend(ppp);
+
+	/* Wait GUARD_TIMEOUTS ms before sending escape sequence */
+	g_timeout_add(GUARD_TIMEOUTS, suspend_and_close, NULL);
+}
+
+static void suspend_gat_chat(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	/*
+	 * As soon as the command is treated by AT server
+	 * we can suspend AT chat and resume PPP client
+	 */
+	g_at_chat_suspend(modem);
+	g_at_ppp_resume(ppp);
+
+	/*
+	 * We wait for another PPP packet to be written
+	 * to suspend again PPP server and close it
+	 */
+	g_at_io_set_write_done(g_at_chat_get_io(modem), ppp_suspend_close, NULL);
+}
+
+static gboolean send_ATO0(gpointer user_data)
+{
+	/* Resume AT chat to send ATO0 */
+	g_at_chat_resume(modem);
+	g_at_chat_send(modem, "ATO0", none_prefix, suspend_gat_chat, NULL, NULL);
+
+	return FALSE;
+}
+
+static gboolean suspend_resume(gpointer user_data)
+{
+	g_print("Send +++\n");
+	/* Send the escape sequence to suspend PPP server*/
+	g_at_io_write(g_at_chat_get_io(modem), "+++", 3);
+
+	/*
+	 * Wait GUARD_TIMEOUTS ms before sending ATO0 cmd
+	 * according to guard timeouts
+	 */
+	g_timeout_add(GUARD_TIMEOUTS, send_ATO0, NULL);
+
+	return FALSE;
+}
+
+static void ppp_suspend_resume(gpointer data)
+{
+	/* Delete the write done CB */
+	g_at_io_set_write_done(g_at_chat_get_io(modem), NULL, NULL);
+
+	/*
+	 * We are sure there are no more PPP packets to be written,
+	 * we can suspend PPP client
+	 */
+	g_at_ppp_suspend(ppp);
+
+	/* Wait GUARD_TIMEOUTS ms before sending escape sequence */
+	g_timeout_add(GUARD_TIMEOUTS, suspend_resume, NULL);
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
+
+	/*
+	 * As soon as a PPP packet is written by the client, we try to send the e=
scape sequence
+	 * and resume PPP server using ATO0 cmd
+	 */
+	if (option_esc)
+		g_at_io_set_write_done(g_at_chat_get_io(modem), ppp_suspend_resume, NULL=
);
+}
+
 static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	GAtIO *io;
-- =

1.7.1


--===============5869771154066466193==--


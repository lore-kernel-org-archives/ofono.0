Content-Type: multipart/mixed; boundary="===============6599994823692772416=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5] mbm: Move +CFUN=1 to after SIM authentication.
Date: Thu, 17 Jun 2010 15:42:15 +0200
Message-ID: <1276782135-26871-10-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276782135-26871-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6599994823692772416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is mostly a hack, as discussed on IRC we don't know what the
"correct" order is, but this seems to make the SIM toolkit work
more or less reliably on this modem, on SIMs with PIN enabled or
disabled alike.  Use this if you want to try out the STK menu.

In particular I'm not sure if the modem will be able to make
emergency calls unauthenticated, without CFUN=3D1.

I've tried other things, but generally, without this patch, with
PIN disabled in the SIM, the initial proactive command is only
passed through by the modem if the profile download is done before
any of the atom drivers initialise, (before sim driver).  With PIN
enabled it won't work at all.

Incidentally it seems that on the calypso we also need to send
+CFUN=3D1 only after SIM authentication, for things to work.

With this patch, the initial proactive command still only works in
the first ofono session after modem reset.  When ofono restarts
without unplugging or resetting (AT*E2RESET) the modem, on the
next session the SIM doesn't get reinitialised and will not send
the Set Up Menu unless it's one of those SIMs that resend it
periodically.
---
 plugins/mbm.c |   55 ++++++++++++++++++++---------------------------------=
--
 1 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 9193539..7873f54 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -121,22 +121,6 @@ poweron:
 	ofono_modem_set_powered(modem, TRUE);
 }
 =

-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct mbm_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("");
-
-	if (!ok) {
-		ofono_modem_set_powered(modem, FALSE);
-		return;
-	}
-
-	g_at_chat_send(data->modem_port, "AT+CRSM=3D242", crsm_prefix,
-			status_check, modem, NULL);
-}
-
 static void cfun_query(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -146,23 +130,13 @@ static void cfun_query(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	DBG("%d", ok);
 =

-	if (!ok)
-		return;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (g_at_result_iter_next(&iter, "+CFUN:") =3D=3D FALSE)
-		return;
-
-	g_at_result_iter_next_number(&iter, &status);
-
-	if (status =3D=3D 4) {
-		g_at_chat_send(data->modem_port, "AT+CFUN=3D1", none_prefix,
-				cfun_enable, modem, NULL);
+	if (!ok) {
+		ofono_modem_set_powered(modem, FALSE);
 		return;
 	}
 =

-	cfun_enable(TRUE, NULL, modem);
+	g_at_chat_send(data->modem_port, "AT+CRSM=3D242", crsm_prefix,
+			status_check, modem, NULL);
 }
 =

 static void emrdy_notifier(GAtResult *result, gpointer user_data)
@@ -324,16 +298,14 @@ static void mbm_pre_sim(struct ofono_modem *modem)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-static void mbm_post_sim(struct ofono_modem *modem)
+static void cfun_enable(gboolean ok, GAtResult *result,
+					gpointer user_data)
 {
+	struct ofono_modem *modem =3D user_data;
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 =

-	DBG("%p", modem);
-
-	ofono_stk_create(modem, 0, "mbmmodem", data->modem_port);
-
 	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem",
 				data->modem_port);
 =

@@ -348,6 +320,19 @@ static void mbm_post_sim(struct ofono_modem *modem)
 		ofono_gprs_add_context(gprs, gc);
 }
 =

+static void mbm_post_sim(struct ofono_modem *modem)
+{
+	struct mbm_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_stk_create(modem, 0, "mbmmodem", data->modem_port);
+
+	g_at_chat_send(data->modem_port, "AT+CFUN=3D1", none_prefix,
+			cfun_enable, modem, NULL);
+
+}
+
 static struct ofono_modem_driver mbm_driver =3D {
 	.name		=3D "mbm",
 	.probe		=3D mbm_probe,
-- =

1.7.1.86.g0e460.dirty


--===============6599994823692772416==--


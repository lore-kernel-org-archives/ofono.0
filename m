Content-Type: multipart/mixed; boundary="===============3379151317243205577=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 1/3] Make fetch command function as external
Date: Fri, 09 Jul 2010 22:52:06 +0800
Message-ID: <1278687128-8983-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3379151317243205577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                |    1 +
 drivers/atmodem/sim-poll.c |   56 ++--------------------------------------=
---
 drivers/atmodem/stk.c      |   53 +++++++++++++++++++++++++++++++++++++++++
 drivers/atmodem/stk.h      |   22 +++++++++++++++++
 4 files changed, 79 insertions(+), 53 deletions(-)
 create mode 100644 drivers/atmodem/stk.h

diff --git a/Makefile.am b/Makefile.am
index 24aa886..e256841 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -143,6 +143,7 @@ builtin_sources +=3D $(gatchat_sources) \
 				drivers/atmodem/network-registration.c \
 				drivers/atmodem/sim.c \
 				drivers/atmodem/stk.c \
+				drivers/atmodem/stk.h \
 				drivers/atmodem/sim-poll.c \
 				drivers/atmodem/sim-poll.h \
 				drivers/atmodem/ussd.c \
diff --git a/drivers/atmodem/sim-poll.c b/drivers/atmodem/sim-poll.c
index f1a83e3..f79d6df 100644
--- a/drivers/atmodem/sim-poll.c
+++ b/drivers/atmodem/sim-poll.c
@@ -39,6 +39,7 @@
 =

 #include "atmodem.h"
 #include "sim-poll.h"
+#include "stk.h"
 =

 struct sim_poll_data {
 	GAtChat *chat;
@@ -58,58 +59,6 @@ struct sim_poll_data {
 static const char *csim_prefix[] =3D { "+CSIM:", NULL };
 =

 static gboolean sim_status_poll(gpointer user_data);
-static void sim_fetch_command(struct sim_poll_data *spd, int length);
-
-static void at_csim_fetch_cb(gboolean ok, GAtResult *result,
-		gpointer user_data)
-{
-	struct sim_poll_data *spd =3D user_data;
-	GAtResultIter iter;
-	const guint8 *response;
-	gint rlen, len;
-
-	if (!ok)
-		return;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "+CSIM:"))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &rlen))
-		return;
-
-	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
-		return;
-
-	if (rlen !=3D len * 2 || len < 2)
-		return;
-
-	/* Check that SW1 indicates success */
-	if (response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91)
-		return;
-
-	if (response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)
-		return;
-
-	DBG("csim_fetch_cb: %i", len);
-
-	ofono_stk_proactive_command_notify(spd->stk, len - 2, response);
-
-	/* Can this happen? */
-	if (response[len - 2] =3D=3D 0x91)
-		sim_fetch_command(spd, response[len - 1]);
-}
-
-static void sim_fetch_command(struct sim_poll_data *spd, int length)
-{
-	char buf[64];
-
-	snprintf(buf, sizeof(buf), "AT+CSIM=3D10,A0120000%02hhX", length);
-
-	g_at_chat_send(spd->chat, buf, csim_prefix,
-			at_csim_fetch_cb, spd, NULL);
-}
 =

 static void sim_status_poll_schedule(struct sim_poll_data *spd)
 {
@@ -196,7 +145,7 @@ static void at_csim_status_cb(gboolean ok, GAtResult *r=
esult,
 		return;
 =

 	/* We have a proactive command pending, FETCH it */
-	sim_fetch_command(spd, response[len - 1]);
+	at_sim_fetch_command(spd->chat, spd->stk, response[len - 1]);
 }
 =

 static gboolean sim_status_poll(gpointer user_data)
@@ -317,3 +266,4 @@ void atmodem_poll_enable(struct ofono_modem *modem, GAt=
Chat *chat)
 		sim_watch(sim_atom,
 				OFONO_ATOM_WATCH_CONDITION_REGISTERED, spd);
 }
+
diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index aede668..6058d69 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -38,6 +38,7 @@
 #include "gatresult.h"
 =

 #include "atmodem.h"
+#include "stk.h"
 =

 struct stk_data {
 	GAtChat *chat;
@@ -45,6 +46,58 @@ struct stk_data {
 =

 static const char *csim_prefix[] =3D { "+CSIM:", NULL };
 =

+static void csim_fetch_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtChat *chat =3D cbd->cb;
+	struct ofono_stk *stk =3D cbd->data;
+	GAtResultIter iter;
+	const guint8 *response;
+	gint rlen, len;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSIM:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &rlen))
+		return;
+
+	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
+		return;
+
+	if (rlen !=3D len * 2 || len < 2)
+		return;
+
+	/* Check that SW1 indicates success */
+	if (response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91)
+		return;
+
+	if (response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)
+		return;
+
+	DBG("csim_fetch_cb: %i", len);
+
+	ofono_stk_proactive_command_notify(stk, len - 2, response);
+
+	/* Can this happen? */
+	if (response[len - 2] =3D=3D 0x91)
+		at_sim_fetch_command(chat, stk, response[len - 1]);
+}
+
+void at_sim_fetch_command(GAtChat *chat, struct ofono_stk *stk, int length)
+{
+	char buf[64];
+	struct cb_data *cbd =3D cb_data_new(chat, stk);
+
+	snprintf(buf, sizeof(buf), "AT+CSIM=3D10,A0120000%02hhX", length);
+	g_at_chat_send(chat, buf, csim_prefix, csim_fetch_cb, cbd, g_free);
+}
+
 static void at_csim_envelope_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
diff --git a/drivers/atmodem/stk.h b/drivers/atmodem/stk.h
new file mode 100644
index 0000000..6e998ac
--- /dev/null
+++ b/drivers/atmodem/stk.h
@@ -0,0 +1,22 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+void at_sim_fetch_command(GAtChat *chat, struct ofono_stk *stk, int length=
);
-- =

1.7.0.4


--===============3379151317243205577==--


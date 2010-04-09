Content-Type: multipart/mixed; boundary="===============6932553106871034440=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 8/8] Implement STATUS polling in atmodem driver.
Date: Fri, 09 Apr 2010 08:50:52 +0200
Message-ID: <1270795852-7302-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6932553106871034440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                |    2 +
 drivers/atmodem/sim-poll.c |  319 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/atmodem/sim-poll.h |   22 +++
 plugins/atgen.c            |    8 +-
 plugins/phonesim.c         |    5 +-
 5 files changed, 350 insertions(+), 5 deletions(-)
 create mode 100644 drivers/atmodem/sim-poll.c
 create mode 100644 drivers/atmodem/sim-poll.h

diff --git a/Makefile.am b/Makefile.am
index a506dba..1279b0a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -125,6 +125,8 @@ builtin_sources +=3D $(gatchat_sources) \
 				drivers/atmodem/network-registration.c \
 				drivers/atmodem/sim.c \
 				drivers/atmodem/stk.c \
+				drivers/atmodem/sim-poll.c \
+				drivers/atmodem/sim-poll.h \
 				drivers/atmodem/ussd.c \
 				drivers/atmodem/voicecall.c \
 				drivers/atmodem/call-barring.c \
diff --git a/drivers/atmodem/sim-poll.c b/drivers/atmodem/sim-poll.c
new file mode 100644
index 0000000..0fca4e7
--- /dev/null
+++ b/drivers/atmodem/sim-poll.c
@@ -0,0 +1,319 @@
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/sim.h>
+#include <ofono/stk.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "ofono.h"
+
+#include "atmodem.h"
+#include "sim-poll.h"
+
+struct sim_poll_data {
+	GAtChat *chat;
+	struct ofono_modem *modem;
+	struct ofono_sim *sim;
+	struct ofono_stk *stk;
+	unsigned int sim_watch;
+	unsigned int stk_watch;
+	unsigned int sim_state_watch;
+	gboolean inserted;
+	int idle_poll_interval;
+	gint status_timeout;
+	gint poll_timeout;
+	guint status_cmd;
+};
+
+static const char *csim_prefix[] =3D { "+CSIM:", NULL };
+
+static gboolean sim_status_poll(gpointer user_data);
+static void sim_fetch_command(struct sim_poll_data *spd, int length);
+
+static void at_csim_fetch_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct sim_poll_data *spd =3D user_data;
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
+	ofono_stk_proactive_command_notify(spd->stk, len - 2, response);
+
+	/* Can this happen? */
+	if (response[len - 2] =3D=3D 0x91)
+		sim_fetch_command(spd, response[len - 1]);
+}
+
+static void sim_fetch_command(struct sim_poll_data *spd, int length)
+{
+	char buf[64];
+
+	snprintf(buf, sizeof(buf), "AT+CSIM=3D10,A0120000%02hhX", length);
+
+	g_at_chat_send(spd->chat, buf, csim_prefix,
+			at_csim_fetch_cb, spd, NULL);
+}
+
+static void sim_status_poll_schedule(struct sim_poll_data *spd)
+{
+	/* TODO: Decide on the interval based on whether any call is active */
+	/* TODO: On idle, possibly only schedule if proactive commands enabled
+	 * as indicated by EFphase + EFsst (51.011: 11.6.1) */
+	int interval =3D spd->idle_poll_interval;
+
+	/* When a SIM is inserted, the SIM might have requested a different
+	 * interval.  */
+	if (spd->inserted)
+		interval =3D ofono_modem_get_integer(spd->modem,
+				"status-poll-interval");
+
+	spd->poll_timeout =3D g_timeout_add_seconds(interval,
+			sim_status_poll, spd);
+}
+
+static gboolean sim_status_timeout(gpointer user_data)
+{
+	struct sim_poll_data *spd =3D user_data;
+
+	spd->status_timeout =3D 0;
+
+	g_at_chat_cancel(spd->chat, spd->status_cmd);
+	spd->status_cmd =3D 0;
+
+	if (spd->inserted =3D=3D TRUE) {
+		spd->inserted =3D FALSE;
+		ofono_sim_inserted_notify(spd->sim, FALSE);
+	}
+
+	sim_status_poll_schedule(spd);
+
+	return FALSE;
+}
+
+static void at_csim_status_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct sim_poll_data *spd =3D user_data;
+	GAtResultIter iter;
+	const guint8 *response;
+	gint rlen, len;
+
+	spd->status_cmd =3D 0;
+
+	if (!spd->status_timeout)
+		/* The STATUS already timed out */
+		return;
+
+	/* Card responded on time */
+
+	g_source_remove(spd->status_timeout);
+	spd->status_timeout =3D 0;
+
+	if (spd->inserted !=3D TRUE) {
+		spd->inserted =3D TRUE;
+		ofono_sim_inserted_notify(spd->sim, TRUE);
+	}
+
+	sim_status_poll_schedule(spd);
+
+	/* Check if we have a proactive command */
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
+	if (response[len - 2] !=3D 0x91)
+		return;
+
+	/* We have a proactive command pending, FETCH it */
+	sim_fetch_command(spd, response[len - 1]);
+}
+
+static gboolean sim_status_poll(gpointer user_data)
+{
+	struct sim_poll_data *spd =3D user_data;
+
+	spd->poll_timeout =3D 0;
+
+	/* The SIM must respond in a given time frame which is of at
+	 * least 5 seconds in TS 11.11.  */
+	spd->status_timeout =3D g_timeout_add_seconds(5,
+			sim_status_timeout, spd);
+
+	/* Send STATUS */
+	spd->status_cmd =3D g_at_chat_send(spd->chat, "AT+CSIM=3D8,A0F200C0",
+			csim_prefix, at_csim_status_cb, spd, NULL);
+	if (spd->status_cmd =3D=3D 0)
+		at_csim_status_cb(FALSE, NULL, spd);
+
+	return FALSE;
+}
+
+static void sim_state_watch(void *user, enum ofono_sim_state new_state)
+{
+	struct sim_poll_data *spd =3D user;
+
+	spd->inserted =3D new_state !=3D OFONO_SIM_STATE_NOT_PRESENT;
+
+	if (!spd->inserted)
+		ofono_modem_set_integer(spd->modem,
+				"status-poll-interval", 30);
+}
+
+static void sim_watch(struct ofono_atom *atom,
+		enum ofono_atom_watch_condition cond, void *data)
+{
+	struct sim_poll_data *spd =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		spd->sim =3D __ofono_atom_get_data(atom);
+
+		spd->sim_state_watch =3D ofono_sim_add_state_watch(spd->sim,
+				sim_state_watch, spd, NULL);
+		sim_state_watch(spd, ofono_sim_get_state(spd->sim));
+
+		sim_status_poll(spd);
+
+		return;
+	}
+
+	if (cond !=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED)
+		return;
+
+	spd->inserted =3D FALSE;
+
+	spd->sim_state_watch =3D 0;
+
+	if (spd->sim_watch) {
+		__ofono_modem_remove_atom_watch(spd->modem, spd->sim_watch);
+		spd->sim_watch =3D 0;
+	}
+
+	if (spd->stk_watch) {
+		__ofono_modem_remove_atom_watch(spd->modem, spd->stk_watch);
+		spd->stk_watch =3D 0;
+	}
+
+	if (spd->status_timeout) {
+		g_source_remove(spd->status_timeout);
+		spd->status_timeout =3D 0;
+	}
+
+	if (spd->poll_timeout) {
+		g_source_remove(spd->poll_timeout);
+		spd->poll_timeout =3D 0;
+	}
+
+	g_free(spd);
+}
+
+static void stk_watch(struct ofono_atom *atom,
+		enum ofono_atom_watch_condition cond, void *data)
+{
+	struct sim_poll_data *spd =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		spd->stk =3D __ofono_atom_get_data(atom);
+	else if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED)
+		spd->stk =3D NULL;
+}
+
+void ofono_atmodem_poll_enable(struct ofono_modem *modem, GAtChat *chat)
+{
+	struct ofono_atom *sim_atom;
+	struct ofono_atom *stk_atom;
+	struct sim_poll_data *spd;
+
+	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+	stk_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_STK);
+
+	if (!sim_atom)
+		return;
+
+	spd =3D g_new0(struct sim_poll_data, 1);
+	spd->chat =3D chat;
+	spd->modem =3D modem;
+	spd->idle_poll_interval =3D 30;
+
+	spd->stk_watch =3D __ofono_modem_add_atom_watch(spd->modem,
+			OFONO_ATOM_TYPE_STK, stk_watch, spd, NULL);
+	if (stk_atom && __ofono_atom_get_registered(stk_atom))
+		stk_watch(stk_atom,
+				OFONO_ATOM_WATCH_CONDITION_REGISTERED, spd);
+
+	spd->sim_watch =3D __ofono_modem_add_atom_watch(spd->modem,
+			OFONO_ATOM_TYPE_SIM, sim_watch, spd, NULL);
+	if (__ofono_atom_get_registered(sim_atom))
+		sim_watch(sim_atom,
+				OFONO_ATOM_WATCH_CONDITION_REGISTERED, spd);
+}
diff --git a/drivers/atmodem/sim-poll.h b/drivers/atmodem/sim-poll.h
new file mode 100644
index 0000000..595c2f5
--- /dev/null
+++ b/drivers/atmodem/sim-poll.h
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
+void ofono_atmodem_poll_enable(struct ofono_modem *modem, GAtChat *chat);
diff --git a/plugins/atgen.c b/plugins/atgen.c
index 262d32f..4a0e315 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -49,6 +49,8 @@
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
 =

+#include <drivers/atmodem/sim-poll.h>
+
 static const char *tty_opts[] =3D {
 	"Baud",
 	"Read",
@@ -157,17 +159,15 @@ static int atgen_disable(struct ofono_modem *modem)
 static void atgen_pre_sim(struct ofono_modem *modem)
 {
 	GAtChat *chat =3D ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", chat);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", chat);
+	ofono_sim_create(modem, 0, "atmodem", chat);
 	ofono_voicecall_create(modem, 0, "atmodem", chat);
 	ofono_stk_create(modem, 0, "atmodem", chat);
 =

-	if (sim)
-		ofono_sim_inserted_notify(sim, TRUE);
+	ofono_atmodem_poll_enable(modem, chat);
 }
 =

 static void atgen_post_sim(struct ofono_modem *modem)
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 9153e1b..5685820 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -59,6 +59,7 @@
 #include <ofono/gprs-context.h>
 =

 #include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/sim-poll.h>
 =

 struct phonesim_data {
 	GAtMux *mux;
@@ -292,7 +293,9 @@ static void phonesim_pre_sim(struct ofono_modem *modem)
 =

 	ofono_stk_create(modem, 0, "atmodem", data->chat);
 =

-	if (sim)
+	if (!data->calypso)
+		ofono_atmodem_poll_enable(modem, data->chat);
+	else if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-- =

1.6.1


--===============6932553106871034440==--


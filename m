Content-Type: multipart/mixed; boundary="===============2959029247495833197=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2] phonesim: add support of +CBC
Date: Fri, 08 Jul 2011 15:29:20 +0200
Message-ID: <1310131760-5611-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2959029247495833197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

PTS test TP/PSI/BV-03-I [Transfer Battery Level Indication] needs to
change battery level and check that the battery level indication is
received at the HF.
So add support for +CBC in phonesim plugin, and force update of the
battery indicator on HFP AG Emulator registration.
---
 plugins/phonesim.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index f49c13a..3a64e2c 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -64,6 +64,8 @@
 #include <drivers/atmodem/sim-poll.h>
 #include <drivers/atmodem/atutil.h>
 =

+#include "ofono.h"
+
 static const char *none_prefix[] =3D { NULL };
 static const char *ptty_prefix[] =3D { "+PTTY:", NULL };
 static int next_iface =3D 0;
@@ -73,6 +75,8 @@ struct phonesim_data {
 	GAtChat *chat;
 	gboolean calypso;
 	gboolean use_mux;
+	unsigned int hfp_watch;
+	int batt_level;
 };
 =

 struct gprs_context_data {
@@ -419,6 +423,43 @@ static void crst_notify(GAtResult *result, gpointer us=
er_data)
 	g_idle_add(phonesim_reset, user_data);
 }
 =

+static void emulator_battery_cb(struct ofono_atom *atom, void *data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+	int val =3D 0;
+
+	if (GPOINTER_TO_INT(data) > 0)
+		val =3D (GPOINTER_TO_INT(data) - 1) / 20 + 1;
+
+	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_BATTERY, val);
+}
+
+static void cbc_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct phonesim_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int status;
+	int level;
+
+	g_at_result_iter_init(&iter, result);
+	if (!g_at_result_iter_next(&iter, "+CBC:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &level))
+		return;
+
+	data->batt_level =3D level;
+
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_battery_cb,
+						GUINT_TO_POINTER(level));
+}
+
 static void phonesim_disconnected(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -481,6 +522,18 @@ static void mux_setup(GAtMux *mux, gpointer user_data)
 					cfun_set_on_cb, modem, NULL);
 }
 =

+static void emulator_hfp_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *user_data)
+{
+	struct phonesim_data *data =3D user_data;
+
+	if (cond !=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		return;
+
+	emulator_battery_cb(atom, GUINT_TO_POINTER(data->batt_level));
+}
+
 static int phonesim_enable(struct ofono_modem *modem)
 {
 	struct phonesim_data *data =3D ofono_modem_get_data(modem);
@@ -574,6 +627,15 @@ static int phonesim_enable(struct ofono_modem *modem)
 	g_at_chat_register(data->chat, "+CRST:",
 				crst_notify, FALSE, modem, NULL);
 =

+	g_at_chat_register(data->chat, "+CBC:",
+				cbc_notify, FALSE, modem, NULL);
+
+	g_at_chat_send(data->chat, "AT+CBC", none_prefix, NULL, NULL, NULL);
+
+	data->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_hfp_watch, data, NULL);
+
 	return 0;
 }
 =

@@ -612,6 +674,8 @@ static int phonesim_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	__ofono_modem_remove_atom_watch(modem, data->hfp_watch);
+
 	g_at_chat_unref(data->chat);
 	data->chat =3D NULL;
 =

-- =

1.7.1


--===============2959029247495833197==--


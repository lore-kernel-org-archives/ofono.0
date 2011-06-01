Content-Type: multipart/mixed; boundary="===============1638186276152312769=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH V3 3/4] voicecall: save last dialed number
Date: Wed, 01 Jun 2011 13:24:22 +0200
Message-ID: <1306927463-10642-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1306927463-10642-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1638186276152312769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index a6ccddd..f176e25 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -37,11 +37,15 @@
 #include "common.h"
 #include "simutil.h"
 #include "smsutil.h"
+#include "storage.h"
 =

 #define MAX_VOICE_CALLS 16
 =

 #define VOICECALL_FLAG_SIM_ECC_READY 0x1
 =

+#define SETTINGS_STORE "voicecall"
+#define SETTINGS_GROUP "Settings"
+
 GSList *g_drivers =3D NULL;
 =

 struct multi_release {
@@ -72,6 +76,8 @@ struct ofono_voicecall {
 	guint tone_source;
 	unsigned int hfp_watch;
 	struct ofono_emulator *pending_em;
+	GKeyFile *settings;
+	char *imsi;
 };
 =

 struct voicecall {
@@ -1478,6 +1484,12 @@ static int voicecall_dial(struct ofono_voicecall *vc=
, const char *number,
 =

 	vc->driver->dial(vc, &ph, clir, cb, vc);
 =

+	if (vc->settings) {
+		g_key_file_set_string(vc->settings, SETTINGS_GROUP,
+					"Number", number);
+		storage_sync(vc->imsi, SETTINGS_STORE, vc->settings);
+	}
+
 	return 0;
 }
 =

@@ -2466,6 +2478,33 @@ static void emulator_hfp_unregister(struct ofono_ato=
m *atom)
 	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
 }
 =

+static void voicecall_load_settings(struct ofono_voicecall *vc)
+{
+	const char *imsi;
+
+	imsi =3D ofono_sim_get_imsi(vc->sim);
+	if (imsi =3D=3D NULL)
+		return;
+
+	vc->settings =3D storage_open(imsi, SETTINGS_STORE);
+
+	if (vc->settings =3D=3D NULL)
+		return;
+
+	vc->imsi =3D g_strdup(imsi);
+}
+
+static void voicecall_close_settings(struct ofono_voicecall *vc)
+{
+	if (vc->settings) {
+		storage_close(vc->imsi, SETTINGS_STORE, vc->settings, TRUE);
+
+		g_free(vc->imsi);
+		vc->imsi =3D NULL;
+		vc->settings =3D NULL;
+	}
+}
+
 static void voicecall_unregister(struct ofono_atom *atom)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2476,6 +2515,8 @@ static void voicecall_unregister(struct ofono_atom *a=
tom)
 =

 	emulator_hfp_unregister(atom);
 =

+	voicecall_close_settings(vc);
+
 	if (vc->sim_state_watch) {
 		ofono_sim_remove_state_watch(vc->sim, vc->sim_state_watch);
 		vc->sim_state_watch =3D 0;
@@ -2615,6 +2656,9 @@ static void sim_state_watch(enum ofono_sim_state new_=
state, void *user)
 =

 		free_sim_ecc_numbers(vc, FALSE);
 		set_new_ecc(vc);
+	case OFONO_SIM_STATE_READY:
+		voicecall_load_settings(vc);
+		break;
 	default:
 		break;
 	}
@@ -2627,6 +2671,7 @@ static void sim_watch(struct ofono_atom *atom,
 	struct ofono_sim *sim =3D __ofono_atom_get_data(atom);
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		voicecall_close_settings(vc);
 		vc->sim_state_watch =3D 0;
 		vc->sim =3D NULL;
 		return;
-- =

1.7.1


--===============1638186276152312769==--


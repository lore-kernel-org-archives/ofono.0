Content-Type: multipart/mixed; boundary="===============2499521136149609834=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 16/16] emulator: Watch netreg status changes
Date: Wed, 11 Aug 2010 10:26:41 +0800
Message-ID: <1281493601-14351-17-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2499521136149609834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Watch netreg status update to notify DUN client, such as +CREG
unsolicited result.
---
 src/emulator.c |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 106 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c8f3d65..56edab6 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -56,6 +56,9 @@ struct modem_settings {
 	int cops;
 	int attached;
 	int gprs_status;
+	int netreg_status;
+	int netreg_lac;
+	int netreg_ci;
 };
 =

 struct ofono_emulator {
@@ -72,6 +75,9 @@ struct ofono_emulator {
 	struct ofono_gprs *gprs;
 	unsigned int gprs_watch;
 	unsigned int gprs_status_watch;
+	struct ofono_netreg *netreg;
+	unsigned int netreg_watch;
+	unsigned int netreg_status_watch;
 };
 =

 static unsigned int ofono_emulator_ids;
@@ -254,12 +260,19 @@ static void creg_cb(GAtServerRequestType type, GAtRes=
ult *result,
 					gpointer user_data)
 {
 	struct ofono_emulator *e =3D user_data;
+	char buf[256];
 =

 	switch (type) {
 	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
 		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
 		break;
 	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		snprintf(buf, sizeof(buf), "+CREG: %d, %x, %x, %x",
+						e->settings.creg,
+						e->settings.netreg_status,
+						e->settings.netreg_lac,
+						e->settings.netreg_ci);
+		ofono_emulator_send_info(e, buf, TRUE);
 		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
 		break;
 	case G_AT_SERVER_REQUEST_TYPE_SET:
@@ -800,6 +813,86 @@ static void add_gprs_watches(struct ofono_emulator *e)
 				OFONO_ATOM_WATCH_CONDITION_REGISTERED, e);
 }
 =

+static void emulator_netreg_update(struct ofono_emulator *e)
+{
+	GAtServer *server =3D e->server;
+	char buf[256];
+
+	switch (e->settings.creg) {
+	case 0:
+		break;
+	case 1:
+		snprintf(buf, sizeof(buf), "+CREG: %d",
+						e->settings.netreg_status);
+		g_at_server_send_unsolicited(server, buf);
+		break;
+	case 2:
+		snprintf(buf, sizeof(buf), "+CREG: %d, %x, %x",
+						e->settings.netreg_status,
+						e->settings.netreg_lac,
+						e->settings.netreg_ci);
+		g_at_server_send_unsolicited(server, buf);
+		break;
+	default:
+		break;
+	}
+}
+
+static void netreg_status_changed(int status, int lac, int ci, int tech,
+					const char *mcc, const char *mnc,
+					void *data)
+{
+	struct ofono_emulator *e =3D data;
+
+	DBG("%d %d %d", status, lac, ci);
+
+	e->settings.netreg_status =3D status;
+	e->settings.netreg_lac =3D lac;
+	e->settings.netreg_ci =3D ci;
+
+	emulator_netreg_update(e);
+}
+
+static void netreg_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_emulator *e =3D data;
+	struct ofono_netreg *netreg;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		e->netreg_status_watch =3D 0;
+		e->netreg =3D NULL;
+		return;
+	}
+
+	netreg =3D __ofono_atom_get_data(atom);
+	e->netreg =3D netreg;
+	e->settings.netreg_status =3D ofono_netreg_get_status(netreg);
+	e->settings.netreg_lac =3D ofono_netreg_get_location(netreg);
+	e->settings.netreg_ci =3D ofono_netreg_get_cellid(netreg);
+	e->netreg_status_watch =3D __ofono_netreg_add_status_watch(e->netreg,
+					netreg_status_changed, e, NULL);
+
+	emulator_netreg_update(e);
+}
+
+static void add_netreg_watches(struct ofono_emulator *e)
+{
+	struct ofono_modem *modem =3D e->modem;
+	struct ofono_atom *netreg_atom;
+
+	e->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_NETREG,
+					netreg_watch, e, NULL);
+
+	netreg_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_NETREG);
+
+	if (netreg_atom && __ofono_atom_get_registered(netreg_atom))
+		netreg_watch(netreg_atom,
+				OFONO_ATOM_WATCH_CONDITION_REGISTERED, e);
+}
+
 unsigned int __ofono_emulator_add_status_watch(struct ofono_emulator *e,
 				ofono_emulator_status_notify_cb_t notify,
 				void *data, ofono_destroy_func destroy)
@@ -859,6 +952,18 @@ static void emulator_unregister(struct ofono_atom *ato=
m)
 		e->gprs_watch =3D 0;
 		e->gprs =3D NULL;
 	}
+
+	if (e->netreg_watch) {
+		if (e->netreg_status_watch) {
+			__ofono_netreg_remove_status_watch(e->netreg,
+						e->netreg_status_watch);
+			e->netreg_status_watch =3D 0;
+		}
+
+		__ofono_modem_remove_atom_watch(e->modem, e->netreg_watch);
+		e->netreg_watch =3D 0;
+		e->netreg =3D NULL;
+	}
 }
 =

 struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
@@ -901,6 +1006,7 @@ struct ofono_emulator *ofono_emulator_create(struct of=
ono_modem *modem,
 	g_at_server_register(e->server, "+CGDCONT", cgdcont_cb, e, NULL);
 =

 	add_gprs_watches(e);
+	add_netreg_watches(e);
 =

 	return e;
 }
-- =

1.7.0.4


--===============2499521136149609834==--


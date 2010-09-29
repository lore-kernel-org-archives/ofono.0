Content-Type: multipart/mixed; boundary="===============8946776057575720249=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 20/21] emulator: Watch GPRS status changes
Date: Wed, 29 Sep 2010 17:45:00 +0800
Message-ID: <1285753501-7668-21-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1285753501-7668-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8946776057575720249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Watch GPRS status update to notify DUN client, such as +CGREG
unsolicited result.
---
 src/emulator.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 2a089a1..7701510 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -55,6 +55,7 @@ struct modem_settings {
 	int cgreg;
 	int cops;
 	int attached;
+	int gprs_status;
 };
 =

 struct ofono_emulator {
@@ -68,6 +69,9 @@ struct ofono_emulator {
 	struct modem_settings settings;
 	enum ofono_emulator_status status;
 	struct ofono_watchlist *status_watches;
+	struct ofono_gprs *gprs;
+	unsigned int gprs_watch;
+	unsigned int gprs_status_watch;
 };
 =

 static GSList *emulator_drivers =3D NULL;
@@ -305,12 +309,16 @@ static void cgreg_cb(GAtServerRequestType type, GAtRe=
sult *result,
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
+		snprintf(buf, sizeof(buf), "+CGREG: %d, %d", e->settings.cgreg,
+					e->settings.gprs_status);
+		ofono_emulator_send_info(e, buf, TRUE);
 		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
 		break;
 	case G_AT_SERVER_REQUEST_TYPE_SET:
@@ -710,6 +718,78 @@ error:
 	g_at_server_send_final(server, res);
 }
 =

+static void emulator_gprs_update(struct ofono_emulator *e)
+{
+	GAtServer *server =3D e->server;
+	char buf[256];
+
+	switch (e->settings.cgreg) {
+	case 0:
+		break;
+	case 1:
+		snprintf(buf, sizeof(buf), "+CGREG: %d",
+						e->settings.gprs_status);
+		g_at_server_send_unsolicited(server, buf);
+		break;
+	case 2:
+		snprintf(buf, sizeof(buf), "+CGREG: %d",
+						e->settings.gprs_status);
+		g_at_server_send_unsolicited(server, buf);
+		break;
+	default:
+		break;
+	}
+}
+
+static void gprs_status_changed(int status, void *data)
+{
+	struct ofono_emulator *e =3D data;
+
+	DBG("%d", status);
+
+	e->settings.gprs_status =3D status;
+
+	emulator_gprs_update(e);
+}
+
+static void gprs_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_emulator *e =3D data;
+	struct ofono_gprs *gprs;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		e->gprs_status_watch =3D 0;
+		e->gprs =3D NULL;
+		return;
+	}
+
+	gprs =3D __ofono_atom_get_data(atom);
+	e->gprs =3D gprs;
+	e->settings.gprs_status =3D ofono_gprs_get_status(gprs);
+	e->gprs_status_watch =3D __ofono_gprs_add_status_watch(e->gprs,
+					gprs_status_changed, e, NULL);
+
+	emulator_gprs_update(e);
+}
+
+static void add_gprs_watches(struct ofono_emulator *e)
+{
+	struct ofono_modem *modem =3D e->modem;
+	struct ofono_atom *gprs_atom;
+
+	e->gprs_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_GPRS,
+					gprs_watch, e, NULL);
+
+	gprs_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_GPRS);
+
+	if (gprs_atom && __ofono_atom_get_registered(gprs_atom))
+		gprs_watch(gprs_atom,
+				OFONO_ATOM_WATCH_CONDITION_REGISTERED, e);
+}
+
 int ofono_emulator_enable(struct ofono_emulator *e, GIOChannel *channel)
 {
 	if (channel =3D=3D NULL)
@@ -734,6 +814,8 @@ int ofono_emulator_enable(struct ofono_emulator *e, GIO=
Channel *channel)
 	g_at_server_register(e->server, "+CGATT", cgatt_cb, e, NULL);
 	g_at_server_register(e->server, "+CGDCONT", cgdcont_cb, e, NULL);
 =

+	add_gprs_watches(e);
+
 	return 0;
 }
 =

@@ -761,6 +843,18 @@ static void emulator_remove(struct ofono_atom *atom)
 	if (e->server)
 		emulator_disable(e);
 =

+	if (e->gprs_watch) {
+		if (e->gprs_status_watch) {
+			__ofono_gprs_remove_status_watch(e->gprs,
+						e->gprs_status_watch);
+			e->gprs_status_watch =3D 0;
+		}
+
+		__ofono_modem_remove_atom_watch(e->modem, e->gprs_watch);
+		e->gprs_watch =3D 0;
+		e->gprs =3D NULL;
+	}
+
 	e->status =3D OFONO_EMULATOR_STATUS_DESTROY;
 	notify_status_watches(e, NULL);
 =

-- =

1.7.0.4


--===============8946776057575720249==--


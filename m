Content-Type: multipart/mixed; boundary="===============7238414342972069520=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 13/15] emulator: Watch netreg status changes
Date: Wed, 07 Jul 2010 18:01:50 +0800
Message-ID: <1278496912-13777-14-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278496912-13777-13-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7238414342972069520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Watch netreg status changes to notify DUN client any unsolicited result,
like +CREG status changes.
---
 src/emulator.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 3bb32ae..8cc83bb 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -72,6 +72,10 @@ struct ofono_emulator {
 	struct ofono_gprs *gprs;
 	unsigned int gprs_watch;
 	unsigned int gprs_status_watch;
+
+	struct ofono_netreg *netreg;
+	unsigned int netreg_watch;
+	unsigned int netreg_status_watch;
 };
 =

 static GSList *emulator_list;
@@ -783,6 +787,18 @@ static void emulator_remove(struct ofono_atom *atom)
 		e->gprs =3D NULL;
 	}
 =

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
+
 	__ofono_watchlist_free(e->status_watches);
 	ofono_emulator_release_id(e->id);
 	g_free(e);
@@ -810,6 +826,83 @@ void ofono_emulator_disable(struct ofono_emulator *e)
 	e->powered =3D FALSE;
 }
 =

+static void emulator_netreg_update(struct ofono_emulator *e)
+{
+	GAtServer *server =3D e->server;
+	char buf[256];
+
+	switch (e->modem_creg) {
+	case 0:
+		break;
+	case 1:
+		snprintf(buf, sizeof(buf), "+CREG: %d", e->netreg_status);
+		g_at_server_send_unsolicited(server, buf);
+		break;
+	case 2:
+		snprintf(buf, sizeof(buf), "+CREG: %d, %x, %x",
+				e->netreg_status, e->netreg_lac, e->netreg_ci);
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
+	e->netreg_status =3D status;
+	e->netreg_lac =3D lac;
+	e->netreg_ci =3D ci;
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
+	e->netreg_status =3D ofono_netreg_get_status(netreg);
+	e->netreg_lac =3D ofono_netreg_get_location(netreg);
+	e->netreg_ci =3D ofono_netreg_get_cellid(netreg);
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
 static void emulator_gprs_update(struct ofono_emulator *e)
 {
 	GAtServer *server =3D e->server;
@@ -930,6 +1023,7 @@ ofono_bool_t ofono_emulator_enable(struct ofono_emulat=
or *e, int fd)
 	g_at_server_register(e->server, "+CGDCONT", cgdcont_cb, e, NULL);
 =

 	add_gprs_watches(e);
+	add_netreg_watches(e);
 =

 	g_io_channel_unref(channel);
 =

-- =

1.6.3.3


--===============7238414342972069520==--


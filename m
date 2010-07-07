Content-Type: multipart/mixed; boundary="===============4136294669494352147=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 07/15] emulator: Add emulator status watches in netreg
Date: Wed, 07 Jul 2010 18:01:44 +0800
Message-ID: <1278496912-13777-8-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278496912-13777-7-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4136294669494352147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add dun_watch to watch emulator status update for netreg atom.
---
 src/network.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/src/network.c b/src/network.c
index c6410a8..b9f0a08 100644
--- a/src/network.c
+++ b/src/network.c
@@ -80,6 +80,9 @@ struct ofono_netreg {
 	GKeyFile *settings;
 	char *imsi;
 	struct ofono_watchlist *status_watches;
+	struct ofono_emulator *dun;
+	unsigned int dun_watch;
+	unsigned int dun_status_watch;
 	const struct ofono_netreg_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -1613,6 +1616,37 @@ const char *ofono_netreg_get_mnc(struct ofono_netreg=
 *netreg)
 	return netreg->current_operator->mnc;
 }
 =

+static void dun_status_watch(struct ofono_emulator *e,
+					enum ofono_emulator_status status,
+					void *data, void *user_data)
+{
+	if (e =3D=3D NULL)
+		return;
+
+	switch (status) {
+	default:
+		break;
+	}
+}
+
+static void dun_watch(struct ofono_atom *atom,
+					enum ofono_atom_watch_condition cond,
+					void *data)
+{
+	struct ofono_netreg *netreg =3D data;
+	struct ofono_emulator *e =3D __ofono_atom_get_data(atom);
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		netreg->dun_status_watch =3D 0;
+		netreg->dun =3D NULL;
+		return;
+	}
+
+	netreg->dun =3D e;
+	netreg->dun_status_watch =3D __ofono_emulator_add_status_watch(e,
+						dun_status_watch, netreg, NULL);
+}
+
 int ofono_netreg_driver_register(const struct ofono_netreg_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -1669,6 +1703,19 @@ static void netreg_unregister(struct ofono_atom *ato=
m)
 		netreg->settings =3D NULL;
 	}
 =

+	if (netreg->dun_watch) {
+		if (netreg->dun_status_watch) {
+			__ofono_emulator_remove_status_watch(netreg->dun,
+						netreg->dun_status_watch);
+			netreg->dun_status_watch =3D 0;
+			netreg->dun =3D NULL;
+		}
+
+		__ofono_modem_remove_atom_watch(modem, netreg->dun_watch);
+		netreg->dun_watch =3D 0;
+		netreg->dun =3D NULL;
+	}
+
 	g_dbus_unregister_interface(conn, path,
 					OFONO_NETWORK_REGISTRATION_INTERFACE);
 	ofono_modem_remove_interface(modem,
@@ -1773,6 +1820,7 @@ void ofono_netreg_register(struct ofono_netreg *netre=
g)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(netreg->atom);
 	const char *path =3D __ofono_atom_get_path(netreg->atom);
 	struct ofono_atom *sim_atom;
+	struct ofono_atom *dun_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_NETWORK_REGISTRATION_INTERFACE,
@@ -1809,6 +1857,16 @@ void ofono_netreg_register(struct ofono_netreg *netr=
eg)
 				sim_spn_read_cb, netreg);
 	}
 =

+	netreg->dun_watch =3D __ofono_modem_add_atom_watch(modem,
+						OFONO_ATOM_TYPE_EMULATOR_DUN,
+						dun_watch, netreg, NULL);
+
+	dun_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_EMULATOR_DUN);
+
+	if (dun_atom && __ofono_atom_get_registered(dun_atom))
+		dun_watch(dun_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
+						netreg);
+
 	__ofono_atom_register(netreg->atom, netreg_unregister);
 }
 =

-- =

1.6.3.3


--===============4136294669494352147==--


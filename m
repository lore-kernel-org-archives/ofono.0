Content-Type: multipart/mixed; boundary="===============5212922214534839486=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 08/21] emulator: Add emulator status watches in gprs atom
Date: Wed, 29 Sep 2010 17:44:48 +0800
Message-ID: <1285753501-7668-9-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1285753501-7668-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5212922214534839486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add dun_watch to watch emulator status update in gprs atom. So that gprs
atom could get notified when we get request to create new PPP connection
from DUN client;
---
 src/gprs.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 6e71b50..8d7fefc 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -83,6 +83,9 @@ struct ofono_gprs {
 	const struct ofono_gprs_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct ofono_emulator *dun;
+	unsigned int dun_watch;
+	unsigned int dun_status_watch;
 };
 =

 struct ofono_gprs_context {
@@ -1603,6 +1606,39 @@ void ofono_gprs_context_deactivated(struct ofono_gpr=
s_context *gc,
 	}
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
+	struct ofono_gprs *gprs =3D data;
+	struct ofono_emulator *e =3D __ofono_atom_get_data(atom);
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		gprs->dun_status_watch =3D 0;
+		gprs->dun =3D NULL;
+		return;
+	}
+
+	DBG("");
+
+	gprs->dun =3D e;
+	gprs->dun_status_watch =3D __ofono_emulator_add_status_watch(e,
+						dun_status_watch, gprs, NULL);
+}
+
 int ofono_gprs_context_driver_register(const struct ofono_gprs_context_dri=
ver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -1752,6 +1788,18 @@ static void gprs_unregister(struct ofono_atom *atom)
 		gprs->netreg =3D NULL;
 	}
 =

+	if (gprs->dun_watch) {
+		if (gprs->dun_status_watch) {
+			__ofono_emulator_remove_status_watch(gprs->dun,
+							gprs->dun_status_watch);
+			gprs->dun_status_watch =3D 0;
+		}
+
+		__ofono_modem_remove_atom_watch(modem, gprs->dun_watch);
+		gprs->dun_watch =3D 0;
+		gprs->dun =3D NULL;
+	}
+
 	ofono_modem_remove_interface(modem,
 					OFONO_CONNECTION_MANAGER_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
@@ -2028,6 +2076,7 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
 	struct ofono_atom *netreg_atom;
 	struct ofono_atom *sim_atom;
+	struct ofono_atom *dun_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CONNECTION_MANAGER_INTERFACE,
@@ -2064,6 +2113,17 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 		netreg_watch(netreg_atom,
 				OFONO_ATOM_WATCH_CONDITION_REGISTERED, gprs);
 =

+	gprs->dun_watch =3D __ofono_modem_add_atom_watch(modem,
+						OFONO_ATOM_TYPE_EMULATOR_DUN,
+						dun_watch, gprs, NULL);
+
+	dun_atom =3D __ofono_modem_find_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_DUN);
+
+	if (dun_atom && __ofono_atom_get_registered(dun_atom))
+		dun_watch(dun_atom,
+				OFONO_ATOM_WATCH_CONDITION_REGISTERED, gprs);
+
 	__ofono_atom_register(gprs->atom, gprs_unregister);
 }
 =

-- =

1.7.0.4


--===============5212922214534839486==--


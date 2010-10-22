Content-Type: multipart/mixed; boundary="===============5183046341141021662=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: [RFC PATCH 3/3] modem: emergency state handling added
Date: Fri, 22 Oct 2010 19:47:57 +0300
Message-ID: <a5e60a52de0f266919a33a46532c378e4c997f42.1287763218.git.andras.domokos@nokia.com>
In-Reply-To: <cover.1287763218.git.andras.domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5183046341141021662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Andras Domokos <andras.domokos@nokia.com>
---
 src/modem.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 9aeb49c..9e96cce 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -70,6 +70,8 @@ struct ofono_modem {
 	struct ofono_sim	*sim;
 	unsigned int		sim_watch;
 	unsigned int		sim_ready_watch;
+	unsigned int		voicecall_watch;
+	unsigned int		emergency_watch;
 	const struct ofono_modem_driver *driver;
 	void			*driver_data;
 	char			*driver_type;
@@ -544,6 +546,34 @@ ofono_bool_t ofono_modem_get_online(struct ofono_modem=
 *modem)
 	return modem->online;
 }
 =

+static void emergency_state_watch(ofono_bool_t state, void *data);
+static void voicecall_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct ofono_voicecall *vc;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		modem->emergency_watch =3D 0;
+		return;
+	}
+
+	vc =3D __ofono_atom_get_data(atom);
+	modem->emergency_watch =3D __ofono_voicecall_add_emergency_watch(vc,
+							emergency_state_watch,
+							modem, NULL);
+}
+
+static void emergency_state_watch(ofono_bool_t state, void *data)
+{
+	struct ofono_modem *modem =3D data;
+
+	DBG("Emergency mode is %s", state ? "On" : "Off");
+
+	if (state)
+			modem_change_state(modem, MODEM_STATE_ONLINE);
+}
+
 void __ofono_modem_append_properties(struct ofono_modem *modem,
 						DBusMessageIter *dict)
 {
@@ -1502,6 +1532,10 @@ int ofono_modem_register(struct ofono_modem *modem)
 					OFONO_ATOM_TYPE_SIM,
 					sim_watch, modem, NULL);
 =

+	modem->voicecall_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_VOICECALL,
+					voicecall_watch, modem, NULL);
+
 	return 0;
 }
 =

@@ -1531,6 +1565,9 @@ static void modem_unregister(struct ofono_modem *mode=
m)
 	modem->sim_watch =3D 0;
 	modem->sim_ready_watch =3D 0;
 =

+	modem->voicecall_watch =3D 0;
+	modem->emergency_watch =3D 0;
+
 	g_slist_foreach(modem->interface_list, (GFunc) g_free, NULL);
 	g_slist_free(modem->interface_list);
 	modem->interface_list =3D NULL;
-- =

1.7.0.4


--===============5183046341141021662==--


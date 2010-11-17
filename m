Content-Type: multipart/mixed; boundary="===============7172336546914637754=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/3] Add ofono_modem_reset()
Date: Wed, 17 Nov 2010 20:56:46 -0200
Message-ID: <1290034608-32307-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7172336546914637754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some modems can screw up everything and then we will need to do a silent
reset of the modem. This patch take the modem back to the OFFLINE state.
---
 include/modem.h |    2 ++
 src/modem.c     |   44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index 7b13ee0..a92eb88 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -46,6 +46,8 @@ int ofono_modem_register(struct ofono_modem *modem);
 ofono_bool_t ofono_modem_is_registered(struct ofono_modem *modem);
 void ofono_modem_remove(struct ofono_modem *modem);
 =

+void ofono_modem_reset(struct ofono_modem *modem);
+
 void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t power=
ed);
 ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem);
 =

diff --git a/src/modem.c b/src/modem.c
index 6d346c3..e57f8fc 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -70,6 +70,7 @@ struct ofono_modem {
 	guint			interface_update;
 	ofono_bool_t		powered;
 	ofono_bool_t		powered_pending;
+	ofono_bool_t		reset;
 	guint			timeout;
 	ofono_bool_t		online;
 	GHashTable		*properties;
@@ -433,6 +434,8 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *user)
 		if (modem->driver->set_online =3D=3D NULL)
 			modem_change_state(modem, MODEM_STATE_ONLINE);
 =

+		modem->reset =3D FALSE;
+
 		break;
 	}
 }
@@ -784,7 +787,8 @@ void ofono_modem_set_powered(struct ofono_modem *modem,=
 ofono_bool_t powered)
 		return;
 	}
 =

-	ofono_dbus_signal_property_changed(conn, modem->path,
+	if (!modem->reset)
+		ofono_dbus_signal_property_changed(conn, modem->path,
 					OFONO_MODEM_INTERFACE,
 					"Powered", DBUS_TYPE_BOOLEAN,
 					&dbus_powered);
@@ -799,6 +803,17 @@ void ofono_modem_set_powered(struct ofono_modem *modem=
, ofono_bool_t powered)
 	} else
 		modem_change_state(modem, MODEM_STATE_POWER_OFF);
 =

+	if (modem->reset && !powering_down) {
+		if (!modem->powered) {
+			int err =3D set_powered(modem, TRUE);
+
+			if (err =3D=3D -EINPROGRESS)
+				return;
+
+			modem_change_state(modem, MODEM_STATE_PRE_SIM);
+		}
+	}
+
 out:
 	if (powering_down && powered =3D=3D FALSE) {
 		modems_remaining -=3D 1;
@@ -806,6 +821,7 @@ out:
 		if (modems_remaining =3D=3D 0)
 			__ofono_exit();
 	}
+
 }
 =

 ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem)
@@ -1565,6 +1581,32 @@ void ofono_modem_remove(struct ofono_modem *modem)
 	g_free(modem);
 }
 =

+static gboolean __reset_modem(void *data)
+{
+	struct ofono_modem *modem =3D data;
+	int err;
+
+	modem->reset =3D TRUE;
+
+	err =3D set_powered(modem, FALSE);
+	if (err =3D=3D -EINPROGRESS)
+		return FALSE;
+
+	err =3D set_powered(modem, TRUE);
+	if (err =3D=3D -EINPROGRESS)
+		return FALSE;
+
+	modem_change_state(modem, MODEM_STATE_PRE_SIM);
+	return FALSE;
+}
+
+void ofono_modem_reset(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+
+	g_idle_add(__reset_modem, modem);
+}
+
 int ofono_modem_driver_register(const struct ofono_modem_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
-- =

1.7.3.1


--===============7172336546914637754==--


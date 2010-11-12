Content-Type: multipart/mixed; boundary="===============1455405896135668405=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [RFC 2/3] Add ofono_modem_reset()
Date: Fri, 12 Nov 2010 17:56:11 -0200
Message-ID: <1289591772-3256-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1289591772-3256-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1455405896135668405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some modems can screw up everything and then we will need to do a silent
reset of the modem. This patch take the modem back to the OFFLINE state.
---
 include/modem.h |    2 +
 src/modem.c     |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 2 files changed, 57 insertions(+), 2 deletions(-)

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
index 3fb6809..f6d7585 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -70,6 +70,7 @@ struct ofono_modem {
 	guint			interface_update;
 	ofono_bool_t		powered;
 	ofono_bool_t		powered_pending;
+	ofono_bool_t		reset_pending;
 	guint			timeout;
 	ofono_bool_t		online;
 	GHashTable		*properties;
@@ -784,7 +785,8 @@ void ofono_modem_set_powered(struct ofono_modem *modem,=
 ofono_bool_t powered)
 		return;
 	}
 =

-	ofono_dbus_signal_property_changed(conn, modem->path,
+	if (!modem->reset_pending)
+		ofono_dbus_signal_property_changed(conn, modem->path,
 					OFONO_MODEM_INTERFACE,
 					"Powered", DBUS_TYPE_BOOLEAN,
 					&dbus_powered);
@@ -799,14 +801,34 @@ void ofono_modem_set_powered(struct ofono_modem *mode=
m, ofono_bool_t powered)
 	} else
 		modem_change_state(modem, MODEM_STATE_POWER_OFF);
 =

-out:
+	if (modem->reset_pending && !powering_down) {
+		int err;
+
+		modem->reset_pending =3D FALSE;
+
+		if (modem->powered) {
+			modem_change_state(modem, MODEM_STATE_OFFLINE);
+		} else {
+			err =3D set_powered(modem, TRUE);
+			if (err =3D=3D -EINPROGRESS) {
+				modem->reset_pending =3D TRUE;
+				return;
+			}
+
+			modem_change_state(modem, MODEM_STATE_PRE_SIM);
+
+			modem_change_state(modem, MODEM_STATE_OFFLINE);
+		}
+	}
 =

+out:
 	if (powering_down && powered =3D=3D FALSE) {
 		modems_remaining -=3D 1;
 =

 		if (modems_remaining =3D=3D 0)
 			__ofono_exit();
 	}
+
 }
 =

 ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem)
@@ -1566,6 +1588,37 @@ void ofono_modem_remove(struct ofono_modem *modem)
 	g_free(modem);
 }
 =

+static gboolean __reset_modem(void *data)
+{
+	struct ofono_modem *modem =3D data;
+	int err;
+
+	err =3D set_powered(modem, FALSE);
+	if (err =3D=3D -EINPROGRESS) {
+		modem->reset_pending =3D TRUE;
+		return FALSE;
+	}
+
+	err =3D set_powered(modem, TRUE);
+	if (err =3D=3D -EINPROGRESS) {
+		modem->reset_pending =3D TRUE;
+		return FALSE;
+	}
+
+	modem_change_state(modem, MODEM_STATE_PRE_SIM);
+
+	modem_change_state(modem, MODEM_STATE_OFFLINE);
+
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


--===============1455405896135668405==--


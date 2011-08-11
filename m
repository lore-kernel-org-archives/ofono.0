Content-Type: multipart/mixed; boundary="===============3562284475885181937=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 1/2] modem: Change to online state when serial is set
Date: Thu, 11 Aug 2011 18:02:38 +0200
Message-ID: <1313078559-13780-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1313078559-13780-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3562284475885181937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For modems with no sim atom, we wait for serial reply to proceed post_sim.
Add API to get serial devinfo like it is done for imsi.
---
 include/devinfo.h |    2 ++
 src/modem.c       |   23 ++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/devinfo.h b/include/devinfo.h
index 5df1316..db1db67 100644
--- a/include/devinfo.h
+++ b/include/devinfo.h
@@ -61,6 +61,8 @@ void ofono_devinfo_remove(struct ofono_devinfo *info);
 void ofono_devinfo_set_data(struct ofono_devinfo *info, void *data);
 void *ofono_devinfo_get_data(struct ofono_devinfo *info);
 =

+const char *ofono_devinfo_get_serial(struct ofono_devinfo *info);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/modem.c b/src/modem.c
index 14c7a20..aa6b1c6 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -72,6 +72,7 @@ struct ofono_modem {
 	ofono_bool_t		powered_pending;
 	ofono_bool_t		get_online;
 	ofono_bool_t		lockdown;
+	ofono_bool_t		pending_post_sim;
 	char			*lock_owner;
 	guint			lock_watch;
 	guint			timeout;
@@ -1093,9 +1094,14 @@ static DBusMessage *modem_set_property(DBusConnectio=
n *conn,
 		if (powered) {
 			modem_change_state(modem, MODEM_STATE_PRE_SIM);
 =

-			/* Force SIM Ready for devies with no sim atom */
+			/*
+			 * Force SIM Ready for devices with no sim atom
+			 * Pratically, it concerns CDMA modems. We need to
+			 * check if their serial is set before proceeding
+			 * post_sim.
+			 */
 			if (modem_has_sim(modem) =3D=3D FALSE)
-				sim_state_watch(OFONO_SIM_STATE_READY, modem);
+				modem->pending_post_sim =3D TRUE;
 		} else {
 			set_online(modem, FALSE);
 			modem_change_state(modem, MODEM_STATE_POWER_OFF);
@@ -1175,7 +1181,7 @@ void ofono_modem_set_powered(struct ofono_modem *mode=
m, ofono_bool_t powered)
 =

 		/* Force SIM Ready for devices with no sim atom */
 		if (modem_has_sim(modem) =3D=3D FALSE)
-			sim_state_watch(OFONO_SIM_STATE_READY, modem);
+			modem->pending_post_sim =3D TRUE;
 	} else {
 		set_online(modem, FALSE);
 =

@@ -1315,18 +1321,29 @@ void ofono_modem_remove_interface(struct ofono_mode=
m *modem,
 	modem->interface_update =3D g_idle_add(trigger_interface_update, modem);
 }
 =

+const char *ofono_devinfo_get_serial(struct ofono_devinfo *info)
+{
+	return info->serial;
+}
+
 static void query_serial_cb(const struct ofono_error *error,
 				const char *serial, void *user)
 {
 	struct ofono_devinfo *info =3D user;
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(info->atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(info->atom);
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
 		return;
 =

 	info->serial =3D g_strdup(serial);
 =

+	if (modem->pending_post_sim =3D=3D TRUE) {
+		modem->pending_post_sim =3D FALSE;
+		sim_state_watch(OFONO_SIM_STATE_READY, modem);
+	}
+
 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_MODEM_INTERFACE,
 						"Serial", DBUS_TYPE_STRING,
-- =

1.7.1


--===============3562284475885181937==--


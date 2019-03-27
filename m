Content-Type: multipart/mixed; boundary="===============5342504361132663085=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 4/6] sim: handling of dual sim single active feature
Date: Wed, 27 Mar 2019 17:40:37 +0530
Message-ID: <1553688637-24476-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5342504361132663085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added implementation for handling CardSlotCount and ActiveCardSlot
properties for DSSA use case.
---
 src/sim.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 74 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index c6ea4b0..2647d40 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -131,6 +131,10 @@ struct ofono_sim {
 	struct ofono_atom *atom;
 	unsigned int hfp_watch;
 =

+	unsigned int card_slot_num;
+	unsigned int active_card_slot;
+	unsigned int pending_active_card_slot;
+
 	GSList *aid_sessions;
 	GSList *aid_list;
 	char *impi;
@@ -473,6 +477,13 @@ static DBusMessage *sim_get_properties(DBusConnection =
*conn,
 	get_pin_retries(sim, &pin_retries_dict, &dbus_retries);
 	ofono_dbus_dict_append_dict(&dict, "Retries", DBUS_TYPE_BYTE,
 							&pin_retries_dict);
+
+	ofono_dbus_dict_append(&dict, "CardSlotCount", DBUS_TYPE_UINT32,
+							&sim->card_slot_num);
+
+	ofono_dbus_dict_append(&dict, "ActiveCardSlot", DBUS_TYPE_UINT32,
+							&sim->active_card_slot);
+
 	g_free(pin_retries_dict);
 	g_free(dbus_retries);
 =

@@ -657,6 +668,28 @@ static gboolean set_own_numbers(struct ofono_sim *sim,
 	return TRUE;
 }
 =

+static void sim_set_slot_callback(const struct ofono_error *error, void *d=
ata)
+{
+	struct ofono_sim *sim =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error setting radio access mode");
+
+		sim->pending_active_card_slot =3D sim->active_card_slot;
+
+		reply =3D __ofono_error_failed(sim->pending);
+		__ofono_dbus_pending_reply(&sim->pending, reply);
+
+		return;
+	}
+
+	sim->active_card_slot =3D sim->pending_active_card_slot;
+
+	reply =3D dbus_message_new_method_return(sim->pending);
+	__ofono_dbus_pending_reply(&sim->pending, reply);
+}
+
 static DBusMessage *sim_set_property(DBusConnection *conn, DBusMessage *ms=
g,
 					void *data)
 {
@@ -724,6 +757,36 @@ error:
 =

 		if (set_ok)
 			return NULL;
+		} else if (!strcmp(name, "ActiveCardSlot")) {
+		dbus_uint32_t value;
+
+		dbus_message_iter_next(&iter);
+
+		if (sim->driver->set_active_sim =3D=3D NULL)
+			return __ofono_error_not_implemented(msg);
+
+		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_recurse(&iter, &var);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_UINT32)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (value <=3D 0 || value > sim->card_slot_num)
+			return __ofono_error_invalid_args(msg);
+
+		if (sim->active_card_slot =3D=3D value)
+			return dbus_message_new_method_return(msg);
+
+		sim->pending =3D dbus_message_ref(msg);
+		sim->pending_active_card_slot =3D value;
+
+		sim->driver->set_active_sim(sim, (value-1), sim_set_slot_callback, sim);
+		/* will be saved in simmanager on success response*/
+		return NULL;
 	}
 =

 	return __ofono_error_invalid_args(msg);
@@ -3803,3 +3866,14 @@ int ofono_sim_logical_access(struct ofono_sim *sim, =
int session_id,
 =

 	return 0;
 }
+
+void ofono_sim_set_card_slot_num(struct ofono_sim *sim, unsigned int val)
+{
+	sim->card_slot_num =3D val;
+}
+
+void ofono_sim_set_active_card_slot_num(struct ofono_sim *sim, unsigned in=
t val)
+{
+	sim->active_card_slot =3D val;
+}
+
-- =

1.9.1


--===============5342504361132663085==--


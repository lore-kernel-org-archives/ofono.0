Content-Type: multipart/mixed; boundary="===============1394802427521670744=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 4/6] sim: add PinRetries property
Date: Tue, 14 Dec 2010 23:36:30 -0200
Message-ID: <1292376992-1888-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1292376992-1888-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1394802427521670744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 6217a25..8c05900 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -62,6 +62,8 @@ struct ofono_sim {
 	enum ofono_sim_password_type pin_type;
 	gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /* Number of PINs */
 =

+	unsigned char pin_retries;
+
 	enum ofono_sim_phase phase;
 	unsigned char mnc_length;
 	enum ofono_sim_cphs_phase cphs_phase;
@@ -369,6 +371,9 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 				DBUS_TYPE_STRING,
 				(void *) &pin_name);
 =

+	ofono_dbus_dict_append(&dict, "PinRetries",
+				DBUS_TYPE_BYTE, &sim->pin_retries);
+
 done:
 	dbus_message_iter_close_container(&iter, &dict);
 =

@@ -1560,6 +1565,28 @@ static void sim_initialize_after_pin(struct ofono_si=
m *sim)
 			sim_cphs_information_read_cb, sim);
 }
 =

+static void sim_retry_counter_query_cb(const struct ofono_error *error,
+					int retry, void *data)
+{
+	struct ofono_sim *sim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Querying PIN Retry Counter failed");
+
+		return;
+	}
+
+	if (sim->pin_retries !=3D retry) {
+		sim->pin_retries =3D retry;
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"PinRetries", DBUS_TYPE_BYTE,
+						&retry);
+	}
+}
+
 static void sim_pin_query_cb(const struct ofono_error *error,
 				enum ofono_sim_password_type pin_type,
 				void *data)
@@ -1592,6 +1619,11 @@ static void sim_pin_query_cb(const struct ofono_erro=
r *error,
 						&pin_name);
 	}
 =

+	if (sim->driver->query_retry_counter !=3D NULL) {
+		sim->driver->query_retry_counter(sim,
+					sim_retry_counter_query_cb, sim);
+	}
+
 checkdone:
 	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
 		sim_initialize_after_pin(sim);
-- =

1.7.3.3


--===============1394802427521670744==--


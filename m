Content-Type: multipart/mixed; boundary="===============2489632788338731089=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] sim: add sim_ready_notify function
Date: Thu, 26 Aug 2010 12:17:58 -0500
Message-ID: <1282843078-7763-1-git-send-email-denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2489632788338731089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    1 +
 src/sim.c     |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 36a99b9..3d8bec5 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -186,6 +186,7 @@ void ofono_sim_remove_state_watch(struct ofono_sim *sim=
, unsigned int id);
 enum ofono_sim_state ofono_sim_get_state(struct ofono_sim *sim);
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d);
+void ofono_sim_ready_notify(struct ofono_sim *sim);
 =

 /* This will queue an operation to read all available records with id from=
 the
  * SIM.  Callback cb will be called every time a record has been read, or =
once
diff --git a/src/sim.c b/src/sim.c
index 04a708b..9c22744 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -48,6 +48,8 @@
 #define SIM_CACHE_PATH_LEN(imsilen) (strlen(SIM_CACHE_PATH) - 3 + imsilen)
 #define SIM_CACHE_HEADER_SIZE 6
 =

+#define SIM_FLAG_WAIT_FOR_READY 0x1
+
 static GSList *g_drivers =3D NULL;
 =

 static gboolean sim_op_next(gpointer user_data);
@@ -99,6 +101,7 @@ struct ofono_sim {
 	unsigned char efust_length;
 	unsigned char *efest;
 	unsigned char efest_length;
+	int flags;
 };
 =

 struct msisdn_set_request {
@@ -694,6 +697,9 @@ static void sim_enter_pin_cb(const struct ofono_error *=
error, void *data)
 =

 	__ofono_dbus_pending_reply(&sim->pending, reply);
 =

+	if (sim->flags & SIM_FLAG_WAIT_FOR_READY)
+		return;
+
 	sim_pin_check(sim);
 }
 =

@@ -724,6 +730,9 @@ static DBusMessage *sim_enter_pin(DBusConnection *conn,=
 DBusMessage *msg,
 	if (!is_valid_pin(pin, PIN_TYPE_PIN))
 		return __ofono_error_invalid_format(msg);
 =

+	if (type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN)
+		sim->flags |=3D SIM_FLAG_WAIT_FOR_READY;
+
 	sim->pending =3D dbus_message_ref(msg);
 	sim->driver->send_passwd(sim, pin, sim_enter_pin_cb, sim);
 =

@@ -762,6 +771,9 @@ static DBusMessage *sim_reset_pin(DBusConnection *conn,=
 DBusMessage *msg,
 	if (!is_valid_pin(pin, PIN_TYPE_PIN))
 		return __ofono_error_invalid_format(msg);
 =

+	if (type =3D=3D OFONO_SIM_PASSWORD_SIM_PUK)
+		sim->flags |=3D SIM_FLAG_WAIT_FOR_READY;
+
 	sim->pending =3D dbus_message_ref(msg);
 	sim->driver->reset_passwd(sim, puk, pin, sim_enter_pin_cb, sim);
 =

@@ -2002,6 +2014,7 @@ static void sim_free_state(struct ofono_sim *sim)
 	}
 =

 	sim->mnc_length =3D 0;
+	sim->flags =3D 0;
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
@@ -2034,6 +2047,15 @@ void ofono_sim_inserted_notify(struct ofono_sim *sim=
, ofono_bool_t inserted)
 		sim_free_state(sim);
 }
 =

+void ofono_sim_ready_notify(struct ofono_sim *sim)
+{
+	if (!(sim->flags & SIM_FLAG_WAIT_FOR_READY))
+		return;
+
+	sim->flags &=3D ~SIM_FLAG_WAIT_FOR_READY;
+	sim_pin_check(sim);
+}
+
 unsigned int ofono_sim_add_state_watch(struct ofono_sim *sim,
 				ofono_sim_state_event_notify_cb_t notify,
 				void *data, ofono_destroy_func destroy)
-- =

1.7.0.4


--===============2489632788338731089==--


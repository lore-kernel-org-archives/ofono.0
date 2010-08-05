Content-Type: multipart/mixed; boundary="===============5075819935407265519=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 6/7] sim: implement GetIcon dbus interface
Date: Thu, 05 Aug 2010 14:32:39 -0700
Message-ID: <1281043960-9616-7-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1281043960-9616-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5075819935407265519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index e19fb06..2b0b20e 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -731,6 +731,50 @@ static DBusMessage *sim_enter_pin(DBusConnection *conn=
, DBusMessage *msg,
 	return NULL;
 }
 =

+static void ofono_sim_get_image_cb(int ok, const char *xpm, int xpm_len,
+					void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+	DBusMessage *reply;
+
+	if (!ok)
+		reply =3D __ofono_error_failed(sim->pending);
+	else {
+		reply =3D dbus_message_new_method_return(sim->pending);
+		dbus_message_append_args(reply, DBUS_TYPE_STRING, &xpm,
+					DBUS_TYPE_INVALID);
+	}
+
+	__ofono_dbus_pending_reply(&sim->pending, reply);
+}
+
+static DBusMessage *sim_get_icon(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_sim *sim =3D data;
+	int id;
+
+	/*
+	 * change the arg to be a byte
+	 * Question: does the icon id start at zero or 1?
+	 */
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_INT32, &id,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (sim->pending)
+		return __ofono_error_busy(msg);
+
+	if (sim->efimg =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	sim->pending =3D dbus_message_ref(msg);
+
+	ofono_sim_get_image(sim, id, ofono_sim_get_image_cb, sim);
+
+	return NULL;
+}
+
 static DBusMessage *sim_reset_pin(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -783,6 +827,8 @@ static GDBusMethodTable sim_methods[] =3D {
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "UnlockPin",		"ss",	"",		sim_unlock_pin,
 							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetIcon",		"i",	"",		sim_get_icon,
+							G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

-- =

1.7.1.1


--===============5075819935407265519==--


Content-Type: multipart/mixed; boundary="===============3639173122011438561=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] sim: Check SIM pin status after changing pin.
Date: Tue, 02 Nov 2010 16:08:42 +0100
Message-ID: <1288710522-10153-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3639173122011438561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

When changing pin, it is possible to get in a state where the modem request=
s puk =

(if incorrect pin is entered too many times). Need to check the SIM pin sta=
tus =

to discover this.
---
 src/sim.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 699ebe9..b2277c5 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -628,15 +628,16 @@ static DBusMessage *sim_unlock_pin(DBusConnection *co=
nn, DBusMessage *msg,
 static void sim_change_pin_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_sim *sim =3D data;
+	DBusMessage *reply;
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		__ofono_dbus_pending_reply(&sim->pending,
-				__ofono_error_failed(sim->pending));
-		return;
-	}
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D __ofono_error_failed(sim->pending);
+	else
+		reply =3D dbus_message_new_method_return(sim->pending);
 =

-	__ofono_dbus_pending_reply(&sim->pending,
-				dbus_message_new_method_return(sim->pending));
+	__ofono_dbus_pending_reply(&sim->pending, reply);
+
+	sim_pin_check(sim);
 }
 =

 static DBusMessage *sim_change_pin(DBusConnection *conn, DBusMessage *msg,
-- =

1.7.0.4


--===============3639173122011438561==--


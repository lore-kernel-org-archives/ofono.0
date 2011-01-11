Content-Type: multipart/mixed; boundary="===============2430189775842444723=="
MIME-Version: 1.0
From: Jussi.Kangas@tieto.com
Subject: [PATCH] sim: check if lock is locked after code changing attempt
Date: Tue, 11 Jan 2011 14:17:13 +0200
Message-ID: <20A4FB08D632914F9C09B9F05CBDF258192D753024@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2430189775842444723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This is fix to Marit Henriksen's TODO item "Check SIM pin status if sim_cha=
nge_pin fails". I've discussed with Marit and it's ok for her if I fix the =
issue. Problem here is that issue could perhaps also be fixed with retry co=
unter solution introduced by Lucas De Marchi couple of tasks ago. That woul=
d seem however require some extra implementation in ste modem ( at least I =
was not able get the ofono show correct values without extra modifications =
) and I think that isimodems don't have that sort of retry counter at all. =
Because of that and since I had this solution already implemented I propose=
 it to be added as well. =


Br,
-Jussi

---
 src/sim.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d627647..789ddde 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -712,8 +712,60 @@ static DBusMessage *sim_unlock_pin(DBusConnection *con=
n, DBusMessage *msg,
 static void sim_change_pin_cb(const struct ofono_error *error, void *data)
 {
     struct ofono_sim *sim =3D data;
+    DBusConnection *conn =3D ofono_dbus_get_connection();
+    const char *path =3D __ofono_atom_get_path(sim->atom);
+    struct ofono_modem *modem =3D __ofono_atom_get_modem(sim->atom);
+    const char *pin_name;
 =

     if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+        if (error->error =3D=3D 12) {
+            sim->locked_pins[sim->pin_type] =3D TRUE;
+            switch (sim->pin_type) {
+            case OFONO_SIM_PASSWORD_SIM_PIN:
+                sim->pin_type =3D OFONO_SIM_PASSWORD_SIM_PUK;
+                pin_name =3D sim_passwd_name(
+                    OFONO_SIM_PASSWORD_SIM_PUK);
+                break;
+            case OFONO_SIM_PASSWORD_PHFSIM_PIN:
+                sim->pin_type =3D OFONO_SIM_PASSWORD_PHFSIM_PUK;
+                pin_name =3D sim_passwd_name(
+                    OFONO_SIM_PASSWORD_PHFSIM_PUK);
+                break;
+            case OFONO_SIM_PASSWORD_PHCORP_PIN:
+                sim->pin_type =3D OFONO_SIM_PASSWORD_PHCORP_PUK;
+                pin_name =3D sim_passwd_name(
+                    OFONO_SIM_PASSWORD_PHCORP_PUK);
+                break;
+            case OFONO_SIM_PASSWORD_PHNET_PIN:
+                sim->pin_type =3D OFONO_SIM_PASSWORD_PHNET_PUK;
+                pin_name =3D sim_passwd_name(
+                        OFONO_SIM_PASSWORD_PHNET_PUK);
+            case OFONO_SIM_PASSWORD_PHNETSUB_PIN:
+                sim->pin_type =3D OFONO_SIM_PASSWORD_PHNETSUB_PUK;
+                pin_name =3D sim_passwd_name(
+                    OFONO_SIM_PASSWORD_PHNETSUB_PUK);
+                break;
+            case OFONO_SIM_PASSWORD_PHSP_PIN:
+                sim->pin_type =3D OFONO_SIM_PASSWORD_PHSP_PUK;
+                pin_name =3D sim_passwd_name(
+                    OFONO_SIM_PASSWORD_PHSP_PUK);
+                break;
+            case OFONO_SIM_PASSWORD_SIM_PIN2:
+                sim->pin_type =3D OFONO_SIM_PASSWORD_SIM_PUK2;
+                pin_name =3D sim_passwd_name(
+                    OFONO_SIM_PASSWORD_SIM_PUK2);
+                break;
+            default:
+                break;
+            }
+            ofono_dbus_signal_property_changed(conn, path,
+                OFONO_SIM_MANAGER_INTERFACE,
+                "PinRequired", DBUS_TYPE_STRING,
+                &pin_name);
+
+            if (sim->pin_type !=3D OFONO_SIM_PASSWORD_SIM_PUK2)
+                ofono_modem_reset(modem);
+        }
         __ofono_dbus_pending_reply(&sim->pending,
                 __ofono_error_failed(sim->pending));
 =

@@ -722,6 +774,7 @@ static void sim_change_pin_cb(const struct ofono_error =
*error, void *data)
         return;
     }
 =

+    sim->pin_type =3D OFONO_SIM_PASSWORD_NONE;
     __ofono_dbus_pending_reply(&sim->pending,
                 dbus_message_new_method_return(sim->pending));
 =

@@ -764,6 +817,7 @@ static DBusMessage *sim_change_pin(DBusConnection *conn=
, DBusMessage *msg,
         return dbus_message_new_method_return(msg);
 =

     sim->pending =3D dbus_message_ref(msg);
+    sim->pin_type =3D type;
     sim->driver->change_passwd(sim, type, old, new,
                     sim_change_pin_cb, sim);
 =

-- =

1.7.1


--===============2430189775842444723==--


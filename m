Content-Type: multipart/mixed; boundary="===============0207673665710242163=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 15/24] sim: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:07 +0000
Message-ID: <1461330601-21333-16-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-15-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0207673665710242163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/sim.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index bcf5afd..94d8840 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -321,8 +321,9 @@ static char **get_service_numbers(GSList *service_numbe=
rs)
 	return ret;
 }
 =

-static void service_number_free(struct service_number *num)
+static void service_number_free(gpointer pointer)
 {
+	struct service_number *num =3D pointer;
 	g_free(num->id);
 	g_free(num);
 }
@@ -615,8 +616,7 @@ static DBusMessage *sim_set_property(DBusConnection *co=
nn, DBusMessage *msg,
 		set_ok =3D set_own_numbers(sim, own_numbers, msg);
 =

 error:
-		g_slist_foreach(own_numbers, (GFunc) g_free, 0);
-		g_slist_free(own_numbers);
+		g_slist_free_full(own_numbers, g_free);
 =

 		if (set_ok)
 			return NULL;
@@ -1195,8 +1195,7 @@ check:
 		char **own_numbers;
 		DBusConnection *conn =3D ofono_dbus_get_connection();
 =

-		g_slist_foreach(sim->own_numbers, (GFunc) g_free, NULL);
-		g_slist_free(sim->own_numbers);
+		g_slist_free_full(sim->own_numbers, g_free);
 		sim->own_numbers =3D sim->new_numbers;
 =

 		own_numbers =3D get_own_numbers(sim->own_numbers);
@@ -1208,8 +1207,7 @@ check:
 =

 		g_strfreev(own_numbers);
 	} else {
-		g_slist_foreach(sim->new_numbers, (GFunc) g_free, NULL);
-		g_slist_free(sim->new_numbers);
+		g_slist_free_full(sim->new_numbers, g_free);
 	}
 =

 	sim->new_numbers =3D NULL;
@@ -1302,9 +1300,7 @@ static void sim_service_numbers_changed(int id, void =
*userdata)
 	struct ofono_sim *sim =3D userdata;
 =

 	if (sim->service_numbers) {
-		g_slist_foreach(sim->service_numbers,
-				(GFunc)service_number_free, NULL);
-		g_slist_free(sim->service_numbers);
+		g_slist_free_full(sim->service_numbers, service_number_free);
 		sim->service_numbers =3D NULL;
 	}
 =

@@ -2025,13 +2021,11 @@ skip_efpl:
 	}
 =

 	if (efli) {
-		g_slist_foreach(efli, (GFunc)g_free, NULL);
-		g_slist_free(efli);
+		g_slist_free_full(efli, g_free);
 	}
 =

 	if (efpl) {
-		g_slist_foreach(efpl, (GFunc)g_free, NULL);
-		g_slist_free(efpl);
+		g_slist_free_full(efpl, g_free);
 	}
 =

 	if (sim->language_prefs !=3D NULL)
@@ -2394,15 +2388,12 @@ static void sim_free_main_state(struct ofono_sim *s=
im)
 	sim->mnc[0] =3D '\0';
 =

 	if (sim->own_numbers) {
-		g_slist_foreach(sim->own_numbers, (GFunc)g_free, NULL);
-		g_slist_free(sim->own_numbers);
+		g_slist_free_full(sim->own_numbers, g_free);
 		sim->own_numbers =3D NULL;
 	}
 =

 	if (sim->service_numbers) {
-		g_slist_foreach(sim->service_numbers,
-				(GFunc)service_number_free, NULL);
-		g_slist_free(sim->service_numbers);
+		g_slist_free_full(sim->service_numbers, service_number_free);
 		sim->service_numbers =3D NULL;
 		sim->sdn_ready =3D FALSE;
 	}
-- =

1.9.1

--===============0207673665710242163==--


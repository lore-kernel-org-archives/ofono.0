Content-Type: multipart/mixed; boundary="===============6886332003944699182=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 5/6] simauth: remove driver code from core simauth atom
Date: Thu, 09 Nov 2017 09:17:11 -0800
Message-ID: <1510247832-19632-5-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1510247832-19632-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6886332003944699182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim-auth.c | 48 +++++-------------------------------------------
 1 file changed, 5 insertions(+), 43 deletions(-)

diff --git a/src/sim-auth.c b/src/sim-auth.c
index f5ae7b6..0567771 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -39,8 +39,6 @@
 =

 #define SIM_AUTH_MAX_RANDS	3
 =

-static GSList *g_drivers =3D NULL;
-
 /*
  * Temporary handle used for the command authentication sequence.
  */
@@ -136,25 +134,6 @@ static void free_apps(struct ofono_sim_auth *sa)
 	g_slist_free(sa->aid_objects);
 }
 =

-int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *d)
-{
-	DBG("driver: %p, name: %s", d, d->name);
-
-	if (d->probe =3D=3D NULL)
-		return -EINVAL;
-
-	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
-
-	return 0;
-}
-
-void ofono_sim_auth_driver_unregister(const struct ofono_sim_auth_driver *=
d)
-{
-	DBG("driver: %p, name: %s", d, d->name);
-
-	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
-}
-
 static void sim_auth_unregister(struct ofono_atom *atom)
 {
 	struct ofono_sim_auth *sa =3D __ofono_atom_get_data(atom);
@@ -173,21 +152,15 @@ static void sim_auth_remove(struct ofono_atom *atom)
 	if (sa =3D=3D NULL)
 		return;
 =

-	if (sa->driver && sa->driver->remove)
-		sa->driver->remove(sa);
-
 	g_free(sa);
 }
 =

+static void sim_auth_register(struct ofono_sim_auth *sa);
+
 struct ofono_sim_auth *ofono_sim_auth_create(struct ofono_modem *modem,
-						unsigned int vendor,
-						const char *driver, void *data)
+		void *data)
 {
 	struct ofono_sim_auth *sa;
-	GSList *l;
-
-	if (driver =3D=3D NULL)
-		return NULL;
 =

 	sa =3D g_new0(struct ofono_sim_auth, 1);
 =

@@ -197,18 +170,7 @@ struct ofono_sim_auth *ofono_sim_auth_create(struct of=
ono_modem *modem,
 	sa->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_SIM_AUTH,
 						sim_auth_remove, sa);
 =

-	for (l =3D g_drivers; l; l =3D l->next) {
-		const struct ofono_sim_auth_driver *drv =3D l->data;
-
-		if (g_strcmp0(drv->name, driver))
-			continue;
-
-		if (drv->probe(sa, vendor, data) < 0)
-			continue;
-
-		sa->driver =3D drv;
-		break;
-	}
+	sim_auth_register(sa);
 =

 	return sa;
 }
@@ -725,7 +687,7 @@ static char *build_nai(const char *imsi)
 	return nai;
 }
 =

-void ofono_sim_auth_register(struct ofono_sim_auth *sa)
+static void sim_auth_register(struct ofono_sim_auth *sa)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(sa->atom);
-- =

2.7.4


--===============6886332003944699182==--


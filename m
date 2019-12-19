Content-Type: multipart/mixed; boundary="===============7727990830730544511=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] sim: handling crash in error scenario for SIM PIN query
Date: Thu, 19 Dec 2019 18:27:49 +0530
Message-ID: <1576760269-30981-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7727990830730544511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of error in sim_pin_query_cb function. pin_type is set
to -1. This is causing segmentation fault in function
sim_passwd_name due to invalid index pin_type =3D -1. Fixing this
issue by handling error case before calling sim_passwd_name
function.
---
 src/sim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/sim.c b/src/sim.c
index 535ccbc..33e1245 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -3201,7 +3201,7 @@ static void sim_pin_query_cb(const struct ofono_error=
 *error,
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(sim->atom);
 	struct cached_pin *cpins =3D pin_cache_lookup(sim->iccid);
-	const char *pin_name =3D sim_passwd_name(pin_type);
+	const char *pin_name;
 	char **locked_pins;
 	gboolean lock_changed;
 =

@@ -3212,6 +3212,8 @@ static void sim_pin_query_cb(const struct ofono_error=
 *error,
 		return;
 	}
 =

+	pin_name =3D sim_passwd_name(pin_type);
+
 	if (sim->pin_type !=3D pin_type) {
 		sim->pin_type =3D pin_type;
 =

-- =

1.9.1

--===============7727990830730544511==--


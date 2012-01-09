Content-Type: multipart/mixed; boundary="===============7607218324004415948=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 1/4] sim: Minor style fixes
Date: Mon, 09 Jan 2012 12:30:41 +0200
Message-ID: <1326105044-26408-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1326105044-26408-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7607218324004415948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index ceead1e..4ef14e3 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -46,10 +46,6 @@
 #include "simfs.h"
 #include "stkutil.h"
 =

-static GSList *g_drivers =3D NULL;
-
-static void sim_own_numbers_update(struct ofono_sim *sim);
-
 struct ofono_sim {
 	/* Contents of the SIM file system, in rough initialization order */
 	char *iccid;
@@ -140,6 +136,10 @@ static const char *const passwd_name[] =3D {
 	[OFONO_SIM_PASSWORD_PHCORP_PUK] =3D "corppuk",
 };
 =

+static void sim_own_numbers_update(struct ofono_sim *sim);
+
+static GSList *g_drivers =3D NULL;
+
 static const char *sim_passwd_name(enum ofono_sim_password_type type)
 {
 	return passwd_name[type];
@@ -1057,21 +1057,21 @@ static DBusMessage *sim_reset_pin(DBusConnection *c=
onn, DBusMessage *msg,
 }
 =

 static GDBusMethodTable sim_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	sim_get_properties	},
+	{ "GetProperties",	"",	"a{sv}",	sim_get_properties },
 	{ "SetProperty",	"sv",	"",		sim_set_property,
-							G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "ChangePin",		"sss",	"",		sim_change_pin,
-							G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "EnterPin",		"ss",	"",		sim_enter_pin,
-							G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "ResetPin",		"sss",	"",		sim_reset_pin,
-							G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "LockPin",		"ss",	"",		sim_lock_pin,
-							G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "UnlockPin",		"ss",	"",		sim_unlock_pin,
-							G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetIcon",		"y",	"ay",		sim_get_icon,
-							G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

-- =

1.7.5.4


--===============7607218324004415948==--


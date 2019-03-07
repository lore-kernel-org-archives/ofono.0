Content-Type: multipart/mixed; boundary="===============3793312911218293231=="
MIME-Version: 1.0
From: Anirudh Gargi <anirudh.gargi@intel.com>
Subject: [PATCH 1/1] sim: fix segfault in sim atom
Date: Thu, 07 Mar 2019 10:53:38 +0530
Message-ID: <1551936218-4164-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3793312911218293231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While adding the sim pin cache feature, pin_name could cause issue in
cases when sim pin is not there.

log:
ofonod[27810]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[27810]: src/sim.c:sim_pin_query_cb() sim->pin_type: 0, pin_type: 0
ofonod[27810]: Aborting (signal 11) [./src/ofonod]
ofonod[27810]: ++++++++ backtrace ++++++++
ofonod[27810]: #0  0x7fb7a7586cb0 in /lib/x86_64-linux-gnu/libc.so.6
ofonod[27810]: #1  0x7fb7a7693cd8 in /lib/x86_64-linux-gnu/libc.so.6
ofonod[27810]: #2  0x4d899b in sim_pin_query_cb() at src/sim.c:3174
ofonod[27810]: #3  0x4649e7 in at_cpin_cb() at drivers/atmodem/sim.c:1304
ofonod[27810]: #4  0x4a5d70 in at_chat_finish_command() at gatchat/gatchat.=
c:462
---
 src/sim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 104ddd1..c6ea4b0 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -3127,7 +3127,7 @@ static void sim_pin_query_cb(const struct ofono_error=
 *error,
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(sim->atom);
 	struct cached_pin *cpins =3D pin_cache_lookup(sim->iccid);
-	const char *pin_name;
+	const char *pin_name =3D sim_passwd_name(pin_type);
 	char **locked_pins;
 	gboolean lock_changed;
 =

@@ -3140,7 +3140,6 @@ static void sim_pin_query_cb(const struct ofono_error=
 *error,
 =

 	if (sim->pin_type !=3D pin_type) {
 		sim->pin_type =3D pin_type;
-		pin_name =3D sim_passwd_name(pin_type);
 =

 		if (pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
 				password_is_pin(pin_type) =3D=3D FALSE)
-- =

2.7.4


--===============3793312911218293231==--


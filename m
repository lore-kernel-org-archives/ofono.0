Content-Type: multipart/mixed; boundary="===============5560840561297115255=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH] Accept opaque data in EF_ICCID.
Date: Fri, 21 May 2010 18:56:35 +0300
Message-ID: <1274457395-14574-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5560840561297115255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index c1c8340..1f4b944 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1304,13 +1304,21 @@ static void sim_iccid_read_cb(int ok, int length, i=
nt record,
 	struct ofono_sim *sim =3D userdata;
 	const char *path =3D __ofono_atom_get_path(sim->atom);
 	DBusConnection *conn =3D ofono_dbus_get_connection();
-	char iccid[21]; /* ICCID max length is 20 + 1 for NULL */
+	char iccid[21]; /* ICCID max length is 20 + 1 for NUL */
+	int i;
 =

 	if (!ok || length < 10)
 		return;
 =

-	extract_bcd_number(data, length, iccid);
-	iccid[20] =3D '\0';
+	for (i =3D 0; i < 10; i++) {
+		unsigned char b =3D data[i];
+		sprintf(iccid + 2 * i, "%x%x", b & 0xf, b >> 4);
+	}
+
+	for (i =3D 20; i > 0 && iccid[i - 1] =3D=3D 'f'; i--)
+		;
+	iccid[i] =3D '\0';
+
 	sim->iccid =3D g_strdup(iccid);
 =

 	ofono_dbus_signal_property_changed(conn, path,
-- =

1.6.3.3


--===============5560840561297115255==--


Content-Type: multipart/mixed; boundary="===============0386243824318869003=="
MIME-Version: 1.0
From: Andre Matos <andre.matos.ste@gmail.com>
Subject: [PATCH] voicecall: fix transfer
Date: Mon, 07 Feb 2011 12:56:53 +0100
Message-ID: <1297079813-26573-1-git-send-email-andre.matos.ste@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0386243824318869003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andre Carvalho de Matos <andre.carvalho.matos@stericsson.com>

transfer method should fail if you have a multiparty call, according to 22.=
091
section 8.11
---
 src/voicecall.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index f3f6a9b..f959f55 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1339,6 +1339,7 @@ static DBusMessage *manager_transfer(DBusConnection *=
conn,
 	struct ofono_voicecall *vc =3D data;
 	int numactive;
 	int numheld;
+	int numconn;
 =

 	if (vc->pending)
 		return __ofono_error_busy(msg);
@@ -1350,11 +1351,12 @@ static DBusMessage *manager_transfer(DBusConnection=
 *conn,
 	 * implementing the call transfer operation for a call that is
 	 * still dialing/alerting.
 	 */
-	numactive +=3D voicecalls_num_connecting(vc);
+	numconn =3D voicecalls_num_connecting(vc);
 =

 	numheld =3D voicecalls_num_held(vc);
 =

-	if ((numactive !=3D 1) && (numheld !=3D 1))
+	if ((numactive > 1 || numheld > 1) ||
+		((numheld + numactive + numconn) !=3D 2))
 		return __ofono_error_failed(msg);
 =

 	if (vc->driver->transfer =3D=3D NULL)
-- =

1.7.0.4


--===============0386243824318869003==--


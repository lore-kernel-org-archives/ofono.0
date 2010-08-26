Content-Type: multipart/mixed; boundary="===============2714372239145831594=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] gprs: add debug info
Date: Thu, 26 Aug 2010 16:08:52 +0300
Message-ID: <1282828132-8989-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2714372239145831594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/gprs.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 9b11053..d57115b 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -945,6 +945,9 @@ static void registration_status_cb(const struct ofono_e=
rror *error,
 {
 	struct ofono_gprs *gprs =3D data;
 =

+	DBG("%s error %d status %d", __ofono_atom_get_path(gprs->atom),
+		error->type, status);
+
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 		ofono_gprs_status_notify(gprs, status);
 =

@@ -958,6 +961,8 @@ static void gprs_attach_callback(const struct ofono_err=
or *error, void *data)
 {
 	struct ofono_gprs *gprs =3D data;
 =

+	DBG("%s error =3D %d", __ofono_atom_get_path(gprs->atom), error->type);
+
 	gprs->flags &=3D ~GPRS_FLAG_ATTACHING;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
@@ -1425,6 +1430,8 @@ static GDBusSignalTable manager_signals[] =3D {
 =

 void ofono_gprs_detached_notify(struct ofono_gprs *gprs)
 {
+	DBG("%s", __ofono_atom_get_path(gprs->atom));
+
 	gprs->driver_attached =3D FALSE;
 	gprs_attached_update(gprs);
 =

@@ -1437,6 +1444,8 @@ void ofono_gprs_detached_notify(struct ofono_gprs *gp=
rs)
 =

 void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status)
 {
+	DBG("%s status %d", __ofono_atom_get_path(gprs->atom), status);
+
 	gprs->status =3D status;
 =

 	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
-- =

1.7.0.4


--===============2714372239145831594==--


Content-Type: multipart/mixed; boundary="===============0807309717026973894=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [offline-atoms PATCHv2] Make gprs atom offline-safe.
Date: Thu, 20 Jan 2011 15:37:11 +0200
Message-ID: <1295530631-21811-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0807309717026973894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Allow use of GPRS atom both in online and offline (post_sim) states.

The GPRS now considers the removal of the netreg atom as implicit detach
and registration change to NOT_REGISTERED.
---
 src/gprs.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 0661f74..7153770 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1373,6 +1373,18 @@ static void gprs_attach_callback(const struct ofono_=
error *error, void *data)
 	}
 }
 =

+static void gprs_netreg_removed(struct ofono_gprs *gprs)
+{
+	gprs->netreg =3D NULL;
+
+	gprs->flags &=3D ~(GPRS_FLAG_RECHECK | GPRS_FLAG_ATTACHING);
+	gprs->status_watch =3D 0;
+	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+	gprs->driver_attached =3D FALSE;
+
+	gprs_attached_update(gprs);
+}
+
 static void gprs_netreg_update(struct ofono_gprs *gprs)
 {
 	ofono_bool_t attach;
@@ -2279,8 +2291,7 @@ static void netreg_watch(struct ofono_atom *atom,
 	struct ofono_gprs *gprs =3D data;
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
-		gprs->status_watch =3D 0;
-		gprs->netreg =3D NULL;
+		gprs_netreg_removed(gprs);
 		return;
 	}
 =

-- =

1.7.1


--===============0807309717026973894==--


Content-Type: multipart/mixed; boundary="===============4982723725269263045=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [offline-atoms PATCH 1/2] Make gprs atom offline-safe.
Date: Fri, 14 Jan 2011 16:40:52 +0200
Message-ID: <1295016053-31994-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1295016053-31994-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4982723725269263045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Allow use of GPRS atom both in online and offline (post_sim) states.

The GPRS now considers the removal of the netreg atom as implicit detach
and registration change to NOT_REGISTERED.
---
 src/gprs.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 0e86bdf..35cc475 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1370,10 +1370,27 @@ static void gprs_attach_callback(const struct ofono=
_error *error, void *data)
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
 =

+	if (gprs->netreg =3D=3D NULL) {
+		gprs_netreg_removed(gprs);
+		return;
+	}
+
 	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTE=
RED;
 =

 	attach =3D attach || (gprs->roaming_allowed &&
@@ -2250,8 +2267,7 @@ static void netreg_watch(struct ofono_atom *atom,
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


--===============4982723725269263045==--


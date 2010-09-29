Content-Type: multipart/mixed; boundary="===============1704506764327703762=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 06/21] gprs: Rename status_watch to netreg_status_watch
Date: Wed, 29 Sep 2010 17:44:46 +0800
Message-ID: <1285753501-7668-7-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1285753501-7668-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1704506764327703762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To be more precise and avoid name conflict with dun_status_watch.
---
 src/gprs.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 3f085ed..6e71b50 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -75,7 +75,7 @@ struct ofono_gprs {
 	int netreg_status;
 	struct ofono_netreg *netreg;
 	unsigned int netreg_watch;
-	unsigned int status_watch;
+	unsigned int netreg_status_watch;
 	GKeyFile *settings;
 	char *imsi;
 	DBusMessage *pending;
@@ -1741,10 +1741,10 @@ static void gprs_unregister(struct ofono_atom *atom)
 	}
 =

 	if (gprs->netreg_watch) {
-		if (gprs->status_watch) {
+		if (gprs->netreg_status_watch) {
 			__ofono_netreg_remove_status_watch(gprs->netreg,
-							gprs->status_watch);
-			gprs->status_watch =3D 0;
+						gprs->netreg_status_watch);
+			gprs->netreg_status_watch =3D 0;
 		}
 =

 		__ofono_modem_remove_atom_watch(modem, gprs->netreg_watch);
@@ -1831,15 +1831,16 @@ static void netreg_watch(struct ofono_atom *atom,
 	struct ofono_gprs *gprs =3D data;
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
-		gprs->status_watch =3D 0;
+		gprs->netreg_status_watch =3D 0;
 		gprs->netreg =3D NULL;
 		return;
 	}
 =

 	gprs->netreg =3D __ofono_atom_get_data(atom);
 	gprs->netreg_status =3D ofono_netreg_get_status(gprs->netreg);
-	gprs->status_watch =3D __ofono_netreg_add_status_watch(gprs->netreg,
-					netreg_status_changed, gprs, NULL);
+	gprs->netreg_status_watch =3D __ofono_netreg_add_status_watch(
+					gprs->netreg, netreg_status_changed,
+					gprs, NULL);
 =

 	gprs_netreg_update(gprs);
 }
-- =

1.7.0.4


--===============1704506764327703762==--


Content-Type: multipart/mixed; boundary="===============5307373839413755443=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 01/16] gprs: Rename status_watch to netreg_status_watch
Date: Wed, 11 Aug 2010 10:26:26 +0800
Message-ID: <1281493601-14351-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5307373839413755443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To be more precise and avoid name conflict with dun_status_watch.
---
 src/gprs.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 2c5bb4e..6c6f07e 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -72,7 +72,7 @@ struct ofono_gprs {
 	int netreg_status;
 	struct ofono_netreg *netreg;
 	unsigned int netreg_watch;
-	unsigned int status_watch;
+	unsigned int netreg_status_watch;
 	GKeyFile *settings;
 	char *imsi;
 	DBusMessage *pending;
@@ -1597,10 +1597,10 @@ static void gprs_unregister(struct ofono_atom *atom)
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
@@ -1684,15 +1684,16 @@ static void netreg_watch(struct ofono_atom *atom,
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


--===============5307373839413755443==--


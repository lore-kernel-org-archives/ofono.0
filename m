Content-Type: multipart/mixed; boundary="===============0796012773631818330=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: [PATCH 06/21] gprs: Rename status_watch to netreg_status_watch
Date: Wed, 12 Jan 2011 18:15:49 +0100
Message-ID: <1294852564-1258-7-git-send-email-frederic.dalleau@intel.com>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0796012773631818330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zhenhua Zhang <zhenhua.zhang@intel.com>

To be more precise and avoid name conflict with dun_status_watch.
---
 src/gprs.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 0e86bdf..4cb5eaf 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -74,7 +74,7 @@ struct ofono_gprs {
 	int netreg_status;
 	struct ofono_netreg *netreg;
 	unsigned int netreg_watch;
-	unsigned int status_watch;
+	unsigned int netreg_status_watch;
 	GKeyFile *settings;
 	char *imsi;
 	DBusMessage *pending;
@@ -2164,10 +2164,10 @@ static void gprs_unregister(struct ofono_atom *atom)
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
@@ -2250,15 +2250,16 @@ static void netreg_watch(struct ofono_atom *atom,
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

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============0796012773631818330==--


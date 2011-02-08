Content-Type: multipart/mixed; boundary="===============6931296366980012034=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 3/3] gprs-provision: update example with SPN
Date: Tue, 08 Feb 2011 12:03:48 +0200
Message-ID: <1297159428-2409-4-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1297159428-2409-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6931296366980012034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 examples/provision.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/examples/provision.c b/examples/provision.c
index 356b0b3..546a161 100644
--- a/examples/provision.c
+++ b/examples/provision.c
@@ -37,6 +37,7 @@
 #include <ofono/log.h>
 =

 static int example_provision_get_settings(const char *mcc, const char *mnc,
+				const char *spn,
 				struct ofono_gprs_provision_data **settings,
 				int *count)
 {
@@ -44,10 +45,11 @@ static int example_provision_get_settings(const char *m=
cc, const char *mnc,
 	*count =3D 0;
 	*settings =3D NULL;
 =

-	ofono_debug("Finding settings for MCC %s, MNC %s",
-			mcc, mnc);
+	ofono_debug("Finding settings for MCC %s, MNC %s, SPN '%s'",
+			mcc, mnc, spn);
 =

-	if (strcmp(mcc, "246") !=3D 0 || strcmp(mnc, "81") !=3D 0)
+	if (strcmp(mcc, "246") !=3D 0 || strcmp(mnc, "81") !=3D 0 ||
+						strcmp(spn, "oFono") !=3D 0)
 		return -ENOENT;
 =

 	ofono_debug("Creating example settings for phonesim");
-- =

1.7.1


--===============6931296366980012034==--


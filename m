Content-Type: multipart/mixed; boundary="===============8502766929383213927=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv8 6/6] tools: lookup-apn update
Date: Fri, 30 Sep 2011 16:31:14 +0300
Message-ID: <1317389474-16566-7-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317389474-16566-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8502766929383213927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/lookup-apn.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 2969baf..c4cb928 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -24,12 +24,7 @@
 #endif
 =

 #include <stdio.h>
-#include <fcntl.h>
-#include <unistd.h>
 #include <stdlib.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
 =

 #include <glib.h>
 =

@@ -39,31 +34,38 @@
 =

 #include "plugins/mbpi.h"
 =

-static void lookup_apn(const char *match_mcc, const char *match_mnc)
+static void lookup_apn(const char *mcc, const char *mnc)
 {
 	GSList *l;
 	GSList *apns;
 	GError *error =3D NULL;
 =

-	printf("Searching for info for network: %s%s\n", match_mcc, match_mnc);
+	printf("Searching for info for network: %s%s\n", mcc, mnc);
 =

-	apns =3D mbpi_lookup(match_mcc, match_mnc, TRUE, &error);
+	apns =3D mbpi_lookup(mcc, mnc, FALSE, &error);
 =

 	if (apns =3D=3D NULL) {
-		g_print("Lookup failed: %s\n", error->message);
+		if (error !=3D NULL) {
+			g_printerr("Lookup failed: %s\n", error->message);
+			g_error_free(error);
+		}
+
 		return;
 	}
 =

+	printf("Found %d APs\n", g_slist_length(apns));
+
 	for (l =3D apns; l; l =3D l->next) {
-		struct ofono_gprs_provision_data *apn =3D l->data;
+		struct ofono_gprs_provision_data *ap =3D l->data;
 =

 		printf("\n");
-		printf("Name: %s\n", apn->name);
-		printf("APN: %s\n", apn->apn);
-		printf("Username: %s\n", apn->username);
-		printf("Password: %s\n", apn->password);
+		printf("Name: '%s'\n", ap->name);
+		printf("APN: '%s'\n", ap->apn);
+		printf("Type: %s\n", mbpi_ap_type(ap->type));
+		printf("Username: '%s'\n", ap->username);
+		printf("Password: '%s'\n", ap->password);
 =

-		mbpi_provision_data_free(apn);
+		mbpi_ap_free(ap);
 	}
 =

 	g_slist_free(apns);
-- =

1.7.4.1


--===============8502766929383213927==--


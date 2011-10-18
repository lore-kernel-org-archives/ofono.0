Content-Type: multipart/mixed; boundary="===============4165836407308546248=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv10 9/9] lookup-apn: Minor style issues
Date: Tue, 18 Oct 2011 14:05:05 +0300
Message-ID: <1318935905-9087-10-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1318935905-9087-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4165836407308546248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/lookup-apn.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index f2727d3..b833b6c 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#include <stdio.h>
 #include <stdlib.h>
 =

 #include <glib.h>
@@ -41,7 +40,7 @@ static void lookup_apn(const char *match_mcc, const char =
*match_mnc,
 	GSList *apns;
 	GError *error =3D NULL;
 =

-	printf("Searching for info for network: %s%s\n", match_mcc, match_mnc);
+	g_print("Searching for info for network: %s%s\n", match_mcc, match_mnc);
 =

 	apns =3D mbpi_lookup(match_mcc, match_mnc, allow_duplicates, &error);
 =

@@ -55,16 +54,16 @@ static void lookup_apn(const char *match_mcc, const cha=
r *match_mnc,
 	}
 =

 	for (l =3D apns; l; l =3D l->next) {
-		struct ofono_gprs_provision_data *apn =3D l->data;
+		struct ofono_gprs_provision_data *ap =3D l->data;
 =

-		printf("\n");
-		printf("Name: %s\n", apn->name);
-		printf("APN: %s\n", apn->apn);
-		printf("Type: %s\n", mbpi_ap_type(apn->type));
-		printf("Username: %s\n", apn->username);
-		printf("Password: %s\n", apn->password);
+		g_print("\n");
+		g_print("Name: %s\n", ap->name);
+		g_print("APN: %s\n", ap->apn);
+		g_print("Type: %s\n", mbpi_ap_type(ap->type));
+		g_print("Username: %s\n", ap->username);
+		g_print("Password: %s\n", ap->password);
 =

-		mbpi_ap_free(apn);
+		mbpi_ap_free(ap);
 	}
 =

 	g_slist_free(apns);
@@ -101,12 +100,12 @@ int main(int argc, char **argv)
 	g_option_context_free(context);
 =

 	if (option_version =3D=3D TRUE) {
-		printf("%s\n", VERSION);
+		g_print("%s\n", VERSION);
 		exit(0);
 	}
 =

 	if (argc < 2) {
-		fprintf(stderr, "Missing parameters\n");
+		g_printerr("Missing parameters\n");
 		exit(1);
 	}
 =

-- =

1.7.4.1


--===============4165836407308546248==--


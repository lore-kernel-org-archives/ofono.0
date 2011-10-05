Content-Type: multipart/mixed; boundary="===============3647048010651361598=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 16/16] lookup-apn: Minor style issues
Date: Wed, 05 Oct 2011 16:18:39 +0300
Message-ID: <1317820719-23609-17-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3647048010651361598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/lookup-apn.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 9c0d345..29c0027 100644
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
@@ -40,7 +39,7 @@ static void lookup_apn(const char *match_mcc, const char =
*match_mnc)
 	GSList *apns;
 	GError *error =3D NULL;
 =

-	printf("Searching for info for network: %s%s\n", match_mcc, match_mnc);
+	g_print("Searching for info for network: %s%s\n", match_mcc, match_mnc);
 =

 	apns =3D mbpi_lookup(match_mcc, match_mnc, FALSE, &error);
 =

@@ -53,16 +52,16 @@ static void lookup_apn(const char *match_mcc, const cha=
r *match_mnc)
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
@@ -96,12 +95,12 @@ int main(int argc, char **argv)
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


--===============3647048010651361598==--


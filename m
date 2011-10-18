Content-Type: multipart/mixed; boundary="===============6636246533331206920=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv10 5/9] lookup-apn: Add command line option to control
 duplicates
Date: Tue, 18 Oct 2011 14:05:01 +0300
Message-ID: <1318935905-9087-6-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1318935905-9087-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6636246533331206920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/lookup-apn.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index c14cced..83a94bb 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -34,7 +34,8 @@
 =

 #include "plugins/mbpi.h"
 =

-static void lookup_apn(const char *match_mcc, const char *match_mnc)
+static void lookup_apn(const char *match_mcc, const char *match_mnc,
+						gboolean allow_duplicates)
 {
 	GSList *l;
 	GSList *apns;
@@ -42,7 +43,7 @@ static void lookup_apn(const char *match_mcc, const char =
*match_mnc)
 =

 	printf("Searching for info for network: %s%s\n", match_mcc, match_mnc);
 =

-	apns =3D mbpi_lookup(match_mcc, match_mnc, TRUE, &error);
+	apns =3D mbpi_lookup(match_mcc, match_mnc, allow_duplicates, &error);
 =

 	if (apns =3D=3D NULL) {
 		if (error !=3D NULL) {
@@ -70,10 +71,13 @@ static void lookup_apn(const char *match_mcc, const cha=
r *match_mnc)
 }
 =

 static gboolean option_version =3D FALSE;
+static gboolean option_duplicates =3D FALSE;
 =

 static GOptionEntry options[] =3D {
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
 				"Show version information and exit" },
+	{ "allow-duplicates", 0, 0, G_OPTION_ARG_NONE, &option_duplicates,
+				"Allow duplicate access point types" },
 	{ NULL },
 };
 =

@@ -106,7 +110,7 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 =

-	lookup_apn(argv[1], argv[2]);
+	lookup_apn(argv[1], argv[2], option_duplicates);
 =

 	return 0;
 }
-- =

1.7.4.1


--===============6636246533331206920==--


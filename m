Content-Type: multipart/mixed; boundary="===============5517426436213919454=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 07/16] lookup-apn: Fix crash on no APNs found
Date: Wed, 05 Oct 2011 16:18:30 +0300
Message-ID: <1317820719-23609-8-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5517426436213919454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/lookup-apn.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index b192c7c..6a00293 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -45,7 +45,10 @@ static void lookup_apn(const char *match_mcc, const char=
 *match_mnc)
 	apns =3D mbpi_lookup(match_mcc, match_mnc, TRUE, &error);
 =

 	if (apns =3D=3D NULL) {
-		g_print("Lookup failed: %s\n", error->message);
+		if (error !=3D NULL) {
+			g_printerr("Lookup failed: %s\n", error->message);
+			g_error_free(error);
+		}
 		return;
 	}
 =

-- =

1.7.4.1


--===============5517426436213919454==--


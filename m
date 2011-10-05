Content-Type: multipart/mixed; boundary="===============2663454678632402425=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 15/16] lookup-apn: Follow plugin's duplicates approach
Date: Wed, 05 Oct 2011 16:18:38 +0300
Message-ID: <1317820719-23609-16-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2663454678632402425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/lookup-apn.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 3918f18..9c0d345 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -42,7 +42,7 @@ static void lookup_apn(const char *match_mcc, const char =
*match_mnc)
 =

 	printf("Searching for info for network: %s%s\n", match_mcc, match_mnc);
 =

-	apns =3D mbpi_lookup(match_mcc, match_mnc, TRUE, &error);
+	apns =3D mbpi_lookup(match_mcc, match_mnc, FALSE, &error);
 =

 	if (apns =3D=3D NULL) {
 		if (error !=3D NULL) {
-- =

1.7.4.1


--===============2663454678632402425==--


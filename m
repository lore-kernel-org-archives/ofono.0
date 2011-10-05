Content-Type: multipart/mixed; boundary="===============2038686880341331527=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 11/16] lookup-apn: Use mbpi_ap_type()
Date: Wed, 05 Oct 2011 16:18:34 +0300
Message-ID: <1317820719-23609-12-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2038686880341331527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/lookup-apn.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 6a00293..90ef3a4 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -58,6 +58,7 @@ static void lookup_apn(const char *match_mcc, const char =
*match_mnc)
 		printf("\n");
 		printf("Name: %s\n", apn->name);
 		printf("APN: %s\n", apn->apn);
+		printf("Type: %s\n", mbpi_ap_type(apn->type));
 		printf("Username: %s\n", apn->username);
 		printf("Password: %s\n", apn->password);
 =

-- =

1.7.4.1


--===============2038686880341331527==--


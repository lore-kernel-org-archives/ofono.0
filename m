Content-Type: multipart/mixed; boundary="===============4294123624060941360=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv10 4/9] lookup-apn: Use mbpi_ap_type()
Date: Tue, 18 Oct 2011 14:05:00 +0300
Message-ID: <1318935905-9087-5-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1318935905-9087-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4294123624060941360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/lookup-apn.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 2fa6b5b..c14cced 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -59,6 +59,7 @@ static void lookup_apn(const char *match_mcc, const char =
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


--===============4294123624060941360==--


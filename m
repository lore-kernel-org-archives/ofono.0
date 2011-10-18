Content-Type: multipart/mixed; boundary="===============5753928815093477135=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv10 7/9] lookup-apn: Use mbpi_ap_free()
Date: Tue, 18 Oct 2011 14:05:03 +0300
Message-ID: <1318935905-9087-8-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1318935905-9087-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5753928815093477135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/lookup-apn.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 83a94bb..f2727d3 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -64,7 +64,7 @@ static void lookup_apn(const char *match_mcc, const char =
*match_mnc,
 		printf("Username: %s\n", apn->username);
 		printf("Password: %s\n", apn->password);
 =

-		mbpi_provision_data_free(apn);
+		mbpi_ap_free(apn);
 	}
 =

 	g_slist_free(apns);
-- =

1.7.4.1


--===============5753928815093477135==--


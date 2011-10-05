Content-Type: multipart/mixed; boundary="===============5411726008609743755=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 13/16] lookup-apn: Use mbpi_ap_free()
Date: Wed, 05 Oct 2011 16:18:36 +0300
Message-ID: <1317820719-23609-14-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5411726008609743755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/lookup-apn.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 90ef3a4..3918f18 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -62,7 +62,7 @@ static void lookup_apn(const char *match_mcc, const char =
*match_mnc)
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


--===============5411726008609743755==--


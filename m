Content-Type: multipart/mixed; boundary="===============3674536829024263306=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] atmodem: fix to populate activated gprs context ip settings
Date: Thu, 26 Sep 2019 16:53:27 +0530
Message-ID: <1569497007-11249-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3674536829024263306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Function to get ipv4 and ipv6 settings for first default activated
context in LTE was not getting called after pdp activation.
Calling ofono_gprs_cid_activated function for last_auto_context_id.
---
 drivers/atmodem/gprs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 16f4927..71a8631 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -194,6 +194,7 @@ static void at_cgdcont_parse(struct ofono_gprs *gprs, G=
AtResult *result,
 				struct l_uintset *cids)
 {
 	GAtResultIter iter;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -204,7 +205,8 @@ static void at_cgdcont_parse(struct ofono_gprs *gprs, G=
AtResult *result,
 		if (!g_at_result_iter_next_number(&iter, &read_cid))
 			break;
 =

-		if (!l_uintset_contains(cids, read_cid))
+		if (!l_uintset_contains(cids, read_cid) &&
+			read_cid !=3D gd->last_auto_context_id)
 			continue;
 =

 		/* ignore protocol */
-- =

1.9.1


--===============3674536829024263306==--


Content-Type: multipart/mixed; boundary="===============7217900373364621137=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Accept ranges in +CSMS responses.
Date: Tue, 10 Nov 2009 07:30:55 +0100
Message-ID: <1257834655-22496-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7217900373364621137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sms.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 20ab47a..dfccdb4 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -1043,7 +1043,7 @@ static void at_csms_query_cb(gboolean ok, GAtResult *=
result,
 	struct sms_data *data =3D ofono_sms_get_data(sms);
 	gboolean cnma_supported =3D FALSE;
 	GAtResultIter iter;
-	int status;
+	int status_min, status_max;
 	char buf[128];
 =

 	dump_response("csms_query_cb", ok, result);
@@ -1059,8 +1059,8 @@ static void at_csms_query_cb(gboolean ok, GAtResult *=
result,
 	if (!g_at_result_iter_open_list(&iter))
 		goto out;
 =

-	while (g_at_result_iter_next_number(&iter, &status))
-		if (status =3D=3D 1)
+	while (g_at_result_iter_next_range(&iter, &status_min, &status_max))
+		if (status_min <=3D 1 && 1 <=3D status_max)
 			cnma_supported =3D TRUE;
 =

 	ofono_debug("CSMS query parsed successfully");
-- =

1.6.1


--===============7217900373364621137==--


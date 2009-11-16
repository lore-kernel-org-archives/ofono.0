Content-Type: multipart/mixed; boundary="===============8131592653605903883=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/4] Fix: Ignore repeated CCWA notify if have
Date: Mon, 16 Nov 2009 22:12:43 +0800
Message-ID: <1258380763.5437.3.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8131592653605903883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some phone like iPhone repeats CCWA notify. So we need to ignore
it when we already have waiting call.
---
 drivers/hfpmodem/voicecall.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 53d4fd1..689597d 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -450,6 +450,12 @@ static void ccwa_notify(GAtResult *result, gpointer
user_data)
 =

 	dump_response("ccwa_notify", TRUE, result);
 =

+	/* CCWA can repeat, ignore if we already have an waiting call */
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_WAITING),
+				at_util_call_compare_by_status))
+		return;
+
 	g_at_result_iter_init(&iter, result);
 =

 	if (!g_at_result_iter_next(&iter, "+CCWA:"))
-- =

1.6.2.5




--===============8131592653605903883==--


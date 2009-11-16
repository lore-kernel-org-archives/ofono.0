Content-Type: multipart/mixed; boundary="===============4462140037525940313=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/4] Fix: Avoid release dialing call when call is 0
Date: Mon, 16 Nov 2009 22:12:21 +0800
Message-ID: <1258380741.5437.2.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4462140037525940313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If +CIEV call goes to 0, we may have another dialing call. We
should not release this dialing call when call=3D0.
---
 drivers/hfpmodem/voicecall.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index d9c3c2a..53d4fd1 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -590,10 +590,11 @@ static void ciev_call_notify(struct
ofono_voicecall *vc,
 	{
 		GSList *waiting;
 		GSList *incoming;
+		GSList *dialing;
 =

 		/* If call goes to 0, then we have no held or active calls
 		 * in the system.  The waiting calls are promoted to incoming
-		 * calls
+		 * calls and dialing call is kept.
 		 */
 		waiting =3D g_slist_find_custom(vd->calls,
 					GINT_TO_POINTER(CALL_STATUS_WAITING),
@@ -612,8 +613,26 @@ static void ciev_call_notify(struct ofono_voicecall
*vc,
 		if (incoming)
 			vd->calls =3D g_slist_remove_link(vd->calls, incoming);
 =

+		/* The dialing call should be kept dialing */
+		dialing =3D g_slist_find_custom(vd->calls,
+					GINT_TO_POINTER(CALL_STATUS_DIALING),
+					at_util_call_compare_by_status);
+
+		if (!dialing)
+			dialing =3D g_slist_find_custom(vd->calls,
+						GINT_TO_POINTER(
+							CALL_STATUS_ALERTING),
+						at_util_call_compare_by_status);
+
+		if (dialing)
+			vd->calls =3D g_slist_remove_link(vd->calls, dialing);
+
 		release_all_calls(vc);
-		vd->calls =3D incoming;
+
+		if (incoming)
+			vd->calls =3D incoming;
+		else if (dialing)
+			vd->calls =3D dialing;
 =

 		break;
 	}
-- =

1.6.2.5




--===============4462140037525940313==--


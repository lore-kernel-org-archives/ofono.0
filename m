Content-Type: multipart/mixed; boundary="===============4520892366073745836=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH] hfp: Handle extra CCWA event
Date: Tue, 18 Aug 2015 19:53:28 +0200
Message-ID: <1439920408-6936-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4520892366073745836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a call is waitng, CCWA event is sent and call object
in state WAITING is created. on ReleaseAndAnswer it is
promoted to INCOMING and later to ACTIVE.
iPhones send an extra CCWA event when active call is ended.
This extra event is creating a second call object in state
WAITING. It is not possible to have two WAITING calls, but
previously waiting call was already promoted to INCOMING.
For a brief time we have two calls from the same number,
one INCOMING and one WAITING. Later WAITING one is removed.
As we cannot have a waiting and incoming call at the same
time, ignore CCWA when there is already an INCOMING call.

< \r\n+CIEV: 3,3\r\n
< \r\n+CIEV: 2,1\r\n
< \r\n+CIEV: 3,0\r\n
< \r\n+CCWA: "01234567890",129,1,"Me"\r\n
< \r\n+CIEV: 3,1\r\n
> AT+CLCC\r
< \r\n+CLCC: 1,0,0,0,0,"09876543210",129,"Me"\r\n
< \r\n+CLCC: 2,1,5,0,0,"01234567890",129,"Me"\r\n
< \r\nOK\r\n
< \r\n+CIEV: 2,0\r\n
< \r\n+CCWA: "01234567890",129,1,"Me"\r\n
< \r\n+CIEV: 2,1\r\n
< \r\n+CIEV: 3,0\r\n
> AT+CLCC\r
< \r\n+CLCC: 2,1,0,0,0,"01234567890",129,"Me"\r\n
< \r\nOK\r\n
---
 drivers/hfpmodem/voicecall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 7542fe4bd41424774dc888e11a6afed4b159f546..b6e0886c8d62e667421b0f5d43a=
c1565c94e0838 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -712,6 +712,16 @@ static void ccwa_notify(GAtResult *result, gpointer us=
er_data)
 				at_util_call_compare_by_status))
 		return;
 =

+	/* some phones may send extra CCWA after active call is ended
+	 * this would trigger creation of second call in state 'WAITING'
+	 * as our previous WAITING call has been promoted to INCOMING
+	 */
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				at_util_call_compare_by_status))
+		return;
+
+
 	g_at_result_iter_init(&iter, result);
 =

 	if (!g_at_result_iter_next(&iter, "+CCWA:"))
-- =

1.7.11.7

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============4520892366073745836==--


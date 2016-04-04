Content-Type: multipart/mixed; boundary="===============2623226804878652283=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH] hfp: Handle +CCWA at HFP connection setup
Date: Mon, 04 Apr 2016 10:36:25 +0200
Message-ID: <1459758985-21457-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2623226804878652283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some phones with an active and waiting call at the time of HFP SLC
establishment, may send call waiting notification before all calls
are synchronized. This will lead to call Id mismatch because call
object is created with assumed Id 1 and not Id assigned by the phone.

In example below waiting call is created with Id 1 but in AT+CLCC
this phone returns active call as call with Id 1, and waiting as 2.

< \r\n+CCWA: "+1234567890",145\r\n
< \r\n+CIEV: 2,1\r\n
drivers/hfpmodem/voicecall.c:ccwa_notify() ccwa_notify: +1234567890 145 0
src/voicecall.c:ofono_voicecall_notify() Got a voicecall event, status: 5, =
id: 1, number: +1234567890 called_number: , called_name
src/voicecall.c:ofono_voicecall_notify() Did not find a call with id: 1
> AT+CIND?\r
< \r\n+CIND: 1,1,1,4,0,2,0\r\n\r\nOK\r\n
src/network.c:ofono_netreg_status_notify() /hfp/org/bluez/hci0/dev_60_AF_6D=
_F7_8E_37 status 1 tech -1
> AT+VGS=3D7\r
< \r\nOK\r\n
> AT+VGM=3D7\r
< \r\nOK\r\n
> AT+CLCC\r
< \r\n+CLCC: 1,1,0,0,0,"+9876543210",145\r\n
< \r\n+CLCC: 2,1,5,0,0,"+1234567890",145\r\n\r\nOK\r\n
src/voicecall.c:ofono_voicecall_notify() Got a voicecall event, status: 0, =
id: 1, number: +9876543210 called_number: , called_name
src/voicecall.c:ofono_voicecall_notify() Found call with id: 1
src/voicecall.c:ofono_voicecall_notify() Got a voicecall event, status: 5, =
id: 2, number: +1234567890 called_number: , called_name
src/voicecall.c:ofono_voicecall_notify() Did not find a call with id: 2
src/voicecall.c:ofono_voicecall_mpty_hint() ids: 0
---
 drivers/hfpmodem/voicecall.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 3acfc3a3b45ffff5c573f8af18c4d3361faabdd5..f8db584cddc341da09d9ca7bbbc=
0fa02c460202b 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -709,6 +709,15 @@ static void ccwa_notify(GAtResult *result, gpointer us=
er_data)
 	int num_type, validity;
 	struct ofono_call *call;
 =

+	/* Waiting call notification makes no sense, when there are
+	 * no calls@all. This can happen when a phone already has
+	 * waiting and active calls and is being connected over HFP
+	 * but it first sends +CCWA before we manage to synchronize
+	 * calls with AT+CLCC.
+	 */
+	if (!vd->calls)
+		return;
+
 	/* CCWA can repeat, ignore if we already have an waiting call */
 	if (g_slist_find_custom(vd->calls,
 				GINT_TO_POINTER(CALL_STATUS_WAITING),
-- =

1.9.3

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============2623226804878652283==--


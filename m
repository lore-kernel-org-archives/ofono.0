Content-Type: multipart/mixed; boundary="===============7834669106178881097=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH v2] Synchronize call status in case of Hangup error
Date: Wed, 05 Aug 2015 14:36:09 +0200
Message-ID: <1438778169-12297-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7834669106178881097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It is possible for the phone to accept Dial request
but not actually dial. This leaves a voicecall object
in state 'dialling' that cannot be removed.
Proposed workaround is to trigger AT+CLCC when an error
is returned for Hangup. As the call is not on the list,
this would remove this hanging object and signal CallRemoved.

Windows Phone trace with this fix:
ofonod[273]: > ATD1;\r
ofonod[273]: < \r\nOK\r\n
ofonod[273]: src/voicecall.c:dial_handle_result() Registering new call: 1
ofonod[273]: < \r\n+CIEV: 5,4\r\n
ofonod[273]: src/network.c:ofono_netreg_strength_notify() strength 80
ofonod[273]: > AT+CHUP\r
ofonod[273]: < \r\nERROR\r\n
ofonod[273]: src/voicecall.c:generic_callback() command failed with error: =
Unknown error type
ofonod[273]: > AT+CLCC\r
ofonod[273]: < \r\nOK\r\n
ofonod[273]: src/voicecall.c:ofono_voicecall_disconnected() Got disconnecti=
on event for id: 1, reason: 2
---
 drivers/hfpmodem/voicecall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index e3e6e0f..f1e9096 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -333,6 +333,10 @@ static void generic_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		}
 	}
 =

+	if (!ok && vd->calls)
+		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
+					clcc_poll_cb, req->vc, NULL);
+
 	req->cb(&error, req->data);
 }
 =

-- =

1.7.11.7

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============7834669106178881097==--


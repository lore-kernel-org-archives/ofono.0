Content-Type: multipart/mixed; boundary="===============6951202397570232769=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] stk: Display action information while sending USSD.
Date: Tue, 28 Aug 2012 15:33:52 +0200
Message-ID: <1346160832-12043-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6951202397570232769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 38f2e18..18a8eaf 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -2026,11 +2026,6 @@ static gboolean handle_command_send_ussd(const struc=
t stk_command *cmd,
 					cmd->send_ussd.ussd_string.len,
 					send_ussd_callback, stk);
 =

-	if (err >=3D 0) {
-		stk->cancel_cmd =3D send_ussd_cancel;
-
-		return FALSE;
-	}
 =

 	if (err =3D=3D -ENOSYS) {
 		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
@@ -2043,6 +2038,20 @@ static gboolean handle_command_send_ussd(const struc=
t stk_command *cmd,
 		return TRUE;
 	}
 =

+	if (err < 0) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
+		/*
+		 * We most likely got an out of memory error, tell SIM
+		 * to retry
+		 */
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
+		return TRUE;
+	}
+
+	stk->cancel_cmd =3D send_ussd_cancel;
+
 	stk_alpha_id_set(stk, cmd->send_ussd.alpha_id,
 				&cmd->send_ussd.text_attr,
 				&cmd->send_ussd.icon_id);
-- =

1.7.9.5


--===============6951202397570232769==--


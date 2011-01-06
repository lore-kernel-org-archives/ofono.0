Content-Type: multipart/mixed; boundary="===============2246937492526101001=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] stk: Remove unwanted error check
Date: Thu, 06 Jan 2011 09:56:32 -0800
Message-ID: <1294336592-9916-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2246937492526101001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Possible return values of  __ofono_voicecall_tone_send
are -ENOSYS, -ENOENT, -ENOMEM and -EINVAL.
---
 src/stk.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index bec46ea..932e49a 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -2170,11 +2170,6 @@ static gboolean handle_command_send_dtmf(const struc=
t stk_command *cmd,
 =

 	err =3D __ofono_voicecall_tone_send(vc, dtmf, dtmf_sent_cb, stk);
 =

-	if (err =3D=3D -EBUSY) {
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
-		return TRUE;
-	}
-
 	if (err =3D=3D -ENOSYS) {
 		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
 		return TRUE;
-- =

1.7.0.4


--===============2246937492526101001==--


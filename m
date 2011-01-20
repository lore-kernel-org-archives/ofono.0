Content-Type: multipart/mixed; boundary="===============8929443241522331583=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 1/2] stkutil: add check for qualifier and browser id
Date: Thu, 20 Jan 2011 14:52:55 +0200
Message-ID: <1295527976-15816-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1295527976-15816-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8929443241522331583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Checks the valid qualifier and browser id values
applicable for launch browser proactive command
---
 src/stkutil.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b7f03e2..abd1c99 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1187,7 +1187,11 @@ static gboolean parse_dataobj_browser_id(struct comp=
rehension_tlv_iter *iter,
 						void *user)
 {
 	unsigned char *byte =3D user;
-	return parse_dataobj_common_byte(iter, byte);
+
+	if (parse_dataobj_common_byte(iter, byte) =3D=3D FALSE || *byte > 4)
+		return FALSE;
+
+	return TRUE;
 }
 =

 /* Defined in TS 102.223 Section 8.48 */
@@ -3229,6 +3233,9 @@ static enum stk_command_parse_result parse_launch_bro=
wser(
 {
 	struct stk_command_launch_browser *obj =3D &command->launch_browser;
 =

+	if (command->qualifier > 3 || command->qualifier =3D=3D 1)
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-- =

1.7.0.4


--===============8929443241522331583==--


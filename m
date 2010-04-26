Content-Type: multipart/mixed; boundary="===============8548176608901654743=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/6] stkutil: Move advance of ctlv to decicated proactive
 commands parser
Date: Mon, 26 Apr 2010 18:29:22 +0800
Message-ID: <1272277766-25432-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1272277766-25432-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8548176608901654743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not all the proactive commands have comprehension tlv other than command
details and device identities. So the appropriate code should be moved to
decicated parser if needed.
---
 src/stkutil.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b4279c1..9f9b1a6 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2079,6 +2079,9 @@ static gboolean parse_display_text(struct stk_command=
 *command,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_DISPLAY)
 		return FALSE;
 =

+	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
+		return FALSE;
+
 	obj->frame_id =3D 0xFF;
 =

 	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
@@ -2121,6 +2124,9 @@ static gboolean parse_get_inkey(struct stk_command *c=
ommand,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

+	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
+		return FALSE;
+
 	obj->frame_id =3D 0xFF;
 =

 	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
@@ -2165,6 +2171,9 @@ static gboolean parse_get_input(struct stk_command *c=
ommand,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

+	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
+		return FALSE;
+
 	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
@@ -2210,6 +2219,9 @@ static gboolean parse_send_sms(struct stk_command *co=
mmand,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
 		return FALSE;
 =

+	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
+		return FALSE;
+
 	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ADDRESS, 0,
@@ -2295,9 +2307,6 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	command->src =3D data[0];
 	command->dst =3D data[1];
 =

-	if (comprehension_tlv_iter_next(&iter) !=3D TRUE)
-		return FALSE;
-
 	switch (command->type) {
 	case STK_COMMAND_TYPE_DISPLAY_TEXT:
 		ok =3D parse_display_text(command, &iter);
-- =

1.7.0.4


--===============8548176608901654743==--


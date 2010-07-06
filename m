Content-Type: multipart/mixed; boundary="===============4201179529467599085=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 12/14] stkutil: Timer Value is conditional, not optional.
Date: Wed, 07 Jul 2010 00:39:07 +0200
Message-ID: <1278455949-2823-13-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4201179529467599085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make the parser check that the value is present when necessary,
so that stk.c doesn't have to check this.
---
 src/stkutil.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index d2cd126..94ff182 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3000,6 +3000,7 @@ static enum stk_command_parse_result parse_timer_mgmt(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_timer_mgmt *obj =3D &command->timer_mgmt;
+	enum stk_data_object_flag value_flags =3D 0;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -3007,10 +3008,13 @@ static enum stk_command_parse_result parse_timer_mg=
mt(
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

+	if ((command->qualifier & 3) =3D=3D 0) /* Start a timer */
+		value_flags =3D DATAOBJ_FLAG_MANDATORY;
+
 	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TIMER_ID,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->timer_id,
-				STK_DATA_OBJECT_TYPE_TIMER_VALUE, 0,
+				STK_DATA_OBJECT_TYPE_TIMER_VALUE, value_flags,
 				&obj->timer_value,
 				STK_DATA_OBJECT_TYPE_INVALID);
 }
-- =

1.7.1.86.g0e460.dirty


--===============4201179529467599085==--


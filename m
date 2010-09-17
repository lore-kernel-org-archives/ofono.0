Content-Type: multipart/mixed; boundary="===============8994974745069908861=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] stk: Language Notification proactive cmd support
Date: Thu, 16 Sep 2010 21:40:07 -0700
Message-ID: <1284698407-12939-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8994974745069908861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 63b1fd3..c9248df 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1907,6 +1907,17 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
+		/*
+		 * If any clients are interested, then the ISO639
+		 * 2-letter codes has to be convered to language strings.
+		 * Converted language strings has to be added to the
+		 * property list.
+		 */
+		ofono_info("Language Code: %s",
+			stk->pending_cmd->language_notification.language);
+		break;
+
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
-- =

1.7.0.4


--===============8994974745069908861==--


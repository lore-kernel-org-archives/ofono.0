Content-Type: multipart/mixed; boundary="===============8622130756855492866=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 03/11] stk: Add support for the proactive command 'Get channel
 status'
Date: Tue, 28 Jun 2011 19:16:15 +0200
Message-ID: <1309281383-6605-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309281383-6605-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8622130756855492866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 4bf6a08..835922f 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -2817,6 +2817,16 @@ static gboolean handle_command_open_channel(const st=
ruct stk_command *cmd,
 	return FALSE;
 }
 =

+static gboolean handle_command_get_channel_status(const struct stk_command=
 *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	rsp->result.type =3D STK_RESULT_TYPE_SUCCESS;
+	rsp->channel_status.channel.id =3D stk->channel.id;
+	rsp->channel_status.channel.status =3D stk->channel.status;
+	return TRUE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -3015,6 +3025,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_GET_CHANNEL_STATUS:
+		respond =3D handle_command_get_channel_status(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
-- =

1.7.1


--===============8622130756855492866==--


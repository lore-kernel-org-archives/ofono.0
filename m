Content-Type: multipart/mixed; boundary="===============9007348187336413454=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2 3/3] stk: Handle provide local info proactive command
Date: Wed, 01 Dec 2010 10:02:58 +0800
Message-ID: <1291168978-10587-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9007348187336413454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index a4abb7d..53eca78 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -26,6 +26,7 @@
 #define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <stdint.h>
 =

 #include <glib.h>
@@ -1995,6 +1996,85 @@ static gboolean handle_command_refresh(const struct =
stk_command *cmd,
 	return TRUE;
 }
 =

+static void get_time(struct stk_response *rsp, struct ofono_stk *stk)
+{
+	time_t now;
+	struct tm *t;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+	time(&now);
+	t =3D localtime(&now);
+
+	if (t =3D=3D NULL) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		goto out;
+	}
+
+	rsp->result.type =3D STK_RESULT_TYPE_SUCCESS;
+
+	if (t->tm_year > 100)
+		rsp->provide_local_info.datetime.year =3D t->tm_year - 100;
+	else
+		rsp->provide_local_info.datetime.year =3D t->tm_year;
+
+	rsp->provide_local_info.datetime.month =3D t->tm_mon + 1;
+	rsp->provide_local_info.datetime.day =3D t->tm_mday;
+	rsp->provide_local_info.datetime.hour =3D t->tm_hour;
+	rsp->provide_local_info.datetime.minute =3D t->tm_min;
+	rsp->provide_local_info.datetime.second =3D t->tm_sec;
+	rsp->provide_local_info.datetime.timezone =3D t->tm_gmtoff / 900;
+	rsp->provide_local_info.datetime.has_timezone =3D TRUE;
+
+out:
+	if (stk_respond(stk, rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+}
+
+static void get_lang(struct stk_response *rsp, struct ofono_stk *stk)
+{
+	char *l;
+	char lang[3];
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+	l =3D getenv("LANG");
+	if (l =3D=3D NULL) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		goto out;
+	}
+
+	memcpy(lang, l, 2);
+	lang[2] =3D '\0';
+
+	rsp->result.type =3D STK_RESULT_TYPE_SUCCESS;
+	rsp->provide_local_info.language =3D lang;
+
+out:
+	if (stk_respond(stk, rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+}
+
+static gboolean handle_command_provide_local_info(const struct stk_command=
 *cmd,
+				struct stk_response *rsp, struct ofono_stk *stk)
+{
+	switch (cmd->qualifier) {
+	case 3:
+		DBG("Date, time and time zone");
+		get_time(rsp, stk);
+		return FALSE;
+
+	case 4:
+		DBG("Language setting");
+		get_lang(rsp, stk);
+		return FALSE;
+
+	default:
+		ofono_info("Unsupported Provide Local Info qualifier: %d",
+				cmd->qualifier);
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+}
+
 static void send_dtmf_cancel(struct ofono_stk *stk)
 {
 	struct ofono_voicecall *vc =3D NULL;
@@ -2427,6 +2507,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO:
+		respond =3D handle_command_provide_local_info(stk->pending_cmd,
+								&rsp, stk);
+		break;
+
 	case STK_COMMAND_TYPE_SEND_DTMF:
 		respond =3D handle_command_send_dtmf(stk->pending_cmd,
 							&rsp, stk);
-- =

1.7.2.3


--===============9007348187336413454==--


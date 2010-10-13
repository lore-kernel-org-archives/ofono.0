Content-Type: multipart/mixed; boundary="===============6861696144187881873=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/13] stk: Simplify and add icon to alphaId api.
Date: Wed, 13 Oct 2010 15:54:12 +0200
Message-ID: <1286978056-16600-9-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1286978056-16600-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6861696144187881873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The assumption is now that stk_alpha_id_set will handle NULL
or empty alphaIds or icons.
---
 src/stk.c |   36 ++++++++++--------------------------
 1 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 863a6dd..01f4e0b 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -409,7 +409,8 @@ static void dict_append_menu(DBusMessageIter *dict, str=
uct stk_menu *menu)
 	dbus_message_iter_close_container(dict, &entry);
 }
 =

-static void stk_alpha_id_set(struct ofono_stk *stk, const char *text)
+static void stk_alpha_id_set(struct ofono_stk *stk, const char *text,
+		const struct stk_icon_id *icon)
 {
 	/* TODO */
 }
@@ -701,10 +702,6 @@ static void send_sms_cancel(struct ofono_stk *stk)
 {
 	stk->extern_req->cancelled =3D TRUE;
 =

-	if (!stk->pending_cmd->send_sms.alpha_id ||
-			!stk->pending_cmd->send_sms.alpha_id[0])
-		return;
-
 	stk_alpha_id_unset(stk);
 }
 =

@@ -723,9 +720,7 @@ static void send_sms_submit_cb(gboolean ok, void *data)
 		return;
 	}
 =

-	if (stk->pending_cmd->send_sms.alpha_id &&
-			stk->pending_cmd->send_sms.alpha_id[0])
-		stk_alpha_id_unset(stk);
+	stk_alpha_id_unset(stk);
 =

 	memset(&rsp, 0, sizeof(rsp));
 =

@@ -774,8 +769,7 @@ static gboolean handle_command_send_sms(const struct st=
k_command *cmd,
 =

 	stk->cancel_cmd =3D send_sms_cancel;
 =

-	if (cmd->send_sms.alpha_id && cmd->send_sms.alpha_id[0])
-		stk_alpha_id_set(stk, cmd->send_sms.alpha_id);
+	stk_alpha_id_set(stk, cmd->send_sms.alpha_id, &cmd->send_sms.icon_id);
 =

 	return FALSE;
 }
@@ -1663,9 +1657,7 @@ static void send_ussd_cancel(struct ofono_stk *stk)
 	if (ussd)
 		__ofono_ussd_initiate_cancel(ussd);
 =

-	if (stk->pending_cmd->send_ussd.alpha_id &&
-			stk->pending_cmd->send_ussd.alpha_id[0])
-		stk_alpha_id_unset(stk);
+	stk_alpha_id_unset(stk);
 }
 =

 static void send_ussd_callback(int error, int dcs, const unsigned char *ms=
g,
@@ -1677,9 +1669,7 @@ static void send_ussd_callback(int error, int dcs, co=
nst unsigned char *msg,
 	enum sms_charset charset;
 	unsigned char no_cause[] =3D { 0x00 };
 =

-	if (stk->pending_cmd->send_ussd.alpha_id &&
-			stk->pending_cmd->send_ussd.alpha_id[0])
-		stk_alpha_id_unset(stk);
+	stk_alpha_id_unset(stk);
 =

 	memset(&rsp, 0, sizeof(rsp));
 =

@@ -1811,8 +1801,7 @@ static gboolean handle_command_send_ussd(const struct=
 stk_command *cmd,
 		return TRUE;
 	}
 =

-	if (cmd->send_ussd.alpha_id && cmd->send_ussd.alpha_id[0])
-		stk_alpha_id_set(stk, cmd->send_ussd.alpha_id);
+	stk_alpha_id_set(stk, cmd->send_ussd.alpha_id, &cmd->send_ussd.icon_id);
 =

 	return FALSE;
 }
@@ -1883,9 +1872,7 @@ static void send_dtmf_cancel(struct ofono_stk *stk)
 	stk->respond_on_exit =3D FALSE;
 	stk->extern_req->cancelled =3D TRUE;
 =

-	if (stk->pending_cmd->send_dtmf.alpha_id &&
-			stk->pending_cmd->send_dtmf.alpha_id[0])
-		stk_alpha_id_unset(stk);
+	stk_alpha_id_unset(stk);
 }
 =

 static void dtmf_sent_cb(const struct ofono_error *error, void *user_data)
@@ -1904,9 +1891,7 @@ static void dtmf_sent_cb(const struct ofono_error *er=
ror, void *user_data)
 =

 	stk->respond_on_exit =3D FALSE;
 =

-	if (stk->pending_cmd->send_dtmf.alpha_id &&
-			stk->pending_cmd->send_dtmf.alpha_id[0])
-		stk_alpha_id_unset(stk);
+	stk_alpha_id_unset(stk);
 =

 	if (error->type =3D=3D OFONO_ERROR_TYPE_FAILURE &&
 			error->error =3D=3D ENOENT) {
@@ -2006,8 +1991,7 @@ static gboolean handle_command_send_dtmf(const struct=
 stk_command *cmd,
 		return TRUE;
 	}
 =

-	if (cmd->send_dtmf.alpha_id && cmd->send_dtmf.alpha_id[0])
-		stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id);
+	stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id, &cmd->send_dtmf.icon_id);
 =

 	/*
 	 * Note that we don't strictly require an agent to be connected,
-- =

1.7.1.86.g0e460.dirty


--===============6861696144187881873==--


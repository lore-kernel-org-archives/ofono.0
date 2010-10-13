Content-Type: multipart/mixed; boundary="===============2344305870752087647=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 13/13] [RfC] API for STK driver to signal executed commands.
Date: Wed, 13 Oct 2010 15:54:16 +0200
Message-ID: <1286978056-16600-13-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1286978056-16600-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2344305870752087647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some modems are able to handle some proactive commands in their
firmware or otherwise, if the command doesn't require input from user.
Nevertheles ofono may need to update internal state or notify the user
where necessary.  With this api the driver can notify core that a
command is being executed in the modem or that a command is finished
executing and the TERMINAL RESPONSE has been sent to SIM.  It would
also be possible for a driver to handle a command.
---
 include/stk.h |    7 +++++++
 src/stk.c     |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/include/stk.h b/include/stk.h
index 638da9c..8f548d3 100644
--- a/include/stk.h
+++ b/include/stk.h
@@ -67,6 +67,13 @@ void ofono_stk_proactive_command_notify(struct ofono_stk=
 *stk,
 =

 void ofono_stk_proactive_session_end_notify(struct ofono_stk *stk);
 =

+void ofono_stk_proactive_command_handled_notify(struct ofono_stk *stk,
+						int length,
+						const unsigned char *pdu);
+void ofono_stk_terminal_response_sent_notify(struct ofono_stk *stk,
+						int length,
+						const unsigned char *pdu);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/stk.c b/src/stk.c
index b3d2b40..69a5353 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -2431,6 +2431,45 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 		stk_command_cb(&error, stk);
 }
 =

+void ofono_stk_proactive_command_handled_notify(struct ofono_stk *stk,
+						int length,
+						const unsigned char *pdu)
+{
+	struct stk_command *cmd;
+
+	stk_proactive_command_cancel(stk);
+
+	cmd =3D stk_command_new_from_pdu(pdu, length);
+
+	if (!cmd || cmd->status !=3D STK_PARSE_RESULT_OK) {
+		ofono_error("Can't parse proactive command");
+
+		if (cmd)
+			stk_command_free(cmd);
+		return;
+	}
+
+	switch (cmd->type) {
+	case STK_COMMAND_TYPE_MORE_TIME:
+		break;
+
+	case STK_COMMAND_TYPE_SEND_SMS:
+		stk_alpha_id_set(stk, cmd->send_sms.alpha_id,
+					&cmd->send_sms.text_attr,
+					&cmd->send_sms.icon_id);
+		break;
+	}
+
+	stk_command_free(cmd);
+}
+
+void ofono_stk_terminal_response_sent_notify(struct ofono_stk *stk,
+						int length,
+						const unsigned char *pdu)
+{
+	stk_alpha_id_unset(stk);
+}
+
 int ofono_stk_driver_register(const struct ofono_stk_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
-- =

1.7.1.86.g0e460.dirty


--===============2344305870752087647==--


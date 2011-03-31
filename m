Content-Type: multipart/mixed; boundary="===============3966833979207795480=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] stk: Check if terminal is busy before SIM Refresh.
Date: Thu, 31 Mar 2011 15:40:56 +0200
Message-ID: <1301578857-3790-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3966833979207795480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++-----------=
----
 1 files changed, 71 insertions(+), 23 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 780e0c2..01e14db 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1924,51 +1924,52 @@ static void send_ussd_callback(int error, int dcs, =
const unsigned char *msg,
 	}
 }
 =

-static gboolean handle_command_send_ussd(const struct stk_command *cmd,
-					struct stk_response *rsp,
-					struct ofono_stk *stk)
+static gboolean ss_is_busy(struct ofono_modem *modem)
 {
-	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
-	static unsigned char busy_on_ss_result[] =3D { 0x03 };
-	static unsigned char busy_on_ussd_result[] =3D { 0x08 };
 	struct ofono_atom *atom;
-	struct ofono_ussd *ussd;
-	int err;
 =

 	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_FORWARDING);
 	if (atom && __ofono_atom_get_registered(atom)) {
 		struct ofono_call_forwarding *cf =3D __ofono_atom_get_data(atom);
 =

-		if (__ofono_call_forwarding_is_busy(cf)) {
-			ADD_ERROR_RESULT(rsp->result,
-						STK_RESULT_TYPE_TERMINAL_BUSY,
-						busy_on_ss_result);
+		if (__ofono_call_forwarding_is_busy(cf))
 			return TRUE;
-		}
 	}
 =

 	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_BARRING);
 	if (atom && __ofono_atom_get_registered(atom)) {
 		struct ofono_call_barring *cb =3D __ofono_atom_get_data(atom);
 =

-		if (__ofono_call_barring_is_busy(cb)) {
-			ADD_ERROR_RESULT(rsp->result,
-						STK_RESULT_TYPE_TERMINAL_BUSY,
-						busy_on_ss_result);
+		if (__ofono_call_barring_is_busy(cb))
 			return TRUE;
-		}
 	}
 =

 	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_SETTINGS);
 	if (atom && __ofono_atom_get_registered(atom)) {
 		struct ofono_call_settings *cs =3D __ofono_atom_get_data(atom);
 =

-		if (__ofono_call_settings_is_busy(cs)) {
-			ADD_ERROR_RESULT(rsp->result,
-						STK_RESULT_TYPE_TERMINAL_BUSY,
-						busy_on_ss_result);
+		if (__ofono_call_settings_is_busy(cs))
 			return TRUE;
-		}
+	}
+
+	return FALSE;
+}
+
+static gboolean handle_command_send_ussd(const struct stk_command *cmd,
+					struct stk_response *rsp,
+					struct ofono_stk *stk)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	static unsigned char busy_on_ss_result[] =3D { 0x03 };
+	static unsigned char busy_on_ussd_result[] =3D { 0x08 };
+	struct ofono_atom *atom;
+	struct ofono_ussd *ussd;
+	int err;
+
+	if (ss_is_busy(modem)) {
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					busy_on_ss_result);
+		return TRUE;
 	}
 =

 	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_USSD);
@@ -2029,6 +2030,11 @@ static gboolean handle_command_refresh(const struct =
stk_command *cmd,
 	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
 	struct ofono_sim *sim =3D NULL;
 	struct ofono_atom *sim_atom;
+	struct ofono_ussd *ussd =3D NULL;
+	struct ofono_atom *ussd_atom;
+	struct ofono_voicecall *vc =3D NULL;
+	struct ofono_atom *vc_atom;
+	uint8_t addnl_info[1];
 	int err;
 	GSList *l;
 =

@@ -2098,6 +2104,48 @@ static gboolean handle_command_refresh(const struct =
stk_command *cmd,
 		return TRUE;
 	}
 =

+	if (rsp !=3D NULL) {
+		ussd_atom =3D __ofono_modem_find_atom(
+					__ofono_atom_get_modem(stk->atom),
+					OFONO_ATOM_TYPE_USSD);
+		if (ussd_atom)
+			ussd =3D __ofono_atom_get_data(ussd_atom);
+
+		if (ussd && __ofono_ussd_is_busy(ussd)) {
+			addnl_info[0] =3D STK_RESULT_ADDNL_ME_PB_USSD_BUSY;
+
+			ADD_ERROR_RESULT(rsp->result,
+					STK_RESULT_TYPE_TERMINAL_BUSY,
+					addnl_info);
+			return TRUE;
+		}
+
+		vc_atom =3D __ofono_modem_find_atom(
+					__ofono_atom_get_modem(stk->atom),
+					OFONO_ATOM_TYPE_VOICECALL);
+		if (vc_atom)
+			vc =3D __ofono_atom_get_data(vc_atom);
+
+		if (vc && __ofono_voicecall_is_busy(vc,
+					OFONO_VOICECALL_INTERACTION_NONE)) {
+			addnl_info[0] =3D STK_RESULT_ADDNL_ME_PB_BUSY_ON_CALL;
+
+			ADD_ERROR_RESULT(rsp->result,
+					STK_RESULT_TYPE_TERMINAL_BUSY,
+					addnl_info);
+			return TRUE;
+		}
+
+		if (ss_is_busy(__ofono_atom_get_modem(stk->atom))) {
+			addnl_info[0] =3D STK_RESULT_ADDNL_ME_PB_SS_BUSY;
+
+			ADD_ERROR_RESULT(rsp->result,
+					STK_RESULT_TYPE_TERMINAL_BUSY,
+					addnl_info);
+			return TRUE;
+		}
+	}
+
 	/*
 	 * For now we can handle the Refresh types that don't require
 	 * a SIM reset except if that part of the task has been already
-- =

1.7.1.86.g0e460.dirty


--===============3966833979207795480==--


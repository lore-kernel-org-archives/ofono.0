Content-Type: multipart/mixed; boundary="===============1875363883446689951=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/4] stk: convert to phone number format
Date: Wed, 05 Sep 2012 19:19:36 +0200
Message-ID: <1346865579-24794-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346865579-24794-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1875363883446689951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The dialing number provided by the Setup Call proactive command
may contain pause and DTMF characters.
---
 src/stk.c |   50 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 19cb0eb..5c79183 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -104,6 +104,27 @@ static void timers_update(struct ofono_stk *stk);
 		result.additional_len =3D sizeof(addn_info);	\
 		result.additional =3D addn_info;			\
 =

+static gboolean convert_to_phone_number_format(const char *input_str,
+							char *output_str)
+{
+	char *digit;
+	char *digit_from =3D "01234567890abcABC";
+	char *digit_to =3D "01234567890*#p*#p";
+	int pos;
+
+	for (pos =3D 0; input_str[pos] !=3D '\0'; pos++) {
+		digit =3D strchr(digit_from, input_str[pos]);
+		if (digit =3D=3D NULL)
+			return FALSE;
+
+		output_str[pos] =3D digit_to[digit - digit_from];
+	}
+
+	output_str[pos] =3D '\0';
+
+	return TRUE;
+}
+
 static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 			ofono_stk_generic_cb_t cb)
 {
@@ -1715,6 +1736,7 @@ static void confirm_call_cb(enum stk_agent_result res=
ult, gboolean confirm,
 	char *alpha_id =3D NULL;
 	struct ofono_voicecall *vc;
 	struct stk_response rsp;
+	char number[256];
 	int err;
 =

 	switch (result) {
@@ -1752,7 +1774,13 @@ static void confirm_call_cb(enum stk_agent_result re=
sult, gboolean confirm,
 		}
 	}
 =

-	err =3D __ofono_voicecall_dial(vc, sc->addr.number, sc->addr.ton_npi,
+	/* Convert the setup call number to phone number format */
+	if (convert_to_phone_number_format(sc->addr.number, number) =3D=3D FALSE)=
 {
+		send_simple_response(stk, STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD);
+		return;
+	}
+
+	err =3D __ofono_voicecall_dial(vc, number, sc->addr.ton_npi,
 					alpha_id, sc->icon_id_call_setup.id,
 					qualifier >> 1, call_setup_connected,
 					stk);
@@ -2353,10 +2381,8 @@ static gboolean handle_command_send_dtmf(const struc=
t stk_command *cmd,
 {
 	static unsigned char not_in_speech_call_result[] =3D { 0x07 };
 	struct ofono_voicecall *vc =3D NULL;
-	char dtmf[256], *digit;
-	char *dtmf_from =3D "01234567890abcABC";
-	char *dtmf_to =3D "01234567890*#p*#p";
-	int err, pos;
+	char dtmf[256];
+	int err;
 =

 	vc =3D __ofono_atom_find(OFONO_ATOM_TYPE_VOICECALL,
 				__ofono_atom_get_modem(stk->atom));
@@ -2366,18 +2392,12 @@ static gboolean handle_command_send_dtmf(const stru=
ct stk_command *cmd,
 	}
 =

 	/* Convert the DTMF string to phone number format */
-	for (pos =3D 0; cmd->send_dtmf.dtmf[pos] !=3D '\0'; pos++) {
-		digit =3D strchr(dtmf_from, cmd->send_dtmf.dtmf[pos]);
-		if (digit =3D=3D NULL) {
-			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
-			return TRUE;
-		}
-
-		dtmf[pos] =3D dtmf_to[digit - dtmf_from];
+	if (convert_to_phone_number_format(cmd->send_dtmf.dtmf, dtmf) =3D=3D
+						FALSE) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
 	}
 =

-	dtmf[pos] =3D '\0';
-
 	err =3D __ofono_voicecall_tone_send(vc, dtmf, dtmf_sent_cb, stk);
 =

 	if (err =3D=3D -ENOSYS) {
-- =

1.7.9.5


--===============1875363883446689951==--


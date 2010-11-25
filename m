Content-Type: multipart/mixed; boundary="===============5753922065828660150=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 2/3] stk: Handle provide local info proactive command
Date: Fri, 26 Nov 2010 00:36:55 +0100
Message-ID: <AANLkTi=B2mLx4REV_h9SGWnZA65kJ+=HxebbXH=_Eb=m@mail.gmail.com>
In-Reply-To: <1290688142-14726-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5753922065828660150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 25 November 2010 13:29, Yang Gu <yang.gu@intel.com> wrote:
> ---
> =C2=A0src/smsutil.c =C2=A0| =C2=A0 =C2=A06 +-
> =C2=A0src/stk.c =C2=A0 =C2=A0 =C2=A0| =C2=A0113 +++++++++++++++++++++++++=
++++++++++++++++
> =C2=A0src/stkagent.c | =C2=A0153 ++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A0src/stkagent.h | =C2=A0 14 +++++
> =C2=A0src/stkutil.c =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A05 files changed, 284 insertions(+), 4 deletions(-)
>
> diff --git a/src/smsutil.c b/src/smsutil.c
> index e6dbf5f..5394817 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -324,10 +324,10 @@ gboolean sms_encode_scts(const struct sms_scts *in,=
 unsigned char *pdu,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (in->year > 99)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
>
> - =C2=A0 =C2=A0 =C2=A0 if (in->month > 12)
> + =C2=A0 =C2=A0 =C2=A0 if (in->month > 12 || in->month =3D=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
>
> - =C2=A0 =C2=A0 =C2=A0 if (in->day > 31)
> + =C2=A0 =C2=A0 =C2=A0 if (in->day > 31 || in->day =3D=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (in->hour > 23)
> @@ -339,7 +339,7 @@ gboolean sms_encode_scts(const struct sms_scts *in, u=
nsigned char *pdu,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (in->second > 59)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
>
> - =C2=A0 =C2=A0 =C2=A0 if ((in->timezone > 12*4-1) || (in->timezone < -(1=
2*4-1)))
> + =C2=A0 =C2=A0 =C2=A0 if ((in->timezone > 12*4) || (in->timezone < -(12*=
4-1)))

Please ignore my comment about the range in the other, because you
already fixed this :)

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pdu =3D pdu + *offset;
> diff --git a/src/stk.c b/src/stk.c
> index ac2e646..1f3817f 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -1992,6 +1992,114 @@ static gboolean handle_command_refresh(const stru=
ct stk_command *cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return TRUE;
> =C2=A0}
>
> +static void request_time_cb(enum stk_agent_result result, unsigned char =
year,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char month, unsigned char day,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char hour, unsigned char minute,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char second, char timezone,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *user_data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *stk =3D user_data;
> + =C2=A0 =C2=A0 =C2=A0 static struct ofono_error error =3D { .type =3D OF=
ONO_ERROR_TYPE_FAILURE };
> + =C2=A0 =C2=A0 =C2=A0 struct stk_response rsp;
> +
> + =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (result) {
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_OK:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&rsp, 0, sizeof=
(rsp));
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D ST=
K_RESULT_TYPE_SUCCESS;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.provide_local_info=
.datetime.year =3D year;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.provide_local_info=
.datetime.month =3D month;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.provide_local_info=
.datetime.day =3D day;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.provide_local_info=
.datetime.hour =3D hour;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.provide_local_info=
.datetime.minute =3D minute;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.provide_local_info=
.datetime.second =3D second;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.provide_local_info=
.datetime.timezone =3D timezone;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stk_respond(stk, &=
rsp, stk_command_cb))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 stk_command_cb(&error, stk);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_BACK:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_GO_BACK);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;

Note that "Backward move", "No reponse" and "User terminated" are not
allowed responses for Provide Local Info in TS102.223 6.11.

> +
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_TIMEOUT:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_NO_RESPONSE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_TERMINATE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_USER_TERMINATED);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static void request_lang_cb(enum stk_agent_result result, char *lang,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *user_data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *stk =3D user_data;
> + =C2=A0 =C2=A0 =C2=A0 static struct ofono_error error =3D { .type =3D OF=
ONO_ERROR_TYPE_FAILURE };
> + =C2=A0 =C2=A0 =C2=A0 struct stk_response rsp;
> +
> + =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (result) {
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_OK:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&rsp, 0, sizeof=
(rsp));
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D ST=
K_RESULT_TYPE_SUCCESS;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.provide_local_info=
.language =3D lang;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stk_respond(stk, &=
rsp, stk_command_cb))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 stk_command_cb(&error, stk);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_BACK:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_GO_BACK);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_TIMEOUT:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_NO_RESPONSE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_TERMINATE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_USER_TERMINATED);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static gboolean handle_command_provide_local_info(const struct stk_comma=
nd *cmd,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stk_response *rsp, struct ofono_s=
tk *stk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int timeout =3D stk->timeout * 1000;
> + =C2=A0 =C2=A0 =C2=A0 int err;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (cmd->qualifier) {
> + =C2=A0 =C2=A0 =C2=A0 case 3:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Date, time and ti=
me zone");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D stk_agent_requ=
est_time(stk->current_agent,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 request_time_cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 stk, NULL, timeout);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 case 4:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Language setting"=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D stk_agent_requ=
est_lang(stk->current_agent,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 request_lang_cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 stk, NULL, timeout);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_info("Unsupporte=
d Provide Local Info qualifier: %d",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd->qualifier);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp->result.type =3D S=
TK_RESULT_TYPE_NOT_CAPABLE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> =C2=A0static void send_dtmf_cancel(struct ofono_stk *stk)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_voicecall *vc =3D NULL;
> @@ -2424,6 +2532,11 @@ void ofono_stk_proactive_command_notify(struct ofo=
no_stk *stk,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&rsp, stk);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>
> + =C2=A0 =C2=A0 =C2=A0 case STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 respond =3D handle_com=
mand_provide_local_info(stk->pending_cmd,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
rsp, stk);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case STK_COMMAND_TYPE_SEND_DTMF:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0respond =3D handle=
_command_send_dtmf(stk->pending_cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&rsp, stk);
> diff --git a/src/stkagent.c b/src/stkagent.c
> index 5cf83e4..78620d5 100644
> --- a/src/stkagent.c
> +++ b/src/stkagent.c
> @@ -956,3 +956,156 @@ int stk_agent_loop_tone(struct stk_agent *agent, co=
nst char *text,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
> +
> +static void get_time_cb(DBusPendingCall *call, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct stk_agent *agent =3D data;
> + =C2=A0 =C2=A0 =C2=A0 stk_agent_time_cb cb =3D agent->user_cb;
> + =C2=A0 =C2=A0 =C2=A0 DBusMessage *reply =3D dbus_pending_call_steal_rep=
ly(call);
> + =C2=A0 =C2=A0 =C2=A0 enum stk_agent_result result;
> + =C2=A0 =C2=A0 =C2=A0 gboolean remove_agent;
> + =C2=A0 =C2=A0 =C2=A0 int year_dbus;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char year;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char month;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char day;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char hour;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char minute;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char second;
> + =C2=A0 =C2=A0 =C2=A0 int timezone_dbus;
> + =C2=A0 =C2=A0 =C2=A0 char timezone;

I think you need to use "signed char" to achieve the same type as
int8_t/guin8 because the sign of "char" depends on the ABI.

> +
> + =C2=A0 =C2=A0 =C2=A0 if (check_error(agent, reply,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &result) =3D=3D -EINVAL) {

Go back and Terminate are not allowed for this command. (same comment as ab=
ove)

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_agent =3D TRUE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (result !=3D STK_AGENT_RESULT_OK) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cb(result, 0, 0, 0, 0,=
 0, 0, 0xFF, agent->user_data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto done;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (dbus_message_get_args(reply, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_IN=
T32, &year_dbus,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_BY=
TE, &month,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_BY=
TE, &day,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_BY=
TE, &hour,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_BY=
TE, &minute,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_BY=
TE, &second,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_IN=
T32, &timezone_dbus,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_IN=
VALID) =3D=3D FALSE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("Can't par=
se the reply to RequestTime()");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_agent =3D TRUE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (year_dbus < 1900) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("Invalid y=
ear");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_agent =3D TRUE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 }

I believe the range is actually 1970-2069 or similar (only values 0-99
in the sms header are allowed)

> +
> + =C2=A0 =C2=A0 =C2=A0 if (year_dbus >=3D 2000)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 year =3D year_dbus - 2=
000;
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 year =3D year_dbus - 1=
900;
> +
> + =C2=A0 =C2=A0 =C2=A0 timezone =3D timezone_dbus;
> +
> + =C2=A0 =C2=A0 =C2=A0 cb(result, year, month, day, hour, minute, second,=
 timezone,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 agent->user_data);
> +
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_END();
> +}
> +
> +int stk_agent_request_time(struct stk_agent *agent, stk_agent_time_cb cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *user_data, ofono_destroy_func dest=
roy,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int timeout)
> +{
> + =C2=A0 =C2=A0 =C2=A0 DBusConnection *conn =3D ofono_dbus_get_connection=
();
> +
> + =C2=A0 =C2=A0 =C2=A0 agent->msg =3D dbus_message_new_method_call(agent-=
>bus, agent->path,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_SIM_APP_INTERFACE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "RequestTime");
> + =C2=A0 =C2=A0 =C2=A0 if (agent->msg =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 dbus_message_append_args(agent->msg, DBUS_TYPE_INV=
ALID);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (dbus_connection_send_with_reply(conn, agent->m=
sg, &agent->call,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 timeout) =3D=3D FALSE ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 agent->call =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
> +
> + =C2=A0 =C2=A0 =C2=A0 agent->user_cb =3D cb;
> + =C2=A0 =C2=A0 =C2=A0 agent->user_data =3D user_data;
> + =C2=A0 =C2=A0 =C2=A0 agent->user_destroy =3D destroy;
> +
> + =C2=A0 =C2=A0 =C2=A0 dbus_pending_call_set_notify(agent->call, get_time=
_cb, agent, NULL);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static void get_lang_cb(DBusPendingCall *call, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct stk_agent *agent =3D data;
> + =C2=A0 =C2=A0 =C2=A0 stk_agent_string_cb cb =3D agent->user_cb;
> + =C2=A0 =C2=A0 =C2=A0 DBusMessage *reply =3D dbus_pending_call_steal_rep=
ly(call);
> + =C2=A0 =C2=A0 =C2=A0 enum stk_agent_result result;
> + =C2=A0 =C2=A0 =C2=A0 gboolean remove_agent;
> + =C2=A0 =C2=A0 =C2=A0 char *lang;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (check_error(agent, reply,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &result) =3D=3D -EINVAL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_agent =3D TRUE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (result !=3D STK_AGENT_RESULT_OK) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cb(result, NULL, agent=
->user_data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto done;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (dbus_message_get_args(reply, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_ST=
RING, &lang,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_IN=
VALID) =3D=3D FALSE ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 strlen(lang) !=3D 2) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("Can't par=
se the reply to RequestLanguage()");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_agent =3D TRUE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 cb(result, lang, agent->user_data);
> +
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_END();
> +}
> +
> +int stk_agent_request_lang(struct stk_agent *agent, stk_agent_string_cb =
cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *user_data, ofono_destroy_func dest=
roy,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int timeout)
> +{
> + =C2=A0 =C2=A0 =C2=A0 DBusConnection *conn =3D ofono_dbus_get_connection=
();
> +
> + =C2=A0 =C2=A0 =C2=A0 agent->msg =3D dbus_message_new_method_call(agent-=
>bus, agent->path,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_SIM_APP_INTERFACE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "RequestLanguage");
> + =C2=A0 =C2=A0 =C2=A0 if (agent->msg =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 dbus_message_append_args(agent->msg, DBUS_TYPE_INV=
ALID);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (dbus_connection_send_with_reply(conn, agent->m=
sg, &agent->call,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 timeout) =3D=3D FALSE ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 agent->call =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
> +
> + =C2=A0 =C2=A0 =C2=A0 agent->user_cb =3D cb;
> + =C2=A0 =C2=A0 =C2=A0 agent->user_data =3D user_data;
> + =C2=A0 =C2=A0 =C2=A0 agent->user_destroy =3D destroy;
> +
> + =C2=A0 =C2=A0 =C2=A0 dbus_pending_call_set_notify(agent->call, get_lang=
_cb, agent, NULL);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> diff --git a/src/stkagent.h b/src/stkagent.h
> index c8e1886..a60cf23 100644
> --- a/src/stkagent.h
> +++ b/src/stkagent.h
> @@ -59,6 +59,12 @@ typedef void (*stk_agent_string_cb)(enum stk_agent_res=
ult result,
> =C2=A0typedef void (*stk_agent_tone_cb)(enum stk_agent_result result,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0void *user_data);
>
> +typedef void (*stk_agent_time_cb)(enum stk_agent_result result,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char year, unsigned char month,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char day, unsigned char hour,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char minute, unsigned char seco=
nd,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char timezone, void *user_data);
> +
> =C2=A0struct stk_agent *stk_agent_new(const char *path, const char *sende=
r,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_boo=
l_t remove_on_terminate);
>
> @@ -136,3 +142,11 @@ int stk_agent_loop_tone(struct stk_agent *agent, con=
st char *text,
>
> =C2=A0void append_menu_items_variant(DBusMessageIter *iter,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct stk_menu_item *items);
> +
> +int stk_agent_request_time(struct stk_agent *agent, stk_agent_time_cb cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 void *user_data, ofono_destroy_func destroy,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 int timeout);
> +
> +int stk_agent_request_lang(struct stk_agent *agent, stk_agent_string_cb =
cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 void *user_data, ofono_destroy_func destroy,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 int timeout);
> diff --git a/src/stkutil.c b/src/stkutil.c
> index 377ceff..48ce93b 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -4553,7 +4553,7 @@ static gboolean build_dataobj_datetime_timezone(str=
uct stk_tlv_builder *tlv,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TRUE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Time zone information is optional */
> - =C2=A0 =C2=A0 =C2=A0 if (scts->timezone =3D=3D (gint8) 0xff) {
> + =C2=A0 =C2=A0 =C2=A0 if (scts->timezone =3D=3D -48) {

Ah, -48 is also a good value :)

But wouldn't the parser also need to translate 0xff into -48?

Best regards

--===============5753922065828660150==--


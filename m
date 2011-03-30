Content-Type: multipart/mixed; boundary="===============3182910014594121110=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 3/6] stk: Introduce BIP command handlers
Date: Wed, 30 Mar 2011 12:08:50 +0200
Message-ID: <AANLkTi=J6wq1r6M2h1GV4LGAFXeZ+KLoNMN1tHNKp5dV@mail.gmail.com>
In-Reply-To: <1300798280-4281-4-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3182910014594121110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I understand that this is a stub but I have some comments just for referenc=
e.

On 22 March 2011 13:51, Philippe Nunes <philippe.nunes@linux.intel.com> w=
rote:
> ---
> =C2=A0src/stk.c | =C2=A0307 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A01 files changed, 307 insertions(+), 0 deletions(-)
>
> diff --git a/src/stk.c b/src/stk.c
> index 68b6240..d224360 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -79,6 +79,9 @@ struct ofono_stk {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__ofono_sms_sim_download_cb_t sms_pp_cb;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void *sms_pp_userdata;
> + =C2=A0 =C2=A0 =C2=A0 struct stk_channel channel;
> + =C2=A0 =C2=A0 =C2=A0 struct stk_channel_data rx_buffer;
> + =C2=A0 =C2=A0 =C2=A0 struct stk_channel_data tx_buffer;
> =C2=A0};
>
> =C2=A0struct envelope_op {
> @@ -2548,6 +2551,285 @@ static gboolean handle_command_launch_browser(con=
st struct stk_command *cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
> =C2=A0}
>
> +static void confirm_open_channel_cb(enum stk_agent_result result,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gboolean con=
firm,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *user_d=
ata)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *stk =3D user_data;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char no_cause[] =3D { 0x00 };
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_error failure =3D { .type =3D OFONO_E=
RROR_TYPE_FAILURE };
> + =C2=A0 =C2=A0 =C2=A0 struct stk_response rsp;
> +
> + =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (result) {
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_TERMINATE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_USER_TERMINATED);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_TIMEOUT:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 confirm =3D FALSE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fall through */
> +
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_OK:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (confirm)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fall through */
> +
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&rsp, 0, sizeof=
(rsp));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADD_ERROR_RESULT(rsp.r=
esult, STK_RESULT_TYPE_TERMINAL_BUSY,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_cause);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stk_respond(stk, &=
rsp, stk_command_cb))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 stk_command_cb(&failure, stk);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* setup the channel
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> +
> + =C2=A0 =C2=A0 =C2=A0 /* For now, return =C2=A0"Command beyond terminal'=
s capabilities" */
> + =C2=A0 =C2=A0 =C2=A0 send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPA=
BLE);
> +}
> +
> +static gboolean handle_command_open_channel(const struct stk_command *cm=
d,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct stk_response *rsp,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct ofono_stk *stk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const struct stk_command_open_channel *oc =3D &cmd=
->open_channel;
> + =C2=A0 =C2=A0 =C2=A0 char *alpha_id;
> + =C2=A0 =C2=A0 =C2=A0 int err;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Don't ask for user confirmation if AID is a nul=
l data object*/
> + =C2=A0 =C2=A0 =C2=A0 if (oc->alpha_id && strlen(oc->alpha_id) =3D=3D 0)=
 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* setup the chan=
nel
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* For now, return =C2=
=A0"Command beyond terminal's capabilities" */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp->result.type =3D S=
TK_RESULT_TYPE_NOT_CAPABLE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 alpha_id =3D dbus_apply_text_attributes(oc->alpha_=
id ? oc->alpha_id : "",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &oc->text_attr);
> + =C2=A0 =C2=A0 =C2=A0 if (alpha_id =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp->result.type =3D S=
TK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D stk_agent_confirm_open_channel(stk->curren=
t_agent, alpha_id,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &oc->icon_id,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 confirm_open_channel_cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 stk, NULL, stk->timeout * 1000);
> + =C2=A0 =C2=A0 =C2=A0 g_free(alpha_id);

What if no AlphaId or Icon are provided?  Also why don't we just use
stk_alpha_id_set?

Another thing, is that AFAICS this series wants to support only one
channel at a time, right?  Then we need to check if a channel is
already open (non-NULL) and return "busy".  In the
close/transmit/receive functions we need to make sure that the channel
is non NULL and the channel id matches.

Also it looks like the patches are in reverse order because unit tests
are added before implementation, and stk.c functions are added before
stkagent.c functions.

> +
> + =C2=A0 =C2=A0 =C2=A0 if (err < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char no_cause=
_result[] =3D { 0x00 };
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We most likely=
 got an out of memory error, tell SIM
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* to retry
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADD_ERROR_RESULT(rsp->=
result, STK_RESULT_TYPE_TERMINAL_BUSY,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_cause_res=
ult);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D TRUE;
> + =C2=A0 =C2=A0 =C2=A0 stk->cancel_cmd =3D stk_request_cancel;
> +
> + =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +}
> +
> +static void channel_activity_cb(enum stk_agent_result result, void *user=
_data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *stk =3D user_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (result =3D=3D STK_AGENT_RESULT_TERMINATE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =
=3D FALSE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_USER_TERMINATED);
> + =C2=A0 =C2=A0 =C2=A0 }

Should we close the channel?

Best regards

--===============3182910014594121110==--


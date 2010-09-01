Content-Type: multipart/mixed; boundary="===============1693572580918421794=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 06/11] Send USSD proactive command handling
Date: Wed, 01 Sep 2010 18:43:21 +0200
Message-ID: <AANLkTi=7+r+pBq2AE+bVHYwPPzrMEeGSM3g5=jEBpGpe@mail.gmail.com>
In-Reply-To: <1283338836-13572-6-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1693572580918421794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 1 September 2010 13:00, Jeevaka Badrappan
<jeevaka.badrappan@elektrobit.com> wrote:
> ---
> =C2=A0src/stk.c | =C2=A0115 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A01 files changed, 115 insertions(+), 0 deletions(-)
>
> diff --git a/src/stk.c b/src/stk.c
> index 3fda2af..66a98b4 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -1590,6 +1590,117 @@ static gboolean handle_command_set_up_call(const =
struct stk_command *cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
> =C2=A0}
>
> +static void send_ussd_callback( int error, int dcs, const unsigned char*=
 msg,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int msg_len, void* userdata)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *stk =3D userdata;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_error failure =3D { .type =3D OFONO_E=
RROR_TYPE_FAILURE };
> + =C2=A0 =C2=A0 =C2=A0 struct stk_response rsp;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stk->pending_cmd->send_ussd.alpha_id &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->pending_cmd->send=
_ussd.alpha_id[0])
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk_alpha_id_unset(stk=
);
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (error) {
> + =C2=A0 =C2=A0 =C2=A0 case OFONO_USSD_FAILURE_NONE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&rsp, 0, sizeof=
(rsp));
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D ST=
K_RESULT_TYPE_SUCCESS;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.send_ussd.dcs =3D =
dcs;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.send_ussd.text =3D=
 g_memdup(msg, msg_len);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stk_respond(stk, &=
rsp, stk_command_cb))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 stk_command_cb(&failure, stk);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case OFONO_USSD_FAILURE_USER_TERMINATED:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_USSD_OR_SS_USER_TERMINATION);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case OFONO_USSD_FAILURE_TIMED_OUT:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_NETWORK_UNAVAILABLE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case OFONO_USSD_FAILURE_RETURN_ERROR:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_USSD_RETURN_ERROR);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static gboolean handle_command_send_ussd(const struct stk_command *cmd,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 stk_response *rsp,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 ofono_stk *stk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_modem *modem =3D __ofono_atom_get_mod=
em(stk->atom);
> + =C2=A0 =C2=A0 =C2=A0 static unsigned char busy_on_ss_result[] =3D { 0x0=
3 };
> + =C2=A0 =C2=A0 =C2=A0 static unsigned char busy_on_ussd_result[] =3D { 0=
x08 };
> + =C2=A0 =C2=A0 =C2=A0 int err;
> +
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_atom *cf_atom;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_atom *cb_atom;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_atom *cs_atom;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_atom *ussd_atom;
> +
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_call_forwarding *cf;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_call_barring *cb;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_call_settings *cs;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_ussd *ussd;
> +
> + =C2=A0 =C2=A0 =C2=A0 cf_atom =3D __ofono_modem_find_atom(modem, OFONO_A=
TOM_TYPE_CALL_FORWARDING);
> + =C2=A0 =C2=A0 =C2=A0 cb_atom =3D __ofono_modem_find_atom(modem, OFONO_A=
TOM_TYPE_CALL_BARRING);
> + =C2=A0 =C2=A0 =C2=A0 cs_atom =3D __ofono_modem_find_atom(modem, OFONO_A=
TOM_TYPE_CALL_SETTINGS);
> + =C2=A0 =C2=A0 =C2=A0 ussd_atom =3D __ofono_modem_find_atom(modem, OFONO=
_ATOM_TYPE_USSD);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!cf_atom || !__ofono_atom_get_registered(cf_at=
om) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !cb_atom || !__ofono_a=
tom_get_registered(cb_atom) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !cs_atom || !__ofono_a=
tom_get_registered(cs_atom)) {
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp->result.type =3D S=
TK_RESULT_TYPE_NOT_CAPABLE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
> + =C2=A0 =C2=A0 =C2=A0 }

Should this return "not capable" only when !ussd_atom?  If the other
atoms are missing I think we can assume they're not occupied.

Best regards

--===============1693572580918421794==--


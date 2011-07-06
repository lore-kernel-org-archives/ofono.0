Content-Type: multipart/mixed; boundary="===============6429879807664401510=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 3/4] stk: Handle set up call in handled_notify
Date: Wed, 06 Jul 2011 18:51:51 +0200
Message-ID: <CAOq732K8_9EY_TPcL7MwdNf99suB=H9efK6PeRzomgi260Lyvw@mail.gmail.com>
In-Reply-To: <1309946773-7747-4-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6429879807664401510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 6 July 2011 12:06, Jeevaka Badrappan
<jeevaka.badrappan@linux.intel.com> wrote:
> ---
> =C2=A0src/stk.c | =C2=A0108 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++-
> =C2=A01 files changed, 106 insertions(+), 2 deletions(-)
>
> diff --git a/src/stk.c b/src/stk.c
> index 9575f0e..26faa11 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -77,6 +77,8 @@ struct ofono_stk {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct timeval get_inkey_start_ts;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int dtmf_id;
>
> + =C2=A0 =C2=A0 =C2=A0 gboolean modem_handled_cmd;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__ofono_sms_sim_download_cb_t sms_pp_cb;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void *sms_pp_userdata;
> =C2=A0};
> @@ -1785,6 +1787,44 @@ static void confirm_call_cb(enum stk_agent_result =
result, gboolean confirm,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stk_command_cb(&er=
ror, stk);
> =C2=A0}
>
> +static void confirm_handled_call_cb(enum stk_agent_result result,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gboolean con=
firm, void *user_data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *stk =3D user_data;
> + =C2=A0 =C2=A0 =C2=A0 const struct stk_command_setup_call *sc =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &stk->pendin=
g_cmd->setup_call;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_voicecall *vc =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_atom *vc_atom;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stk->driver->user_confirmation =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (result !=3D STK_AGENT_RESULT_OK) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->driver->user_conf=
irmation(stk, FALSE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 stk->driver->user_confirmation(stk, confirm);
> +
> + =C2=A0 =C2=A0 =C2=A0 vc_atom =3D __ofono_modem_find_atom(__ofono_atom_g=
et_modem(stk->atom),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 OFONO_ATOM_TYPE_VOICECALL);
> + =C2=A0 =C2=A0 =C2=A0 if (vc_atom)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc =3D __ofono_atom_ge=
t_data(vc_atom);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (vc =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> +
> + =C2=A0 =C2=A0 =C2=A0 __ofono_voicecall_set_alpha_and_icon_id(vc, sc->al=
pha_id_call_setup,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 sc->icon_id_call_setup.id);
> +
> + =C2=A0 =C2=A0 =C2=A0 stk->modem_handled_cmd =3D TRUE;
> +
> + =C2=A0 =C2=A0 =C2=A0 return;
> +out:
> + =C2=A0 =C2=A0 =C2=A0 stk_command_free(stk->pending_cmd);
> + =C2=A0 =C2=A0 =C2=A0 stk->pending_cmd =3D NULL;
> +}
> +
> =C2=A0static gboolean handle_command_set_up_call(const struct stk_command=
 *cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct stk_response *rsp,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct ofono_stk *stk)
> @@ -2601,6 +2641,40 @@ static gboolean handle_command_launch_browser(cons=
t struct stk_command *cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
> =C2=A0}
>
> +static void handle_setup_call_confirmation_req(struct stk_command *cmd,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct ofono_stk *stk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const struct stk_command_setup_call *sc =3D &cmd->=
setup_call;
> + =C2=A0 =C2=A0 =C2=A0 int err;
> + =C2=A0 =C2=A0 =C2=A0 char *alpha_id =3D dbus_apply_text_attributes(
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc->alpha_id=
_usr_cfm ?
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sc->alpha_id=
_usr_cfm : "",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &sc->text_at=
tr_usr_cfm);
> + =C2=A0 =C2=A0 =C2=A0 if (alpha_id =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D stk_agent_confirm_call(stk->current_agent,=
 alpha_id,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &sc->icon_id=
_usr_cfm,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 confirm_hand=
led_call_cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->timeout=
 * 1000);
> + =C2=A0 =C2=A0 =C2=A0 g_free(alpha_id);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (err < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> +
> + =C2=A0 =C2=A0 =C2=A0 stk->pending_cmd =3D cmd;
> + =C2=A0 =C2=A0 =C2=A0 stk->cancel_cmd =3D stk_request_cancel;
> +
> + =C2=A0 =C2=A0 =C2=A0 return;
> +
> +out:
> + =C2=A0 =C2=A0 =C2=A0 if (stk->driver->user_confirmation)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->driver->user_conf=
irmation(stk, FALSE);
> +
> + =C2=A0 =C2=A0 =C2=A0 stk_command_free(cmd);
> +}
> +
> =C2=A0static void stk_proactive_command_cancel(struct ofono_stk *stk)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stk->immediate_response)
> @@ -2615,8 +2689,38 @@ static void stk_proactive_command_cancel(struct of=
ono_stk *stk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> +static void proactive_session_end_handled_cmd(struct ofono_stk *stk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 stk->modem_handled_cmd =3D FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch(stk->pending_cmd->type) {
> + =C2=A0 =C2=A0 =C2=A0 case STK_COMMAND_TYPE_SETUP_CALL:
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ofono_voicecall=
 *vc =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ofono_atom *vc_=
atom;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc_atom =3D __ofono_mo=
dem_find_atom(
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __ofono_atom=
_get_modem(stk->atom),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_ATOM_T=
YPE_VOICECALL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vc_atom)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 vc =3D __ofono_atom_get_data(vc_atom);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vc !=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 __ofono_voicecall_clear_alpha_and_icon_id(vc);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;

This part seems fragile.  A new command may arrive and the alpha id
and icon id won't be cleared.  Additionally modem_handled_cmd is not
reset when the pending_cmd is cancelled so it may affect a future
command.  Maybe voicecall.c should automatically clear the alpha &
icon id after the first new call?

Best regards

--===============6429879807664401510==--


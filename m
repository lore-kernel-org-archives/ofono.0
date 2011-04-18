Content-Type: multipart/mixed; boundary="===============4683570043027594792=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] stk: Clear 'respond_on_exit' flag after sending the
 terminal response
Date: Tue, 19 Apr 2011 01:33:20 +0200
Message-ID: <BANLkTinLsBpz9ZBspNM+uE+rep+wdJk2PA@mail.gmail.com>
In-Reply-To: <1302784842-13259-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4683570043027594792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 14 April 2011 14:40, Philippe Nunes <philippe.nunes@linux.intel.com> w=
rote:
> ---
> =C2=A0src/stk.c | =C2=A0 27 ++-------------------------
> =C2=A01 files changed, 2 insertions(+), 25 deletions(-)
>
> diff --git a/src/stk.c b/src/stk.c
> index c86cbfb..8214b65 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -128,6 +128,7 @@ static int stk_respond(struct ofono_stk *stk, struct =
stk_response *rsp,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stk_command_free(stk->pending_cmd);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stk->pending_cmd =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stk->cancel_cmd =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stk->driver->terminal_response(stk, tlv_len, t=
lv, cb, stk);
>

Overall this looks good.

> @@ -477,10 +478,8 @@ static void user_termination_cb(enum stk_agent_resul=
t result, void *user_data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_stk *stk =3D user_data;
>
> - =C2=A0 =C2=A0 =C2=A0 if (result =3D=3D STK_AGENT_RESULT_TERMINATE) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =
=3D FALSE;
> + =C2=A0 =C2=A0 =C2=A0 if (result =3D=3D STK_AGENT_RESULT_TERMINATE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0send_simple_respon=
se(stk, STK_RESULT_TYPE_USER_TERMINATED);
> - =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0}
>
> =C2=A0static void stk_alpha_id_set(struct ofono_stk *stk,
> @@ -598,7 +597,6 @@ static void default_agent_notify(gpointer user_data)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stk->default_agent =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stk->current_agent =3D stk->session_agent;
> - =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
> =C2=A0}
>
> =C2=A0static void session_agent_notify(gpointer user_data)
> @@ -617,7 +615,6 @@ static void session_agent_notify(gpointer user_data)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stk->session_agent =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stk->current_agent =3D stk->default_agent;
> - =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stk->remove_agent_source) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_source_remove(st=
k->remove_agent_source);
> @@ -1159,8 +1156,6 @@ static void request_selection_cb(enum stk_agent_res=
ult result, uint8_t id,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_stk *stk =3D user_data;
>
> - =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (result) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case STK_AGENT_RESULT_OK:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> @@ -1243,8 +1238,6 @@ static void display_text_cb(enum stk_agent_result r=
esult, void *user_data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static unsigned char screen_busy_result[] =3D =
{ 0x01 };
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static struct ofono_error error =3D { .type =
=3D OFONO_ERROR_TYPE_FAILURE };
>
> - =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * There are four possible paths for DisplayTe=
xt with immediate
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * response flag set:
> @@ -1386,8 +1379,6 @@ static void request_confirmation_cb(enum stk_agent_=
result result,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_command_get_inkey *cmd =3D &stk->pe=
nding_cmd->get_inkey;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_response rsp;
>
> - =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
> @@ -1442,8 +1433,6 @@ static void request_key_cb(enum stk_agent_result re=
sult, char *string,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_command_get_inkey *cmd =3D &stk->pe=
nding_cmd->get_inkey;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_response rsp;
>
> - =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (result) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case STK_AGENT_RESULT_OK:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&rsp, 0, si=
zeof(rsp));
> @@ -1560,8 +1549,6 @@ static void request_string_cb(enum stk_agent_result=
 result, char *string,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gboolean packed =3D (qualifier & (1 << 3)) !=
=3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_response rsp;
>
> - =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (result) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case STK_AGENT_RESULT_OK:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&rsp, 0, si=
zeof(rsp));
> @@ -1699,8 +1686,6 @@ static void confirm_call_cb(enum stk_agent_result r=
esult, gboolean confirm,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_response rsp;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
>
> - =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;

However there's a change in behaviour here which I think is incorrect.
 We need to wait for the call to be cancelled or connected before
responding, so I'd just leave this line as is.

Best regards

--===============4683570043027594792==--


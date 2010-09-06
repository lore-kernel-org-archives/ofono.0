Content-Type: multipart/mixed; boundary="===============0029134861176920745=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/2] stk and stkutil changes for Send USSD proactive
 command
Date: Tue, 07 Sep 2010 01:54:19 +0200
Message-ID: <AANLkTimRZ9XVx+1FcFdhTwY4B97XFcqDnJj5XzVRvqkn@mail.gmail.com>
In-Reply-To: <1283764886-17588-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0029134861176920745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 6 September 2010 11:21, Jeevaka Badrappan
<jeevaka.badrappan@elektrobit.com> wrote:
> ---
> =C2=A0src/stk.c =C2=A0 =C2=A0 | =C2=A0137 +++++++++++++++++++++++++++++++=
++++++++++++++++++++++++-
> =C2=A0src/stkutil.c | =C2=A0 22 +++++++++
> =C2=A0src/stkutil.h | =C2=A0 13 +++++
> =C2=A03 files changed, 169 insertions(+), 3 deletions(-)
>
> diff --git a/src/stk.c b/src/stk.c
> index 3fda2af..5d84141 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -56,10 +56,8 @@ struct ofono_stk {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*cancel_cmd)(struct ofono_stk *stk);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GQueue *envelope_q;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DBusMessage *pending;
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_timer timers[8];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0guint timers_source;
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int timeout;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int short_timeout;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_agent *session_agent;
> @@ -1590,6 +1588,136 @@ static gboolean handle_command_set_up_call(const =
struct stk_command *cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
> =C2=A0}
>
> +static void send_ussd_callback( int error, int dcs, const unsigned char =
*msg,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int msg_len, void *userdata)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *stk =3D userdata;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_error failure =3D { .type =3D OFONO_E=
RROR_TYPE_FAILURE };
> + =C2=A0 =C2=A0 =C2=A0 struct stk_response rsp;
> + =C2=A0 =C2=A0 =C2=A0 enum sms_charset charset;
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
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cbs_dcs_decode(dc=
s, NULL, NULL, &charset,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, =
NULL))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rsp.send_ussd.text.dcs =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rsp.send_ussd.text.dcs =3D charset;

What is the meaning of that -1?  I don't see this value handled in stkutil.

The rest of this patch looks okay to me, but you have some formatting
issues: space after '(' above, and the first hunk removes empty lines.
 Other than that I think Denis might want you to split this patch into
stk patch and stkutil patch.

With regards to 1/2 he'll probably want one patch for atmodem, one for
isimodem, one for include, one for plugin, etc.  Also I think it's
fair to assume that the charset is IRA and there's not need to account
for other possibilities, but other might have different opinions.  And
I'm not sure if the enum sms_charset values change should be global,
or translation should be done here in stk.c.

Best regards

--===============0029134861176920745==--


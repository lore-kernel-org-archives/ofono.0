Content-Type: multipart/mixed; boundary="===============4457029876719047041=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] stk: Add busy error for the display text command
Date: Mon, 29 Nov 2010 22:17:41 +0100
Message-ID: <AANLkTimih-84mT+uFCXytpBXHpH-rdkx=_y=ML29tAXy@mail.gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018813547CFDD@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4457029876719047041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 25 November 2010 09:44, Lucas, GuillaumeX <guillaumex.lucas@intel.com>=
 wrote:
> From: Guillaume Lucas <guillaumex.lucas@intel.com>
>
> According to the sequence 1.2 of the ETSI TS 102 384 a busy
> screen error type must be returned for the display text
> proactive command when the message is not urgent and if the
> ME is not able to display the text.
> ---
> =C2=A0doc/stk-api.txt | =C2=A0 =C2=A01 +
> =C2=A0src/stk.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 +++++++
> =C2=A0src/stkagent.c =C2=A0| =C2=A0 12 ++++++++++--
> =C2=A0src/stkagent.h =C2=A0| =C2=A0 =C2=A01 +
> =C2=A04 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> index b9ca592..79daee6 100644
> --- a/doc/stk-api.txt
> +++ b/doc/stk-api.txt
> @@ -116,6 +116,7 @@ Methods =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 byt=
e RequestSelection(string title, byte icon_id,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cleared prior to the display of this text.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Possible Errors: [service].Error.SimToolkit.GoBack
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[servi=
ce].Error.SimToolkit.Busy
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Implementation notes:
>
> diff --git a/src/stk.c b/src/stk.c
> index ac2e646..e6b78a4 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -1250,6 +1250,10 @@ static void display_text_cb(enum stk_agent_result =
result, void *user_data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0STK_RESULT_TYPE_NO_RESPONSE : STK_RESULT_TYPE_SUCCESS);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_BUSY:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_TERMINAL_BUSY);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +

According to TS 102.223 on Screen Busy we also need to append a
"additional info" field in the Terminal Busy response with a 1-byte
value 01 ("screen is busy").

Denis on IRC also wondered if this response should be allowed when the
message is flagged urgent.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0case STK_AGENT_RESULT_TERMINATE:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0send_simple_respon=
se(stk, STK_RESULT_TYPE_USER_TERMINATED);
> @@ -1363,6 +1367,7 @@ static void request_confirmation_cb(enum stk_agent_=
result result,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case STK_AGENT_RESULT_TERMINATE:
> + =C2=A0 =C2=A0 =C2=A0 default:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0send_simple_respon=
se(stk, STK_RESULT_TYPE_USER_TERMINATED);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;

Most of the other commands also allow a "Terminal busy" response in
table 6.1 in section 6.11, without giving a specific "additional info"
value.  I think it would be ok to treat them the same way as
DisplayText and supply the "screen is busy" value, what do you think?

Best regards

--===============4457029876719047041==--


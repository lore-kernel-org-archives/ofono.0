Content-Type: multipart/mixed; boundary="===============5265674015385777671=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/9] gatchat: fix gatsyntax to support +CPOS
Date: Wed, 09 Mar 2011 16:19:20 -0600
Message-ID: <4D77FCE8.5040905@gmail.com>
In-Reply-To: <1299582051-32701-7-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5265674015385777671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

On 03/08/2011 05:00 AM, Jarko Poutiainen wrote:
> ---
>  gatchat/gatsyntax.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> =

> diff --git a/gatchat/gatsyntax.c b/gatchat/gatsyntax.c
> index 2fc70b8..a85bc66 100644
> --- a/gatchat/gatsyntax.c
> +++ b/gatchat/gatsyntax.c
> @@ -90,7 +90,11 @@ static GAtSyntaxResult gsmv1_feed(GAtSyntax *syntax,
>  =

>  		case GSMV1_STATE_INITIAL_CR:
>  			if (byte =3D=3D '\n')
> -				syntax->state =3D GSMV1_STATE_INITIAL_LF;
> +				if (*len =3D=3D 2) {

You simply cannot do this.  The whole idea behind the state machine in
GAtSyntax is that your data is a byte-stream.  There are no markers, and
you can make no assumptions on the length of the buffer that is fed into
this function.  e.g. if you're unlucky you can get:

gsmv1_feed("\r")
gsmv1_feed("\n")

> +					res =3D G_AT_SYNTAX_RESULT_PROMPT;
> +					syntax->state =3D GSMV1_STATE_IDLE;
> +				} else
> +					syntax->state =3D GSMV1_STATE_INITIAL_LF;

Is there any particular reason why CPOS is not re-using the prompting
feature of AT commands and has to invent its own?  If you think about
this a bit harder you will realize that the spec is *completely* broken
here and introduces a parser ambiguity which cannot be reliably fixed.

At this point my only suggestion is that you need to set a parser hint
after every CPOS command sent to the modem.  Or better yet, push a
change request to 27.007 to use proper prompting procedures.

>  			else
>  				syntax->state =3D GSMV1_STATE_ECHO;
>  			break;
> @@ -252,7 +256,9 @@ static GAtSyntaxResult gsm_permissive_feed(GAtSyntax =
*syntax,
>  =

>  		switch (syntax->state) {
>  		case GSM_PERMISSIVE_STATE_IDLE:
> -			if (byte =3D=3D '\r' || byte =3D=3D '\n')
> +			if (byte =3D=3D '\n' && *len =3D=3D 2)
> +				res =3D G_AT_SYNTAX_RESULT_PROMPT;
> +			else if (byte =3D=3D '\r' || byte =3D=3D '\n')
>  				/* ignore */;
>  			else if (byte =3D=3D '>')
>  				syntax->state =3D GSM_PERMISSIVE_STATE_PROMPT;

Regards,
-Denis

--===============5265674015385777671==--


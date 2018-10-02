Content-Type: multipart/mixed; boundary="===============4521745518521407278=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/6] gatchat: support for auth NONE
Date: Tue, 02 Oct 2018 18:26:00 -0500
Message-ID: <fcd0ecad-519e-7add-88cf-e39060886f64@gmail.com>
In-Reply-To: <20181002062628.17466-5-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4521745518521407278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/02/2018 01:26 AM, Giacinto Cifelli wrote:
> Added authentication method G_AT_PPP_AUTH_METHOD_NONE and its handling.
> =

> This method is already used in the code, and

Hmm, I don't think so?

> the patch is just allowing its explicit use, on top of the implicit
> selection done when username is empty.

I do not see how this is true?  Even if username / password is empty, =

the CHAP/PAP authentication method applies.  We just hash the empty =

password for CHAP / send it plaintext for PAP.

There is of course the possibility that the PPP server can simply not =

ask us for the AUTH_PROTO option, in which case we would find that =

acceptable and the auth protocol would not be used.

> ---
>   gatchat/gatppp.c  | 3 ++-
>   gatchat/gatppp.h  | 1 +
>   gatchat/ppp_lcp.c | 3 +++
>   3 files changed, 6 insertions(+), 1 deletion(-)
> =


<snip>

> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> index df9cd0ef..258ae763 100644
> --- a/gatchat/ppp_lcp.c
> +++ b/gatchat/ppp_lcp.c
> @@ -279,6 +279,9 @@ static enum rcr_result lcp_rcr(struct pppcp_data *ppp=
cp,
>   				*new_len =3D 4;
>   =

>   				return RCR_NAK;
> +
> +			case G_AT_PPP_AUTH_METHOD_NONE:
> +				return RCR_ACCEPT;

Should this not be RCR_REJECT ?  Otherwise we're accepting a server =

proposed auth protocol when we're explicitly configured not to use one.

>   			}
>   			break;
>   		}
> =


Regards,
-Denis

--===============4521745518521407278==--


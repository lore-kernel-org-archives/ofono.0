Content-Type: multipart/mixed; boundary="===============6026415281212704800=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatchat/gatppp.c: Add timeout handler in ppp_enter_phase
Date: Mon, 04 Jan 2016 23:28:14 -0600
Message-ID: <568B546E.80503@gmail.com>
In-Reply-To: <1450860754-31695-1-git-send-email-marko.sulejic@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6026415281212704800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

On 12/23/2015 02:52 AM, Marko =C5=A0uleji=C4=87 wrote:
>   * ppp_enter_phase calls ppp_dead if the PPP phase is PPP_PHASE_DEAD
>     && ppp->sta_pending =3D=3D FALSE, but fails if sta_pending is never s=
et
>     to FALSE. So a timeout handler was added to handle this case too.
> ---
>   gatchat/gatppp.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index 5144084..f84535a 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -361,8 +361,12 @@ static inline void ppp_enter_phase(GAtPPP *ppp, enum=
 ppp_phase phase)
>   	DBG(ppp, "%d", phase);
>   	ppp->phase =3D phase;
>
> -	if (phase =3D=3D PPP_PHASE_DEAD && ppp->sta_pending =3D=3D FALSE)
> -		ppp->ppp_dead_source =3D g_idle_add(ppp_dead, ppp);
> +	if (phase =3D=3D PPP_PHASE_DEAD) {
> +		if(ppp->sta_pending)
> +			ppp->ppp_dead_source =3D g_timeout_add(5000, ppp_dead, ppp);
> +		else
> +			ppp->ppp_dead_source =3D g_idle_add(ppp_dead, ppp);
> +	}

This seems wrong.  sta_pending is set if we are trying to transmit a =

terminate_ack.  If this fails, then the peer is likely severing the =

connection very shortly afterwards.

What is the sequence of events you're observing here?

Regards,
-Denis

--===============6026415281212704800==--


Content-Type: multipart/mixed; boundary="===============0638419990655391104=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ppp: transition phase to DEAD when lcp finishes
Date: Mon, 10 May 2010 09:21:37 -0500
Message-ID: <201005100921.38197.denkenz@gmail.com>
In-Reply-To: <1272925423-3584-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0638419990655391104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> change the state to DEAD when lcp finishes.  This prevents us from
> calling our disconnect function again if we are already dead.

I'm curious under what circumstances tlf gets called on LCP when we're alre=
ady =

down?

> ---
>  gatchat/gatppp.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> =

> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index 70669b0..dd6d84d 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -186,9 +186,6 @@ static inline void ppp_enter_phase(GAtPPP *ppp, enum
>  ppp_phase phase) {
>  	g_print("Entering new phase: %d\n", phase);
>  	ppp->phase =3D phase;
> -
> -	if (phase =3D=3D PPP_PHASE_DEAD)
> -		ppp_dead(ppp);
>  }
> =

>  void ppp_set_auth(GAtPPP *ppp, const guint8* auth_data)
> @@ -290,6 +287,10 @@ void ppp_lcp_down_notify(GAtPPP *ppp)
> =

>  void ppp_lcp_finished_notify(GAtPPP *ppp)
>  {
> +	if (ppp->phase =3D=3D PPP_PHASE_DEAD)
> +		return;

I prefer we move this to ppp_enter_phase

> +
> +	ppp_enter_phase(ppp, PPP_PHASE_DEAD);

Keep this

>  	ppp_dead(ppp);

And remove this.

Regards,
-Denis

--===============0638419990655391104==--


Content-Type: multipart/mixed; boundary="===============8185031201036172185=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: [PATCH] ppp: silently discard packets if needed
Date: Tue, 27 Apr 2010 18:12:03 -0300
Message-ID: <20100427211203.GD5070@vigoh>
In-Reply-To: <1272400009-29082-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8185031201036172185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

* Kristen Carlson Accardi <kristen@linux.intel.com> [2010-04-27 13:26:49 =
-0700]:

> When receiving a packet, check the protocol and the phase to see
> if the packet should be dropped.
> ---
>  gatchat/gatppp.c |   31 ++++++++++++++++++++++++++-----
>  1 files changed, 26 insertions(+), 5 deletions(-)
> =

> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index c7bf089..933cbec 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -173,17 +173,38 @@ static struct frame_buffer *ppp_encode(GAtPPP *ppp,=
 guint8 *data, int len)
>  	return fb;
>  }
>  =

> +/*
> + * Silently discard packets which are received when they shouldn't be
> + */
> +static inline gboolean drop_packet(GAtPPP *ppp, guint16 protocol)
> +{
> +	switch (ppp->phase) {
> +	case PPP_PHASE_ESTABLISHMENT:
> +	case PPP_PHASE_TERMINATION:
> +		if (protocol !=3D LCP_PROTOCOL)
> +			return TRUE;
> +		break;
> +	case PPP_PHASE_AUTHENTICATION:
> +		if (protocol !=3D LCP_PROTOCOL && protocol !=3D CHAP_PROTOCOL)
> +			return TRUE;
> +		break;
> +	case PPP_PHASE_DEAD:
> +		return TRUE;
> +		break;

You have a return and a break on the same case. You'll never reach the
break here.

> +	case PPP_PHASE_NETWORK:
> +		break;
> +	}
> +
> +	return FALSE;
> +}
> +
>  /* called when we have received a complete ppp frame */
>  static void ppp_recv(GAtPPP *ppp, struct frame_buffer *frame)
>  {
>  	guint16 protocol =3D ppp_proto(frame->bytes);
>  	guint8 *packet =3D ppp_info(frame->bytes);
>  =

> -	/*
> -	 * Any non-LCP packets received during Link Establishment
> -	 * phase must be silently discarded.
> -	 */
> -	if (ppp->phase =3D=3D PPP_PHASE_ESTABLISHMENT && protocol !=3D LCP_PROT=
OCOL)
> +	if (drop_packet(ppp, protocol))
>  		return;
>  =

>  	switch (protocol) {
> -- =

> 1.6.6.1
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

-- =

Gustavo F. Padovan
http://padovan.org

--===============8185031201036172185==--


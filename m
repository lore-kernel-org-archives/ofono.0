Content-Type: multipart/mixed; boundary="===============6504613724387179506=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 05/18] gatppp: add g_at_ppp_set_suspend_function()
 definition
Date: Wed, 30 Mar 2011 15:54:45 -0500
Message-ID: <4D939895.5070303@gmail.com>
In-Reply-To: <1301066749-12052-6-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6504613724387179506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 03/25/2011 10:25 AM, Guillaume Zajac wrote:
> ---
>  gatchat/gatppp.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index 993b5ea..9df6b8e 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -467,6 +467,14 @@ void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc fu=
nc, gpointer user_data)
>  	ppp->debug_data =3D user_data;
>  }
>  =

> +void g_at_ppp_set_suspend_function(GAtPPP *ppp, GAtSuspendFunc func, gpo=
inter user_data)
> +{
> +	if (ppp =3D=3D NULL)
> +		return;
> +
> +	g_at_hdlc_set_suspend_function(ppp->hdlc, func, user_data);
> +}
> +

This is really not enough, you must also shut down the read watch on the
TUN device, so that we don't try to forward packets from TUN to HDLC
while we're suspended.

>  void g_at_ppp_shutdown(GAtPPP *ppp)
>  {
>  	if (ppp->phase =3D=3D PPP_PHASE_DEAD || ppp->phase =3D=3D PPP_PHASE_TER=
MINATION)

Regards,
-Denis

--===============6504613724387179506==--


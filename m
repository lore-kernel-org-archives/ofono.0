Content-Type: multipart/mixed; boundary="===============8570786332155470602=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 13/26] gatppp: add g_at_ppp_suspend() definition
Date: Mon, 02 May 2011 07:26:36 -0500
Message-ID: <4DBEA2FC.4000801@gmail.com>
In-Reply-To: <1301648188-7208-14-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8570786332155470602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 04/01/2011 03:56 AM, Guillaume Zajac wrote:
> ---
>  gatchat/gatppp.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index 9df6b8e..5f005fe 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -484,6 +484,15 @@ void g_at_ppp_shutdown(GAtPPP *ppp)
>  	pppcp_signal_close(ppp->lcp);
>  }
>  =

> +void g_at_ppp_suspend(GAtPPP *ppp)
> +{
> +	if (ppp =3D=3D NULL)
> +		return;
> +
> +	ppp_net_suspend_interface(ppp->net);
> +	g_at_hdlc_suspend(ppp->hdlc);
> +}
> +

What do you think of automatically calling ppp_net_suspend_interface
when the ppp suspend callback is triggered?  e.g. using a proxy function
in g_at_ppp_set_suspend_function.

>  void g_at_ppp_ref(GAtPPP *ppp)
>  {
>  	g_atomic_int_inc(&ppp->ref_count);

Regards,
-Denis

--===============8570786332155470602==--


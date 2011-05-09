Content-Type: multipart/mixed; boundary="===============6572500294376447376=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v4 2/8] ppp_net: add ppp_net_suspend_interface() function
Date: Sun, 08 May 2011 23:11:41 -0500
Message-ID: <4DC7697D.9040006@gmail.com>
In-Reply-To: <1304523546-643-3-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6572500294376447376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 05/04/2011 10:39 AM, Guillaume Zajac wrote:
> ---
>  gatchat/ppp.h     |    1 +
>  gatchat/ppp_net.c |    9 +++++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> =


I applied this patch, however I had to fix it slightly afterward:

> @@ -196,3 +196,12 @@ void ppp_net_free(struct ppp_net *net)
>  	g_free(net->if_name);
>  	g_free(net);
>  }
> +
> +void ppp_net_suspend_interface(struct ppp_net *net)
> +{
> +	if (net =3D=3D NULL || net->channel =3D=3D NULL)
> +		return;
> +
> +	if (net->watch)
> +		g_source_remove(net->watch);
> +}

Whenever removing a watch, please make sure to reset the watch variable
back to zero.

Also, I'm missing the _resume version of the above function...

Regards,
-Denis

--===============6572500294376447376==--


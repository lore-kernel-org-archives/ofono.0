Content-Type: multipart/mixed; boundary="===============8838184476306540347=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ppp: change MTU on TUN device when MRU option received
Date: Thu, 22 Apr 2010 17:10:11 -0500
Message-ID: <201004221710.11515.denkenz@gmail.com>
In-Reply-To: <1271970911-9645-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8838184476306540347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> ---
>  gatchat/ppp_net.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
> index c1f2eb4..fc1f9fb 100644
> --- a/gatchat/ppp_net.c
> +++ b/gatchat/ppp_net.c
> @@ -50,10 +50,26 @@ struct ppp_net {
> =

>  void ppp_net_set_mtu(struct ppp_net *net, guint16 mtu)
>  {
> +	struct ifreq ifr;
> +	int sock;
> +
>  	if (net =3D=3D NULL)
>  		return;
> =

>  	net->mtu =3D mtu;
> +
> +	sock =3D socket(AF_INET, SOCK_DGRAM, 0);
> +	if (sock < 0)
> +		return;
> +

I think it would be a good idea to make this function return a gboolean =

indicating success or failure instead of silently returning.

> +	memset(&ifr, 0, sizeof(ifr));
> +
> +	strncpy(ifr.ifr_name, net->if_name, sizeof(ifr.ifr_name));
> +	ifr.ifr_mtu =3D mtu;
> +	if (ioctl(sock, SIOCSIFMTU, (caddr_t) &ifr) < 0)
> +		g_printerr("Unable to change MTU\n");

Generally the preferred style is to not have a space after memset but do ha=
ve =

space before the if.

> +
> +	close(sock);
>  }
> =

>  void ppp_net_process_packet(struct ppp_net *net, guint8 *packet)
> =


Otherwise patch looks good.

Regards,
-Denis

--===============8838184476306540347==--


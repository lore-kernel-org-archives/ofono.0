Content-Type: multipart/mixed; boundary="===============6982152755511783767=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] gatchat: Print error message if opening tun failes
Date: Tue, 21 Aug 2012 15:00:14 +0200
Message-ID: <1345554014.13726.85.camel@aeonflux>
In-Reply-To: <1345528828-28740-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6982152755511783767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> This is a very common misstake. Let's help the users to
> configure their system correctly.
> ---
>  gatchat/ppp_net.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> =

> diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
> index 1609b99..7082de7 100644
> --- a/gatchat/ppp_net.c
> +++ b/gatchat/ppp_net.c
> @@ -155,8 +155,12 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp, int fd)
>  	if (fd < 0) {
>  		/* open a tun interface */
>  		fd =3D open("/dev/net/tun", O_RDWR);
> -		if (fd < 0)
> +		if (fd < 0) {
> +			fprintf(stderr, "Couldn't open tun device. "
> +					"Do you run oFono as root and do you "
> +					"have the TUN module loaded?");

really, stderr?

>  			goto error;
> +		}
>  =

>  		ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
>  		strcpy(ifr.ifr_name, "ppp%d");

Aren't the atom drivers checking this case for you?

Regards

Marcel



--===============6982152755511783767==--


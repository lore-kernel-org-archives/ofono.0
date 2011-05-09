Content-Type: multipart/mixed; boundary="===============5554841934811638807=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v4 1/5] gatppp: Add new contructor to use external fd
Date: Sun, 08 May 2011 23:44:25 -0500
Message-ID: <4DC77129.7090503@gmail.com>
In-Reply-To: <1304690513-3137-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5554841934811638807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 05/06/2011 09:01 AM, Guillaume Zajac wrote:
> ---
>  gatchat/gatppp.c  |   33 ++++++++++++++++++++++++++++++++-
>  gatchat/gatppp.h  |    1 +
>  gatchat/ppp.h     |    2 +-
>  gatchat/ppp_net.c |   40 +++++++++++++++++++++++++---------------
>  4 files changed, 59 insertions(+), 17 deletions(-)
> =

> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index 993b5ea..c4cad90 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -76,6 +76,7 @@ struct _GAtPPP {
>  	gpointer debug_data;
>  	gboolean sta_pending;
>  	guint ppp_dead_source;
> +	int fd;
>  };
>  =

>  void ppp_debug(GAtPPP *ppp, const char *str)
> @@ -288,7 +289,7 @@ void ppp_auth_notify(GAtPPP *ppp, gboolean success)
>  void ppp_ipcp_up_notify(GAtPPP *ppp, const char *local, const char *peer,
>  					const char *dns1, const char *dns2)
>  {
> -	ppp->net =3D ppp_net_new(ppp);
> +	ppp->net =3D ppp_net_new(ppp, ppp->fd);

So please be careful here, you're passing in the file descriptor and you
do not establish a clear ownership of it.  Is ppp_net_new responsible to
close the fd in all cases?  Right now there are error cases (e.g.
ppp_net_new returns NULL) in which the fd is closed and others where it
is not.  You have to be extra paranoid when writing a library and make
sure every case has been thought through.

>  =

>  	if (ppp->net =3D=3D NULL) {
>  		ppp->disconnect_reason =3D G_AT_PPP_REASON_NET_FAIL;
> @@ -314,6 +315,7 @@ void ppp_ipcp_down_notify(GAtPPP *ppp)
>  		return;
>  =

>  	ppp_net_free(ppp->net);
> +	ppp->fd =3D -1;
>  	ppp->net =3D NULL;
>  }
>  =

> @@ -498,6 +500,8 @@ void g_at_ppp_unref(GAtPPP *ppp)
>  =

>  	if (ppp->net)
>  		ppp_net_free(ppp->net);
> +	else if (ppp->fd >=3D 0)
> +		close(ppp->fd);
>  =

>  	if (ppp->chap)
>  		ppp_chap_free(ppp->chap);
> @@ -541,6 +545,8 @@ static GAtPPP *ppp_init_common(GAtHDLC *hdlc, gboolea=
n is_server, guint32 ip)
>  =

>  	ppp->ref_count =3D 1;
>  =

> +	ppp->fd =3D -1;
> +
>  	/* set options to defaults */
>  	ppp->mru =3D DEFAULT_MRU;
>  	ppp->mtu =3D DEFAULT_MTU;
> @@ -633,3 +639,28 @@ GAtPPP *g_at_ppp_server_new_from_io(GAtIO *io, const=
 char *local)
>  =

>  	return ppp;
>  }
> +
> +GAtPPP *g_at_ppp_server_new_full(GAtIO *io, const char *local, int fd)
> +{
> +	GAtHDLC *hdlc;
> +	GAtPPP *ppp;
> +	guint32 ip;
> +
> +	if (local =3D=3D NULL)
> +		ip =3D 0;
> +	else if (inet_pton(AF_INET, local, &ip) !=3D 1)
> +		return NULL;
> +
> +	hdlc =3D g_at_hdlc_new_from_io(io);
> +	if (hdlc =3D=3D NULL)
> +		return NULL;
> +
> +	ppp =3D ppp_init_common(hdlc, TRUE, ip);
> +
> +	/* Set the fd value returned by ConnMan */
> +	ppp->fd =3D fd;
> +
> +	g_at_hdlc_unref(hdlc);
> +
> +	return ppp;
> +}
> diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
> index fb5de4c..825c022 100644
> --- a/gatchat/gatppp.h
> +++ b/gatchat/gatppp.h
> @@ -54,6 +54,7 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem);
>  GAtPPP *g_at_ppp_new_from_io(GAtIO *io);
>  GAtPPP *g_at_ppp_server_new(GIOChannel *modem, const char *local);
>  GAtPPP *g_at_ppp_server_new_from_io(GAtIO *io, const char *local);
> +GAtPPP *g_at_ppp_server_new_full(GAtIO *io, const char *local, int fd);
>  =

>  void g_at_ppp_open(GAtPPP *ppp);
>  void g_at_ppp_set_connect_function(GAtPPP *ppp, GAtPPPConnectFunc callba=
ck,
> diff --git a/gatchat/ppp.h b/gatchat/ppp.h
> index d2786d7..8107820 100644
> --- a/gatchat/ppp.h
> +++ b/gatchat/ppp.h
> @@ -102,7 +102,7 @@ void ppp_chap_free(struct ppp_chap *chap);
>  void ppp_chap_process_packet(struct ppp_chap *chap, const guint8 *new_pa=
cket);
>  =

>  /* TUN / Network related functions */
> -struct ppp_net *ppp_net_new(GAtPPP *ppp);
> +struct ppp_net *ppp_net_new(GAtPPP *ppp, int fd);
>  const char *ppp_net_get_interface(struct ppp_net *net);
>  void ppp_net_process_packet(struct ppp_net *net, const guint8 *packet);
>  void ppp_net_free(struct ppp_net *net);
> diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
> index 1a6cdf7..0f25299 100644
> --- a/gatchat/ppp_net.c
> +++ b/gatchat/ppp_net.c
> @@ -123,12 +123,12 @@ const char *ppp_net_get_interface(struct ppp_net *n=
et)
>  	return net->if_name;
>  }
>  =

> -struct ppp_net *ppp_net_new(GAtPPP *ppp)
> +struct ppp_net *ppp_net_new(GAtPPP *ppp, int fd)
>  {
>  	struct ppp_net *net;
>  	GIOChannel *channel =3D NULL;
>  	struct ifreq ifr;
> -	int fd, err;
> +	int err;
>  =

>  	net =3D g_try_new0(struct ppp_net, 1);
>  	if (net =3D=3D NULL)
> @@ -140,23 +140,33 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp)
>  		return NULL;
>  	}
>  =

> -	/* open a tun interface */
> -	fd =3D open("/dev/net/tun", O_RDWR);
> -	if (fd < 0)
> -		goto error;
> -
> -	memset(&ifr, 0, sizeof(ifr));
> -	ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
> -	strcpy(ifr.ifr_name, "ppp%d");
> -
> -	err =3D ioctl(fd, TUNSETIFF, (void *) &ifr);
> -	if (err < 0)
> -		goto error;
> +	/*
> +	 * If the fd value is still the default one,
> +	 * open the tun interface and configure it.
> +	 */
> +	if (fd < 0) {
> +		/* open a tun interface */
> +		fd =3D open("/dev/net/tun", O_RDWR);
> +		if (fd < 0)
> +			goto error;
> +
> +		memset(&ifr, 0, sizeof(ifr));
> +		ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
> +		strcpy(ifr.ifr_name, "ppp%d");
> +
> +		err =3D ioctl(fd, TUNSETIFF, (void *) &ifr);
> +		if (err < 0)
> +			goto error;
> +	} else {
> +		err =3D ioctl(fd, TUNGETIFF, (void *) &ifr);
> +		if (err < 0)
> +			goto error;
> +	}
>  =

>  	net->if_name =3D strdup(ifr.ifr_name);
> -

Please avoid such changes.  Resist the urge to change formatting or
white-spacing when submitting feature patches.  Send a separate patch,
otherwise it confuses the reviewer.

Please note that in this particular case the original formatting is the
preferred style already.

>  	/* create a channel for reading and writing to this interface */
>  	channel =3D g_io_channel_unix_new(fd);
> +
>  	if (channel =3D=3D NULL)
>  		goto error;
>  =


Regards,
-Denis

--===============5554841934811638807==--


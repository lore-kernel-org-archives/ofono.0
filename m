Content-Type: multipart/mixed; boundary="===============3878044127332998480=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] gisi: use strerror_r() instead of strerror()
Date: Fri, 26 Nov 2010 15:07:29 -0600
Message-ID: <4CF02191.8000806@gmail.com>
In-Reply-To: <1290682265-11373-3-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3878044127332998480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

On 11/25/2010 04:51 AM, R=C3=A9mi Denis-Courmont wrote:
> ---
>  gisi/netlink.c |    8 ++++++--
>  gisi/server.c  |   11 ++++++++---
>  2 files changed, 14 insertions(+), 5 deletions(-)
> =

> diff --git a/gisi/netlink.c b/gisi/netlink.c
> index 44a4a8d..dcc322c 100644
> --- a/gisi/netlink.c
> +++ b/gisi/netlink.c
> @@ -240,8 +240,12 @@ static gboolean g_pn_nl_process(GIOChannel *channel,=
 GIOCondition cond,
>  		case NLMSG_ERROR: {
>  			struct nlmsgerr *err =3D NLMSG_DATA(nlh);
>  			if (err->error)
> -				g_printerr("Netlink error: %s",
> -						strerror(-err->error));
> +			{
> +				char msg[256];
> +
> +				strerror_r(-err->error, msg, sizeof(msg));
> +				g_printerr("Netlink error: %s", msg);
> +			}

So my question is why we're using g_printerr in the first place inside a
library.  Perhaps an approach similar to g_at_chat_set_debug is in order?

>  			return TRUE;
>  		}
>  		case RTM_NEWADDR:
> diff --git a/gisi/server.c b/gisi/server.c
> index 159bb2d..df2e4eb 100644
> --- a/gisi/server.c
> +++ b/gisi/server.c
> @@ -157,7 +157,10 @@ g_isi_server_add_name(GIsiServer *self)
>  		return;
>  =

>  	if (ioctl(self->fd, SIOCPNGETOBJECT, &object) < 0) {
> -		g_warning("%s: %s", "ioctl(SIOCPNGETOBJECT)", strerror(errno));
> +		char msg[256];
> +
> +		strerror_r(errno, msg, sizeof(msg));
> +		g_warning("%s: %s", "ioctl(SIOCPNGETOBJECT)", msg);
>  	} else {
>  		struct sockaddr_pn spn =3D {
>  			.spn_family =3D PF_PHONET,
> @@ -173,8 +176,10 @@ g_isi_server_add_name(GIsiServer *self)
>  =

>  		if (sendto(self->fd, req, sizeof(req), 0,
>  				(void *)&spn, sizeof(spn)) !=3D sizeof(req)) {
> -			g_warning("%s: %s", "sendto(PN_NAMESERVICE)",
> -				  strerror(errno));
> +			char msg[256];
> +
> +			strerror_r(errno, msg, sizeof(msg));
> +			g_warning("%s: %s", "sendto(PN_NAMESERVICE)", msg);
>  		}
>  	}
>  }

Regards,
-Denis

--===============3878044127332998480==--


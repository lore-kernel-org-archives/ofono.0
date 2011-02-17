Content-Type: multipart/mixed; boundary="===============3725052534632766505=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-server:Add test of PPP disconnect reason
Date: Thu, 17 Feb 2011 10:14:45 -0600
Message-ID: <4D5D4975.1050306@gmail.com>
In-Reply-To: <1297950507-9175-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3725052534632766505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 02/17/2011 07:48 AM, Guillaume Zajac wrote:
> ---
>  gatchat/test-server.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/test-server.c b/gatchat/test-server.c
> index e574d64..c0a5a4d 100644
> --- a/gatchat/test-server.c
> +++ b/gatchat/test-server.c
> @@ -137,6 +137,12 @@ static void ppp_disconnect(GAtPPPDisconnectReason re=
ason, gpointer user)
>  	g_at_ppp_unref(ppp);
>  	ppp =3D NULL;
>  =

> +	if (reason =3D=3D G_AT_PPP_REASON_NET_FAIL) {

Don't you mean G_AT_PPP_REASON_LINK_DEAD?

> +		g_at_server_unref(server);
> +		server =3D NULL;
> +		return;
> +	}
> +
>  	g_at_server_resume(server);
>  	g_at_server_set_debug(server, server_debug, "Server");
>  =


Regards,
-Denis

--===============3725052534632766505==--


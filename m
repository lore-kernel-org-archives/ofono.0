Content-Type: multipart/mixed; boundary="===============1394647206120790990=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH] Fix: transaction id usage in gisi/server.c
Date: Fri, 23 Apr 2010 17:27:51 +0200
Message-ID: <7974cbff72c4740d8527ba84523bf59a@chewa.net>
In-Reply-To: <1272035836-27549-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1394647206120790990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 23 Apr 2010 18:17:16 +0300, Pekka Pessi <Pekka.Pessi@nokia.com>
wrote:
> @@ -174,9 +172,11 @@ g_isi_server_add_name(GIsiServer *self)
>  			0, 0,
>  		};
> =

> -		if (sendto(self->fd, req, sizeof(req), 0, (void *)&spn,
> -				sizeof(spn)) !=3D sizeof(spn))
> -			return;
> +		if (sendto(self->fd, req, sizeof(req), 0,
> +				(void *)&spn, sizeof(spn)) !=3D sizeof(req)) {
> +			g_warning("%s: %s", "sendto(PN_NAMESERVICE)",
> +				  strerror(errno));
> +		}
>  	}

sendto() does not set errno if it returns less than sizeof(req) but more
than -1. I don't know if we care though.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============1394647206120790990==--


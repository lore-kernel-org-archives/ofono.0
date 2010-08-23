Content-Type: multipart/mixed; boundary="===============8317729533358743899=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] hfp: fix typo
Date: Mon, 23 Aug 2010 20:15:53 +0200
Message-ID: <1282587353.23399.249.camel@localhost.localdomain>
In-Reply-To: <1282586689-6776-1-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8317729533358743899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joao,

> ---
>  plugins/hfp.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/plugins/hfp.c b/plugins/hfp.c
> index 0337891..9a892db 100644
> --- a/plugins/hfp.c
> +++ b/plugins/hfp.c
> @@ -83,7 +83,7 @@ static void clear_data(struct ofono_modem *modem)
>  	memset(data->cind_pos, 0, sizeof(data->cind_pos));
>  }
>  =

> -static void sevice_level_conn_established(struct ofono_modem *modem)
> +static void service_level_conn_established(struct ofono_modem *modem)

good one. Patch has been applied.

Regards

Marcel



--===============8317729533358743899==--


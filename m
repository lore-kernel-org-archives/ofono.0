Content-Type: multipart/mixed; boundary="===============1913412107426127060=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix: use of g_checksum_get_digest() inout argument
Date: Mon, 29 Mar 2010 18:14:22 -0700
Message-ID: <1269911662.11714.217.camel@localhost.localdomain>
In-Reply-To: <1269869914-4662-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1913412107426127060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

>  gatchat/ppp_auth.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
> index fe3c501..1e0c82b 100644
> --- a/gatchat/ppp_auth.c
> +++ b/gatchat/ppp_auth.c
> @@ -107,7 +107,7 @@ static void chap_process_challenge(struct auth_data *=
auth, guint8 *packet)
>  		response->length =3D htons(response_length);
>  		response->data[0] =3D digest_len;
>  		g_checksum_get_digest(checksum, &response->data[1],
> -					(gsize *) &response->data[0]);
> +					&digest_len);
>  		/* leave the name empty? */
>  	}

thanks for the patch. I changed it a bit by moving the data[0]
assignment after the get_digest call to ensure we use the right length
value on the wire. Not that it matters in this case since it is a fixed
length anyway, but just in case.

Regards

Marcel



--===============1913412107426127060==--


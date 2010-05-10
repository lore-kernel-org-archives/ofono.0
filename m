Content-Type: multipart/mixed; boundary="===============8687554029220890332=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ppp: set address and control field
Date: Mon, 10 May 2010 16:40:57 -0500
Message-ID: <201005101640.57357.denkenz@gmail.com>
In-Reply-To: <1273521997-7356-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8687554029220890332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> Before sending to hdlc, set the address and control field.
> Fix hardcode of ppp header size.

Patch has been applied with one minor modification:

> +#define PPP_ADDR_FIELD	0xff
> +#define PPP_CTRL	0x03

These really should be private.

> @@ -83,7 +83,7 @@ static void chap_process_challenge(struct ppp_chap *cha=
p,
>  const guint8 *packet) */
>  	digest_len =3D g_checksum_type_get_length(chap->method);
>  	response_length =3D digest_len + sizeof(*header) + 1;
> -	ppp_packet =3D g_try_malloc0(response_length + 2);
> +	ppp_packet =3D g_try_malloc0(response_length + sizeof(struct ppp_header=
));
>  	if (!ppp_packet)
>  		goto challenge_out;

Can we make this function use pppcp_packet_new or similar?

Regards,
-Denis

--===============8687554029220890332==--


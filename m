Content-Type: multipart/mixed; boundary="===============7163797612129196190=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] isigen: increase offline timeout
Date: Wed, 03 Nov 2010 19:21:33 +0100
Message-ID: <1288808493.9615.56.camel@aeonflux>
In-Reply-To: <1288808182-15952-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7163797612129196190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> The modem deregisters from network before response to MTC_STATE_REQ is
> returned. Deregistering can take at least 8 seconds.
> ---
>  plugins/isigen.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/isigen.c b/plugins/isigen.c
> index 493d926..014456f 100644
> --- a/plugins/isigen.c
> +++ b/plugins/isigen.c
> @@ -373,7 +373,7 @@ static void isigen_online(struct ofono_modem *modem, =
ofono_bool_t online,
>  =

>  	isi->online =3D online;
>  =

> -	if (g_isi_send(isi->client, req, sizeof(req), MTC_TIMEOUT,
> +	if (g_isi_send(isi->client, req, sizeof(req), 8 + MTC_TIMEOUT,
>  			mtc_state_cb, cbd, NULL))
>  		return;

are you sure you just wanna hardcode it like this and not use a proper
constant for it?

Regards

Marcel



--===============7163797612129196190==--


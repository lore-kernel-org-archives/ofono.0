Content-Type: multipart/mixed; boundary="===============6959218671271881357=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv3] stemodem: Fix for MT call not working when caller id is
 hidden.
Date: Tue, 04 Jan 2011 00:06:17 -0800
Message-ID: <1294128377.5852.73.camel@aeonflux>
In-Reply-To: <1294127736-3068-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6959218671271881357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

> In *ECAV, the number will not be included if caller id is hidden.
> Set it to an empty string in that case, and set number type to
> 128, unknown number type.
> ---
>  drivers/stemodem/voicecall.c |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
> index bf68f52..7f0a19f 100644
> --- a/drivers/stemodem/voicecall.c
> +++ b/drivers/stemodem/voicecall.c
> @@ -1,4 +1,4 @@
> -/*
> +e/*

What is this ;)

Regards

Marcel



--===============6959218671271881357==--


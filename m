Content-Type: multipart/mixed; boundary="===============9056496148959699649=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 8/8] doc: update sim-api
Date: Thu, 14 Oct 2010 08:56:33 +0300
Message-ID: <1287035793.3316.23.camel@aeonflux>
In-Reply-To: <1286896694-3054-9-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9056496148959699649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

> ---
>  doc/sim-api.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/sim-api.txt b/doc/sim-api.txt
> index d5bf279..c502772 100644
> --- a/doc/sim-api.txt
> +++ b/doc/sim-api.txt
> @@ -125,3 +125,7 @@ Properties	boolean Present [readonly]
>  =

>  			Contains the Intergrated Circuit Card Identifer (ICCID)
>  			which is read directly from the SIM.
> +
> +		boolean FixedDialing [readonly]
> +
> +			True if a Fixed Dialing is enabled in SIM card.

can we please make this a bit more verbose. I want to have some
description on what this is intended for. So something along the line
that you can detect that the SIM card is in fixed dialing mode. That
this means you can make emergency calls only etc. So what is the impact
for the application developers and what is expected from them todo.

Remember that these docs are not just for us, they are for the
application developers and need to be as verbose as possible. So they go
off into the right direction ;)

Regards

Marcel



--===============9056496148959699649==--


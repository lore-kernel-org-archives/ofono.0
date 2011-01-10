Content-Type: multipart/mixed; boundary="===============1303144303969658466=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/1] Add voice call boolean property for MO/MT distinction
Date: Mon, 10 Jan 2011 17:20:13 +0200
Message-ID: <AANLkTim0s1MiQvaQkg7-5-RLBQ7NWAkgK=oXzj_38+ZF@mail.gmail.com>
In-Reply-To: <1294157851-23271-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1303144303969658466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

2011/1/4 R=C3=A9mi Denis-Courmont <remi.denis-courmont@nokia.com>:
> ---
> =C2=A0doc/voicecall-api.txt | =C2=A0 =C2=A05 +++++
> =C2=A0src/voicecall.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A06 +++++-
> =C2=A02 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
> index 4f38e6a..682b46b 100644
> --- a/doc/voicecall-api.txt
> +++ b/doc/voicecall-api.txt
> @@ -92,6 +92,11 @@ Properties =C2=A0 string LineIdentification [readonly]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Contains the Name Identification information returned
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0by the network, if present.
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 boolean Originated [re=
adonly]
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Indicates whether the call was mobile-originated
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (true) or mobile-terminated (false).
> +

This (still) looks good to me. I think it makes the API complete.

Cheers,
Aki

--===============1303144303969658466==--


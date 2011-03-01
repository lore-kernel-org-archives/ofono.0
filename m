Content-Type: multipart/mixed; boundary="===============0079681017434385309=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/1] isimodem: group timeouts in enum,
 remove unused timeout
Date: Tue, 01 Mar 2011 15:27:11 +0200
Message-ID: <AANLkTimsPyYHC8MK5U5k9W4zKzfLDm7TCDBRRjPFqNtH@mail.gmail.com>
In-Reply-To: <1296997000-12073-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0079681017434385309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi George,

2011/2/6 George Matveev <george@matveev.se>:
> Introduce enum network_timeout for scan/registration timeouts,
> remove unused NETWORK_TIMEOUT.
> ---
> =C2=A0drivers/isimodem/network.h | =C2=A0 =C2=A08 +++++---
> =C2=A01 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/isimodem/network.h b/drivers/isimodem/network.h
> index b96216d..f35ed5a 100644
> --- a/drivers/isimodem/network.h
> +++ b/drivers/isimodem/network.h
> @@ -27,11 +27,13 @@ extern "C" {
> =C2=A0#endif
>
> =C2=A0#define PN_NETWORK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0A
> -#define NETWORK_TIMEOUT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A05
> -#define NETWORK_SCAN_TIMEOUT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 180
> -#define NETWORK_SET_TIMEOUT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0240
> =C2=A0#define NET_INVALID_TIME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x64

I would rather just remove the unused define.

> +enum network_timeout {
> + =C2=A0 =C2=A0 =C2=A0 NETWORK_SCAN_TIMEOUT =C2=A0 =C2=A0=3D =C2=A0 =C2=
=A0 =C2=A0 180,
> + =C2=A0 =C2=A0 =C2=A0 NETWORK_SET_TIMEOUT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D =C2=A0 =C2=A0 =C2=A0 240

This is not the indentation style to use for enums. Check
coding-style.txt, section M11.

Cheers,
Aki

--===============0079681017434385309==--


Content-Type: multipart/mixed; boundary="===============6389994700794377555=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 5/6] GPRS: document bearer property
Date: Thu, 20 Jan 2011 10:06:50 +0200
Message-ID: <AANLkTintNFsNHsBRxc=W=vAVW0knZ-4wSj_YKS0hAjwd@mail.gmail.com>
In-Reply-To: <1295428765-8683-5-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6389994700794377555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

2011/1/19 R=C3=A9mi Denis-Courmont <remi.denis-courmont@nokia.com>:
> ---
> =C2=A0doc/connman-api.txt | =C2=A0 10 ++++++++++
> =C2=A01 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/doc/connman-api.txt b/doc/connman-api.txt
> index 22e02e5..13f622c 100644
> --- a/doc/connman-api.txt
> +++ b/doc/connman-api.txt
> @@ -77,6 +77,16 @@ Properties =C2=A0 boolean Attached [readonly]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0be available, e.g. receiving SMS over packet radio
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0or network initiated PDP activation.
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 string Bearer [readonl=
y, optional]
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Contains the data bearer technology as reported by the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 GPRS service registration (if known).
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Possible values are:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "gsm", "edge", "umts", "hsdpa", "hsupa",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "hspa" (HSDPA and HSUPA at the same time) and
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "lte"
> +

Should this also report 'none'? At least CPSB can report that a
context is idle, i.e., no bearer associated with it.

Cheers,
Aki

--===============6389994700794377555==--


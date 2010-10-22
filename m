Content-Type: multipart/mixed; boundary="===============0441296708177695736=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] common : bring back some details about technology
Date: Fri, 22 Oct 2010 16:29:50 +0300
Message-ID: <AANLkTi=BOYfkBK77ywP9YT+VwfmEDvcjj3HDHwKQn2on@mail.gmail.com>
In-Reply-To: <20101021140720.178830@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0441296708177695736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/10/21 "Beno=C3=AEt Monin" <benoit.monin@gmx.fr>:
> diff --git a/src/common.c b/src/common.c
> index b5b9a6f..d571d81 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -655,15 +655,15 @@ const char *registration_tech_to_string(int tech)
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_GSM:
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "gsm";
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_GSM_COMPACT:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "gsm";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "gprs";
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN:
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "umts=
";
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_GSM_EGPRS:
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "edge=
";
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hspa";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hsdpa";
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hspa";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hsupa";
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "hspa=
";
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_EUTRAN:

Do you need to know if the cell supports high speed uplink, downlink
or both; or in fact, when uplink or downlink is active (i.e., channel
allocated)? Currently the API is telling you the former, and
supporting the latter would require changes not only in the D-Bus API,
but also in the driver API.

As a side note, I think I was originally proposing using the
generation tags, but either way works for me. That is, I consider it
3.5G when at least HSDPA is available.

Cheers,
Aki

--===============0441296708177695736==--


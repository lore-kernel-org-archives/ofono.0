Content-Type: multipart/mixed; boundary="===============5737839205745461754=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 3/3] isimodem: header updates for ISI2.5
Date: Tue, 01 Feb 2011 16:43:13 +0100
Message-ID: <1296574993.1520.272.camel@aeonflux>
In-Reply-To: <ee97ff346483182ef6af8e5d023b10ffe12dd28f.1296569048.git.jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5737839205745461754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

>  drivers/isimodem/debug.c   |  132 ++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/isimodem/debug.h   |    9 +++
>  drivers/isimodem/mtc.h     |   38 +++++++++++++
>  drivers/isimodem/version.h |   26 +++++++++
>  4 files changed, 205 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/isimodem/version.h

<snip>

> +enum isi_version {
> +	ISI_20 =3D 0,
> +	ISI_25 =3D 1
> +};

so what is the final decision here now. ISI doing auto-detection and
this gets not exposed to the modem drivers or we do.

Aki, I remember you saying that this is not needed at all.

Regards

Marcel



--===============5737839205745461754==--


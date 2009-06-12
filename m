Content-Type: multipart/mixed; boundary="===============4767634298780183599=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: MNC/MCC as string?
Date: Fri, 12 Jun 2009 12:56:54 +0200
Message-ID: <a183fc99d677ed75caa3dc7b2ff2e32c@chewa.net>
In-Reply-To: <1244801553.8688.0.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4767634298780183599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




On Fri, 12 Jun 2009 12:12:33 +0200, Marcel Holtmann <marcel@holtmann.org>
wrote:
> Hi Aki,
> =

>> Anyway, here it is. Please test; seems to work for me on my N95.
> =

> +static void extract_mcc_mnc(const char *str, char *mcc, char *mnc)
>  {
> -       int num =3D 0;
> -       unsigned int i;
> -
>         /* Three digit country code */
> -       for (i =3D 0; i < 3; i++)
> -               num =3D num * 10 + (int)(str[i] - '0');
> -
> -       *mcc =3D num;
> -
> -       num =3D 0;
> +       strncpy(mcc, str, sizeof(mcc));
> +       mcc[3] =3D '\0';
> =

> maybe I am blind, but how is this suppose to work. The sizeof(mmc) is 1
> byte.

Actually, it is the size of a pointer, which will work (by accident) on
32-bits platform, and overflow on others. =


-- =

R=C3=A9mi Denis-Courmont


--===============4767634298780183599==--


Content-Type: multipart/mixed; boundary="===============4696474425330869486=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] Fix huawei_disconnect function issue
Date: Fri, 04 Mar 2011 10:14:14 -0300
Message-ID: <AANLkTi=4erm914qxzZa_pY6K+OPbv=OZx63_WxM-aCsL@mail.gmail.com>
In-Reply-To: <1299236656.32127.2.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4696474425330869486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Fri, Mar 4, 2011 at 8:04 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Anyhow, we need to get rid of the if (cbd =3D=3D NULL) check first. A whi=
le
> back we changed cb_data_new() to use g_new0() instead of g_try_new0() to
> simplify the code. So first that should be all cleaned up.
>
> A quick grep showed these locations for the AT modems:
>
> drivers/mbmmodem/location-reporting.c: =C2=A0if (cbd =3D=3D NULL)
> plugins/bluetooth.c: =C2=A0 =C2=A0if (cbd =3D=3D NULL) {
> plugins/huawei.c: =C2=A0 =C2=A0 =C2=A0 if (cbd =3D=3D NULL)


Since git-blame was pointing to me for th mbmmodem and the fix was
really simple, I fixed also the huawei case. bluetooth.c does not
apply here since it uses its own struct cb_data and calls
g_try_new0().


regards,

Lucas De Marchi

--===============4696474425330869486==--


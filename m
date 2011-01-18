Content-Type: multipart/mixed; boundary="===============2100451725938126084=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [gisi-notify-fix PATCH 1/4] gisi: remove before notify
Date: Tue, 18 Jan 2011 22:30:48 +0200
Message-ID: <AANLkTikqEA7HHv4KCk-Ocad0A4CgtmA_A=fOyKbx8nnb@mail.gmail.com>
In-Reply-To: <1294860252-29570-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2100451725938126084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

2011/1/12  <Pekka.Pessi@nokia.com>:
> @@ -192,24 +223,18 @@ static void service_dispatch(GIsiServiceMux *mux, G=
IsiMessage *msg,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pending_dispatch(pend, msg);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (pend->t=
ype =3D=3D GISI_MESSAGE_TYPE_RESP &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !is_indication && pend->utid =3D=3D utid=
) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!is_indication && pend->utid =3D=
=3D utid) {

The rest looked good, so I amended this extra space that had jumped in
here, and pushed. Thanks.

Cheers,
Aki

--===============2100451725938126084==--


Content-Type: multipart/mixed; boundary="===============0656561002706567381=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] sim: Ensure to call sim_pin_check
Date: Wed, 25 Aug 2010 16:57:02 +0300
Message-ID: <AANLkTindHKjMMpLuvtGBHbYcFxQYU+wYxcRRr_B+09uM@mail.gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA8029A8687@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0656561002706567381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/8/25  <Jeevaka.Badrappan@elektrobit.com>:
> I believe the right place to call the sim_pin_check() will be
> before the if condition(if (sim->language_prefs =3D=3D NULL)) in
> sim_efpl_read_cb(), like shown below
>
> =C2=A0 =C2=A0 =C2=A0if (efpl) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_slist_foreach(ef=
pl, (GFunc)g_free, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_slist_free(efpl);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sim_pin_check(sim);
>
> =C2=A0 =C2=A0 =C2=A0if (sim->language_prefs =3D=3D NULL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> =C2=A0 =C2=A0 =C2=A0ofono_dbus_signal_array_property_changed(conn, path,
>
> OFONO_SIM_MANAGER_INTERFACE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 "PreferredLanguages",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 DBUS_TYPE_STRING,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &sim->language_prefs);
>
> Let me know your views on this.

I think you are right. I've submitted a patch doing this in slightly
different manner...

-- =

Pekka.Pessi mail at nokia.com

--===============0656561002706567381==--


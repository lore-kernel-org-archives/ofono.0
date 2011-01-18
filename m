Content-Type: multipart/mixed; boundary="===============0641822182552495097=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 2/5] netreg: Add CPHS CSP PLMN mode implementation
Date: Tue, 18 Jan 2011 20:44:25 +0200
Message-ID: <AANLkTinjgScOv8sEkzWCsmoa1spQfPJpw+G9x5npPULc@mail.gmail.com>
In-Reply-To: <1295360948.3873.180.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0641822182552495097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/18 Marcel Holtmann <marcel@holtmann.org>:
>> + =C2=A0 =C2=A0 if (netreg->settings) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_key_file_set_boolean(netre=
g->settings, SETTINGS_GROUP,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "ForcedAuto", netre=
g->forced_auto);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 storage_sync(netreg->imsi, S=
ETTINGS_STORE, netreg->settings);
>> + =C2=A0 =C2=A0 }
>
> why are we bothering to store this value? Would it not be better to
> re-read when bringing up the modem?

We read the value always, yes, but storing the last known value rids
us of a superfluous PropertyChanged signal in the case when last value
of forced_auto was true, and after reading is still true. This is
because forced_auto is by default set to false.

I went back and forth with this myself as well, so perhaps it's not
worth the trouble.

Cheers,
Aki

--===============0641822182552495097==--


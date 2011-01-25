Content-Type: multipart/mixed; boundary="===============2274626584557849923=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/1] isimodem: Adding version isimodem and isimodem2.5
Date: Tue, 25 Jan 2011 14:39:39 +0200
Message-ID: <AANLkTik7d2_wahOGoEb3fSGbgfJw1vLfbyrbKeH7wofR@mail.gmail.com>
In-Reply-To: <1295958228.1520.36.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2274626584557849923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/1/25 Marcel Holtmann <marcel@holtmann.org>:
>> +enum isi_version {
>> + =C2=A0 =C2=A0 ISI_20 =3D 0,
>> + =C2=A0 =C2=A0 ISI_25 =3D 1
>> +};
>> +
>
> If we follow the same layout as with all other modem drivers, then the
> *modem.h should only contain the prototypes for the init callbacks.
>
>> =C2=A0extern struct ofono_modem *isi_modem_by_interface(char const *ifna=
me);
>
> This one already violates this one and might need to be cleaned up.
>
> The ISI modem is special since it really only has two users anyway in
> the end, but maybe drivers/isimodem/version.h analog to vendor.h from
> atmodem might be a good idea.
>
> Aki, what is your preference here?

I don't think there is a need for this, as ISI itself already provides
both ISI version (which we have available always via the
g_isi_client_verify() call), and in many cases also the resource ID as
means to find the correct quirk to use.

Of course, I could be convinced otherwise, but not without seeing
actual patches. It might become extremely ugly with using ISI version
and the resource ID, and using something like vendor.h might then make
sense.

But remember that we also have the isiusb plugin, and I would like it
to keep working with *any* isimodem out there.

Cheers,
Aki

--===============2274626584557849923==--


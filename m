Content-Type: multipart/mixed; boundary="===============2640552539986346974=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] isimodem: Adding version isimodem and isimodem2.5
Date: Tue, 25 Jan 2011 13:45:50 +0100
Message-ID: <1295959550.1520.43.camel@aeonflux>
In-Reply-To: <AANLkTik7d2_wahOGoEb3fSGbgfJw1vLfbyrbKeH7wofR@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2640552539986346974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> +enum isi_version {
> >> +     ISI_20 =3D 0,
> >> +     ISI_25 =3D 1
> >> +};
> >> +
> >
> > If we follow the same layout as with all other modem drivers, then the
> > *modem.h should only contain the prototypes for the init callbacks.
> >
> >>  extern struct ofono_modem *isi_modem_by_interface(char const *ifname);
> >
> > This one already violates this one and might need to be cleaned up.
> >
> > The ISI modem is special since it really only has two users anyway in
> > the end, but maybe drivers/isimodem/version.h analog to vendor.h from
> > atmodem might be a good idea.
> >
> > Aki, what is your preference here?
> =

> I don't think there is a need for this, as ISI itself already provides
> both ISI version (which we have available always via the
> g_isi_client_verify() call), and in many cases also the resource ID as
> means to find the correct quirk to use.
> =

> Of course, I could be convinced otherwise, but not without seeing
> actual patches. It might become extremely ugly with using ISI version
> and the resource ID, and using something like vendor.h might then make
> sense.

if you don't need external version or vendor quirks, then even better.
We are just damn unlucky in the atmodem case. The less the modem plugins
have to specify the better.

So this clearly then is not suppose to be in isimodem.h and while at it,
someone might wanna cleanup isi_modem_by_interface and move it to a
better location.

Regards

Marcel



--===============2640552539986346974==--


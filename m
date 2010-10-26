Content-Type: multipart/mixed; boundary="===============4384319545429816394=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: modem atom api change request for support GSM&CDMA dual mode
Date: Tue, 26 Oct 2010 16:15:19 -0700
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702BC6B86@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE805DC8D79@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4384319545429816394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

> > > Generally, Multimode modem will have different devices. =

> So it can be =

> > > regarded as two different modems. E.g. There is a =

> multimode modem, =

> > > there are two device files for Echo mode:
> > > such as /dev/ttyUSB0(for GSM) and /dev/ttyUSB1(for CDMA).
> > >
> > > Of course, there may be multimode modem that only offers =

> one device =

> > > file, or other similar cases.
> > =

> > Yes, I meant also the MM modem cases where it offers one =

> device file, =

> > which exposes the MM modem as a single device to the AP and also =

> > offering mode switching between GSM and CDMA. When considering both =

> > these cases Property name ModemAccesSTechnology suits better than =

> > Type.
> > =

> =

> Yes, I do agree.
> =

> > > It seems it is very hard to support this case in ofono currently.
> >
> > Any reasons ?
> > =

> =

> Do you mean the multimode modem only works at one mode at a =

> time. Can the GSM and CDMA mode work at the same time.

Yes, I meant the one which works in One mode at a time, which provides
roaming between CDMA and GSM networks.Can I go ahead with the =

modifications and submit the patch, as I am dependant on this task for
CDMA SMS developement ?

> I means, such as when you are in a GSM call you can receive =

> CDMA SMS at the same time. If so, Could you please describe =

> how you achieve this? In my opinion, we need to do much =

> change to make ofono support this.

I am not sure if its possible to listen to the paging channel
in CDMA for notifications while the GSM call is active unless
it exposes to the AP as two different modems.

BR,
Rajesh

--===============4384319545429816394==--


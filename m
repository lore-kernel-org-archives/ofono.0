Content-Type: multipart/mixed; boundary="===============8636296749517589300=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: modem atom api change request for support GSM&CDMA dual mode
Date: Tue, 26 Oct 2010 08:52:17 +0200
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE805DC8D79@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702B73BC4@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8636296749517589300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

> > Generally, Multimode modem will have different devices. So it
> > can be regarded as two different modems. E.g. There is a
> > multimode modem, there are two device files for Echo mode:
> > such as /dev/ttyUSB0(for GSM) and /dev/ttyUSB1(for CDMA).
> >
> > Of course, there may be multimode modem that only offers one
> > device file, or other similar cases.
> =

> Yes, I meant also the MM modem cases where it offers one device file,
> which exposes the MM modem as a single device to the AP and also
> offering
> mode switching between GSM and CDMA. When considering both these cases
> Property name ModemAccesSTechnology suits better than Type.
> =


Yes, I do agree.

> > It seems it is very hard to support this case in ofono currently.
>
> Any reasons ?
> =


Do you mean the multimode modem only works at one mode at a time. Can
the =

GSM and CDMA mode work at the same time. I means, such as when you are
in a =

GSM call you can receive CDMA SMS at the same time. If so, Could you
please =

describe how you achieve this? In my opinion, we need to do much change
to
make ofono support this.

Best regards
Caiwen



--===============8636296749517589300==--


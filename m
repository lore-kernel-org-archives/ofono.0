Content-Type: multipart/mixed; boundary="===============4297324229636211449=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: modem atom api change request for support GSM&CDMA dual mode
Date: Tue, 26 Oct 2010 07:37:12 +0200
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE805DC8CFE@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702B73BAF@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4297324229636211449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

> >
> >Considering support GSM + CDMA dual mode, it is necessary to let
upper
> layer to
> >know the type of the modem currently in use. My proposed solution is
> add a
> >property 'Type' in modem atom to indicate it. The following is the
> definition
> >of the property:
> >
> >string Type [readonly]
> >
> >Type of the modem. The possible values are:
> > "gsm" - the modem is a GSM modem
> > "cdma" - the modem is a CDMA modem
> > "unknown" - the modem is neither a GSM modem nor
> >             a CDMA modem
> =

> As there are also Multimode modems(both GSM and CDMA), Property name
> Type would be misleading.
>

Generally, Multimode modem will have different devices. So it can be
regarded as
two different modems. E.g. There is a multimode modem, there are two
device files for
Echo mode: such as /dev/ttyUSB0(for GSM) and /dev/ttyUSB1(for CDMA).

Of course, there may be multimode modem that only offers one device
file, or other =

similar cases. It seems it is very hard to support this case in ofono
currently.

> string ModemAccessTechnology [readonly]
> =

> Current Access Technology of the Modem.
> The Possible values are:
> "gsm" - the current modem access technology is GSM
> "cdma" - the current modem access technology is CDMA
> =


Best regards
Caiwen


--===============4297324229636211449==--


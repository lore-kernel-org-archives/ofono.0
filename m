Content-Type: multipart/mixed; boundary="===============1580584180137091498=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/3] coex: Adding documetation for coex interface
Date: Tue, 27 Nov 2018 10:15:01 +0100
Message-ID: <CAKSBH7F32NNSgZv6cfoD2mwZfiOJcbnxC0FhrPwoD+jpdNKS6Q@mail.gmail.com>
In-Reply-To: <20181127090129.GB20504@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1580584180137091498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 27, 2018 at 10:01 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > +LTE Coexistence hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service              org.ofono
> > +Interface    org.ofono.IntelLTECoex*
> > +Object path  [variable prefix]/{modem0,modem1,...}
>
> The interface should be generic, not Intel-specific in the end, right?

We discussed this earlier.
It is Intel-specific, because it uses non-standard command to disable
bands colliding with the WiFi frequencies, and perhaps only
interesting for these modems.

>
>
> > +             a(a{sv}) GetPlmnHistory()
> > +                     Requests for LTE Plmn history list stored in NVM =
to
> > +                     retrieve geo location history like MobileNetworkC=
ode,
> > +                     MobileCountryCode, LteBandsFDD, LteBandsTDD, Chan=
nelBandwidth.
> > +                     *most recently uused
>
> "uused" is typo?
>

BR,
Giacinto

>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============1580584180137091498==--


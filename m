Content-Type: multipart/mixed; boundary="===============4887131080648344870=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 1/1] telit: stay 'online' until POST_SIM state reached
Date: Fri, 07 Dec 2012 09:09:23 +0100
Message-ID: <1354867763.2781.94.camel@jerome.southpole.se>
In-Reply-To: <1354861353.2781.84.camel@jerome.southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4887131080648344870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-12-07 at 07:22 +0100, Jonas Bonn wrote:
> Hi Denis,
> =

> On Tue, 2012-12-04 at 23:55 -0600, Denis Kenzior wrote:
> > Hi Jonas,
> > =

> > On 12/04/2012 09:46 AM, Jonas Bonn wrote:
> > > In offline state where CFUN=3D4, the Telit HE910 also powers down the=
 SIM
> > > card so AT commands that query the SIM will fail.  These failures res=
ult
> > > in ofono not getting to POST_SIM state where it will export the GPRS
> > > feature.
> =

> > =

> > Does the HE910 have a proper CFUN mode where it does not turn off the =

> > SIM?  You are making some nasty hacks because of it, and the other Teli=
t =

> > devices support this just fine.

With the above patch, after the modem is enabled (telit_enable()) we end
up with this from list-modems:

[ /telit_0 ]
    Features =3D sim =

    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.VoiceCallManager org.ofono.SimManager =

    Online =3D 0
    Model =3D HE910
    Revision =3D 12.00.003
    Type =3D hardware
    Serial =3D 357164040533674
    Manufacturer =3D Telit
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 08 000 999 110 112 911 118 119 =

    [ org.ofono.SimManager ]
        Retries =3D [pin2 =3D 3] [puk2 =3D 10] [pin =3D 3] [puk =3D 10] =

        FixedDialing =3D 0
        SubscriberNumbers =3D =

        BarredDialing =3D 0
        CardIdentifier =3D 89..............
        LockedPins =3D =

        PinRequired =3D none
        Present =3D 1

Without the patch we get the following:

[ /telit_0 ]
    Features =3D sim =

    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.VoiceCallManager org.ofono.SimManager =

    Online =3D 0
    Model =3D HE910
    Revision =3D 12.00.003
    Type =3D hardware
    Serial =3D 357164040533674
    Manufacturer =3D Telit
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 08 000 999 110 112 911 118 119 =

    [ org.ofono.SimManager ]
        Present =3D 0

In this state, Connman will never try to "online" the modem.

/Jonas


--===============4887131080648344870==--


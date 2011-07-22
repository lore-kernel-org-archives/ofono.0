Content-Type: multipart/mixed; boundary="===============8623299052273559422=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] SpeedUp CDMA: querying SIM state during powering on phase.
Date: Fri, 22 Jul 2011 10:57:45 +0100
Message-ID: <568DE01DA537804BA73470071BAC288938F4DEBC@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1311328408.21109.311.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8623299052273559422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > > This is wrong code. So in case CFUN=3D1 fails, you still go ahead and
> > > query the SIM state. That is rather pointless and might result on
> > > unforseen feedback from the modem.
> > >
> > > In addition you do not handle the set_powered in case ^SYSINFO fails =
or
> > > you have polled max attempts.
> > >
> > > Now looking over this. I do not like this at all. Please do not copy =
any
> > > code from Huawei plugin and write this from scratch based on actual
> > > traces and the documentation.
> >
> > I totally agree, I will rework this part.
> >
> > I will set the powered flag after CFUN, and use the SYSINFO to broadcas=
t SIM
> info (available or not).
> =

> please post OFONO_AT_DEBUG traces to the mailing list first.
> =

> If you wanna handle some fake CDMA SIM states, then we might need a
> simplified SIM atom driver for CDMA as well. Or something only CDMA
> specific.

No. In fact modems seems to react correctly. There is SIM state notificatio=
n, but we got it once over 10. So I do not want to rely on.

SYSINFO will give me the info, and it's always correct so I do not need a p=
olling mechanism. =


> Otherwise the check for a valid CDMA SIM, ROM SIM or whatever they call
> it should be done during the enable callback handling. If it is not
> there, then it is not there. Nothing you can do about it anyway. Failing
> the modem enabling seems to be the best approach in my book.

Exactly, I have to check for SIM available or not. I will send once the SYS=
INFO in the cfun callback, and based on the result notify the availability =
of the SIM.

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============8623299052273559422==--


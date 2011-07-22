Content-Type: multipart/mixed; boundary="===============6050878792787620509=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] SpeedUp CDMA: querying SIM state during powering on phase.
Date: Fri, 22 Jul 2011 11:53:27 +0200
Message-ID: <1311328408.21109.311.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938F4DEA6@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6050878792787620509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> > This is wrong code. So in case CFUN=3D1 fails, you still go ahead and
> > query the SIM state. That is rather pointless and might result on
> > unforseen feedback from the modem.
> > =

> > In addition you do not handle the set_powered in case ^SYSINFO fails or
> > you have polled max attempts.
> > =

> > Now looking over this. I do not like this at all. Please do not copy any
> > code from Huawei plugin and write this from scratch based on actual
> > traces and the documentation.
> =

> I totally agree, I will rework this part.
> =

> I will set the powered flag after CFUN, and use the SYSINFO to broadcast =
SIM info (available or not).

please post OFONO_AT_DEBUG traces to the mailing list first.

If you wanna handle some fake CDMA SIM states, then we might need a
simplified SIM atom driver for CDMA as well. Or something only CDMA
specific.

Otherwise the check for a valid CDMA SIM, ROM SIM or whatever they call
it should be done during the enable callback handling. If it is not
there, then it is not there. Nothing you can do about it anyway. Failing
the modem enabling seems to be the best approach in my book.

Regards

Marcel



--===============6050878792787620509==--


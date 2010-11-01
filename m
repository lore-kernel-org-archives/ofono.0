Content-Type: multipart/mixed; boundary="===============0708605278015919703=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC PATCH 2/3] voicecall: emergency call handling added
Date: Mon, 01 Nov 2010 10:41:41 +0100
Message-ID: <1288604501.3322.104.camel@aeonflux>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782BE902C40D@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0708605278015919703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> > > To give you a more complex example, it might well be that the gprs
> > > connection needs to be torn down when making an emergency call in
> > > 2G mode, there are such networks out there that prevents you from
> > > making an emergency call if your device is attached to a =

> > PDP context.
> > > In this given situation it comes to the question how to =

> > bring down the
> > > gprs connection. It can be done such that the gprs atom =

> > will tear down
> > > the connection after receiving the EmergencyMode notification, or
> > > another option is to have gprs connection handling functions made
> > =

> > Have we established that this is actually still needed?  I thought you
> > guys said all the networks that have this problem have been =

> > fixed by now?
> =

> AFAIK, this is still a product requirement for us. I can recheck, but I j=
ust asked last week and the answer was a very definite "Yes, this is still =
required".

as Denis and I mentioned, we have been told that this is not needed
anymore. So where is this still needed?

And again, this is something that the modem firmware should be doing
anyway (if it is needed). The modem firmware knows best. And we do have
the GPRS suspend support already to signal this back to the user.

Regards

Marcel



--===============0708605278015919703==--


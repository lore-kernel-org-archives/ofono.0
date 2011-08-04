Content-Type: multipart/mixed; boundary="===============8933791122181298604=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] speedup: blacklist the NO CARRIER terminator for control
 channel
Date: Thu, 04 Aug 2011 18:24:45 +0200
Message-ID: <1312475086.3373.41.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC28893905BCDA@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8933791122181298604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> > > Some Speedup cards will send the NO CARRIER in the control channel.
> > =

> > please include a trace. I am not sure how this effect anything since we
> > are not supporting online/offline mode with these cards.
> =

> Ok, no problem. What kind of test do you want me to do?
> =

> I make a data call that failed and then I disable the modem?

you are proposing to blacklist this terminator. So you should know where
it causes a problem. I only blacklisted it modems that were supporting
online mode and where switching offline caused a problem that NO CARRIER
came before OK. Do you have that problem?

Regards

Marcel



--===============8933791122181298604==--


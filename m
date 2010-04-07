Content-Type: multipart/mixed; boundary="===============3665763738652173918=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 11:03:32 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9C141100E@orsmsx508.amr.corp.intel.com>
In-Reply-To: <201004071233.50561.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3665763738652173918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi Waldo,
> =

> > > Hi Denis,
> > >
> > > Actually our apps listen for the IncomingMessage signal, and store the
> > > SMS in an internal database.
> > > At some point by design, a restart, a crash or other reasons, it may
> > > happen that apps are down while ofono and the modem are up, in that
> > > case we lose incoming messages.
> >
> > A similar lack of robustness exists at the modem API side as well, if
> oFono
> >  crashes/runs out of battery after receiving the message from the modem
> >  driver the message is lost. There is no provision in the SMS modem API
> to
> >  signal back to the modem driver that the message has been successfully
> >  stored on the APE.
> =

> If oFono crashes/runs out of battery here the driver is gone along with
> oFono.
> Notifying it of anything is not going to help ;)

Currently the modem driver acknowledges the PDU right away. If there was a =
notification back to the modem driver, the PDU acknowledgement could be del=
ayed till that point in time. If something bad happens in between, either t=
he modem or the network can hold on to the PDU and redeliver once oFono is =
up and running again.

Looking at at_cmt_notify() the current implementation might have that affec=
t already, as AT+CNMA is only send after calling ofono_sms_deliver_notify()=
. So as long as ofono_sms_deliver_notify() is handled synchronously and ens=
ures that the PDU is stored one way or another before returning, it will wo=
rk in case of a crash. (Would like to see assumptions like that called out =
in the code) That said, if your storage has issues (disk full?) there is cu=
rrently no way to let the modem driver know that delivery was unsuccessful.

Cheers,
Waldo

--===============3665763738652173918==--


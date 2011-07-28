Content-Type: multipart/mixed; boundary="===============2585066392344715902=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] speedup: during enable, we have to go offline first.
Date: Thu, 28 Jul 2011 15:21:33 +0200
Message-ID: <1311859293.8920.108.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938FA9AC7@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2585066392344715902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> > > >  plugins/speedup.c |    2 +-
> > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > >
> > > > diff --git a/plugins/speedup.c b/plugins/speedup.c
> > > > index 90ca5e3..a7aa43c 100644
> > > > --- a/plugins/speedup.c
> > > > +++ b/plugins/speedup.c
> > > > @@ -177,7 +177,7 @@ static int speedup_enable(struct ofono_modem *m=
odem)
> > > >  	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NUL=
L,
> > > NULL);
> > > >  	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL,=
 NULL);
> > > >
> > > > -	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL,
> > > > +	g_at_chat_send(data->aux, "AT+CFUN=3D4", NULL,
> > > >  					cfun_enable, modem, NULL);
> > >
> > > this is not a correct fix. You are messing up the logic here. You are
> > > still in offline mode from an oFono point of view, but your modem is
> > > actually online.
> > >
> > > Try the same that we did for ZTE with sending +CFUN=3D1;+CFUN=3D4 if =
that
> > > works out.
> > =

> > This is not working:
> > =

> > ofonod[17315]: plugins/speedup.c:speedup_enable() 0x9ae1af8
> > ofonod[17315]: src/modem.c:get_modem_property() modem 0x9ae1af8 propert=
y Modem
> > ofonod[17315]: plugins/speedup.c:open_device() Modem /dev/ttyUSB1
> > ofonod[17315]: src/modem.c:get_modem_property() modem 0x9ae1af8 propert=
y Aux
> > ofonod[17315]: plugins/speedup.c:open_device() Aux /dev/ttyUSB2
> > ofonod[17315]: Modem: > ATE0 +CMEE=3D1\r
> > ofonod[17315]: Aux: > ATE0 +CMEE=3D1\r
> > ofonod[17315]: Aux: < ATE0 +CMEE=3D1\r
> > ofonod[17315]: Modem: < \r\nOK\r\n
> > ofonod[17315]: Aux: < \r\nOK\r\n
> > ofonod[17315]: Aux: > AT+CFUN=3D1;+CFUN=3D4\r
> > ofonod[17315]: Aux: < \r\n+CME ERROR: 0\r\n
> > ofonod[17315]: plugins/speedup.c:cfun_enable()
> > =

> > =

> > > If not, then check if we can go CFUN=3D1 first and then after SIM que=
ry
> > > succeeded, we go into CFUN=3D4. We do this for Huawei actually.
> > =

> > I will try this...
> =

> I have attach the log. There is an issue. The AT command just after the C=
FUN=3D1 to go online are failing. I guess that we have to do some timing st=
uff, because if I use minicom to send the AT+CREG=3D? Later, the answer is =
correct.

actually you can only do set_powered() after the CFUN=3D4 succeeded. You
need to feed that into your modem enabling procedure.

ofonod[26439]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[26439]: plugins/speedup.c:speedup_pre_sim() 0x8909ae0
ofonod[26439]: Aux: > AT+GCAP\r
ofonod[26439]: src/sim.c:ofono_sim_add_state_watch() 0x890a348
ofonod[26439]: src/sim.c:ofono_sim_add_state_watch() 0x890a348
ofonod[26439]: src/sim.c:ofono_sim_add_state_watch() 0x890a348
ofonod[26439]: Aux: < \r\n+GCAP: +CGSM,+FCLASS,+DS\r\n\r\nOK\r\n
ofonod[26439]: Aux: > AT+CFUN=3D4\r
ofonod[26439]: Aux: < \r\nOK\r\n

The log clearly shows that you power on the modem before sending CFUN=3D4.
Try to change that.

Some other comments along the lines for this modem:

ofonod[26439]: Aux: > AT+CSCB=3D?\r
ofonod[26439]: Aux: < \r\nERROR\r\n
ofonod[26439]: CSCB not supported

Since CBS is not supported, do not even bother creating that atom.

ofonod[26439]: Aux: > AT+CSCS?\r
ofonod[26439]: Aux: < \r\nERROR\r\n
ofonod[26439]: Aux: > AT+CUSD=3D1\r
ofonod[26439]: Aux: < \r\nERROR\r\n
ofonod[26439]: Could not enable CUSD notifications

Same goes for USSD. That is why I hate blind copies from other modem
plugins.

And I would not be surprised if even SMS is half failing. It takes a lot
of patience to figure out what quirks are needed for what hardware. If
it is not tested, then we rather not enable it in the first place.

Regards

Marcel



--===============2585066392344715902==--


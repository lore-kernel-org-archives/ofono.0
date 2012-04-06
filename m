Content-Type: multipart/mixed; boundary="===============8344865342108647436=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] SpeedUp: enable online/offline
Date: Fri, 06 Apr 2012 14:45:02 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E18A8F27F@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <4F7EFE53.7030904@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8344865342108647436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> On 04/06/2012 08:34 AM, Bertrand Aygon wrote:
> > Add speedup_set_online.
> > Add a polling mechanism since most speedup dongles failed in couple =

> > of AT commands following the CFUN=3D1 when they are offline.
> >
> > ---
> >  plugins/speedup.c |  106
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 106 insertions(+), 0 deletions(-)
> >
> > diff --git a/plugins/speedup.c b/plugins/speedup.c index
> > ca6ed13..905f462 100644
> > --- a/plugins/speedup.c
> > +++ b/plugins/speedup.c
> > @@ -47,12 +47,16 @@
> >  #include <drivers/atmodem/atutil.h>  #include =

> > <drivers/atmodem/vendor.h>
> >
> > +static const char *creg_prefix[] =3D { "+CREG:", NULL };
> >  static const char *none_prefix[] =3D { NULL };
> >
> >  struct speedup_data {
> >  	GAtChat *modem;
> >  	GAtChat *aux;
> >  	gboolean have_sim;
> > +	guint online_poll_source;
> > +	guint online_poll_count;
> > +	struct cb_data *online_cbd;
> =

> You need to free these in case the modem is removed when the online =

> operation is in progress.

Ok, I will do this.


> >  	struct at_util_sim_state_query *sim_state_query;  };
> >
> > @@ -238,6 +242,107 @@ static int speedup_disable(struct ofono_modem
> *modem)
> >  	return -EINPROGRESS;
> >  }
> >
> > +static gboolean creg_online_check(gpointer user_data);
> > +
> > +static void creg_online_cb(gboolean ok, GAtResult *result,
> > +						gpointer user_data)
> > +{
> > +	struct speedup_data *data =3D user_data;
> > +	ofono_modem_online_cb_t cb =3D data->online_cbd->cb;
> > +
> > +	if (ok) {
> > +		CALLBACK_WITH_SUCCESS(cb, data->online_cbd->data);
> > +		goto done;
> > +	}
> > +
> > +	data->online_poll_count++;
> > +
> > +	if (data->online_poll_count > 15)
> > +		goto failure;
> > +
> > +	data->online_poll_source =3D g_timeout_add_seconds(2,
> > +						creg_online_check, data);
> > +	return;
> > +
> > +failure:
> > +	CALLBACK_WITH_FAILURE(cb, data->online_cbd->data);
> > +
> > +done:
> > +	g_free(data->online_cbd);
> > +	data->online_cbd =3D NULL;
> > +}
> > +
> > +static gboolean creg_online_check(gpointer user_data) {
> > +	struct speedup_data *data =3D user_data;
> > +
> > +	data->online_poll_source =3D 0;
> > +
> > +	g_at_chat_send(data->aux, "AT+CREG=3D?", creg_prefix,
> > +					creg_online_cb, data, NULL);
> =

> Just for my understanding, the modem stops responding to all commands =

> when
> CFUN=3D1 is issued, hence you're polling that CREG is supported?

It responds errors. Here are some logs. First log without the polling mecha=
nism.

...
ofonod[8096]: src/network.c:ofono_netreg_strength_notify() strength 40
ofonod[8096]: Aux: > AT+CGATT=3D1\r
ofonod[8096]: Aux: < \r\nOK\r\n
ofonod[8096]: src/gprs.c:gprs_attach_callback() /speedup_3 error =3D 0
ofonod[8096]: Aux: > AT+CIND?\r
ofonod[8096]: Aux: < \r\n+CIND: 5,2,1,0,0,0,1,0\r\n\r\nOK\r\n
ofonod[8096]: Aux: > AT+CRSM=3D192,28437,0,0,255\r
ofonod[8096]: Aux: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[8096]: Aux: > AT+COPS=3D3,0\r
ofonod[8096]: Aux: < \r\nOK\r\n
ofonod[8096]: Aux: > AT+COPS?\r
ofonod[8096]: Aux: < \r\n+COPS: 0,0,"F SFR",2\r\n\r\nOK\r\n
ofonod[8096]: drivers/atmodem/network-registration.c:cops_cb() cops_cb: =

F SFR, 208 10 2
ofonod[8096]: src/network.c:current_operator_callback() 0x9c696e0, (nil)
ofonod[8096]: src/gprs.c:netreg_status_changed() 1
ofonod[8096]: src/cbs.c:cbs_location_changed() 1, 48101, 20894309, -1, 20810
ofonod[8096]: src/cbs.c:cbs_location_changed() 1, 0, 0
ofonod[8096]: Aux: > AT+CGREG?\r
ofonod[8096]: Aux: < \r\n+CGREG: 2,1, BBE5, 13ED265\r\n\r\nOK\r\n
ofonod[8096]: src/gprs.c:registration_status_cb() /speedup_3 error 0 status=
 1
ofonod[8096]: src/gprs.c:ofono_gprs_status_notify() /speedup_3 status 1

... going offline

ofonod[8096]: plugins/speedup.c:speedup_set_online() modem 0x9c59cc0 offline
ofonod[8096]: Aux: > AT+CFUN=3D4\r
ofonod[8096]: Aux: < \r\nOK\r\n
ofonod[8096]: src/modem.c:modem_change_state() old state: 3, new state: 2
ofonod[8096]: src/modem.c:flush_atoms()
ofonod[8096]: src/ussd.c:ussd_remove() atom: 0x9c594b0
ofonod[8096]: src/network.c:__ofono_netreg_remove_status_watch() 0x9c696e0
ofonod[8096]: src/cbs.c:cbs_remove() atom: 0x9c59408
ofonod[8096]: src/sim.c:ofono_sim_remove_spn_watch() 0x9c6a140
ofonod[8096]: src/network.c:netreg_remove() atom: 0x9c59198
ofonod[8096]: Aux: < \r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n
ofonod[8096]: src/gprs.c:ofono_gprs_status_notify() /speedup_3 status 0

... going online

ofonod[8096]: plugins/speedup.c:speedup_set_online() modem 0x9c59cc0 online
ofonod[8096]: Aux: > AT+CFUN=3D1\r
ofonod[8096]: Aux: < \r\nOK\r\n
ofonod[8096]: src/modem.c:modem_change_state() old state: 2, new state: 3
ofonod[8096]: Aux: > AT+CREG=3D?\r
ofonod[8096]: Aux: < \r\nERROR\r\n
ofonod[8096]: Unable to initialize Network Registration
ofonod[8096]: src/network.c:netreg_remove() atom: 0x9c5aa80
ofonod[8096]: Aux: > AT+CSCB=3D?\r
ofonod[8096]: Aux: < \r\nERROR\r\n
ofonod[8096]: CSCB not supported
ofonod[8096]: src/cbs.c:cbs_remove() atom: 0x9c5fc90
ofonod[8096]: Aux: > AT+CSCS?\r
ofonod[8096]: Aux: < \r\nERROR\r\n
ofonod[8096]: Aux: > AT+CUSD=3D1\r
ofonod[8096]: Aux: < \r\nERROR\r\n
ofonod[8096]: Could not enable CUSD notifications
ofonod[8096]: Aux: < \r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n
ofonod[8096]: src/gprs.c:ofono_gprs_status_notify() /speedup_3 status 0
ofonod[8096]: Aux: < \r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n
ofonod[8096]: src/gprs.c:ofono_gprs_status_notify() /speedup_3 status 0
ofonod[8096]: Aux: < \r\n+CREG: 2\r\n\r\n+CGREG: 2\r\n
ofonod[8096]: src/gprs.c:ofono_gprs_status_notify() /speedup_3 status 2
ofonod[8096]: Aux: < \r\n+CREG: 1, BBE5, 13ED265\r\n\r\n+CGREG: 0\r\n
ofonod[8096]: src/gprs.c:ofono_gprs_status_notify() /speedup_3 status 0



And now with the polling mechanism:

...
ofonod[8814]: Aux: < \r\nOK\r\n
ofonod[8814]: Aux: > AT+COPS?\r
ofonod[8814]: Aux: < \r\n+COPS: 0,2,"20810",2\r\n\r\nOK\r\n
ofonod[8814]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 208, mnc: 10
ofonod[8814]: Aux: > AT+CIND?\r
ofonod[8814]: Aux: < \r\n+CIND: 5,2,1,0,0,0,1,0\r\n\r\nOK\r\n
ofonod[8814]: src/network.c:ofono_netreg_strength_notify() strength 40
ofonod[8814]: Aux: > AT+CGATT=3D1\r
ofonod[8814]: Aux: < \r\nOK\r\n
ofonod[8814]: src/gprs.c:gprs_attach_callback() /speedup_0 error =3D 0
ofonod[8814]: Aux: > AT+CIND?\r
ofonod[8814]: Aux: < \r\n+CIND: 5,2,1,0,0,0,1,0\r\n\r\nOK\r\n
ofonod[8814]: Aux: > AT+CRSM=3D192,28437,0,0,255\r
ofonod[8814]: Aux: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[8814]: Aux: > AT+COPS=3D3,0\r
ofonod[8814]: Aux: < \r\nOK\r\n
ofonod[8814]: Aux: > AT+COPS?\r
ofonod[8814]: Aux: < \r\n+COPS: 0,0,"F SFR",2\r\n\r\nOK\r\n
ofonod[8814]: drivers/atmodem/network-registration.c:cops_cb() cops_cb: =

F SFR, 208 10 2
ofonod[8814]: src/network.c:current_operator_callback() 0x9365d08, (nil)
ofonod[8814]: src/gprs.c:netreg_status_changed() 1
ofonod[8814]: src/cbs.c:cbs_location_changed() 1, 48101, 20894309, -1, 20810
ofonod[8814]: src/cbs.c:cbs_location_changed() 1, 0, 0
ofonod[8814]: Aux: > AT+CGREG?\r
ofonod[8814]: Aux: < \r\n+CGREG: 2,1, BBE5, 13ED265\r\n\r\nOK\r\n
ofonod[8814]: src/gprs.c:registration_status_cb() /speedup_0 error 0 status=
 1
ofonod[8814]: src/gprs.c:ofono_gprs_status_notify() /speedup_0 status 1

... going offline

ofonod[8814]: plugins/speedup.c:speedup_set_online() modem 0x93643c0 offline
ofonod[8814]: Aux: > AT+CFUN=3D4\r
ofonod[8814]: Aux: < \r\nOK\r\n
ofonod[8814]: src/modem.c:modem_change_state() old state: 3, new state: 2
ofonod[8814]: src/modem.c:flush_atoms()
ofonod[8814]: src/ussd.c:ussd_remove() atom: 0x9364a58
ofonod[8814]: src/network.c:__ofono_netreg_remove_status_watch() 0x9365d08
ofonod[8814]: src/cbs.c:cbs_remove() atom: 0x93649b8
ofonod[8814]: src/sim.c:ofono_sim_remove_spn_watch() 0x9364bf0
ofonod[8814]: src/network.c:netreg_remove() atom: 0x93579d8
ofonod[8814]: Aux: < \r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n
ofonod[8814]: src/gprs.c:ofono_gprs_status_notify() /speedup_0 status 0

... going online

ofonod[8814]: plugins/speedup.c:speedup_set_online() modem 0x93643c0 online
ofonod[8814]: Aux: > AT+CFUN=3D1\r
ofonod[8814]: Aux: < \r\nOK\r\n
ofonod[8814]: Aux: > AT+CREG=3D?\r
ofonod[8814]: Aux: < \r\nERROR\r\n
ofonod[8814]: Aux: < \r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n
ofonod[8814]: src/gprs.c:ofono_gprs_status_notify() /speedup_0 status 0
ofonod[8814]: Aux: < \r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n
ofonod[8814]: src/gprs.c:ofono_gprs_status_notify() /speedup_0 status 0
ofonod[8814]: Aux: < \r\n+CREG: 2\r\n\r\n+CGREG: 2\r\n
ofonod[8814]: src/gprs.c:ofono_gprs_status_notify() /speedup_0 status 2
ofonod[8814]: Aux: < \r\n+CREG: 1, BBE5, 13ED265\r\n\r\n+CGREG: 0\r\n
ofonod[8814]: src/gprs.c:ofono_gprs_status_notify() /speedup_0 status 0
ofonod[8814]: Aux: > AT+CREG=3D?\r
ofonod[8814]: Aux: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
ofonod[8814]: src/modem.c:modem_change_state() old state: 2, new state: 3
ofonod[8814]: Aux: > AT+CREG=3D?\r
ofonod[8814]: Aux: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
ofonod[8814]: Aux: > AT+CSCB=3D?\r
ofonod[8814]: Aux: < \r\n+CSCB: (0-1)\r\n\r\nOK\r\n
ofonod[8814]: Aux: > AT+CSCS?\r
ofonod[8814]: Aux: < \r\n+CSCS: "GSM"\r\n\r\nOK\r\n
ofonod[8814]: Aux: > AT+CUSD=3D1\r
ofonod[8814]: Aux: < \r\nOK\r\n
ofonod[8814]: Aux: > AT+CREG=3D2\r
ofonod[8814]: Aux: < \r\nOK\r\n
ofonod[8814]: Aux: > AT+CSCB=3D1,"0-65535"\r
ofonod[8814]: Aux: < \r\n+CMS ERROR: 314\r\n
ofonod[8814]: src/cbs.c:cbs_got_imsi() Got IMSI: 208103385793730
ofonod[8814]: Aux: > AT+CIND=3D?\r
ofonod[8814]: Aux: < \r\n+CIND: =

("battchg",(0-5)),("signal",(0-5)),("service",(0-1)),("call",(0-1)),("roam"=
,(0-1)),("smsfull",(0-1)),("GPRS
coverage",(0-1)),("callsetup",(0-3))\r\n\r\nOK\r\n
ofonod[8814]: src/sim.c:ofono_sim_add_spn_watch() 0x9364bf0
ofonod[8814]: src/network.c:__ofono_netreg_add_status_watch() 0x9365d08
ofonod[8814]: src/network.c:__ofono_netreg_add_status_watch() 0x9365d08
ofonod[8814]: src/network.c:__ofono_netreg_add_status_watch() 0x9365d08
ofonod[8814]: Aux: > AT+CRSM=3D192,28488,0,0,255\r
ofonod[8814]: Aux: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[8814]: drivers/atmodem/cbs.c:at_cbs_set_topics()
ofonod[8814]: Aux: > AT+CMER=3D3,0,0,1\r
ofonod[8814]: Aux: < \r\nOK\r\n
ofonod[8814]: Aux: > AT+CREG?\r
ofonod[8814]: Aux: < \r\n+CREG: 2,1, BBE5, 13ED265\r\n\r\nOK\r\n
ofonod[8814]: src/network.c:ofono_netreg_status_notify() /speedup_0 status =
1 tech -1
ofonod[8814]: src/gprs.c:netreg_status_changed() 1
ofonod[8814]: src/cbs.c:cbs_location_changed() 1, 48101, 20894309, -1,
(null)(null)
ofonod[8814]: Aux: > AT+CSCB=3D1\r
ofonod[8814]: Aux: < \r\n+CMS ERROR: 314\r\n
ofonod[8814]: Aux: > =

AT+CSCB=3D0,"5,38,54,130,147,221,223,231,237,786,4352-4356"\r
ofonod[8814]: Aux: < \r\n+CMS ERROR: 314\r\n
ofonod[8814]: Setting Cell Broadcast topics failed
ofonod[8814]: Aux: > AT+CRSM=3D192,28613,0,0,255\r
ofonod[8814]: Aux: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[8814]: Aux: > AT+COPS=3D3,2\r
ofonod[8814]: Aux: < \r\nOK\r\n
ofonod[8814]: Aux: > AT+COPS?\r
ofonod[8814]: Aux: < \r\n+COPS: 0,2,"20810",2\r\n\r\nOK\r\n
ofonod[8814]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 208, mnc: 10
ofonod[8814]: Aux: > AT+CIND?\r
ofonod[8814]: Aux: < \r\n+CIND: 5,1,1,0,0,0,0,0\r\n\r\nOK\r\n
ofonod[8814]: src/network.c:ofono_netreg_strength_notify() strength 20
ofonod[8814]: Aux: > AT+CGATT=3D1\r

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


--===============8344865342108647436==--


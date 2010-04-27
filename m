Content-Type: multipart/mixed; boundary="===============4932154735686754251=="
MIME-Version: 1.0
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v0] Read EF_ICCID property of SIM
Date: Tue, 27 Apr 2010 17:43:32 +0200
Message-ID: <20100427154331.GA18877@pc0043.bmw-carit.intra>
In-Reply-To: <201004270921.21557.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4932154735686754251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Apr 27, 2010 at 04:21:21PM +0200, Denis Kenzior wrote:
> Hi Daniel,
> =

> > On Tue, Apr 27, 2010 at 08:36:31AM +0200, Daniel Wagner wrote:
> > > > Please use the sim file queue like EFpl does, no need to invent your
> > > > own solution.
> > >
> > > I used the ofono_sim_read function but that didn't work. On the
> > > terminal I saw only:
> > >
> > > CRSM=3D192,12258
> > >
> > > With read_file_transparent it is:
> > >
> > > ofonod[2048]: Control:> AT+CRSM=3D176,12258,0,0,10\r
> > > ofonod[2048]: Control:< \r\r\n+CRSM:
> > > 144,0,"989422024754212460F6"\r\n\r\nOK\r\n
> > =

> > I looked into this. It comes down to:
> > =

> > ofono_sim_read -> sim_op_next -> read_file_info
> > =

> > and since sim_op_next does not check what structure type it is, it
> > always calles read_file_info (CRSM=3D192).
> > =

> > I'm not sure how to resolve this here. The problem is the callback
> > given to sim_op_next has of course a different signature than
> > read_file_transparent wants (ofono_sim_read_file_cb_t vs
> > ofono_sim_read_cb_t)
> > =

> > Should I add something like:
> > =

> > int ofono_sim_read_transparent(struct ofono_sim *sim, int id,
> >     				      	enum ofono_sim_file_structure expected_type,
> > 					ofono_sim_read_cb_t cb, void *data)
> > =

> =

> ofono_sim_read handles transparent, cyclic and record based files.  There =

> should be no need to add anything.  Just do exactly what e.g. EFli / EFpl =

> functions do.

Ah, that's good to know. I following the EFli / EFpl templates:

static void sim_initialize(struct ofono_sim *sim)
{
	ofono_sim_read(sim, SIM_EF_ICCID_FILEID,
		OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
		sim_iccid_read_cb, sim);
...

I have not moved the call to
another place as you have suggested yet.

The debug output is:

ofonod[18879]: src/modem.c:ofono_modem_create() name: (null), type: hso
ofonod[18879]: src/modem.c:set_modem_property() modem 0xc0f260 property Path
ofonod[18879]: src/modem.c:set_modem_property() modem 0xc0f260 property Reg=
istered
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Reg=
istered
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property App=
licationPort
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Con=
trolPort
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Net=
workInterface
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Path
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Reg=
istered
ofonod[18879]: src/modem.c:set_modem_property() modem 0xc0f260 property App=
licationPort
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property App=
licationPort
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Con=
trolPort
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Net=
workInterface
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Path
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Reg=
istered
ofonod[18879]: src/modem.c:set_modem_property() modem 0xc0f260 property Con=
trolPort
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property App=
licationPort
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Con=
trolPort
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Net=
workInterface
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Path
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Reg=
istered
ofonod[18879]: src/modem.c:set_modem_property() modem 0xc0f260 property Net=
workInterface
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property App=
licationPort
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Con=
trolPort
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Net=
workInterface
ofonod[18879]: src/modem.c:set_modem_property() modem 0xc0f260 property Reg=
istered
ofonod[18879]: src/modem.c:unregister_property() property 0xc0ffb0
ofonod[18879]: plugins/hso.c:hso_probe() 0xc0f260
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Path
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Reg=
istered
ofonod[18879]: plugins/hso.c:hso_enable() 0xc0f260
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property Con=
trolPort
ofonod[18879]: src/modem.c:get_modem_property() modem 0xc0f260 property App=
licationPort
ofonod[18879]: Control:> ATE0\r
ofonod[18879]: App:> ATE0\r
ofonod[18879]: App:< \r\nOK\r\n
ofonod[18879]: Control:< \r\nOK\r\n
ofonod[18879]: Control:> AT+CFUN=3D1\r
ofonod[18879]: Control:< \r\nOK\r\n
ofonod[18879]: plugins/hso.c:cfun_enable() =

ofonod[18879]: plugins/hso.c:hso_pre_sim() 0xc0f260
ofonod[18879]: src/sim.c:ofono_sim_add_state_watch() 0xc0f500
ofonod[18879]: src/sim.c:ofono_sim_add_state_watch() 0xc0f500
ofonod[18879]: Control:> AT+CGMI\r
ofonod[18879]: Control:< \r\nOption N.V.\r\n\r\nOK\r\n
ofonod[18879]: Control:> AT+CRSM=3D176,28590,0,0,1\r
ofonod[18879]: Control:< \r\r\n+CRSM: 144,0,"03"\r\n\r\nOK\r\n
ofonod[18879]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 1
ofonod[18879]: Control:> AT+CRSM=3D192,12258\r
ofonod[18879]: Control:< \r\r\n+CRSM: 111,0\r\n\r\nOK\r\n
ofonod[18879]: Control:> AT+CGMM\r
ofonod[18879]: Control:< \r\nGlobeTrotter HSUPA Modem\r\n\r\nOK\r\n
ofonod[18879]: Control:> AT+CPIN?\r
ofonod[18879]: Control:< \r\n+CPIN: SIM PIN\r\n\r\nOK\r\n
ofonod[18879]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: SIM PIN
ofonod[18879]: Control:> AT+CRSM=3D192,28421\r
ofonod[18879]: Control:< \r\r\n+CRSM: 111,0\r\n\r\nOK\r\n
ofonod[18879]: Control:> AT+CGMR\r
ofonod[18879]: Control:< \r\n2.12.0.0Hd (Date: Oct 29 2009, Time: 09:56:48)=
\r\n\r\nOK\r\n
ofonod[18879]: Control:> AT+CRSM=3D192,12037\r
ofonod[18879]: Control:< \r\r\n+CRSM: 111,0\r\n\r\nOK\r\n
ofonod[18879]: Control:> AT+CGSN\r
ofonod[18879]: Control:< \r\n351721030157214,PK29997020\r\n\r\nOK\r\n
 =

> What modem are you using? Some of them are dumb and don't implement +CRSM=
 'GET =

> RESPONSE' properly.

It's a Option iCON 451. I didn't check what "\r\r\n+CRSM:
144,0,"03"\r\n\r\nOK\r\n" exaclty means. I guess I have to check the
standard.

cheers,
daniel

--===============4932154735686754251==--


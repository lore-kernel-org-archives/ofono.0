Content-Type: multipart/mixed; boundary="===============5650617989625971269=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] zte: delay the sending of &C0 after SIM is ready.
Date: Fri, 29 Jul 2011 15:58:10 +0200
Message-ID: <1311947891-9893-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5650617989625971269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When sending &C0 after CFUN, sometimes we got error:

ofonod[8818]: plugins/zte.c:zte_enable() 0x8576190
ofonod[8818]: src/modem.c:get_modem_property() modem 0x8576190 property Mod=
em
ofonod[8818]: plugins/zte.c:open_device() Modem /dev/ttyUSB5
ofonod[8818]: src/modem.c:get_modem_property() modem 0x8576190 property Aux
ofonod[8818]: plugins/zte.c:open_device() Aux /dev/ttyUSB2
ofonod[8818]: Modem: > ATE0 +CMEE=3D1\r
ofonod[8818]: Aux: > ATE0 +CMEE=3D1\r
ofonod[8818]: Aux: < ATE0 +CMEE=3D1\r\r\nOK\r\n
ofonod[8818]: Aux: > AT+CFUN=3D1;+CFUN=3D4\r
ofonod[8818]: Modem: < \r\nOK\r\n
ofonod[8818]: Aux: < \r\nOK\r\n
ofonod[8818]: plugins/zte.c:cfun_enable() =

ofonod[8818]: Modem: > AT&C0\r
ofonod[8818]: Aux: > AT&C0\r
ofonod[8818]: Aux: < \r\nERROR\r\n
ofonod[8818]: Aux: > AT+CPIN?\r
ofonod[8818]: Modem: < \r\nERROR\r\n
ofonod[8818]: Aux: < \r\n+CME ERROR: 14\r\n
ofonod[8818]: Aux: > AT+CPIN?\r
ofonod[8818]: Aux: < \r\n+CME ERROR: 14\r\n
ofonod[8818]: Aux: > AT+CPIN?\r
ofonod[8818]: Aux: < \r\n+CME ERROR: 14\r\n

If waiting for SIM, this is OK:

ofonod[9428]: plugins/zte.c:zte_enable() 0x9fdbb48
ofonod[9428]: src/modem.c:get_modem_property() modem 0x9fdbb48 property Mod=
em
ofonod[9428]: plugins/zte.c:open_device() Modem /dev/ttyUSB5
ofonod[9428]: src/modem.c:get_modem_property() modem 0x9fdbb48 property Aux
ofonod[9428]: plugins/zte.c:open_device() Aux /dev/ttyUSB2
ofonod[9428]: Modem: > ATE0 +CMEE=3D1\r
ofonod[9428]: Aux: > ATE0 +CMEE=3D1\r
ofonod[9428]: Aux: < ATE0 +CMEE=3D1\r\r\nOK\r\n
ofonod[9428]: Aux: > AT+CFUN=3D1;+CFUN=3D4\r
ofonod[9428]: Modem: < \r\nOK\r\n
ofonod[9428]: src/modem.c:get_modem_property() modem 0x9fdbb48 property Path
ofonod[9428]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.0/u=
sb2/2-1/2-1.3/2-1.3:1.0/ttyUSB0/tty/ttyUSB0 (zte)
ofonod[9428]: plugins/udev.c:add_zte() modem 0x9fdbb48
ofonod[9428]: src/modem.c:get_modem_property() modem 0x9fdbb48 property Mod=
emRegistered
ofonod[9428]: src/modem.c:get_modem_property() modem 0x9fdbb48 property Aux=
Registered
ofonod[9428]: Aux: < \r\nOK\r\n
ofonod[9428]: plugins/zte.c:cfun_enable() =

ofonod[9428]: Aux: > AT+CPIN?\r
ofonod[9428]: Aux: < \r\n+CME ERROR: 14\r\n
ofonod[9428]: Aux: > AT+CPIN?\r
ofonod[9428]: Aux: < \r\n+CME ERROR: 14\r\n
ofonod[9428]: Aux: > AT+CPIN?\r
ofonod[9428]: Aux: < \r\n+CME ERROR: 14\r\n
ofonod[9428]: Modem: < \r\n+ZPSTM: 3,446976652D696E204E6F77;3,456E676C69736=
8204D656E75;4,48696E6469204D656E75;132,4D2D57616C6C657420286D4368656B29;\r\n
ofonod[9428]: Aux: < \r\n+ZPSTM: 3,446976652D696E204E6F77;3,456E676C6973682=
04D656E75;4,48696E6469204D656E75;132,4D2D57616C6C657420286D4368656B29;\r\n
ofonod[9428]: Aux: > AT+CPIN?\r
ofonod[9428]: Aux: < \r\n+CME ERROR: 14\r\n
ofonod[9428]: Aux: > AT+CPIN?\r
ofonod[9428]: Aux: < \r\n+CME ERROR: 14\r\n
ofonod[9428]: Aux: > AT+CPIN?\r
ofonod[9428]: Aux: < \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[9428]: examples/emulator.c:powered_watch() Adding modem 0x9fdbb48 to=
 the list
ofonod[9428]: examples/emulator.c:create_tcp() Created server_watch: 52
ofonod[9428]: examples/emulator.c:create_tcp() Created server_watch: 53
ofonod[9428]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[9428]: plugins/zte.c:zte_pre_sim() 0x9fdbb48
ofonod[9428]: Aux: > AT+GCAP\r
ofonod[9428]: Modem: > AT&C0\r
ofonod[9428]: src/sim.c:ofono_sim_add_state_watch() 0x9fdb178
ofonod[9428]: src/sim.c:ofono_sim_add_state_watch() 0x9fdb178
ofonod[9428]: src/sim.c:ofono_sim_add_state_watch() 0x9fdb178
ofonod[9428]: Aux: < \r\n+GCAP: +CGSM,+FCLASS,+DS\r\n\r\nOK\r\n
ofonod[9428]: Aux: > AT&C0\r
ofonod[9428]: Aux: < \r\nOK\r\n
ofonod[9428]: Aux: > AT+CRSM=3D192,12258,0,0,255\r
ofonod[9428]: Modem: < \r\nOK\r\n


Bertrand Aygon (1):
  zte: delay the sending of &C0 after SIM is ready.

 plugins/zte.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

-- =

1.7.4.1

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

--===============5650617989625971269==--


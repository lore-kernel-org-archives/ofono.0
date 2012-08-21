Content-Type: multipart/mixed; boundary="===============7229186301341941466=="
MIME-Version: 1.0
From: Lemoine Simon <simon.lemoine@dunasys.com>
Subject: Re: sierra wireless MC8092
Date: Tue, 21 Aug 2012 09:47:31 +0200
Message-ID: <1345535252.7489.31.camel@dunasys010>
In-Reply-To: <503239BA.1070000@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7229186301341941466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for your answer, I have used at_util_sim_state_query_new() like
in plugins/zte.c, and it works, CPIN? responds READY. =


But when I launch active-context script, I see that I get an IP address
but I lost it right after. I have try to understand the code but I don't
know why sw_gprs_deactivate_primary() is called, and why after
ofono_netreg_status_notify() is called periodically.

Here is a part of the log I obtain :

# ./create-internet-context ofnew.fr
ofonod[775]: src/gprs.c:add_context() Registering new context
Created new context /sierra_6/context5
Setting APN to ofnew.fr
# ./activate-context =

ofonod[775]: drivers/swmodem/gprs-context.c:sw_gprs_activate_primary()
cid 1
ofonod[775]: Modem: > AT+CGDCONT=3D1,"IP","ofnew.fr"\r
ofonod[775]: Modem: < \r\nOK\r\n
ofonod[775]: drivers/swmodem/gprs-context.c:at_cgdcont_cb() ok 1
ofonod[775]: Modem: > AT!SCACT=3D1,1\r
ofonod[775]: Modem: < \r\nOK\r\n
ofonod[775]: drivers/swmodem/gprs-context.c:at_scact_up_cb() ok 1
ofonod[775]: src/modem.c:get_modem_property() modem 0xf3988 property
NetworkInterface
ofonod[775]: src/gprs.c:pri_activate_callback() 0xfba38
ofonod[775]: Modem: > AT!SCPADDR=3D1\r
ofonod[775]: Modem: < \r\n!SCPADDR: 1,"10.32.202.200"\r\n\r\nOK\r\n
ofonod[775]: drivers/swmodem/gprs-context.c:sw_gprs_deactivate_primary()
cid 1
ofonod[775]: Modem: > AT!SCACT=3D0,1\r
# ofonod[775]: Modem: < \r\nOK\r\n\r\n+CGEV: ME DEACT IP, 10.32.202.200,
1\r\n
ofonod[775]: drivers/swmodem/gprs-context.c:at_scact_down_cb() ok 1
ofonod[775]: Modem: < \r\n+CREG: 1,"3808","0041F9A6",2\r\n\r\n+CGREG:
1,"3808","0041F9A6",2\r\n
ofonod[775]: src/network.c:ofono_netreg_status_notify() /sierra_6 status
1 tech 2
ofonod[775]: src/gprs.c:netreg_status_changed() 1
ofonod[775]: src/gprs.c:ofono_gprs_status_notify() /sierra_6 status 1
ofonod[775]: Modem: > AT+COPS=3D3,2\r
ofonod[775]: Modem: < \r\nOK\r\n
ofonod[775]: Modem: > AT+COPS?\r
ofonod[775]: Modem: < \r\n+COPS: 0,2,"20801",2\r\n\r\nOK\r\n
ofonod[775]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 208, mnc: 01
ofonod[775]: Modem: > AT+CIND?\r
ofonod[775]: Modem: < \r\n+CIND: 2,3,1,0,0,0,1,0\r\n\r\nOK\r\n
ofonod[775]: Modem: > AT+COPS=3D3,0\r
ofonod[775]: Modem: < \r\nOK\r\n
ofonod[775]: Modem: > AT+COPS?\r
ofonod[775]: Modem: < \r\n+COPS: 0,0,"Orange F",2\r\n\r\nOK\r\n
ofonod[775]: drivers/atmodem/network-registration.c:cops_cb() cops_cb:
Orange F, 208 01 2
ofonod[775]: src/network.c:current_operator_callback() 0xf5c70, 0xec778
ofonod[775]: Modem: < \r\n+CREG: 1,"3808","00417168",2\r\n\r\n+CGREG:
1,"3808","00417168",2\r\n
ofonod[775]: src/network.c:ofono_netreg_status_notify() /sierra_6 status
1 tech 2
ofonod[775]: src/gprs.c:netreg_status_changed() 1
ofonod[775]: src/gprs.c:ofono_gprs_status_notify() /sierra_6 status 1
ofonod[775]: Modem: > AT+COPS=3D3,2\r
ofonod[775]: Modem: < \r\nOK\r\n
ofonod[775]: Modem: > AT+COPS?\r
ofonod[775]: Modem: < \r\n+COPS: 0,2,"20801",2\r\n\r\nOK\r\n
ofonod[775]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 208, mnc: 01
ofonod[775]: Modem: > AT+CIND?\r
ofonod[775]: Modem: < \r\n+CIND: 2,3,1,0,0,0,1,0\r\n\r\nOK\r\n
ofonod[775]: Modem: > AT+COPS=3D3,0\r
ofonod[775]: Modem: < \r\nOK\r\n
ofonod[775]: Modem: > AT+COPS?\r
ofonod[775]: Modem: < \r\n+COPS: 0,0,"Orange F",2\r\n\r\nOK\r\n
ofonod[775]: drivers/atmodem/network-registration.c:cops_cb() cops_cb:
Orange F, 208 01 2
ofonod[775]: src/network.c:current_operator_callback() 0xf5c70, 0xec778
ofonod[775]: Modem: < \r\n+CREG: 1,"3808","0041F9A5",2\r\n\r\n+CGREG:
1,"3808","0041F9A5",2\r\n
ofonod[775]: src/network.c:ofono_netreg_status_notify() /sierra_6 status
1 tech 2
ofonod[775]: src/gprs.c:netreg_status_changed() 1
ofonod[775]: src/gprs.c:ofono_gprs_status_notify() /sierra_6 status 1
ofonod[775]: Modem: > AT+COPS=3D3,2\r
ofonod[775]: Modem: < \r\nOK\r\n
ofonod[775]: Modem: > AT+COPS?\r
ofonod[775]: Modem: < \r\n+COPS: 0,2,"20801",2\r\n\r\nOK\r\n
ofonod[775]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 208, mnc: 01
ofonod[775]: Modem: > AT+CIND?\r
ofonod[775]: Modem: < \r\n+CIND: 2,3,1,0,0,0,1,0\r\n\r\nOK\r\n
ofonod[775]: Modem: > AT+COPS=3D3,0\r
ofonod[775]: Modem: < \r\nOK\r\n
ofonod[775]: Modem: > AT+COPS?\r
ofonod[775]: Modem: < \r\n+COPS: 0,0,"Orange F",2\r\n\r\nOK\r\n
ofonod[775]: drivers/atmodem/network-registration.c:cops_cb() cops_cb:
Orange F, 208 01 2
ofonod[775]: src/network.c:current_operator_callback() 0xf5c70, 0xec778

Thanks for your help.
Simon

Le lundi 20 ao=C3=BBt 2012 =C3=A0 08:20 -0500, Denis Kenzior a =C3=A9crit :
> Hi Simon,
> =

> On 08/20/2012 04:15 AM, Lemoine Simon wrote:
> >> Hi,
> >>
> >> I'm trying to use a Sierra Wireless MC8092 card with Ofono on an
> >> embedded system, but Ofono fail to setup the card because there are
> >> only five interfaces ttyUSB0 to ttyUSB4.
> >>
> >> I have seen in function setup_sierra (plugins/udevng.c) that Ofono
> >> expects to have a NetworkInterface on the interface 7.
> >>
> >> Does anybody know why the MC8092 doesn't have seven interfaces? Or
> >> which of the five interfaces could be the NetworkInterface?
> >
> > It was because I haven't sierra_net driver in my kernel.
> >
> > Now ofono finds the Network interface as usb0.
> > But I have an error with PIN authentication, and some AT commands return
> > ERROR, here is a part of the log I obtain :
> >
> > ofonod[550]: plugins/udevng.c:setup_sierra() modem=3D/dev/ttyUSB3
> > app=3D/dev/ttyUSB4 net=3Dusb0 diag=3D/dev/ttyUSB1
> > ofonod[550]: src/modem.c:set_modem_property() modem 0xf6e38 property
> > Modem
> > ofonod[550]: src/modem.c:set_modem_property() modem 0xf6e38 property App
> > ofonod[550]: src/modem.c:set_modem_property() modem 0xf6e38 property
> > Diag
> > ofonod[550]: src/modem.c:set_modem_property() modem 0xf6e38 property
> > NetworkInterface
> > ofonod[550]: src/modem.c:ofono_modem_register() 0xf6e38
> > ofonod[550]: plugins/sierra.c:sierra_probe() 0xf6e38
> > ofonod[550]: src/modem.c:emit_modem_added() 0xf6e38
> > ofonod[550]: src/modem.c:call_modemwatches() 0xf6e38 added:1
> > ofonod[550]: plugins/hfp_ag.c:modem_watch() modem: 0xf6e38, added: 1
> > ofonod[550]: plugins/dun_gw.c:modem_watch() modem: 0xf6e38, added: 1
> > ofonod[550]: plugins/smart-messaging.c:modem_watch() modem: 0xf6e38,
> > added: 1
> > ofonod[550]: plugins/push-notification.c:modem_watch() modem: 0xf6e38,
> > added: 1
> > ofonod[550]: plugins/sierra.c:sierra_enable() 0xf6e38
> > ofonod[550]: src/modem.c:get_modem_property() modem 0xf6e38 property
> > Modem
> > ofonod[550]: plugins/sierra.c:open_device() Modem /dev/ttyUSB3
> > ofonod[550]: Modem:>  ATE0&C0 +CMEE=3D1\r
> > ofonod[550]: Modem:<  ATE0&C0 +CMEE=3D1\r\r\nOK\r\n
> > ofonod[550]: Modem:>  AT+CFUN=3D4\r
> > ofonod[550]: Modem:<  \r\nOK\r\n
> > ofonod[550]: plugins/sierra.c:cfun_enable()
> > ofonod[550]: src/modem.c:modem_change_state() old state: 0, new state: 1
> > ofonod[550]: plugins/sierra.c:sierra_pre_sim() 0xf6e38
> > ofonod[550]: Modem:>  AT+GCAP\r
> > ofonod[550]: src/sim.c:ofono_sim_add_state_watch() 0xf6408
> > ofonod[550]: src/sim.c:ofono_sim_add_state_watch() 0xf6408
> > ofonod[550]: src/sim.c:ofono_sim_add_state_watch() 0xf6408
> > ofonod[550]: Modem:<  \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
> > ofonod[550]: Modem:>  AT+CRSM=3D192,12258,0,0,255\r
> > ofonod[550]: Modem:<  \r\n+CME ERROR: 3\r\n
> =

> CME ERROR 3 means 'Operation not allowed'.
> =

> > ofonod[550]: Modem:>  AT+CGMI\r
> > ofonod[550]: Modem:<  \r\nSierra Wireless, Incorporated\r\n\r\nOK\r\n
> > ofonod[550]: Modem:>  AT+CRSM=3D192,28421,0,0,255\r
> > ofonod[550]: Modem:<  \r\n+CME ERROR: 3\r\n
> > ofonod[550]: Modem:>  AT+CGMM\r
> > ofonod[550]: Modem:<  \r\nMC8092\r\n\r\nOK\r\n
> > ofonod[550]: Modem:>  AT+CRSM=3D192,12037,0,0,255\r
> > ofonod[550]: Modem:<  \r\n+CME ERROR: 3\r\n
> > ofonod[550]: Modem:>  AT+CGMR\r
> > ofonod[550]: Modem:<  \r\nP1_0_0_8AP R1338 CNHKGDKCE01 2011/10/21
> > 09:21:31\r\n\r\nOK\r\n
> > ofonod[550]: Modem:>  AT+CPIN?\r
> > ofonod[550]: Modem:<  \r\n+CME ERROR: 14\r\n
> =

> And this means 'Sim Busy'
> =

> > ofonod[550]: Querying PIN authentication state failed
> > ofonod[550]: Modem:>  AT+CGSN\r
> > ofonod[550]: Modem:<  \r\n351516050021187\r\n\r\nOK\r\n
> > ofonod[550]: Modem:<  \r\n!STKC: 81\r\n
> >
> > AT+CRSM=3D192,12258,0,0,255 return an error. I have tried to send "AT
> > +CRSM=3D192,12258,0,0,255" to the modem by using minicom and it returns=
 no
> > error. Do you know why it returns an error when I'm using Ofono?
> >
> > I have add a retry loop on "AT+CPIN?" request, at the third attempt the
> > request return OK but no other commands are sent.
> >
> =

> Basically what happens is that oFono is too fast.  When you try this =

> with minicom the firmware had enough time to initialize, but it does not =

> have the same chance (time wise) with oFono.
> =

> The modem firmware is trying to initialize its own internal state and =

> throws all of these errors.  What you might need to do is to add a =

> periodic query of CPIN? until that returns something other than CME =

> ERROR: 14.  at_util_sim_state_query_new() does just that.  See =

> plugins/zte.c or plugins/speedup.c for an example of how this is done.
> =

> Regards,
> -Denis



--===============7229186301341941466==--


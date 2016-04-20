Content-Type: multipart/mixed; boundary="===============4524973070876021042=="
MIME-Version: 1.0
From: Yorn <yorn@gmx.net>
Subject: Re: Ublox Toby Modem
Date: Wed, 20 Apr 2016 19:54:12 +0200
Message-ID: <5717C244.3080302@gmx.net>
In-Reply-To: <571799C7.6040906@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4524973070876021042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

logs + comments inline

Am 20.04.2016 um 17:01 schrieb Dragos Tatulea:
> Hi Yorn,
>
> On 04/20/2016 04:24 PM, Yorn wrote:
>> Hi Dragos,
>>
>> it is still active=3D0 :(
>>
>> root(a)colibri-vf:~/test# ./list-contexts
>> [ /ublox_0 ]
>>      [ /ublox_0/context1 ]
>>          Username =3D
>>          AuthenticationMethod =3D chap
>>          Protocol =3D ip
>>          Name =3D Internet
>>          Settings =3D { }
>>          IPv6.Settings =3D { }
>>          Active =3D 0
>>          AccessPointName =3D
>>          Password =3D
>>          Type =3D internet
>>
> Can you run only oFono (no connman) with OFONO_AT_DEBUG env variable set
> and run the following scripts:
>
> enable-modem
> online-modem
> activate-context
>
> Then send the logs.
Here they are [1]

I set the context information now as follows:
root(a)colibri-vf:~/test# ./list-contexts
[ /ublox_0 ]
     [ /ublox_0/context1 ]
         Username =3D eplus
         AuthenticationMethod =3D chap
         Protocol =3D ip
         Name =3D Internet
         Settings =3D { }
         IPv6.Settings =3D { }
         Active =3D 0
         AccessPointName =3D m2m.tele2.com
         Password =3D
         Type =3D internet


I would expect AT Commands like this, however, I am not a modem AT =

command expert, so this is more or less taken from a tutorial (which set =

up my manual environment successfully)

AT+COPS?
AT+CGDCONT=3D1,"IP","m2m.tele2.com"
ATD*99***1#
AT+CGACT=3D1,1
AT+CGDATA=3D"PPP",1
CONNECT ""

But I do not really find them in the logs.

There are some modem errors return.

BR - Yorn

[1]
ofonod[6749]: plugins/ublox.c:open_device() Aux /dev/ttyACM0
ofonod[6749]: Aux: > AT\r
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: Finally woke up the modem
ofonod[6749]: Aux: > ATE0 +CMEE=3D1\r
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CFUN=3D4\r
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: plugins/ublox.c:cfun_enable() ok 1
ofonod[6749]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[6749]: plugins/ublox.c:ublox_pre_sim() 0x1cf0680
ofonod[6749]: Aux: > AT+UBMCONF=3D2\r
ofonod[6749]: src/sim.c:ofono_sim_add_state_watch() 0x1ccc810
ofonod[6749]: src/sim.c:ofono_sim_add_state_watch() 0x1ccc810
ofonod[6749]: src/sim.c:ofono_sim_add_state_watch() 0x1ccc810
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+GCAP\r
ofonod[6749]: Aux: < \r\n+GCAP: +CGSM\r\n\r\nOK\r\n
ofonod[6749]: Aux: > AT+CRSM=3D192,12258\r
ofonod[6749]: Aux: < \r\n+CRSM: =

144,0,"62178202412183022FE28A01058B032F06078002000A880110"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 25
ofonod[6749]: Aux: > AT+CGMI\r
ofonod[6749]: Aux: < \r\nu-blox\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CRSM=3D176,12258,0,0,10\r
ofonod[6749]: Aux: < \r\n+CRSM: 144,0,"98640264500110007536"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 10
ofonod[6749]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 10
ofonod[6749]: Aux: > AT+CGMM\r
ofonod[6749]: Aux: < \r\nTOBY-L210\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CRSM=3D192,28421\r
ofonod[6749]: Aux: < \r\n+CRSM: =

144,0,"62178202412183026F058A01058B036F060480020008880110"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 25
ofonod[6749]: Aux: > AT+CGMR\r
ofonod[6749]: Aux: < \r\n09.71\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CRSM=3D176,28421,0,0,8\r
ofonod[6749]: Aux: < \r\n+CRSM: 144,0,"FFFFFFFFFFFFFFFF"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 8
ofonod[6749]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 8
ofonod[6749]: Aux: > AT+CGSN\r
ofonod[6749]: Aux: < \r\n352255060097262\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CRSM=3D192,12037\r
ofonod[6749]: Aux: < \r\n+CRSM: =

144,0,"62178202412183022F058A01058B032F06068002000C880128"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 25
ofonod[6749]: Aux: > AT+CRSM=3D176,12037,0,0,12\r
ofonod[6749]: Aux: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFFFFFF"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 12
ofonod[6749]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 12
ofonod[6749]: Aux: > AT+CPIN?\r
ofonod[6749]: Aux: < \r\n+CPIN: READY\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[6749]: src/sim.c:sim_pin_query_cb() sim->pin_type: 0, pin_type: 0
ofonod[6749]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[6749]: Aux: > AT+UPINCNT\r
ofonod[6749]: Aux: < \r\n+UPINCNT: 3,3,10,10\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:upincnt_cb() retry counter id=3D1, val=
=3D3
ofonod[6749]: drivers/atmodem/sim.c:upincnt_cb() retry counter id=3D4, val=
=3D3
ofonod[6749]: drivers/atmodem/sim.c:upincnt_cb() retry counter id=3D9, val=
=3D10
ofonod[6749]: drivers/atmodem/sim.c:upincnt_cb() retry counter id=3D11, val=
=3D10
ofonod[6749]: Aux: > AT+CRSM=3D192,28590\r
ofonod[6749]: Aux: < \r\n+CRSM: 106,130\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CRSM=3D192,28589\r
ofonod[6749]: Aux: < \r\n+CRSM: =

144,0,"62178202412183026FAD8A01058B036F060B80020004880118"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 25
ofonod[6749]: Aux: > AT+CRSM=3D176,28589,0,0,4\r
ofonod[6749]: Aux: < \r\n+CRSM: 144,0,"00000102"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 4
ofonod[6749]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 4
ofonod[6749]: Aux: > AT+CRSM=3D192,28438\r
ofonod[6749]: Aux: < \r\n+CRSM: 106,130\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CRSM=3D192,28472\r
ofonod[6749]: Aux: < \r\n+CRSM: =

144,0,"62178202412183026F388A01058B036F06058002000C880120"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 25
ofonod[6749]: Aux: > AT+CRSM=3D176,28472,0,0,12\r
ofonod[6749]: Aux: < \r\n+CRSM: 144,0,"06FA1CAC213E040040011000"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 12
ofonod[6749]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 12
ofonod[6749]: Aux: > AT+CRSM=3D192,28502\r
ofonod[6749]: Aux: < \r\n+CRSM: =

144,0,"62178202412183026F568A01058B036F060A80020001880128"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 25
ofonod[6749]: Aux: > AT+CRSM=3D176,28502,0,0,1\r
ofonod[6749]: Aux: < \r\n+CRSM: 144,0,"00"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 1
ofonod[6749]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 1
ofonod[6749]: Aux: > AT+CIMI\r
ofonod[6749]: Aux: < \r\n240075810199181\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 240075810199181
ofonod[6749]: src/modem.c:modem_change_state() old state: 1, new state: 2
ofonod[6749]: plugins/ublox.c:ublox_post_sim() 0x1cf0680
ofonod[6749]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_context_probe()
ofonod[6749]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_context_probe()
ofonod[6749]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_context_probe()
ofonod[6749]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_context_probe()
ofonod[6749]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_context_probe()
ofonod[6749]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_context_probe()
ofonod[6749]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_context_probe()
ofonod[6749]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_context_probe()
ofonod[6749]: src/modem.c:get_modem_property() modem 0x1cf0680 property =

AlwaysOnline
ofonod[6749]: Aux: > AT+CGDCONT=3D?\r
ofonod[6749]: Aux: < \r\n+CGDCONT: =

(1-8),"IP",,,(0-2),(0-2),(0,1),(0,1),(0-2),(0,1)\r\n+CGDCONT: =

(1-8),"IPV6",,,(0-2),(0-2),(0,1),(0,1),(0-2),(0,1)\r\n+CGDCONT: =

(1-8),"IPV4V6",,,(0-2),(0-2),(0,1),(0,1),(0-2),(0,1)\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CRSM=3D192,28480\r
ofonod[6749]: Aux: < \r\n+CRSM: =

144,0,"62198205422100220283026F408A01058B036F0606800200448800"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 27
ofonod[6749]: Aux: > AT+CGREG=3D?\r
ofonod[6749]: Aux: < \r\n+CGREG: (0-2)\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CRSM=3D178,28480,1,4,34\r
ofonod[6749]: Aux: < \r\n+CRSM: =

144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 34
ofonod[6749]: Aux: > AT+CGREG=3D2\r
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CGAUTO=3D0\r
ofonod[6749]: Aux: < \r\n+CME ERROR: 100\r\n
ofonod[6749]: Aux: > AT+CGEREP=3D2,1\r
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: plugins/bluez5.c:bt_register_profile() Bluetooth: =

Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw) profile
ofonod[6749]: Aux: > AT+CRSM=3D178,28480,2,4,34\r
ofonod[6749]: RegisterProfile() replied an error: =

org.freedesktop.DBus.Error.UnknownMethod, Method "RegisterProfile" with =

signature "osa{sv}" on interface "org.bluez.ProfileManager1" doesn't exist
ofonod[6749]: Aux: < \r\n+CRSM: =

144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 34
ofonod[6749]: Aux: > AT+UREG=3D1\r
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CRSM=3D192,28489\r
ofonod[6749]: Aux: < \r\n+CRSM: 106,130\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CRSM=3D192,20256\r
ofonod[6749]: Aux: < \r\n+CRSM: 106,130\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: src/modem.c:get_modem_property() modem 0x1cf0680 property =

AlwaysOnline
ofonod[6749]: plugins/ublox.c:ublox_set_online() modem 0x1cf0680 online
ofonod[6749]: Aux: > AT\r
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: Finally woke up the modem
ofonod[6749]: Aux: > AT+CFUN=3D1\r
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: src/modem.c:modem_change_state() old state: 2, new state: 3
ofonod[6749]: Aux: > AT+CREG=3D?\r
ofonod[6749]: Aux: < \r\n+CREG: 2\r\n
ofonod[6749]: Aux: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
ofonod[6749]: Aux: > AT+CREG=3D2\r
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CIND=3D?\r
ofonod[6749]: Aux: < \r\n+CIND: =

("battchg",(0-5)),("signal",(0-5)),("service",(0-1)),("sounder",(0-1)),("me=
ssage",(0-1)),("call",(0-1)),("roam",(0-1)),("smsfull",(0-1)),("gprs",(0-2)=
),("callsetup",(0-3)),("callheld",(0-1)),("simind",(0-2))\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+CIND=3D0,1,0,0,0,0,0,0,0,0,0,0\r
ofonod[6749]: Aux: < \r\n+CME ERROR: 4\r\n
ofonod[6749]: Aux: > AT+CMER=3D?\r
ofonod[6749]: Aux: < \r\n+CMER: (0-1),(0),(0),(0-2),(0-1)\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/network-registration.c:build_cmer_string()
ofonod[6749]: Aux: > AT+CMER=3D1,0,0,1\r
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: src/sim.c:ofono_sim_add_spn_watch() 0x1ccc810
ofonod[6749]: src/network.c:__ofono_netreg_add_status_watch() 0x1ccb1d0
ofonod[6749]: src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 0
ofonod[6749]: Aux: > AT+CREG?\r
ofonod[6749]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39, =

toread: 17
ofonod[6749]: Aux: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
ofonod[6749]: src/network.c:ofono_netreg_status_notify() /ublox_0 status =

2 tech -1
ofonod[6749]: src/network.c:current_operator_callback() 0x1ccb1d0, (nil)
ofonod[6749]: src/gprs.c:netreg_status_changed() 2
ofonod[6749]: src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 0
ofonod[6749]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39, =

toread: 34
ofonod[6749]: Aux: > AT+CRSM=3D192,28437\r
ofonod[6749]: Aux: < \r\n+CRSM: 106,130\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: < \r\n+CREG: 5,"0000","00000000",4\r\n
ofonod[6749]: src/network.c:ofono_netreg_status_notify() /ublox_0 status =

5 tech 4
ofonod[6749]: src/gprs.c:netreg_status_changed() 5
ofonod[6749]: src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 0
ofonod[6749]: Aux: > AT+COPS=3D3,2\r
ofonod[6749]: Aux: < \r\n+CIEV: 7,1\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+COPS?\r
ofonod[6749]: Aux: < \r\n+COPS: 0,2,"26203",4\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/network-registration.c:cops_numeric_cb() =

Cops numeric got mcc: 262, mnc: 03
ofonod[6749]: Aux: > AT+CIND?\r
ofonod[6749]: Aux: < \r\n+CIND: 5,3,0,0,0,0,1,0,1,0,0,1\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: src/network.c:ofono_netreg_strength_notify() strength 60
ofonod[6749]: Aux: > AT+COPS=3D3,0\r
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: Aux: > AT+COPS?\r
ofonod[6749]: Aux: < \r\n+COPS: 0,0,"E-Plus",4\r\n
ofonod[6749]: Aux: < \r\nOK\r\n
ofonod[6749]: drivers/atmodem/network-registration.c:cops_cb() cops_cb: =

E-Plus, 262 03 4
ofonod[6749]: src/network.c:current_operator_callback() 0x1ccb1d0, (nil)
ofonod[6749]: src/gprs.c:netreg_status_changed() 5
ofonod[6749]: src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 0
ofonod[6749]: Aux: < \r\n+CIEV: 2,2\r\n
ofonod[6749]: src/network.c:ofono_netreg_strength_notify() strength 40
ofonod[6749]: Aux: < \r\n+CIEV: 2,3\r\n
ofonod[6749]: src/network.c:ofono_netreg_strength_notify() strength 60
ofonod[6749]: Aux: < \r\n+CIEV: 2,2\r\n
ofonod[6749]: src/network.c:ofono_netreg_strength_notify() strength 40
ofonod[6749]: Aux: < \r\n+CIEV: 2,3\r\n
ofonod[6749]: src/network.c:ofono_netreg_strength_notify() strength 60

>
> Thanks


--===============4524973070876021042==--


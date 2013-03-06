Content-Type: multipart/mixed; boundary="===============3300882963937425443=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Wed, 06 Mar 2013 10:23:57 +0100
Message-ID: <51370B2D.5050904@syscom-instruments.com>
In-Reply-To: <513658D4.8040508@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3300882963937425443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05. 03. 13 21:43, Denis Kenzior wrote:

>
> Nope, can't really help here; perhaps if you shared a detailed AT log?
>
> Regards,
> -Denis

Hi Denis,

Here the logs when it fails (AT + ofono full debug) :

--------------------------------------------------------------------------
plugins/g1.c:g1_enable()
src/modem.c:get_modem_property() modem 0xf4030 property Device
src/modem.c:modem_change_state() old state: 0, new state: 1
plugins/g1.c:g1_pre_sim()
 > ATE0Q0V1\r
< ATE0Q0V1\r\r\nOK\r\n
 > AT+CFUN=3D1\r
src/sim.c:ofono_sim_add_state_watch() 0xf1b50
src/sim.c:ofono_sim_add_state_watch() 0xf1b50
src/sim.c:ofono_sim_add_state_watch() 0xf1b50
< \r\nOK\r\n
plugins/g1.c:cfun_set_on_cb()
 > AT+GCAP\r
< \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
 > AT+CRC=3D1\r
< \r\nOK\r\n
 > AT+CLIP=3D1\r
< \r\nOK\r\n
 > AT+CDIP=3D1\r
< \r\nOK\r\n
 > AT+CNAP=3D1\r
< \r\nERROR\r\n
 > AT+COLP=3D1\r
< \r\nOK\r\n
 > AT+CSSN=3D1,1\r
< \r\nOK\r\n
 > AT+VTD?\r
< \r\n+VTD: 0\r\n\r\nOK\r\n
 > AT+CCWA=3D1\r
< \r\nOK\r\n
drivers/atmodem/voicecall.c:at_voicecall_initialized() voicecall_init: =

registering to notifications
src/sim.c:ofono_sim_add_state_watch() 0xf1b50
 > AT+CRSM=3D192,12258\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
 > AT+CGMI\r
< \r\nSIMCOM INCORPORATED\r\n\r\nOK\r\n
 > AT+CLCC\r
< \r\nOK\r\n
 > AT+CGMM\r
< \r\nSIMCOM_SIM5216E\r\n\r\nOK\r\n
 > AT+CRSM=3D192,28421\r
< \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
 > AT+CGMR\r
< \r\n+CGMR: SIM5216E_V1.5\r\n\r\nOK\r\n
 > AT+CGSN\r
< \r\n359769031171256\r\n\r\nOK\r\n
 > AT+CRSM=3D192,12037\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
 > AT+CPIN?\r
< \r\n+CPIN: READY\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
drivers/atmodem/sim.c:at_pin_retries_query()
 > AT+CPINR\r
< \r\nERROR\r\n
Querying remaining pin retries failed
 > AT+CRSM=3D192,28599\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
src/voicecall.c:ecc_g2_read_cb() 0
 > AT+CRSM=3D192,28599\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
src/voicecall.c:ecc_g3_read_cb() 0
 > AT+CRSM=3D192,28590\r
< \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
 > AT+CRSM=3D192,28589\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
 > AT+CRSM=3D192,28438\r
< \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
 > AT+CRSM=3D192,28472\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
 > AT+CIMI\r
< \r\n262015500220406\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 262015500220406
src/modem.c:modem_change_state() old state: 1, new state: 2
plugins/g1.c:g1_post_sim()
drivers/atmodem/gprs-context.c:at_gprs_context_probe()
src/modem.c:modem_change_state() old state: 2, new state: 3
 > AT+CSCS?\r
< \r\n+CSCS: "IRA"\r\n\r\nOK\r\n
 > AT+CUSD=3D1\r
< \r\nOK\r\n
 > AT+CREG=3D?\r
< \r\n+CREG: (0-2)\r\n\r\nOK\r\n
 > AT+CAOC=3D2\r
< \r\nOK\r\n
 > AT+CCWE=3D1\r
< \r\nERROR\r\n
 > AT+CSMS=3D?\r
< \r\n+CSMS: (0-1)\r\n\r\nOK\r\n
drivers/atmodem/sms.c:at_csms_query_cb() CSMS query parsed successfully
 > AT+CSCS=3D?\r
< \r\n+CSCS: ("IRA","GSM","UCS2")\r\n\r\nOK\r\n
 > AT+CGDCONT=3D?\r
< \r\n+CGDCONT: (1-16),"IP",,,(0-2),(0-4)\r\n+CGDCONT: =

(1-16),"PPP",,,(0-2),(0-4)\r\n+CGDCONT: =

(1-16),"IPV6",,,(0-2),(0-4)\r\n\r\nOK\r\n
 > AT+CREG=3D2\r
< \r\nOK\r\n
 > AT+CSMS=3D1\r
< \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
 > AT+CPBS=3D?\r
< \r\n+CPBS: ("SM","DC","FD","LD","MC","ME","RC","EN","ON")\r\n\r\nOK\r\n
 > AT+CGREG=3D?\r
< \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
 > AT+CIND=3D?\r
< \r\n+CIND: =

("battchg",(0-5)),("signal",(0-5)),("service",(0-1)),("call",(0-1)),("roam"=
,(0-1)),("smsfull",(0-1)),("GPRS =

coverage",(0-1)),("callsetup",(0-3))\r\n\r\nOK\r\n
src/sim.c:ofono_sim_add_spn_watch() 0xf1b50
 > AT+CSMS?\r
< \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
 > AT+CGREG=3D2\r
< \r\nOK\r\n
 > AT+CGAUTO=3D0\r
< \r\nOK\r\n
 > AT+CGEREP=3D2,1\r
< \r\nOK\r\n
src/sim.c:ofono_sim_add_spn_watch() 0xf1b50
 > AT+CMER=3D3,0,0,1\r
< \r\nOK\r\n
 > AT+CREG?\r
< \r\n+CREG: 2,1, 889D, 13EB0D\r\n\r\nOK\r\n
src/network.c:ofono_netreg_status_notify() /g1_0 status 1 tech -1
 > AT+CMGF=3D?\r
< \r\n+CMGF: (0-1)\r\n\r\nOK\r\n
 > AT+CPSB=3D1\r
< \r\nERROR\r\n
 > AT+COPS=3D3,2\r
< \r\nOK\r\n
 > AT+COPS?\r
< \r\n+COPS: 0,2,"26201",2\r\n\r\nOK\r\n
drivers/atmodem/network-registration.c:cops_numeric_cb() Cops numeric =

got mcc: 262, mnc: 01
 > AT+CIND?\r
< \r\n+CIND: 4,3,1,0,0,0,1,0\r\n\r\nOK\r\n
src/network.c:ofono_netreg_strength_notify() strength 60
 > AT+CIND?\r
< \r\n+CIND: 4,3,1,0,0,0,1,0\r\n\r\nOK\r\n
 > AT+CPMS=3D?\r
< \r\n+CPMS: =

("ME","MT","SM","SR"),("ME","MT","SM","SR"),("ME","SM")\r\n\r\nOK\r\n
 > AT+CRSM=3D192,28480\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
 > AT+COPS=3D3,0\r
< \r\nOK\r\n
 > AT+COPS?\r
< \r\n+COPS: 0,0,"T-Mobile D",2\r\n\r\nOK\r\n
drivers/atmodem/network-registration.c:cops_cb() cops_cb: T-Mobile D, =

262 01 2
src/network.c:current_operator_callback() 0xff868, (nil)
 > AT+CMGF=3D0\r
< \r\nOK\r\n
 > AT+CPMS=3D"ME","ME","ME"\r
< \r\n+CPMS: 0,255,0,255,0,255\r\n\r\nOK\r\n
 > AT+CNMI=3D?\r
< \r\n+CNMI: (0,1,2),(0,1,2,3),(0,2),(0,1,2),(0,1)\r\n\r\nOK\r\n
drivers/atmodem/sms.c:build_cnmi_string()
drivers/atmodem/sms.c:construct_ack_pdu()
 > AT+CNMI=3D1,2,2,1,0\r
< \r\nOK\r\n
src/network.c:__ofono_netreg_add_status_watch() 0xff868
src/sms.c:sms_restore_tx_queue()
plugins/push-notification.c:sms_watch() registered
plugins/smart-messaging.c:sms_watch() registered
 > AT+CMGL=3D4\r
< \r\nOK\r\n
drivers/atmodem/sms.c:at_cmgl_done()
 > AT+CGSMS=3D3\r
< \r\nOK\r\n
 > AT+CRSM=3D192,28489\r
< \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
 > AT+CRSM=3D192,20256\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
 > AT+CRSM=3D192,28618\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
Unable to read waiting messages numbers from SIM
 > AT+CRSM=3D192,28617\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
Unable to read mailbox identifies from SIM
 > AT+CRSM=3D192,28433\r
< \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
src/message-waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on SIM
 > AT+CRSM=3D192,28613\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
 > AT+CRSM=3D192,28486\r
< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 0
 > AT+CRSM=3D192,28437\r
< \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
 > AT+CRSM=3D192,28435\r
< \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
 > AT+CRSM=3D192,28436\r
< \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
Provisioning failed
src/sim.c:ofono_sim_remove_spn_watch() 0xf1b50
src/gprs.c:add_context() Registering new context
src/network.c:__ofono_netreg_add_status_watch() 0xff868
 > AT+CGATT=3D1\r
< \r\nOK\r\n
src/gprs.c:gprs_attach_callback() /g1_0 error =3D 0
 > AT+CGREG?\r
< \r\n+CGREG: 2,1, 889D, 13EB0D\r\n\r\nOK\r\n
src/gprs.c:registration_status_cb() /g1_0 error 0 status 1
src/gprs.c:ofono_gprs_status_notify() /g1_0 status 1
src/sms.c:tx_queue_entry_new() pdu_len: 27, tpdu_len: 26
src/sms.c:tx_next() tx_next: 0xfe1a0
 > AT+CMGS=3D26\r
< \r\n>
 > 0011000B911487584414F70000A70DCDF7FBFD7EBFDFEFF71B1402<CtrlZ>
< \r\n
< \r\n+CMS ERROR: Unknown error\r\n
src/sms.c:tx_finished() tx_finished 0xfe1a0
src/sms.c:sms_tx_queue_remove_entry() 0xfe1a0
--------------------------------------------------------------------------

I tried to find some information about the operator and SMS/GPRS. I =

didn't find documentation in my fluent language. I will ask to a german =

guy. Maybe, there are a AT command to know wether operator supports this ?

Otherwise, I try to find documentation about this amazing SMS over GPRS =

feature. From what I read, there an AT command to select the behavior. I =

guess it's the AT+CGSMS command. Ofono set CGSMS to 3 :

AT+CGSMS=3D3

 From the modem documentation, I see :

A numeric parameter which indicates the service or service preference to =

be used
0 =E2=80=93 GPRS(value is not really supported and is internally mapped to =
2)
1 =E2=80=93 circuit switched(value is not really supported and is internall=
y =

mapped to 3)
2 =E2=80=93 GPRS preferred (use circuit switched if GPRS not available)
3 =E2=80=93 circuit switched preferred (use GPRS if circuit switched not av=
ailable)

Maybe the "circuit switched" has got some troubles on the operator =

network and as I disabled GPRS, the SMS sending failed most of the time ?

There also the command AT+CSMS :

+CSMS: 1,1,1

The first 1 tells the "SMS@command is compatible with GSM phase 2+.". =

Perhaps, the thing has an impact about the issue ...

Regards,
avd.

--===============3300882963937425443==--


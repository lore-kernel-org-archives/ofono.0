Content-Type: multipart/mixed; boundary="===============3659642630122403130=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH] telit: notify sim inserted when sim ready
Date: Fri, 27 Jul 2012 12:54:41 +0200
Message-ID: <50127371.7000905@hale.at>
In-Reply-To: <CAC+thW2CJEf1QEaewfh60Uv44JtR3aKp-1W_O-M1KnaitTNwUQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3659642630122403130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 27/07/12 11:58, Andrea Galbusera wrote:
> Hi Christopher,
>
> On Fri, Jul 27, 2012 at 11:37 AM, Christopher Vogl
> <christopher.vogl@hale.at> wrote:
>> On 26/07/12 17:19, Andrea Galbusera wrote:
>>> I did some preliminary test with your patch. See the logs below:
>>>
>>> -------- with patch applied --------
>>>
>>> ofonod[30959]: plugins/telit.c:telit_enable() 0x9e281c8
>>> ofonod[30959]: src/modem.c:get_modem_property() modem 0x9e281c8 property
>>> Modem
>>> ofonod[30959]: plugins/telit.c:open_device() Modem /dev/ttyUSB0
>>> ofonod[30959]: Modem: > ATE0 +CMEE=3D1\r
>>> ofonod[30959]: Modem: < ATE0 +CMEE=3D1\r
>>> ofonod[30959]: Modem: < \r\nOK\r\n
>>> ofonod[30959]: Modem: > AT+CFUN=3D4\r
>>> ofonod[30959]: Modem: < \r\nOK\r\n
>>> ofonod[30959]: plugins/telit.c:cfun_enable_cb() 0x9e281c8
>>> ofonod[30959]: examples/emulator.c:powered_watch() Adding modem
>>> 0x9e281c8 to the list
>>> ofonod[30959]: examples/emulator.c:create_tcp() Created server_watch: 38
>>> ofonod[30959]: examples/emulator.c:create_tcp() Created server_watch: 39
>>> ofonod[30959]: src/modem.c:modem_change_state() old state: 0, new state=
: 1
>>> ofonod[30959]: plugins/telit.c:telit_pre_sim() 0x9e281c8
>>> ofonod[30959]: Modem: > AT+GCAP\r
>>> ofonod[30959]: src/sim.c:ofono_sim_add_state_watch() 0x9e2a0d8
>>> ofonod[30959]: src/sim.c:ofono_sim_add_state_watch() 0x9e2a0d8
>>> ofonod[30959]: src/sim.c:ofono_sim_add_state_watch() 0x9e2a0d8
>>> ofonod[30959]: Modem: < \r\n+GCAP: +CGSM,+DS,+FCLASS,+MS,+ES\r\n\r\nOK\=
r\n
>>> ofonod[30959]: Modem: > AT+CRC=3D1\r
>>> ofonod[30959]: Modem: < \r\nOK\r\n
>>> ofonod[30959]: Modem: > AT+CLIP=3D1\r
>>> ofonod[30959]: Modem: < \r\nOK\r\n
>>> ofonod[30959]: Modem: > AT+CDIP=3D1\r
>>> ofonod[30959]: Modem: < \r\nERROR\r\n
>>> ofonod[30959]: Modem: > AT+CNAP=3D1\r
>>> ofonod[30959]: Modem: < \r\nERROR\r\n
>>> ofonod[30959]: Modem: > AT+COLP=3D1\r
>>> ofonod[30959]: Modem: < \r\n+CME ERROR: 10\r\n
>>> ofonod[30959]: Modem: > AT+CSSN=3D1,1\r
>>> ofonod[30959]: Modem: < \r\n+CME ERROR: 10\r\n
>>> ofonod[30959]: Modem: > AT+VTD?\r
>>> ofonod[30959]: Modem: < \r\n+CME ERROR: 10\r\n
>>> ofonod[30959]: Modem: > AT+CCWA=3D1\r
>>> ofonod[30959]: Modem: < \r\n+CME ERROR: 10\r\n
>>> ofonod[30959]: drivers/atmodem/voicecall.c:at_voicecall_initialized()
>>> voicecall_init: registering to notifications
>>> ofonod[30959]: src/sim.c:ofono_sim_add_state_watch() 0x9e2a0d8
>>> ofonod[30959]: Modem: > AT#QSS=3D2\r
>>> ofonod[30959]: Modem: < \r\nOK\r\n
>>> ofonod[30959]: Modem: > AT#QSS?\r
>>> ofonod[30959]: Modem: < \r\n#QSS: 2,1\r\n\r\nOK\r\n
>>> ofonod[30959]: plugins/telit.c:telit_qss_cb() 0x9e281c8
>>> ofonod[30959]: plugins/telit.c:switch_sim_state_status() 0x9e281c8
>>> ofonod[30959]: plugins/telit.c:switch_sim_state_status() SIM inserted
>>> ofonod[30959]: Modem: > AT+CGMI\r
>>> ofonod[30959]: Modem: < \r\nTelit\r\n\r\nOK\r\n
>>> ofonod[30959]: Modem: > AT+CLCC\r
>>> ofonod[30959]: Modem: < \r\n+CME ERROR: 10\r\n
>>> ofonod[30959]: Modem: > AT+CGMM\r
>>> ofonod[30959]: Modem: < \r\nUC864-E\r\n\r\nOK\r\n
>>> ofonod[30959]: Modem: > AT+CGMR\r
>>> ofonod[30959]: Modem: < \r\n08.01.005\r\n\r\nOK\r\n
>>> ofonod[30959]: Modem: > AT+CGSN\r
>>> ofonod[30959]: Modem: < \r\n352636020412669\r\n\r\nOK\r\n
>>>
>>> No sim readyness notification comes unless the modem is brought
>>> online. Is this expected?
>> In telit_enable() AT+CFUN=3D4 is issued. This disables TX and RX - cause=
s the
>> modem to do a network deregistration (if registered) - and does a SIM
>> deactivation according to the Telit AT reference manual.
>> So I suppose that  the SIM readyness notificytion is not emitted until
>> AT+CFUN=3D1 is set in telit_set_online().
>> I don't know if this is the expected behaviour, some plugins set AT+CFUN=
=3D1
>> in the enable function.
>>
>>
>>> Issuing ./online-modem brings the process further with:
>>>
>>> ofonod[31135]: plugins/telit.c:telit_set_online() modem 0x99a81c8 online
>>> ofonod[31135]: Modem: > AT+CFUN=3D1\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: src/modem.c:common_online_cb() Online in PRE SIM state
>>> ofonod[31135]: Modem: < \r\n#QSS: 2\r\n
>>> ofonod[31135]: plugins/telit.c:telit_qss_notify() 0x99a81c8
>>> ofonod[31135]: plugins/telit.c:switch_sim_state_status() 0x99a81c8
>>> ofonod[31135]: plugins/telit.c:switch_sim_state_status() SIM inserted
>>> and PIN unlocked
>>> ofonod[31135]: Modem: < \r\n#QSS: 3\r\n
>>> ofonod[31135]: plugins/telit.c:telit_qss_notify() 0x99a81c8
>>> ofonod[31135]: plugins/telit.c:switch_sim_state_status() 0x99a81c8
>>> ofonod[31135]: plugins/telit.c:switch_sim_state_status() SIM inserted a=
nd
>>> ready
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28599\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 21\r\n
>>> ofonod[31135]: src/voicecall.c:ecc_g2_read_cb() 0
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28599\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 21\r\n
>>> ofonod[31135]: src/voicecall.c:ecc_g3_read_cb() 0
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,12258\r
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>> 144,0,0000000A2FE204000FF04401020000\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
>>> 00, 15
>>> ofonod[31135]: Modem: > AT+CRSM=3D176,12258,0,0,10\r
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>> 144,0,989301070051275811F8\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
>>> 00, 10
>>> ofonod[31135]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
>>> dataoff: 0, tocopy: 10
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28421\r
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>> 144,0,000000056F05040001F04401020000\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
>>> 00, 15
>>> ofonod[31135]: Modem: > AT+CRSM=3D176,28421,0,0,5\r
>>> ofonod[31135]: Modem: < \r\n+CRSM: 144,0,0201000306\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
>>> 00, 5
>>> ofonod[31135]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
>>> dataoff: 0, tocopy: 5
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,12037\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 21\r\n
>>> ofonod[31135]: Modem: > AT+CPIN?\r
>>> ofonod[31135]: Modem: < \r\n+CPIN: READY\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
>>> ofonod[31135]: drivers/atmodem/sim.c:at_pin_retries_query()
>>> ofonod[31135]: Modem: > AT+CPINR\r
>>> ofonod[31135]: Modem: < \r\nERROR\r\n
>>> ofonod[31135]: Querying remaining pin retries failed
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28590\r
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>> 144,0,000000016FAE040004F04401020000\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
>>> 00, 15
>>> ofonod[31135]: Modem: > AT+CRSM=3D176,28590,0,0,1\r
>>> ofonod[31135]: Modem: < \r\n+CRSM: 144,0,03\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
>>> 00, 1
>>> ofonod[31135]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
>>> dataoff: 0, tocopy: 1
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28589\r
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>> 144,0,000000036FAD040004F04401020000\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
>>> 00, 15
>>> ofonod[31135]: Modem: > AT+CRSM=3D176,28589,0,0,3\r
>>> ofonod[31135]: Modem: < \r\n+CRSM: 144,0,00FFFF\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
>>> 00, 3
>>> ofonod[31135]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
>>> dataoff: 0, tocopy: 3
>>> ofonod[31135]: EFad should contain at least four bytes
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28438\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 21\r\n
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28472\r
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>> 144,0,0000000C6F38040014F04401020000\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
>>> 00, 15
>>> ofonod[31135]: Modem: > AT+CRSM=3D176,28472,0,0,12\r
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>> 144,0,FF3CFF0F0F003C03000C0000\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
>>> 00, 12
>>> ofonod[31135]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
>>> dataoff: 0, tocopy: 12
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28474\r
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>> 144,0,00001C526F3A040011F0220502011D\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
>>> 00, 15
>>> ofonod[31135]: Modem: > AT+CIMI\r
>>> ofonod[31135]: Modem: < \r\n222109001113943\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 222109001113=
943
>>> ofonod[31135]: src/modem.c:modem_change_state() old state: 1, new state=
: 2
>>> ofonod[31135]: plugins/telit.c:telit_post_sim() 0x99a81c8
>>> ofonod[31135]: Example History Probe for modem: 0x99a81c8
>>> ofonod[31135]: Example Network Time Probe for modem: 0x99a81c8
>>> ofonod[31135]: src/modem.c:modem_change_state() old state: 2, new state=
: 3
>>> ofonod[31135]: plugins/telit.c:telit_post_online() 0x99a81c8
>>> ofonod[31135]: drivers/atmodem/gprs-context.c:at_gprs_context_probe()
>>> ofonod[31135]: Modem: > AT+CSMS=3D?\r
>>> ofonod[31135]: Registered handle for channel 13: 0x10006
>>> ofonod[31135]: Modem: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sms.c:at_csms_query_cb() CSMS query
>>> parsed successfully
>>> ofonod[31135]: Modem: > AT+CREG=3D?\r
>>> ofonod[31135]: Modem: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CSCS?\r
>>> ofonod[31135]: Modem: < \r\n+CSCS: "IRA"\r\n\r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CUSD=3D1\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CAOC=3D2\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CCWE=3D1\r
>>> ofonod[31135]: Modem: < \r\nERROR\r\n
>>> ofonod[31135]: Modem: > AT+CGDCONT=3D?\r
>>> ofonod[31135]: Modem: < \r\n+CGDCONT:
>>> (1-16),"IP",,,(0-2),(0-4)\r\n+CGDCONT:
>>> (1-16),"PPP",,,(0-2),(0-4)\r\n+CGDCONT:
>>> (1-16),"IPV6",,,(0-2),(0-4)\r\n\r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28480\r
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>> 144,0,000000576F40040011F0440502011D\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
>>> 00, 15
>>> ofonod[31135]: Modem: > AT+CSMS=3D1\r
>>> ofonod[31135]: Modem: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CREG=3D2\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CGREG=3D?\r
>>> ofonod[31135]: Modem: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CRSM=3D178,28480,1,4,29\r
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>>
>>> 144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\=
nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
>>> 00, 29
>>> ofonod[31135]: Modem: > AT+CSMS?\r
>>> ofonod[31135]: Modem: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CIND=3D?\r
>>> ofonod[31135]: Modem: < \r\n+CIND:
>>>
>>> (("battchg",(0-5,99)),("signal",(0-7,99)),("service",(0,1)),("sounder",=
(0,1)),("message",(0,1)),("call",(0,1)),("roam",(0,1)),("smsfull",(0,1)),("=
rssi",(0-5,99)))\r\n\r\nOK\r\n
>>> ofonod[31135]: src/sim.c:ofono_sim_add_spn_watch() 0x99aa0d8
>>> ofonod[31135]: Modem: > AT+CGREG=3D2\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CGAUTO=3D0\r
>>> ofonod[31135]: Modem: < \r\nERROR\r\n
>>> ofonod[31135]: Modem: > AT+CGEREP=3D2,1\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: src/network.c:__ofono_netreg_add_status_watch() 0x99a6748
>>> ofonod[31135]: Modem: > AT+CRSM=3D178,28480,2,4,29\r
>>> ofonod[31135]: Registered handle for channel 1: 0x10007
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>>
>>> 144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\=
nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
>>> 00, 29
>>> ofonod[31135]: Modem: > AT+CMGF=3D?\r
>>> ofonod[31135]: Modem: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CMER=3D3,0,0,1\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 4\r\n
>>> ofonod[31135]: Modem: > AT+CREG?\r
>>> ofonod[31135]: Modem: < \r\n+CREG: 2,1,"3AF2","04DE9AE"\r\n\r\nOK\r\n
>>> ofonod[31135]: src/network.c:ofono_netreg_status_notify() /telit_0
>>> status 1 tech -1
>>> ofonod[31135]: src/gprs.c:netreg_status_changed() 1
>>> ofonod[31135]: Modem: > AT+CPSB=3D1\r
>>> ofonod[31135]: Modem: < \r\nERROR\r\n
>>> ofonod[31135]: Modem: > AT+CRSM=3D178,28480,3,4,29\r
>>> ofonod[31135]: Modem: < \r\n+CRSM:
>>>
>>> 144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\=
nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
>>> 00, 29
>>> ofonod[31135]: Modem: > AT+CPMS=3D?\r
>>> ofonod[31135]: Modem: < \r\n+CPMS:
>>> ("ME","SM","SR"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+COPS=3D3,2\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+COPS?\r
>>> ofonod[31135]: Modem: < \r\n+COPS: 0,2,"22210",2\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/network-registration.c:cops_numeric_cb()
>>> Cops numeric got mcc: 222, mnc: 10
>>> ofonod[31135]: Modem: > AT+CIND?\r
>>> ofonod[31135]: Modem: < \r\n+CIND: 5,0,1,0,0,0,0,0,3\r\n\r\nOK\r\n
>>> ofonod[31135]: src/network.c:ofono_netreg_strength_notify() strength 60
>>> ofonod[31135]: Modem: > AT+CGATT=3D1\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: src/gprs.c:gprs_attach_callback() /telit_0 error =3D 0
>>> ofonod[31135]: Modem: > AT+CIND?\r
>>> ofonod[31135]: Modem: < \r\n+CIND: 5,0,1,0,0,0,0,0,3\r\n\r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,20256\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 21\r\n
>>> ofonod[31135]: Modem: > AT+CMGF=3D0\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+COPS=3D3,0\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+COPS?\r
>>> ofonod[31135]: Modem: < \r\n+COPS: 0,0,"vodafone IT",2\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/network-registration.c:cops_cb()
>>> cops_cb: vodafone IT, 222 10 2
>>> ofonod[31135]: src/network.c:current_operator_callback() 0x99a6748, (ni=
l)
>>> ofonod[31135]: src/gprs.c:netreg_status_changed() 1
>>> ofonod[31135]: Modem: > AT+CGREG?\r
>>> ofonod[31135]: Modem: < \r\n+CGREG: 2,1,"3AF2","04DE9AE"\r\n\r\nOK\r\n
>>> ofonod[31135]: src/gprs.c:registration_status_cb() /telit_0 error 0 sta=
tus
>>> 1
>>> ofonod[31135]: src/gprs.c:ofono_gprs_status_notify() /telit_0 status 1
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28618\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 22\r\n
>>> ofonod[31135]: Unable to read waiting messages numbers from SIM
>>> ofonod[31135]: Modem: > AT+CPMS=3D"ME","ME","ME"\r
>>> ofonod[31135]: Modem: < \r\n+CPMS: 0,50,0,50,0,50\r\n\r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28617\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 22\r\n
>>> ofonod[31135]: Unable to read mailbox identifies from SIM
>>> ofonod[31135]: Modem: > AT+CNMI=3D?\r
>>> ofonod[31135]: Modem: < \r\n+CNMI:
>>> (0-3),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sms.c:build_cnmi_string()
>>> ofonod[31135]: drivers/atmodem/sms.c:construct_ack_pdu()
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28433\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 21\r\n
>>> ofonod[31135]: src/message-waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS
>>> on SIM
>>> ofonod[31135]: Modem: > AT+CNMI=3D2,2,2,1,0\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: src/network.c:__ofono_netreg_add_status_watch() 0x99a6748
>>> ofonod[31135]: src/sms.c:sms_restore_tx_queue()
>>> ofonod[31135]: plugins/push-notification.c:sms_watch() registered
>>> ofonod[31135]: plugins/smart-messaging.c:sms_watch() registered
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28435\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 21\r\n
>>> ofonod[31135]: Modem: > AT+CMGL=3D4\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: drivers/atmodem/sms.c:at_cmgl_done()
>>> ofonod[31135]: Modem: > AT+CGSMS=3D3\r
>>> ofonod[31135]: Modem: < \r\nOK\r\n
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28613\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 22\r\n
>>> ofonod[31135]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff:
>>> 39, toread: 17
>>> ofonod[31135]: EFspn read successfully, but couldn't parse
>>> ofonod[31135]: Modem: > AT+CRSM=3D192,28437\r
>>> ofonod[31135]: Modem: < \r\n+CME ERROR: 21\r\n
>>>
>>> A problem I see is that the test is not passing at second and
>>> subsequent tries if I do restart ofono. At second run, I don't see the
>>> whole thing evolving and bringing up modem services/interfaces the
>>> same way. To me it looks like, without power cycling the modem, I
>>> cannot stop and restart ofono and obtain the same behaviour.
>>> Sounds like, at cycles +CFUN=3D4 --> +CFUN=3D1 subsequent to the first,
>>> those #QSS=3D2 and #QSS=3D3 notifications are not coming from the modem:
>>> switch_sim_state_status() is not called and no sim readyness
>>> notification is making the thing evolve.
>>
>>  From your debug output below:
>>
>> ...
>>
>> ofonod[31145]: Modem: > AT#QSS?\r
>> ofonod[31145]: Modem: < \r\n#QSS: 2,3\r\n\r\nOK\r\n
>> ofonod[31145]: plugins/telit.c:telit_qss_cb() 0x912a1c8
>> ofonod[31145]: plugins/telit.c:switch_sim_state_status() 0x912a1c8
>> ofonod[31145]: plugins/telit.c:switch_sim_state_status() SIM inserted and
>> ready
>> ...
>>
>> In cfun_enable_cb() the current SIM state is queried and the modem answe=
res
>> with #QSS: 2,3
>> which means that SIM state notifications are enabled (2) and the SIM is
>> inserted and ready (3).
>>
>> Strangely, the modem answers with '+CME ERROR: 10' (meaning no SIM inser=
ted)
>> on a following AT+CPIN?
>>
>>
>> ofonod[31145]: Modem: > AT+CPIN?\r
>> ofonod[31145]: Modem: < \r\n+CME ERROR: 10\r\n
> Is this really strange? According to your comment above, in my
> understanding, querying +CPIN? before issuing +CFUN=3D1 is expected to
> fail (SIM deactivated).
> It is what I always see with this simple sequence from terminal (after
> modem reset):
It is strange for me that AT#QSS? returns #QSS: 2,3 after a AT+CFUN=3D4 =

and before AT+CFUN=3D1
If AT+CFUN=3D4 deactivates the SIM (whatever that should mean exactly) =

then why does the modem say that the SIM is ready to use?

>
> at+cpin?
> +CPIN: READY
>
> OK
> at+cfun=3D4
> OK
> at+cpin?
> ERROR
> at+cpin?
> ERROR
> at+cfun=3D1
> OK
> at+cpin?
> +CPIN: READY
>
> OK
That is what I would expect according to the AT reference manual.
>
> The point here seems more related with #QSS not coming out after +CFUN=3D=
1...
> Are you using MDM or AUX serial port? If you use the upstream telit
> driver I suppose MDM is used. I'm seeing something strange while
> testing sms sending too: looks like the modem is spitting out some
> notifications from the AUX port and some others from MDM... I'm
> looking into it right now.
In this case we are not using the upstream ofono. We use both ports, one =

for the AT chat and one for the data (ppp) like more and more other =

plugins now do.
We also have some hardware related patches to switch between two SIM =

slots which most likely cannot be committed. I am currently preparing =

some patches but I have to extract them first from our code.

>
> BTW, what firmware revision is your UC864-G running?
Ofono says: Revision =3D 08.01.107

We had some problems with our early development board which never =

emitted #QSS: 3,
that's why we didn't use the code from the patch in the first place.


--
Scanned by MailScanner.


--===============3659642630122403130==--


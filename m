Content-Type: multipart/mixed; boundary="===============6773627106883855656=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: calypso does not power up from 0.17
Date: Wed, 14 Apr 2010 13:45:44 +0200
Message-ID: <w2s359c5481004140445w927cd1b6vd6467dc3e1fe60ab@mail.gmail.com>
In-Reply-To: <201004140543.06250.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6773627106883855656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2010 at 12:43 PM, Denis Kenzior <denkenz@gmail.com> wrote:
[...]
> I have a hunch that the GAtMux code might need some love. =C2=A0Can you t=
ry the
> following patch?
>
[...]

It works :)

Just need a couple of days to verify how the version bump affects our
freerunners.

Thanks!

    Niko

log following:

ofonod[856]: plugins/calypso.c:write_file()
/sys/bus/platform/devices/neo1973-pm-gsm.0/power_on, 0
ofonod[856]: plugins/calypso.c:write_file()
/sys/bus/platform/devices/neo1973-pm-gsm.0/reset, 0
ofonod[856]: plugins/calypso.c:write_file()
/sys/bus/platform/devices/neo1973-pm-gsm.0/power_on, 1
ofonod[856]: plugins/calypso.c:write_file()
/sys/bus/platform/devices/neo1973-pm-gsm.0/reset, 1
ofonod[856]: plugins/calypso.c:write_file()
/sys/bus/platform/devices/neo1973-pm-gsm.0/reset, 0
ofonod[856]: plugins/calypso.c:modem_initialize()
ofonod[856]: src/modem.c:get_modem_property() modem 0x86928 property Device
ofonod[856]: Setup: > AT\r
ofonod[856]: Setup: < AT-Command Interpreter ready\r\n
ofonod[856]: Setup: Wakeup got no response
ofonod[856]: Setup: > AT\r
ofonod[856]: Setup: < AT\r\r\nOK\r\n
ofonod[856]: Setup: Finally woke up the modem
ofonod[856]: Setup: > ATE0\r
ofonod[856]: Setup: < ATE0\r
ofonod[856]: Setup: < \r\nOK\r\n
ofonod[856]: Setup: > AT+CMUX=3D?\r
ofonod[856]: Setup: < \r\n+CMUX: (1),(0),(1-5),(10-100),(1-255),(0-100),(2-=
255),
ofonod[856]: Setup: < (1-255),(1-7)\r\n\r\nOK\r\n
ofonod[856]: Setup: > AT+CMUX=3D1,0,5,64\r
ofonod[856]: Setup: < \r\nOK\r\n
ofonod[856]: plugins/calypso.c:mux_setup() 0x87e80
ofonod[856]: DLC3: > AT\r
denis patch
ofonod[856]: DLC0: < AT-Command Interpreter ready\r\n
denis patch
denis patch
ofonod[856]: DLC1: < AT-Command Interpreter ready\r\n
denis patch
denis patch
ofonod[856]: DLC2: < AT-Command Interpreter ready\r\n
denis patch
denis patch
ofonod[856]: DLC3: < AT-Command Interpreter ready\r\n
denis patch
ofonod[856]: DLC3: Wakeup got no response
ofonod[856]: DLC3: > AT\r
denis patch
ofonod[856]: DLC3: < AT\r
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: Finally woke up the modem
ofonod[856]: DLC3: > AT+CFUN=3D1\r
denis patch
ofonod[856]: DLC3: < AT+CFUN=3D1\r
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: plugins/calypso.c:cfun_set_on_cb()
ofonod[856]: plugins/calypso.c:calypso_pre_sim()
ofonod[856]: DLC0: > AT\r
ofonod[856]: DLC1: > AT\r
ofonod[856]: DLC2: > AT\r
ofonod[856]: DLC3: > AT\r
ofonod[856]: src/sim.c:ofono_sim_add_ready_watch() 0x86f20
ofonod[856]: src/sim.c:ofono_sim_add_ready_watch() 0x86f20
denis patch
ofonod[856]: DLC0: < \r\nOK\r\n
denis patch
ofonod[856]: DLC0: Finally woke up the modem
ofonod[856]: DLC0: > ATE0\r
denis patch
ofonod[856]: DLC1: < AT\r\r\nOK\r\n
denis patch
ofonod[856]: DLC1: Finally woke up the modem
denis patch
ofonod[856]: DLC2: < AT\r\r\nOK\r\n
denis patch
ofonod[856]: DLC2: Finally woke up the modem
denis patch
ofonod[856]: DLC3: < AT\r\r\nOK\r\n
denis patch
ofonod[856]: DLC3: Finally woke up the modem
denis patch
ofonod[856]: DLC0: < \r\nOK\r\n
denis patch
ofonod[856]: DLC0: > AT%CUNS=3D0\r
ofonod[856]: DLC1: > ATE0\r
ofonod[856]: DLC2: > ATE0\r
ofonod[856]: DLC3: > ATE0\r
denis patch
ofonod[856]: DLC0: < \r\nOK\r\n
denis patch
ofonod[856]: DLC0: > AT%CPI=3D3\r
denis patch
ofonod[856]: DLC1: < ATE0\r
denis patch
denis patch
ofonod[856]: DLC2: < ATE0\r
denis patch
denis patch
ofonod[856]: DLC3: < ATE0\r
denis patch
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
ofonod[856]: DLC1: > AT%CUNS=3D0\r
denis patch
ofonod[856]: DLC0: < \r\nOK\r\n
denis patch
ofonod[856]: drivers/calypsomodem/voicecall.c:calypso_voicecall_initialized=
()
voicecall_init: registering to notifications
denis patch
ofonod[856]: DLC2: < \r\nOK\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC2: > AT%CUNS=3D0\r
ofonod[856]: DLC3: > AT%CUNS=3D0\r
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
denis patch
ofonod[856]: DLC2: < \r\nOK\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT%CSTAT=3D1\r
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT(a)ST=3D"-26"\r
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT%SLEEP=3D2\r
denis patch
ofonod[856]: DLC3: < \r\nEXT: I\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CGMI\r
denis patch
ofonod[856]: DLC3: < \r\n+CGMI: FIC/OpenMoko\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CRSM=3D176,28590,0,0,1\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM: 144,0,03\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 1
ofonod[856]: DLC3: > AT+CRSM=3D192,28599\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM:
148,4,00000E187F20020000000000099300190C00838A838A\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: src/voicecall.c:ecc_g2_read_cb() 0
ofonod[856]: DLC3: > AT+CGMM\r
denis patch
ofonod[856]: DLC3: < \r\n+CGMM: "Neo1973 GTA01/GTA02 Embedded GSM
Modem"\r\n\r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CPIN?\r
denis patch
ofonod[856]: DLC3: < \r\n+CPIN: READY\r\n\r\nOK\r\n
denis patch
ofonod[856]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[856]: DLC3: > AT+CRSM=3D192,28599\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM:
148,4,00000E187F20020000000000099300190C00838A838A\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: src/voicecall.c:ecc_g3_read_cb() 0
ofonod[856]: DLC3: > AT+CGMR\r
denis patch
ofonod[856]: DLC3: < \r\n+CGMR: "GSM:
gsm_ac_gp_fd_pu_em_cph_ds_vc_cal35_ri_36_amd8_ts0
denis patch
denis patch
ofonod[856]: DLC3: < -Moko11"\r\n\r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CIMI\r
denis patch
ofonod[856]: DLC3: < \r\n222108201031578\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 222108201031578
ofonod[856]: DLC3: > AT+CRSM=3D192,28421\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM: 111,0\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CGSN\r
denis patch
ofonod[856]: DLC3: < \r\n+CGSN: 354651011629286\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CRSM=3D192,12037\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM:
148,4,00000E183F00010000000000099302160C00838A838A\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CRSM=3D192,28438\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM:
148,4,00000E187F20020000000000099300190C00838A838A\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: plugins/calypso.c:calypso_post_sim()
ofonod[856]: drivers/atmodem/call-volume.c:at_call_volume_probe() 0x876d8
ofonod[856]: DLC1: > AT+CREG=3D?\r
ofonod[856]: DLC3: > AT+CUSD=3D1\r
denis patch
ofonod[856]: DLC1: < \r\n+CREG: (0-2)\r\n
denis patch
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC1: > AT+CREG=3D2\r
ofonod[856]: DLC3: > AT+CAOC=3D2\r
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC1: > AT%CSQ=3D1\r
ofonod[856]: DLC3: > AT+CCWE=3D1\r
denis patch
ofonod[856]: DLC1: < \r\n%CSQ: 1 \r\n
denis patch
ofonod[856]: drivers/atmodem/network-registration.c:report_signal_strength()
csq_notify: 1
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC1: > AT+CREG?\r
ofonod[856]: DLC3: > AT+CSSN=3D1,1\r
denis patch
ofonod[856]: DLC1: < \r\n+CREG: 2,0\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: src/ssn.c:__ofono_ssn_mo_watch_add() 0x87658, 6
ofonod[856]: src/ssn.c:__ofono_ssn_mo_watch_add() 0x87658, 5
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
ofonod[856]: src/network.c:current_operator_callback() 0x87270, (nil)
ofonod[856]: DLC1: > AT+COPS=3D0\r
ofonod[856]: DLC3: > AT+CMUT?\r
denis patch
ofonod[856]: DLC1: < \r\n+CREG: 2\r\n
denis patch
ofonod[856]: src/network.c:current_operator_callback() 0x87270, (nil)
denis patch
ofonod[856]: DLC3: < \r\n+CMUT: 0\r\n\r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CLVL=3D?\r
denis patch
ofonod[856]: DLC3: < \r\n+CLVL: (0-255)\r\n\r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CLVL?\r
denis patch
ofonod[856]: DLC3: < \r\n+CLVL: 175\r\n\r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CRSM=3D192,28480\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM: 111,0\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CRSM=3D192,28589\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM: 111,0\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CRSM=3D192,28489\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM: 111,0\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CRSM=3D192,28618\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM:
148,4,00000E187F20020000000000099300190C00838A838A\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: Unable to read waiting messages numbers from SIM
ofonod[856]: DLC3: > AT+CRSM=3D192,28617\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM:
148,4,00000E187F20020000000000099300190C00838A838A\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: Unable to read mailbox identifies from SIM
ofonod[856]: DLC3: > AT+CRSM=3D192,28433\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM:
148,4,00000E187F20020000000000099300190C00838A838A\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: src/message-waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on S=
IM
ofonod[856]: DLC3: > AT+CRSM=3D192,28613\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM:
148,4,00000E187F20020000000000099300190C00838A838A\r\n
denis patch
denis patch
ofonod[856]: DLC3: < \r\nOK\r\n
denis patch
ofonod[856]: DLC3: > AT+CRSM=3D192,28486\r
denis patch
ofonod[856]: DLC3: < \r\n+CRSM: 111,0\r\n\r\nOK\r\n
denis patch
denis patch
ofonod[856]: DLC1: < \r\n+CREG: 1,"9C50","596D"\r\n
denis patch
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n\r\n%CSQ:  8, 99, 0\r\n
denis patch
ofonod[856]: drivers/atmodem/network-registration.c:report_signal_strength()
csq_notify: 8
ofonod[856]: DLC1: > AT\r
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
ofonod[856]: DLC1: Finally woke up the modem
ofonod[856]: DLC1: > AT+COPS=3D3,2\r
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
ofonod[856]: DLC1: > AT+COPS?\r
denis patch
ofonod[856]: DLC1: < \r\n+COPS: 0,2,"22210"\r\n
denis patch
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
ofonod[856]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 222, mnc: 10
ofonod[856]: DLC1: > AT+COPS=3D3,0\r
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
ofonod[856]: DLC1: > AT+COPS?\r
denis patch
ofonod[856]: DLC1: < \r\n+COPS: 0,0,"vodafone IT"\r\n\r\nOK\r\n
denis patch
ofonod[856]: drivers/atmodem/network-registration.c:cops_cb() cops_cb:
vodafone IT, 222 10 0
ofonod[856]: src/network.c:current_operator_callback() 0x87270, (nil)
ofonod[856]: DLC1: > AT+CREG?\r
denis patch
ofonod[856]: DLC1: < \r\n+CREG: 2,1,"9C50","596D"\r\n
denis patch
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
ofonod[856]: DLC1: > AT+COPS=3D3,2\r
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
ofonod[856]: DLC1: > AT+COPS?\r
denis patch
ofonod[856]: DLC1: < \r\n+COPS: 0,2,"22210"\r\n
denis patch
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
ofonod[856]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 222, mnc: 10
ofonod[856]: DLC1: > AT+COPS=3D3,0\r
denis patch
ofonod[856]: DLC1: < \r\nOK\r\n
denis patch
ofonod[856]: DLC1: > AT+COPS?\r
denis patch
ofonod[856]: DLC1: < \r\n+COPS: 0,0,"vodafone IT"\r\n\r\nOK\r\n
denis patch
ofonod[856]: drivers/atmodem/network-registration.c:cops_cb() cops_cb:
vodafone IT, 222 10 0
ofonod[856]: src/network.c:current_operator_callback() 0x87270, 0x87780
denis patch
ofonod[856]: DLC3: < %CSTAT: EONS, 0\r\n
denis patch
ofonod[856]: plugins/calypso.c:cstat_notify() phonebook: 0, sms: 0
ofonod[856]: plugins/calypso.c:cstat_notify() stat: EONS, enabled: 0
denis patch
ofonod[856]: DLC3: < %CSTAT: PHB, 0\r\n
denis patch
ofonod[856]: plugins/calypso.c:cstat_notify() phonebook: 0, sms: 0
ofonod[856]: plugins/calypso.c:cstat_notify() stat: PHB, enabled: 0
denis patch
ofonod[856]: DLC3: < %CSTAT: SMS, 1\r\n
denis patch
ofonod[856]: plugins/calypso.c:cstat_notify() phonebook: 0, sms: 0
ofonod[856]: plugins/calypso.c:cstat_notify() stat: SMS, enabled: 1
ofonod[856]: DLC2: > AT\r
denis patch
ofonod[856]: DLC2: < \r\nOK\r\n
denis patch
ofonod[856]: DLC2: Finally woke up the modem
ofonod[856]: DLC2: > AT+CSMS=3D?\r
denis patch
ofonod[856]: DLC2: < \r\n+CSMS: (0,1)\r\n
denis patch
denis patch
ofonod[856]: DLC2: < \r\nOK\r\n
denis patch
ofonod[856]: drivers/atmodem/sms.c:at_csms_query_cb() CSMS query
parsed successfully
ofonod[856]: DLC2: > AT+CSMS=3D1\r
denis patch
ofonod[856]: DLC2: < \r\n+CSMS: 1,1,1\r\n
denis patch
denis patch
ofonod[856]: DLC2: < \r\nOK\r\n
denis patch
ofonod[856]: DLC2: > AT+CSMS?\r
denis patch
ofonod[856]: DLC2: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
denis patch
ofonod[856]: DLC2: > AT+CMGF=3D?\r
denis patch
ofonod[856]: DLC2: < \r\n+CMGF: (0,1)\r\n
denis patch
denis patch
ofonod[856]: DLC2: < \r\nOK\r\n
denis patch
ofonod[856]: DLC2: > AT+CPMS=3D?\r
denis patch
ofonod[856]: DLC2: < \r\n+CPMS: ("ME","SM"),("ME","SM"),("ME","SM")\r\n
denis patch
denis patch
ofonod[856]: DLC2: < \r\nOK\r\n
denis patch
ofonod[856]: DLC2: > AT+CMGF=3D0\r
denis patch
ofonod[856]: DLC2: < \r\nOK\r\n
denis patch
ofonod[856]: DLC2: > AT+CPMS=3D"ME","ME","ME"\r
denis patch
ofonod[856]: DLC2: < \r\n+CPMS: 0,0,0,0,0,0\r\n\r\nOK\r\n
denis patch
ofonod[856]: DLC2: > AT+CNMI=3D?\r
denis patch
ofonod[856]: DLC2: < \r\n+CNMI: (0-2),(0-3),(0,2),(0,1),(0,1)\r\n\r\nOK\r\n
denis patch
ofonod[856]: DLC2: > AT+CNMI=3D2,2,2,1,0\r
denis patch
ofonod[856]: DLC2: < \r\nOK\r\n
denis patch
ofonod[856]: DLC2: > AT+CMGL=3D4\r
denis patch
ofonod[856]: DLC2: < \r\nERROR\r\n
denis patch
ofonod[856]: drivers/atmodem/sms.c:at_cmgl_cb() Initial listing SMS
storage failed!

--===============6773627106883855656==--


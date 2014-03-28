Content-Type: multipart/mixed; boundary="===============7995922143970377560=="
MIME-Version: 1.0
From: Eric BOUXIROT <eric.bouxirot@azimut-monitoring.com>
Subject: Re: problem sim status
Date: Fri, 28 Mar 2014 18:27:08 +0100
Message-ID: <lh4bcu$p02$1@ger.gmane.org>
In-Reply-To: <53348A7A.3040805@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7995922143970377560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior a =C3=A9crit :
> Hi Eric,
>
>> ok, i will add this, but if i understand well, this is for +CPIN request
>> AFTER sending a PIN. (but i mean my modem need this too.)
>> =

>> my problem is when modem is added throught dbus/ofono, ofono send somes
>> init commands and finaly i mean sim-manager send an +CPIN request to
>> know if SIM is locked or not... THIS request fail with CME error 14
>> because of too fast query.
>> =

>
> Ah, its one of those modems that doesn't have a sim ready notification.
>  In that case you probably need to run CPIN queries as part of the modem
> power-up procedure.  See examples in plugins/zte.c and plugins/speedup.c
> (cfun_enable & sim_state_cb)
>
> Regards,
> -Denis

hi Denis,

is it normal that pre_sim function is called before ofono get modem =

manufacturer and model ?

ofonod[406]: plugins/sierra.c:open_device() Modem /dev/ttyUSB2
ofonod[406]: Modem: > ATE0 &C0\r
ofonod[406]: Modem: < ATE0 &C0\r
ofonod[406]: Modem: < \r\nOK\r\n
ofonod[406]: Modem: > AT+CMEE=3D1\r
ofonod[406]: Modem: < \r\n+CREG: 2\r\n
ofonod[406]: Modem: < \r\n+CIEV: 2,1\r\n
ofonod[406]: Modem: < \r\n+CIEV: 4,1\r\n
ofonod[406]: Modem: < \r\nOK\r\n
ofonod[406]: Modem: > AT+CFUN=3D4\r
ofonod[406]: Modem: < \r\nOK\r\n
ofonod[406]: plugins/sierra.c:cfun_enable()
ofonod[406]: src/modem.c:get_modem_property() modem 0x12d290 property =

Model
ofonod[406]: src/modem.c:modem_change_state() old state: 0, new state: =

1
ofonod[406]: plugins/sierra.c:sierra_pre_sim() 0x12d290
ofonod[406]: src/modem.c:get_modem_property() modem 0x12d290 property =

Model
ofonod[406]: plugins/sierra.c:sierra_pre_sim()
ofonod[406]: Modem: > AT+GCAP\r
ofonod[406]: src/sim.c:ofono_sim_add_state_watch() 0x12e628
ofonod[406]: src/sim.c:ofono_sim_add_state_watch() 0x12e628
ofonod[406]: src/sim.c:ofono_sim_add_state_watch() 0x12e628
ofonod[406]: Modem: < \r\nERROR\r\n
ofonod[406]: Modem: > AT+CRSM=3D192,12258,0,0,255\r
ofonod[406]: Modem: < \r\n+CME ERROR: 3\r\n
ofonod[406]: Modem: > AT+CGMI\r
ofonod[406]: Modem: < \r\nSierra Wireless, Incorporated\r\n\r\nOK\r\n
ofonod[406]: Modem: > AT+CGMM\r
ofonod[406]: Modem: < \r\nSL8083\r\n\r\nOK\r\n
ofonod[406]: Modem: > AT+CGMR\r
ofonod[406]: Modem: < \r\nS4_0_0_7AP R1384 CNSZXD00000155 2012/09/29 =

10:26:17\r\n\r\nOK\r\n
ofonod[406]: Modem: > AT+CGSN\r
ofonod[406]: Modem: < \r\n355131041136262\r\n\r\nOK\r\n
ofonod[406]: Modem: > AT+CRSM=3D192,28421,0,0,255\r
ofonod[406]: Modem: < \r\n+CIEV: 2,0\r\n\r\n+CIEV: 4,0\r\n\r\n+CREG: =

0\r\n\r\n+CME ERROR: 3\r\n
ofonod[406]: Modem: > AT+CRSM=3D192,12037,0,0,255\r
ofonod[406]: Modem: < \r\n+CME ERROR: 3\r\n
ofonod[406]: Modem: > AT+CPIN?\r
ofonod[406]: Modem: < \r\n+CME ERROR: 14\r\n
ofonod[406]: Querying PIN authentication state failed


i would like to get model in presim to make a better patch using modem =

model with a new enum in vendor list (like simcom)
how i can make pre_sim to wait for theses information available ?


--===============7995922143970377560==--


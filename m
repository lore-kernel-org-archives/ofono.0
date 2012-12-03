Content-Type: multipart/mixed; boundary="===============0501623865866173790=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: Telit HE910 modem --- unable be put on line by Connman
Date: Mon, 03 Dec 2012 10:55:23 +0100
Message-ID: <50BC770B.7040001@hale.at>
In-Reply-To: <50B8D36B.1070305@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0501623865866173790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mingli,

On 30/11/12 16:40, Ming Li Wu wrote:
> Hello,
>
> I am working on Telit HE910 modem.
>
> I am using ofono 1.11, and the commit is
> 6e3a6156b34c52bde253b097976d0ba9dd575879.
>
> For the Telit modem, "AT+CFUN=3D4" is used to enable
> the modem. According to "Telit He910 AT Commands
> Reference Guide", "issuing AT+CFUN=3D4[,0] actually
> causes the module to perform either a network
> deregistration and a SIM deactivation."
>
> After this command is sent out, an unsolicited indication
> "\r\n#QSS: 0\r\n" is received by of ofono. This means that
> the sim card cannot be detected by the modem. It turns out
> that Connman will not put the modem on line.
>
> if "AT+CFUN=3D5" was used, it worked fine.
>
> My questions are:
> 1. Why is "AT+CFUN=3D4" used to enable the modem, instead of "AT+CFUN=3D1=
" =

> or "AT+CFUN=3D5"?
> 2. If "AT+CFUN=3D4" is reasonable, are there any solutions to solve this =

> problem?
>
> Thanks!
>
> Mingli
>
>
> The following is the log  when "AT+CFUN=3D4" was used.
> ofonod[358]: plugins/udevng.c:setup_telit() modem=3D/dev/ttyACM0 =

> aux=3D/dev/ttyACM3 gps=3D(null) diag=3D/dev/ttyACM1
> ofonod[358]: src/modem.c:set_modem_property() modem 0x1152008 property =

> Modem
> ofonod[358]: src/modem.c:set_modem_property() modem 0x1152008 property =

> Aux
> ofonod[358]: src/modem.c:set_modem_property() modem 0x1152008 property =

> Diag
> ofonod[358]: src/modem.c:ofono_modem_register() 0x1152008
> ofonod[358]: plugins/telit.c:telit_probe() 0x1152008
> ofonod[358]: src/modem.c:emit_modem_added() 0x1152008
> ofonod[358]: src/modem.c:call_modemwatches() 0x1152008 added:1
> ofonod[358]: plugins/hfp_ag.c:modem_watch() modem: 0x1152008, added: 1
> ofonod[358]: plugins/dun_gw.c:modem_watch() modem: 0x1152008, added: 1
> ofonod[358]: plugins/smart-messaging.c:modem_watch() modem: 0x1152008, =

> added: 1
> ofonod[358]: plugins/push-notification.c:modem_watch() modem: =

> 0x1152008, added: 1
> ofonod[358]: plugins/telit.c:telit_enable() 0x1152008
> ofonod[358]: src/modem.c:get_modem_property() modem 0x1152008 property =

> Modem
> ofonod[358]: plugins/telit.c:open_device() Modem /dev/ttyACM0
> ofonod[358]: src/modem.c:get_modem_property() modem 0x1152008 property =

> Aux
> ofonod[358]: plugins/telit.c:open_device() Aux /dev/ttyACM3
> ofonod[358]: Aux: > ATE0 +CMEE=3D1\r
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: Aux: > AT#QSS=3D0\r
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: Aux: > AT+CFUN=3D4\r
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: plugins/telit.c:cfun_enable_cb() 0x1152008
> ofonod[358]: src/modem.c:modem_change_state() old state: 0, new state: 1
> ofonod[358]: plugins/telit.c:telit_pre_sim() 0x1152008
> ofonod[358]: Aux: > AT&C0\r
> ofonod[358]: src/sim.c:ofono_sim_add_state_watch() 0x1153d30
> ofonod[358]: src/sim.c:ofono_sim_add_state_watch() 0x1153d30
> ofonod[358]: src/sim.c:ofono_sim_add_state_watch() 0x1153d30
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: Aux: > AT+GCAP\r
> ofonod[358]: Aux: < \r\n+GCAP: +CGSM,+DS,+FCLASS,+MS,+ES\r\n\r\nOK\r\n
> ofonod[358]: Aux: > AT+CRC=3D1\r
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: Aux: > AT+CLIP=3D1\r
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: Aux: > AT+CDIP=3D1\r
> ofonod[358]: Aux: < \r\nERROR\r\n
> ofonod[358]: Aux: > AT+CNAP=3D1\r
> ofonod[358]: Aux: < \r\nERROR\r\n
> ofonod[358]: Aux: > AT+COLP=3D1\r
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: Aux: > AT+CSSN=3D1,1\r
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: Aux: > AT+VTD?\r
> ofonod[358]: Aux: < \r\n0\r\n\r\nOK\r\n
> ofonod[358]: Aux: > AT+CCWA=3D1\r
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: drivers/atmodem/voicecall.c:at_voicecall_initialized() =

> voicecall_init: registering to notifications
> ofonod[358]: src/sim.c:ofono_sim_add_state_watch() 0x1153d30
> ofonod[358]: Aux: > AT#AUTOATT=3D0\r
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: Aux: > AT#QSS=3D2\r
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: Aux: > AT+CGMI\r
> ofonod[358]: Aux: < \r\nTelit\r\n\r\nOK\r\n
> ofonod[358]: Aux: > AT+CLCC\r
> ofonod[358]: Aux: < \r\nOK\r\n
> ofonod[358]: Aux: > AT+CGMM\r
> ofonod[358]: Aux: < \r\nHE910\r\n\r\nOK\r\n
> ofonod[358]: Aux: > AT+CGMR\r
> ofonod[358]: Aux: < \r\n12.00.003\r\n\r\nOK\r\n
> ofonod[358]: Aux: > AT+CGSN\r
> ofonod[358]: Aux: < \r\n357164040533674\r\n\r\nOK\r\n
> ofonod[358]: Aux: < \r\n#QSS: 0\r\n
> ofonod[358]: plugins/telit.c:telit_qss_notify() 0x1152008
> ofonod[358]: plugins/telit.c:switch_sim_state_status() 0x1152008, SIM =

> status: 0
>
>

AT+CFUN=3D1 is used to set the modem online, i.e. enable RX, TX it also =

enables the SIM. AT+CFUN =3D 4 is used to set the modem in flight mode.
I cannot see that the modem is set online in your debug output, i.e. a =

D-Bus call to org.ofono.Modem.SetProperty('Online', true) is made.
Without this call you will never get an URC of #QSS with a value greater =

than 0. SIM detection is enabled after AT+CFUN=3D1.
I never worked with ConnMan so I don't know what causes ConnMan to set =

the modem online.

Try to issue
dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono =

/telit_0 org.ofono.Modem.SetProperty string:'Online' variant:boolean:'true'
and see what happens (you may need to change /telit_0 to what
dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono / =

org.ofono.Manager.GetModems
returns)


If this works for you, you will run into the next problem.
In /drivers/atmodem/sim.c, at_qss_notify()
case 2:    /* PIN unlocked */
has to be changed to
case 3:    /* SIM INSERTED and READY */

otherwise AT+CMER=3D ... for example will return +CME ERROR: 14  (SIM BUSY).

After a PIN has been entered, we have to wait until the modem reports =

that the SIM is ready.
The above change solves the problem when a PIN is required but we have =

to do something similar when no PIN is required, otherwise we will run =

into the same problem.




--
Scanned by MailScanner.


--===============0501623865866173790==--


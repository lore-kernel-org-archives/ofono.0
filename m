Content-Type: multipart/mixed; boundary="===============0988456611309171021=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Telit HE910 modem --- unable be put on line by Connman
Date: Mon, 03 Dec 2012 12:40:38 +0100
Message-ID: <50BC8FB6.7020309@southpole.se>
In-Reply-To: <50BC770B.7040001@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0988456611309171021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/03/2012 10:55 AM, Christopher Vogl wrote:
> Hi Mingli,
>
> On 30/11/12 16:40, Ming Li Wu wrote:
>> Hello,
>>
>> I am working on Telit HE910 modem.
>>
>> I am using ofono 1.11, and the commit is
>> 6e3a6156b34c52bde253b097976d0ba9dd575879.
>>
>> For the Telit modem, "AT+CFUN=3D4" is used to enable
>> the modem. According to "Telit He910 AT Commands
>> Reference Guide", "issuing AT+CFUN=3D4[,0] actually
>> causes the module to perform either a network
>> deregistration and a SIM deactivation."
>>
>> After this command is sent out, an unsolicited indication
>> "\r\n#QSS: 0\r\n" is received by of ofono. This means that
>> the sim card cannot be detected by the modem. It turns out
>> that Connman will not put the modem on line.
>>
>> if "AT+CFUN=3D5" was used, it worked fine.
>>
>> My questions are:
>> 1. Why is "AT+CFUN=3D4" used to enable the modem, instead of "AT+CFUN=3D=
1"
>> or "AT+CFUN=3D5"?
>> 2. If "AT+CFUN=3D4" is reasonable, are there any solutions to solve this
>> problem?
>>
>> Thanks!
>>
>> Mingli
>>
>>
>> The following is the log  when "AT+CFUN=3D4" was used.
>> ofonod[358]: plugins/udevng.c:setup_telit() modem=3D/dev/ttyACM0
>> aux=3D/dev/ttyACM3 gps=3D(null) diag=3D/dev/ttyACM1
>> ofonod[358]: src/modem.c:set_modem_property() modem 0x1152008 property
>> Modem
>> ofonod[358]: src/modem.c:set_modem_property() modem 0x1152008 property
>> Aux
>> ofonod[358]: src/modem.c:set_modem_property() modem 0x1152008 property
>> Diag
>> ofonod[358]: src/modem.c:ofono_modem_register() 0x1152008
>> ofonod[358]: plugins/telit.c:telit_probe() 0x1152008
>> ofonod[358]: src/modem.c:emit_modem_added() 0x1152008
>> ofonod[358]: src/modem.c:call_modemwatches() 0x1152008 added:1
>> ofonod[358]: plugins/hfp_ag.c:modem_watch() modem: 0x1152008, added: 1
>> ofonod[358]: plugins/dun_gw.c:modem_watch() modem: 0x1152008, added: 1
>> ofonod[358]: plugins/smart-messaging.c:modem_watch() modem: 0x1152008,
>> added: 1
>> ofonod[358]: plugins/push-notification.c:modem_watch() modem:
>> 0x1152008, added: 1
>> ofonod[358]: plugins/telit.c:telit_enable() 0x1152008
>> ofonod[358]: src/modem.c:get_modem_property() modem 0x1152008 property
>> Modem
>> ofonod[358]: plugins/telit.c:open_device() Modem /dev/ttyACM0
>> ofonod[358]: src/modem.c:get_modem_property() modem 0x1152008 property
>> Aux
>> ofonod[358]: plugins/telit.c:open_device() Aux /dev/ttyACM3
>> ofonod[358]: Aux: > ATE0 +CMEE=3D1\r
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: Aux: > AT#QSS=3D0\r
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: Aux: > AT+CFUN=3D4\r
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: plugins/telit.c:cfun_enable_cb() 0x1152008
>> ofonod[358]: src/modem.c:modem_change_state() old state: 0, new state: 1
>> ofonod[358]: plugins/telit.c:telit_pre_sim() 0x1152008
>> ofonod[358]: Aux: > AT&C0\r
>> ofonod[358]: src/sim.c:ofono_sim_add_state_watch() 0x1153d30
>> ofonod[358]: src/sim.c:ofono_sim_add_state_watch() 0x1153d30
>> ofonod[358]: src/sim.c:ofono_sim_add_state_watch() 0x1153d30
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: Aux: > AT+GCAP\r
>> ofonod[358]: Aux: < \r\n+GCAP: +CGSM,+DS,+FCLASS,+MS,+ES\r\n\r\nOK\r\n
>> ofonod[358]: Aux: > AT+CRC=3D1\r
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: Aux: > AT+CLIP=3D1\r
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: Aux: > AT+CDIP=3D1\r
>> ofonod[358]: Aux: < \r\nERROR\r\n
>> ofonod[358]: Aux: > AT+CNAP=3D1\r
>> ofonod[358]: Aux: < \r\nERROR\r\n
>> ofonod[358]: Aux: > AT+COLP=3D1\r
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: Aux: > AT+CSSN=3D1,1\r
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: Aux: > AT+VTD?\r
>> ofonod[358]: Aux: < \r\n0\r\n\r\nOK\r\n
>> ofonod[358]: Aux: > AT+CCWA=3D1\r
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: drivers/atmodem/voicecall.c:at_voicecall_initialized()
>> voicecall_init: registering to notifications
>> ofonod[358]: src/sim.c:ofono_sim_add_state_watch() 0x1153d30
>> ofonod[358]: Aux: > AT#AUTOATT=3D0\r
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: Aux: > AT#QSS=3D2\r
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: Aux: > AT+CGMI\r
>> ofonod[358]: Aux: < \r\nTelit\r\n\r\nOK\r\n
>> ofonod[358]: Aux: > AT+CLCC\r
>> ofonod[358]: Aux: < \r\nOK\r\n
>> ofonod[358]: Aux: > AT+CGMM\r
>> ofonod[358]: Aux: < \r\nHE910\r\n\r\nOK\r\n
>> ofonod[358]: Aux: > AT+CGMR\r
>> ofonod[358]: Aux: < \r\n12.00.003\r\n\r\nOK\r\n
>> ofonod[358]: Aux: > AT+CGSN\r
>> ofonod[358]: Aux: < \r\n357164040533674\r\n\r\nOK\r\n
>> ofonod[358]: Aux: < \r\n#QSS: 0\r\n
>> ofonod[358]: plugins/telit.c:telit_qss_notify() 0x1152008
>> ofonod[358]: plugins/telit.c:switch_sim_state_status() 0x1152008, SIM
>> status: 0
>>
>>
>
> AT+CFUN=3D1 is used to set the modem online, i.e. enable RX, TX it also
> enables the SIM. AT+CFUN =3D 4 is used to set the modem in flight mode.
> I cannot see that the modem is set online in your debug output, i.e. a
> D-Bus call to org.ofono.Modem.SetProperty('Online', true) is made.
> Without this call you will never get an URC of #QSS with a value greater
> than 0. SIM detection is enabled after AT+CFUN=3D1.
> I never worked with ConnMan so I don't know what causes ConnMan to set
> the modem online.

ConnMan can enable the modem, but needs the GPRS interface exported from =

Ofono in order to be able to do so, something which happens in post_sim =

for the Telit modem.  So this is a catch 22...

The online-modem command works fine for this modem, the dilemma is to =

get ConnMan to do issue it for us.

So I guess, in summary, the problem is that post_sim will not be called =

until _after_ telit_online, whereas we really would need it to somehow =

be called in conjunction with telit_enable so that telit_online can be =

invoked by ConnMan... hope that makes sense.

Any suggestions?

The Telit HE910 manual says:

Note: the command reports the SIM status change after the <mode> has =

been set to
2. We suggest to set <mode>=3D2 and save the value in the user profile, then
power off the module. The proper SIM status will be available at the next
power on.

So, my thinking is that we need to do something like this:

i)   At telit_enable, set CFUN=3D1 and wait for QSS=3D2 or QSS=3D3.
ii)  When we get QSS=3D2 or QSS=3D3 then we can set SIM_READY state so that =

post_sim gets called... this should be called after all the IMSI =

querying, etc. (right?)
iii) Once we're in SIM_READY state, we set CFUN=3D4... this is the 'end' =

of the 'telit_enable' phase
iv)  While in CFUN=3D4 state, we ignore QSS: 0
V)   This should result in the GPRS interface being exported so that =

connman can call 'online' call which will result in the switch to the =

"real" CFUN=3D1

What do you think?  Reasonable?  Will it work?

Best regards,
Jonas Bonn
South Pole Consulting

--===============0988456611309171021==--


Content-Type: multipart/mixed; boundary="===============4672562007109710469=="
MIME-Version: 1.0
From: Debayan Banerjee <debayanin@gmail.com>
Subject: Re: Huawei EC1260 not working
Date: Fri, 01 Oct 2010 16:55:31 +0530
Message-ID: <AANLkTikFxqQYcd0LK5++e3gqLPG6zxsoqrdqo_r8A0cT@mail.gmail.com>
In-Reply-To: <1285930662.4231.11.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4672562007109710469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 1 October 2010 16:27, Marcel Holtmann <marcel@holtmann.org> wrote:

>
> start oFono like this "env OFONO_AT_DEBUG=3D1 ./src/ofonod -n -d" and post
> the logging messages here.

[root(a)ws244 ~]# OFONO_AT_DEBUG=3D1 ofonod -n -d '*'
ofonod[1379]: oFono version 0.20
ofonod[1379]: src/plugin.c:__ofono_plugin_init()
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd3c8, name: ste
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd394, name: palmpre
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd2f8, name: hfp
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd2ac, name: novatel
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd278, name: em770
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd244, name: huawei
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd210, name: hso
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd1d4, name: mbm
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd1a0, name: calypso
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd16c, name: g1
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd138, name: atgen
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dd104, name: phonesim
ofonod[1379]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80dd060, name: stemodem
ofonod[1379]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80dd0a4, name: stemodem
ofonod[1379]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80dd014, name: hso
ofonod[1379]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80dcfd8, name: mbm
ofonod[1379]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80dcf00, name: hfpmodem
ofonod[1379]: src/network.c:ofono_netreg_driver_register() driver:
0x80dcf60, name: hfpmodem
ofonod[1379]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x80dcf98, name: hfpmodem
ofonod[1379]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80dcea0, name: calypsomodem
ofonod[1379]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80dcd40, name: atmodem
ofonod[1379]: src/modem.c:ofono_devinfo_driver_register() driver:
0x80dcde8, name: atmodem
ofonod[1379]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x80dcd94, name: atmodem
ofonod[1379]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x80dcbc0, name: atmodem
ofonod[1379]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x80dcc00, name: atmodem
ofonod[1379]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x80dcb00, name: atmodem
ofonod[1379]: src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x80dcdb4, name: atmodem
ofonod[1379]: src/ssn.c:ofono_ssn_driver_register() driver: 0x80dcddc,
name: atmodem
ofonod[1379]: src/ussd.c:ofono_ussd_driver_register() driver:
0x80dcd10, name: atmodem
ofonod[1379]: src/sms.c:ofono_sms_driver_register() driver: 0x80dcb48,
name: atmodem
ofonod[1379]: src/sim.c:ofono_sim_driver_register() driver: 0x80dccc0,
name: atmodem
ofonod[1379]: src/network.c:ofono_netreg_driver_register() driver:
0x80dcc60, name: atmodem
ofonod[1379]: src/cbs.c:ofono_cbs_driver_register() driver: 0x80dcb98,
name: atmodem
ofonod[1379]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x80dce04, name: atmodem
ofonod[1379]: src/gprs.c:ofono_gprs_driver_register() driver:
0x80dce2c, name: atmodem
ofonod[1379]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x80dce50, name: atmodem
ofonod[1379]: src/modem.c:ofono_devinfo_driver_register() driver:
0x80dc75c, name: isimodem
ofonod[1379]: src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x80dc74c, name: isimodem
ofonod[1379]: src/network.c:ofono_netreg_driver_register() driver:
0x80dc780, name: isimodem
ofonod[1379]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x80dc7c0, name: isimodem
ofonod[1379]: src/sms.c:ofono_sms_driver_register() driver: 0x80dc804,
name: isimodem
ofonod[1379]: src/cbs.c:ofono_cbs_driver_register() driver: 0x80dc81c,
name: isimodem
ofonod[1379]: src/sim.c:ofono_sim_driver_register() driver: 0x80dc840,
name: isimodem
ofonod[1379]: src/ssn.c:ofono_ssn_driver_register() driver: 0x80dc888,
name: isimodem
ofonod[1379]: src/ussd.c:ofono_ussd_driver_register() driver:
0x80dc894, name: isimodem
ofonod[1379]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x80dc8c0, name: isimodem
ofonod[1379]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x80dc8e0, name: isimodem
ofonod[1379]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x80dc908, name: isimodem
ofonod[1379]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x80dc920, name: isimodem
ofonod[1379]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x80dc948, name: isimodem
ofonod[1379]: src/modem.c:ofono_modem_driver_register() driver:
0x80dc730, name: isimodem
ofonod[1379]: plugins/hfp.c:parse_adapters()
ofonod[1379]: src/modem.c:ofono_modem_create() name:
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD, type: huawei
ofonod[1379]: src/modem.c:ofono_modem_create() name:
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD, type: huawei
ofonod[1379]: src/modem.c:ofono_modem_create() name:
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD, type: huawei



>
> Also run lsusb to let us now which Huawei modem that is.


Bus 002 Device 005: ID 12d1:140b Huawei Technologies Co., Ltd.


>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>



-- =

Debayan Banerjee
Software Engineer

--===============4672562007109710469==--


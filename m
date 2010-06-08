Content-Type: multipart/mixed; boundary="===============1066332412253798661=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: Huawei E1552 broken
Date: Tue, 08 Jun 2010 17:09:31 +0300
Message-ID: <87iq5tzkdg.fsf@potku.valot.fi>
In-Reply-To: <87mxv5zte0.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1066332412253798661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kalle.valo@canonical.com> writes:

> But now connman doesn't show the operator name "Saunalahti" anymore, the
> name property in connman Service is just empty:
>
> ./cmcc show cellular_244053111242822_huawei0_primarycontext1
> AutoConnect: true
> Name: =

> Nameservers: { 193.229.0.40 193.229.0.42 }
> Proxy: { Method=3Ddirect }

Denis, below is a log snippet. I hope it helps.

Kalle



Jun  8 13:46:31 tukki ofonod[12996]: oFono version 0.22
Jun  8 13:46:31 tukki connmand[12966]: plugins/ofono.c:ofono_connect() conn=
ection 0x10c2720
Jun  8 13:46:31 tukki ofonod[12996]: src/plugin.c:__ofono_plugin_init() =

Jun  8 13:46:31 tukki ofonod[12996]: src/nettime.c:ofono_nettime_driver_reg=
ister() driver: 0x6d12c0 name: Example Network Time
Jun  8 13:46:31 tukki ofonod[12996]: src/history.c:ofono_history_driver_reg=
ister() driver: 0x6d1240 name: Example Call History
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d11a0, name: ste
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d1100, name: palmpre
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d0f00, name: novatel
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d0e40, name: em770
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d0da0, name: huawei
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d0ce0, name: hso
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d0c40, name: mbm
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d0b80, name: calypso
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d0ae0, name: wavecom
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d0a40, name: g1
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d09a0, name: atgen
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6d08a0, name: phonesim
Jun  8 13:46:31 tukki ofonod[12996]: src/voicecall.c:ofono_voicecall_driver=
_register() driver: 0x6d0620, name: stemodem
Jun  8 13:46:31 tukki ofonod[12996]: src/gprs.c:ofono_gprs_context_driver_r=
egister() driver: 0x6d0720, name: stemodem
Jun  8 13:46:31 tukki ofonod[12996]: src/gprs.c:ofono_gprs_context_driver_r=
egister() driver: 0x6d0540, name: hsomodem
Jun  8 13:46:31 tukki ofonod[12996]: src/radio-settings.c:ofono_radio_setti=
ngs_driver_register() driver: 0x6d05a0, name: hsomodem
Jun  8 13:46:31 tukki ofonod[12996]: src/gprs.c:ofono_gprs_context_driver_r=
egister() driver: 0x6d0440, name: mbm
Jun  8 13:46:31 tukki ofonod[12996]: src/stk.c:ofono_stk_driver_register() =
driver: 0x6d04a0, name: mbmmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/voicecall.c:ofono_voicecall_driver=
_register() driver: 0x6d0260, name: hfpmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/network.c:ofono_netreg_driver_regi=
ster() driver: 0x6d0320, name: hfpmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/call-volume.c:ofono_call_volume_dr=
iver_register() driver: 0x6d03a0, name: hfpmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/voicecall.c:ofono_voicecall_driver=
_register() driver: 0x6d0160, name: calypsomodem
Jun  8 13:46:31 tukki ofonod[12996]: src/radio-settings.c:ofono_radio_setti=
ngs_driver_register() driver: 0x6d00e0, name: nwmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/voicecall.c:ofono_voicecall_driver=
_register() driver: 0x6cfdc0, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_devinfo_driver_regis=
ter() driver: 0x6cff40, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/call-barring.c:ofono_call_barring_=
driver_register() driver: 0x6cfe80, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/call-forwarding.c:ofono_call_forwa=
rding_driver_register() driver: 0x6cfa80, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/call-meter.c:ofono_call_meter_driv=
er_register() driver: 0x6cfb00, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/call-settings.c:ofono_call_setting=
s_driver_register() driver: 0x6cf8c0, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/phonebook.c:ofono_phonebook_driver=
_register() driver: 0x6cff00, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/ssn.c:ofono_ssn_driver_register() =
driver: 0x6cff20, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/ussd.c:ofono_ussd_driver_register(=
) driver: 0x6cfd60, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/sms.c:ofono_sms_driver_register() =
driver: 0x6cf9c0, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/sim.c:ofono_sim_driver_register() =
driver: 0x6cfc40, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/stk.c:ofono_stk_driver_register() =
driver: 0x6cfd00, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/network.c:ofono_netreg_driver_regi=
ster() driver: 0x6cfba0, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/cbs.c:ofono_cbs_driver_register() =
driver: 0x6cfa20, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/call-volume.c:ofono_call_volume_dr=
iver_register() driver: 0x6cffa0, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/gprs.c:ofono_gprs_driver_register(=
) driver: 0x6d0000, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/gprs.c:ofono_gprs_context_driver_r=
egister() driver: 0x6d0040, name: atmodem
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_devinfo_driver_regis=
ter() driver: 0x6ced00, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/phonebook.c:ofono_phonebook_driver=
_register() driver: 0x6cece0, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/network.c:ofono_netreg_driver_regi=
ster() driver: 0x6ced40, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/voicecall.c:ofono_voicecall_driver=
_register() driver: 0x6ceda0, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/sms.c:ofono_sms_driver_register() =
driver: 0x6cee40, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/cbs.c:ofono_cbs_driver_register() =
driver: 0x6cee80, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/sim.c:ofono_sim_driver_register() =
driver: 0x6ceec0, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/ssn.c:ofono_ssn_driver_register() =
driver: 0x6cef50, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/ussd.c:ofono_ussd_driver_register(=
) driver: 0x6cef80, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/call-forwarding.c:ofono_call_forwa=
rding_driver_register() driver: 0x6cefc0, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/call-settings.c:ofono_call_setting=
s_driver_register() driver: 0x6cf000, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/call-barring.c:ofono_call_barring_=
driver_register() driver: 0x6cf060, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/call-meter.c:ofono_call_meter_driv=
er_register() driver: 0x6cf0a0, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/radio-settings.c:ofono_radio_setti=
ngs_driver_register() driver: 0x6cf100, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/gprs.c:ofono_gprs_driver_register(=
) driver: 0x6cf140, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/gprs.c:ofono_gprs_context_driver_r=
egister() driver: 0x6cf180, name: isimodem
Jun  8 13:46:31 tukki ofonod[12996]: src/modem.c:ofono_modem_driver_registe=
r() driver: 0x6cec40, name: isimodem
Jun  8 13:46:31 tukki connmand[12966]: plugins/ofono.c:manager_properties_r=
eply() =

Jun  8 13:46:50 tukki kernel: [46805.940110] usb 1-1: new high speed USB de=
vice using ehci_hcd and address 42
Jun  8 13:46:50 tukki kernel: [46806.101474] usb 1-1: configuration #1 chos=
en from 1 choice
Jun  8 13:46:50 tukki kernel: [46806.106070] scsi141 : SCSI emulation for U=
SB Mass Storage devices
Jun  8 13:46:50 tukki kernel: [46806.106548] usb-storage: device found at 42
Jun  8 13:46:50 tukki kernel: [46806.106553] usb-storage: waiting for devic=
e to settle before scanning
Jun  8 13:46:50 tukki kernel: [46806.106617] scsi142 : SCSI emulation for U=
SB Mass Storage devices
Jun  8 13:46:50 tukki kernel: [46806.106935] usb-storage: device found at 42
Jun  8 13:46:50 tukki kernel: [46806.106940] usb-storage: waiting for devic=
e to settle before scanning
Jun  8 13:46:51 tukki usb-modeswitch: switching 12d1:1446 (HUAWEI Technolog=
y: HUAWEI Mobile)
Jun  8 13:46:51 tukki kernel: [46806.637929] usb 1-1: USB disconnect, addre=
ss 42
Jun  8 13:46:58 tukki kernel: [46813.650070] usb 1-1: new high speed USB de=
vice using ehci_hcd and address 43
Jun  8 13:46:58 tukki kernel: [46813.811479] usb 1-1: configuration #1 chos=
en from 1 choice
Jun  8 13:46:58 tukki kernel: [46813.816202] option 1-1:1.0: GSM modem (1-p=
ort) converter detected
Jun  8 13:46:58 tukki kernel: [46813.816398] usb 1-1: GSM modem (1-port) co=
nverter now attached to ttyUSB0
Jun  8 13:46:58 tukki kernel: [46813.816802] option 1-1:1.1: GSM modem (1-p=
ort) converter detected
Jun  8 13:46:58 tukki kernel: [46813.816933] usb 1-1: GSM modem (1-port) co=
nverter now attached to ttyUSB1
Jun  8 13:46:58 tukki kernel: [46813.825236] option 1-1:1.2: GSM modem (1-p=
ort) converter detected
Jun  8 13:46:58 tukki kernel: [46813.825424] usb 1-1: GSM modem (1-port) co=
nverter now attached to ttyUSB2
Jun  8 13:46:58 tukki kernel: [46813.829382] scsi146 : SCSI emulation for U=
SB Mass Storage devices
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:ofono_modem_create() name:=
 (null), type: huawei
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:set_modem_property() modem=
 0x1d44110 property Path
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:set_modem_property() modem=
 0x1d44110 property Registered
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:get_modem_property() modem=
 0x1d44110 property ModemRegistered
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:get_modem_property() modem=
 0x1d44110 property PcuiRegistered
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:set_modem_property() modem=
 0x1d44110 property Modem
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:set_modem_property() modem=
 0x1d44110 property ModemRegistered
Jun  8 13:46:58 tukki kernel: [46813.833461] usb-storage: device found at 43
Jun  8 13:46:58 tukki kernel: [46813.833464] usb-storage: waiting for devic=
e to settle before scanning
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:get_modem_property() modem=
 0x1d44110 property Path
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:get_modem_property() modem=
 0x1d44110 property ModemRegistered
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:get_modem_property() modem=
 0x1d44110 property PcuiRegistered
Jun  8 13:46:58 tukki kernel: [46813.842778] scsi147 : SCSI emulation for U=
SB Mass Storage devices
Jun  8 13:46:58 tukki kernel: [46813.849311] usb-storage: device found at 43
Jun  8 13:46:58 tukki kernel: [46813.849315] usb-storage: waiting for devic=
e to settle before scanning
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:get_modem_property() modem=
 0x1d44110 property Path
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:get_modem_property() modem=
 0x1d44110 property ModemRegistered
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:get_modem_property() modem=
 0x1d44110 property PcuiRegistered
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:set_modem_property() modem=
 0x1d44110 property Pcui
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:set_modem_property() modem=
 0x1d44110 property PcuiRegistered
Jun  8 13:46:58 tukki ofonod[12996]: plugins/huawei.c:huawei_probe() 0x1d44=
110
Jun  8 13:46:58 tukki connmand[12966]: plugins/ofono.c:manager_changed() pa=
th /
Jun  8 13:46:58 tukki connmand[12966]: plugins/ofono.c:get_modem_properties=
() path /huawei0
Jun  8 13:46:58 tukki connmand[12966]: plugins/ofono.c:modem_properties_rep=
ly() path /huawei0
Jun  8 13:46:58 tukki connmand[12966]: plugins/ofono.c:modem_change_powered=
() path /huawei0 powered 1
Jun  8 13:46:58 tukki ofonod[12996]: plugins/huawei.c:huawei_enable() 0x1d4=
4110
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:get_modem_property() modem=
 0x1d44110 property Modem
Jun  8 13:46:58 tukki ofonod[12996]: src/modem.c:get_modem_property() modem=
 0x1d44110 property Pcui
Jun  8 13:46:58 tukki ofonod[12996]: Pcui:> ATE0\r
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:< ATE0\r\r\nOK\r\n
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:> AT+CFUN=3D1\r
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:46:59 tukki ofonod[12996]: plugins/huawei.c:cfun_enable() =

Jun  8 13:46:59 tukki ofonod[12996]: plugins/huawei.c:huawei_pre_sim() 0x1d=
44110
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:> AT^SYSINFO\r
Jun  8 13:46:59 tukki ofonod[12996]: src/sim.c:ofono_sim_add_state_watch() =
0x1d49eb0
Jun  8 13:46:59 tukki ofonod[12996]: src/sim.c:ofono_sim_add_state_watch() =
0x1d49eb0
Jun  8 13:46:59 tukki connmand[12966]: plugins/ofono.c:powered_reply() =

Jun  8 13:46:59 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:46:59 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:< \r\n^SYSINFO:0,0,0,0,255,,0\r\n=
\r\nOK\r\n
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:> AT+CGMI\r
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:< \r\nhuawei\r\n\r\nOK\r\n
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:> AT+CGMM\r
Jun  8 13:46:59 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:< \r\nE1552\r\n\r\nOK\r\n
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:> AT+CGMR\r
Jun  8 13:46:59 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:< \r\n11.608.13.02.00\r\n\r\nOK\r=
\n
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:> AT+CGSN\r
Jun  8 13:46:59 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:< \r\n^STIN:0,0,0\r\n\r\n35314303=
8645652\r\n\r\nOK\r\n
Jun  8 13:46:59 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:46:59 tukki usb-modeswitch: switched to 12d1:1001 (HUAWEI Technol=
ogy: HUAWEI Mobile)
Jun  8 13:46:59 tukki ofonod[12996]: Pcui:< \r\n^BOOT:38645652,0,0,0,87\r\n
Jun  8 13:47:00 tukki ofonod[12996]: Pcui:< \r\n^SRVST:1\r\n\r\n^MODE:5,4\r=
\n
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:< \r\n^SIMST:1\r\n\r\n^SRVST:2\r\n
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:> AT+CRSM=3D176,28590,0,0,1\r
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:< \r\n+CRSM: 106,130,""\r\n\r\nOK=
\r\n
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:> AT+CPIN?\r
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:< \r\n+CPIN: READY\r\n\r\nOK\r\n
Jun  8 13:47:01 tukki ofonod[12996]: drivers/atmodem/sim.c:at_cpin_cb() crs=
m_pin_cb: READY
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:> AT+CRSM=3D192,12258\r
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r=
\n
Jun  8 13:47:01 tukki ofonod[12996]: drivers/atmodem/sim.c:at_crsm_info_cb(=
) crsm_info_cb: 90, 00, 0
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:> AT+CIMI\r
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:< \r\n244053111242822\r\n\r\nOK\r=
\n
Jun  8 13:47:01 tukki ofonod[12996]: drivers/atmodem/sim.c:at_cimi_cb() cim=
i_cb: 244053111242822
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:> AT+CRSM=3D192,28421\r
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r=
\n
Jun  8 13:47:01 tukki ofonod[12996]: drivers/atmodem/sim.c:at_crsm_info_cb(=
) crsm_info_cb: 90, 00, 0
Jun  8 13:47:01 tukki ofonod[12996]: Pcui:> AT+CRSM=3D192,12037\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r=
\n
Jun  8 13:47:02 tukki ofonod[12996]: drivers/atmodem/sim.c:at_crsm_info_cb(=
) crsm_info_cb: 90, 00, 0
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CRSM=3D192,28438\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CRSM: 106,130,""\r\n\r\nOK=
\r\n
Jun  8 13:47:02 tukki ofonod[12996]: plugins/huawei.c:huawei_post_sim() 0x1=
d44110
Jun  8 13:47:02 tukki ofonod[12996]: Example History Probe for modem: 0x1d4=
4110
Jun  8 13:47:02 tukki ofonod[12996]: Example Network Time Probe for modem: =
0x1d44110
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CREG=3D?\r
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CREG: (0-2)\r\n\r\nOK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CSMS=3D?\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CSMS: (0-1)\r\n\r\nOK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: drivers/atmodem/sms.c:at_csms_query_cb=
() CSMS query parsed successfully
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CSCB=3D?\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CSCB: (0-1)\r\n\r\nOK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CUSD=3D1\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CGDCONT=3D?\r
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CGDCONT: (1-16),"IP",,,(0-=
2),(0-3)\r\n+CGDCONT: (1-16),"PPP",,,(0-2),(0-3)\r\n+CGDCONT: (1-16),"IPV6"=
,,,(0-2),(0-3)\r\n\r\nOK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CRSM=3D192,28480\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r=
\n
Jun  8 13:47:02 tukki ofonod[12996]: drivers/atmodem/sim.c:at_crsm_info_cb(=
) crsm_info_cb: 90, 00, 0
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CREG=3D2\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CSMS=3D1\r
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CSCB=3D1,"0-65535"\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CMS ERROR: 500\r\n
Jun  8 13:47:02 tukki ofonod[12996]: src/cbs.c:cbs_got_imsi() Got IMSI: 244=
053111242822
Jun  8 13:47:02 tukki ofonod[12996]: src/network.c:__ofono_netreg_add_statu=
s_watch() 0x1d4a0b0
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CGREG=3D?\r
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CRSM=3D192,28589\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r=
\n
Jun  8 13:47:02 tukki ofonod[12996]: drivers/atmodem/sim.c:at_crsm_info_cb(=
) crsm_info_cb: 90, 00, 0
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CREG?\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CREG: 2,1,5AA,5579\r\n\r\n=
OK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: src/cbs.c:cbs_location_changed() 1, 14=
50, 21881, -1, (null)(null)
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CSMS?\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\n+CSMS: ,1,1,1\r\n\r\nOK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CGREG=3D2\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CGAUTO=3D0\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\nERROR\r\n
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CGEREP=3D2,1\r
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:02 tukki ofonod[12996]: src/network.c:__ofono_netreg_add_statu=
s_watch() 0x1d4a0b0
Jun  8 13:47:02 tukki ofonod[12996]: Pcui:> AT+CRSM=3D192,28489\r
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:get_imsi() path /hua=
wei0
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:sim_properties_reply=
() path /huawei0
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:add_device() path /h=
uawei0 imsi 244053111242822
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:connman_device_create()=
 node 244053111242822 type 5
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:connman_device_create()=
 device 0x10ca360
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:__connman_element_init=
ialize() element 0x10ca360
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10ca360 name 244053111242822
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:set_static_property() =
name Type type 115 value 0x7fff83cb7e48
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:connman_device_set_stri=
ng() device 0x10ca360 key Path value /huawei0
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10ca360 name 244053111242822
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:set_static_property() =
name Path type 115 value 0x7fff83cb7e48
Jun  8 13:47:02 tukki connmand[12966]: src/storage.c:__connman_storage_load=
_device() device 0x10ca360
Jun  8 13:47:02 tukki connmand[12966]: src/profile.c:__connman_profile_acti=
ve_ident() =

Jun  8 13:47:02 tukki connmand[12966]: src/device.c:device_load() device 0x=
10ca360
Jun  8 13:47:02 tukki connmand[12966]: src/storage.c:__connman_storage_open=
() ident default suffix profile
Jun  8 13:47:02 tukki connmand[12966]: src/storage.c:__connman_storage_open=
() keyfile 0x10dbf20
Jun  8 13:47:02 tukki connmand[12966]: src/storage.c:__connman_storage_clos=
e() ident default suffix profile keyfile 0x10dbf20 save 0
Jun  8 13:47:02 tukki connmand[12966]: src/profile.c:__connman_profile_get_=
offlinemode() offlinemode 0
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:connman_element_regist=
er() element 0x10ca360 name 244053111242822 parent (nil)
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:connman_element_ref() =
element 0x10ca360 name 244053111242822 refcount 2
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:register_element() ele=
ment 0x10ca360 path /org/moblin/connman/device/244053111242822
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:probe_element() elemen=
t 0x10ca360 name 244053111242822
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:probe_element() driver=
 0x655220 name device
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:device_probe() element =
0x10ca360 name 244053111242822
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:device_probe() driver 0=
x654d80 name modem
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:modem_probe() device=
 0x10ca360
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:setup_device() device 0=
x10ca360
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:register_interface() el=
ement 0x10ca360 name 244053111242822
Jun  8 13:47:02 tukki connmand[12966]: src/technology.c:__connman_technolog=
y_add_device() device 0x10ca360
Jun  8 13:47:02 tukki connmand[12966]: src/notifier.c:__connman_notifier_re=
gister() type 6
Jun  8 13:47:02 tukki connmand[12966]: src/notifier.c:technology_registered=
() type 6 registered 1
Jun  8 13:47:02 tukki connmand[12966]: src/technology.c:technology_get() ty=
pe 6
Jun  8 13:47:02 tukki connmand[12966]: src/technology.c:technology_find() t=
ype 6
Jun  8 13:47:02 tukki connmand[12966]: src/technology.c:technology_get() te=
chnology 0x10d9510
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:__connman_device_enable=
() device 0x10ca360
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:connman_device_get_stri=
ng() device 0x10ca360 key Path
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10ca360 name 244053111242822
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:modem_enable() devic=
e 0x10ca360, path, /huawei0
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:gprs_change_powered(=
) path /huawei0 powered 1
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:check_networks() mod=
em 0x10d9210
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:powered_reply() =

Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() device 0x10ca360
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() key PrimaryContexts
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:connman_device_get_stri=
ng() device 0x10ca360 key Path
Jun  8 13:47:02 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10ca360 name 244053111242822
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:add_default_context(=
) =

Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() key Attached
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() Attached 0
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() key RoamingAllowed
Jun  8 13:47:02 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() key Powered
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:connman_device_set_powe=
red() driver 0x10ca360 powered 1
Jun  8 13:47:02 tukki connmand[12966]: src/device.c:__connman_device_enable=
() device 0x10ca360
Jun  8 13:47:02 tukki connmand[12966]: src/technology.c:__connman_technolog=
y_enable_device() device 0x10ca360
Jun  8 13:47:02 tukki connmand[12966]: src/notifier.c:__connman_notifier_en=
able() type 6
Jun  8 13:47:02 tukki connmand[12966]: src/notifier.c:technology_enabled() =
type 6 enabled 1
Jun  8 13:47:02 tukki connmand[12966]: src/manager.c:technology_notify() ty=
pe 6 enabled 1
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r=
\n
Jun  8 13:47:03 tukki ofonod[12996]: drivers/atmodem/sim.c:at_crsm_info_cb(=
) crsm_info_cb: 90, 00, 0
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:> AT+COPS=3D3,2\r
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:> AT+COPS?\r
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:< \r\n+COPS: 0,2,"24405",2\r\n\r\=
nOK\r\n
Jun  8 13:47:03 tukki ofonod[12996]: drivers/atmodem/network-registration.c=
:cops_numeric_cb() Cops numeric got mcc: 244, mnc: 05
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:> AT+CSQ\r
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:< \r\n+CSQ: 20,99\r\n\r\nOK\r\n
Jun  8 13:47:03 tukki ofonod[12996]: drivers/atmodem/network-registration.c=
:csq_cb() csq_cb: 20
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:> AT+CMGF=3D?\r
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:< \r\n+CMGF: (0-1)\r\n\r\nOK\r\n
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:> AT+CGATT=3D1\r
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:< \r\n^SRVST:1\r\n\r\n+CREG: 2,5A=
A,5579\r\n\r\n+CGREG: 2,5AA,5579\r\n\r\n^SRVST:2\r\n\r\n+CREG: 1,5AA,5579\r=
\n\r\n+CGREG: 0,5AA,5579\r\n
Jun  8 13:47:03 tukki ofonod[12996]: src/network.c:current_operator_callbac=
k() 0x1d4a0b0, (nil)
Jun  8 13:47:03 tukki ofonod[12996]: src/gprs.c:netreg_status_changed() 2
Jun  8 13:47:03 tukki ofonod[12996]: src/cbs.c:cbs_location_changed() 2, 14=
50, 21881, -1, (null)(null)
Jun  8 13:47:03 tukki ofonod[12996]: src/gprs.c:netreg_status_changed() 1
Jun  8 13:47:03 tukki ofonod[12996]: src/cbs.c:cbs_location_changed() 1, 14=
50, 21881, -1, (null)(null)
Jun  8 13:47:03 tukki kernel: [46818.831520] usb-storage: device scan compl=
ete
Jun  8 13:47:03 tukki kernel: [46818.834222] scsi 146:0:0:0: CD-ROM        =
    HUAWEI   Mass Storage     2.31 PQ: 0 ANSI: 2
Jun  8 13:47:03 tukki kernel: [46818.844733] usb-storage: device scan compl=
ete
Jun  8 13:47:03 tukki kernel: [46818.846957] scsi 147:0:0:0: Direct-Access =
    HUAWEI   MMC Storage      2.31 PQ: 0 ANSI: 2
Jun  8 13:47:03 tukki kernel: [46818.854798] sr0: scsi-1 drive
Jun  8 13:47:03 tukki kernel: [46818.855093] sr 146:0:0:0: Attached scsi CD=
-ROM sr0
Jun  8 13:47:03 tukki kernel: [46818.855252] sr 146:0:0:0: Attached scsi ge=
neric sg1 type 5
Jun  8 13:47:03 tukki kernel: [46818.857583] sd 147:0:0:0: Attached scsi ge=
neric sg2 type 0
Jun  8 13:47:03 tukki kernel: [46818.872784] sd 147:0:0:0: [sdb] Attached S=
CSI removable disk
Jun  8 13:47:03 tukki ofonod[12996]: Pcui:< \r\n^RSSI:20\r\n
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:< \r\n+CREG: 1,5AA,5579\r\n\r\n+C=
GREG: 1,5AA,5579\r\n\r\nOK\r\n
Jun  8 13:47:04 tukki ofonod[12996]: src/gprs.c:netreg_status_changed() 1
Jun  8 13:47:04 tukki ofonod[12996]: src/cbs.c:cbs_location_changed() 1, 14=
50, 21881, -1, (null)(null)
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:> AT+CRSM=3D192,28613\r
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:gprs_changed() path =
/huawei0
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:gprs_changed() Attac=
hed 1
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:check_networks() mod=
em 0x10d9210
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() device 0x10ca360
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() key PrimaryContexts
Jun  8 13:47:04 tukki connmand[12966]: src/device.c:connman_device_get_stri=
ng() device 0x10ca360 key Path
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10ca360 name 244053111242822
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:add_default_context(=
) =

Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() key Attached
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() Attached 1
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() key RoamingAllowed
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:check_networks_reply=
() key Powered
Jun  8 13:47:04 tukki connmand[12966]: src/device.c:connman_device_set_powe=
red() driver 0x10ca360 powered 1
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:add_networks() =

Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:add_network() device=
 0x10ca360 path /huawei0/primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/device.c:connman_device_get_netw=
ork() device 0x10ca360 identifier /huawei0/primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_create=
() identifier huawei0_primarycontext1 type 10
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_create=
() network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:__connman_element_init=
ialize() element 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
name Type type 115 value 0x7fff83cb7d88
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
name Strength type 121 value 0x7fff83cb7d8c
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_set_st=
ring() network 0x10d0810 key Path value /huawei0/primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
name Path type 115 value 0x7fff83cb7d88
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_set_av=
ailable() network 0x10d0810 available 1
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:__connman_service_look=
up_from_network() network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/device.c:connman_device_get_stri=
ng() device 0x10ca360 key MCC
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10ca360 name 244053111242822
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10c4cf0 name (null)
Jun  8 13:47:04 tukki connmand[12966]: src/device.c:connman_device_get_stri=
ng() device 0x10ca360 key MNC
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10ca360 name 244053111242822
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10c4cf0 name (null)
Jun  8 13:47:04 tukki connmand[12966]: src/device.c:connman_device_add_netw=
ork() device 0x10ca360 network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:connman_element_regist=
er() element 0x10d0810 name huawei0_primarycontext1 parent 0x10ca360
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:connman_element_ref() =
element 0x10d0810 name huawei0_primarycontext1 refcount 2
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:register_element() ele=
ment 0x10d0810 path /org/moblin/connman/device/244053111242822/huawei0_prim=
arycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:probe_element() elemen=
t 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:probe_element() driver=
 0x655360 name network
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:network_probe() elemen=
t 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:network_probe() driver=
 0x654dc0 name network
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key Path
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:network_probe() netw=
ork 0x10d0810 path /huawei0/primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:config_network() pat=
h /huawei0/primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:register_interface() e=
lement 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:__connman_element_list=
() =

Jun  8 13:47:04 tukki connmand[12966]: src/element.c:append_path() element =
0x10ca360 name 244053111242822
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:append_path() element =
0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:config_network_reply=
() network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/device.c:connman_device_get_stri=
ng() device 0x10ca360 key Path
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10ca360 name 244053111242822
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:set_network_name() p=
ath /huawei0
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:set_network_name_rep=
ly() network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_set_na=
me() network 0x10d0810 name =

Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
name Name type 115 value 0x7fff83cb7eb8
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:create_service() =

Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key Path
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/profile.c:__connman_profile_add_=
network() network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:__connman_service_crea=
te_from_network() network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:connman_service_create=
() service 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:__connman_service_init=
ialize() service 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/location.c:__connman_location_cr=
eate() service 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/location.c:__connman_location_cr=
eate() location 0x10ca690
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:__connman_service_get(=
) service 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/profile.c:__connman_profile_acti=
ve_ident() =

Jun  8 13:47:04 tukki connmand[12966]: src/service.c:update_from_network() =
service 0x10cf520 network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key Name
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_ui=
nt8() network 0x10d0810 key Strength
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_bo=
ol() network 0x10d0810 key Roaming
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key WiFi.Mode
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key WiFi.Security
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key Cellular.MCC
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10ca360 name 244053111242822
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10c4cf0 name (null)
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key Cellular.MNC
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10ca360 name 244053111242822
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10c4cf0 name (null)
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_ui=
nt8() network 0x10d0810 key Cellular.Mode
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10ca360 name 244053111242822
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10c4cf0 name (null)
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:connman_element_ref() =
element 0x10d0810 name huawei0_primarycontext1 refcount 3
Jun  8 13:47:04 tukki connmand[12966]: src/profile.c:__connman_profile_acti=
ve_path() =

Jun  8 13:47:04 tukki connmand[12966]: src/service.c:service_register() ser=
vice 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:service_register() pat=
h /profile/default/cellular_244053111242822_huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/config.c:__connman_config_provis=
ion_service() service 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/storage.c:__connman_storage_load=
_service() service 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:service_load() service=
 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/profile.c:__connman_profile_chan=
ged() =

Jun  8 13:47:04 tukki connmand[12966]: src/connection.c:find_active_gateway=
() =

Jun  8 13:47:04 tukki connmand[12966]: src/service.c:__connman_service_auto=
_connect() =

Jun  8 13:47:04 tukki connmand[12966]: src/service.c:__connman_service_conn=
ect() service 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_set_st=
ring() network 0x10d0810 key Cellular.APN value internet
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
name Cellular.APN type 115 value 0x7fff83cb7d38
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:network_setup() =

Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key Cellular.APN
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key Path
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:set_apn() path /huaw=
ei0/primarycontext1, apn internet
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_set_st=
ring() network 0x10d0810 key Cellular.Username value (null)
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
name Cellular.Username type 115 value 0x7fff83cb7d38
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:network_setup() =

Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_set_st=
ring() network 0x10d0810 key Cellular.Password value (null)
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:set_static_property() =
name Cellular.Password type 115 value 0x7fff83cb7d38
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:network_setup() =

Jun  8 13:47:04 tukki connmand[12966]: src/ipconfig.c:__connman_ipconfig_en=
able() ipconfig (nil)
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:__connman_network_conn=
ect() network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/device.c:__connman_device_discon=
nect() device 0x10ca360
Jun  8 13:47:04 tukki connmand[12966]: src/device.c:connman_device_set_disc=
onnected() device 0x10ca360 disconnected 1
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:__connman_network_disc=
onnect() network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key Path
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:set_network_active()=
 network 0x10d0810, path /huawei0/primarycontext1, active 1
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:connman_element_ref() =
element 0x10d0810 name huawei0_primarycontext1 refcount 4
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_set_as=
sociating() network 0x10d0810 associating 1
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:__connman_service_look=
up_from_network() network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:__connman_service_indi=
cate_state() service 0x10cf520 state 2
Jun  8 13:47:04 tukki connmand[12966]: src/profile.c:__connman_profile_chan=
ged() =

Jun  8 13:47:04 tukki connmand[12966]: src/connection.c:find_active_gateway=
() =

Jun  8 13:47:04 tukki connmand[12966]: plugins/ofono.c:set_active_reply() n=
etwork 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/element.c:connman_element_unref(=
) element 0x10d0810 name huawei0_primarycontext1 refcount 3
Jun  8 13:47:04 tukki connmand[12966]: src/device.c:connman_device_get_netw=
ork() device 0x10ca360 identifier huawei0_primarycontext1
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_set_er=
ror() nework 0x10d0810, error 1
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:__connman_service_look=
up_from_network() network 0x10d0810
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:__connman_service_indi=
cate_state() service 0x10cf520 state 8
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:__connman_service_auto=
_connect() =

Jun  8 13:47:04 tukki connmand[12966]: src/storage.c:__connman_storage_save=
_service() service 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:service_save() service=
 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/profile.c:__connman_profile_chan=
ged() =

Jun  8 13:47:04 tukki connmand[12966]: src/connection.c:find_active_gateway=
() =

Jun  8 13:47:04 tukki connmand[12966]: plugins/wifi.c:wifi_scan() device 0x=
10d5160
Jun  8 13:47:04 tukki connmand[12966]: plugins/supplicant.c:supplicant_scan=
() device 0x10d5160
Jun  8 13:47:04 tukki connmand[12966]: plugins/supplicant.c:initiate_scan()=
 task 0x10c2a30
Jun  8 13:47:04 tukki connmand[12966]: GPRS Attach is in progress
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:get_properties() servi=
ce 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10cc330
Jun  8 13:47:04 tukki connmand[12966]: plugins/supplicant.c:scan_reply() ta=
sk 0x10c2a30
Jun  8 13:47:04 tukki connmand[12966]: src/device.c:connman_device_set_scan=
ning() device 0x10d5160 scanning 1
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_set_av=
ailable() network 0x10cd8f0 available 0
Jun  8 13:47:04 tukki connmand[12966]: src/network.c:connman_network_set_av=
ailable() network 0x10d6a00 available 0
Jun  8 13:47:04 tukki connmand[12966]: plugins/supplicant.c:supplicant_filt=
er() task 0x10c2a30 member StateChange
Jun  8 13:47:04 tukki connmand[12966]: plugins/supplicant.c:state_change() =
state DISCONNECTED =3D=3D> SCANNING
Jun  8 13:47:04 tukki connmand[12966]: wlan0 SCANNING (scanning)
Jun  8 13:47:04 tukki connmand[12966]: plugins/supplicant.c:supplicant_filt=
er() task 0x10c2a30 member Scanning
Jun  8 13:47:04 tukki connmand[12966]: wlan0 scanning started
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:get_properties() servi=
ce 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c2be0
Jun  8 13:47:04 tukki connmand[12966]: src/service.c:get_properties() servi=
ce 0x10cf520
Jun  8 13:47:04 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c9160
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r=
\n
Jun  8 13:47:04 tukki ofonod[12996]: drivers/atmodem/sim.c:at_crsm_info_cb(=
) crsm_info_cb: 90, 00, 0
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:> AT+COPS=3D3,0\r
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:> AT+COPS?\r
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:< \r\n+COPS: 0,0,"Saunalahti",2\r=
\n\r\nOK\r\n
Jun  8 13:47:04 tukki ofonod[12996]: drivers/atmodem/network-registration.c=
:cops_cb() cops_cb: Saunalahti, 244 05 2
Jun  8 13:47:04 tukki ofonod[12996]: src/network.c:current_operator_callbac=
k() 0x1d4a0b0, (nil)
Jun  8 13:47:04 tukki ofonod[12996]: src/gprs.c:netreg_status_changed() 1
Jun  8 13:47:04 tukki ofonod[12996]: src/cbs.c:cbs_location_changed() 1, 14=
50, 21881, -1, 24405
Jun  8 13:47:04 tukki ofonod[12996]: src/cbs.c:cbs_location_changed() 1, 0,=
 0
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:> AT+CPMS=3D?\r
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:< \r\n+CPMS: ("ME","MT","SM","SR"=
),("ME","MT","SM","SR"),("ME","MT","SM","SR")\r\n\r\nOK\r\n
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:> AT+COPS=3D3,2\r
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:> AT+COPS?\r
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:< \r\n+COPS: 0,2,"24405",2\r\n\r\=
nOK\r\n
Jun  8 13:47:04 tukki ofonod[12996]: drivers/atmodem/network-registration.c=
:cops_numeric_cb() Cops numeric got mcc: 244, mnc: 05
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:> AT+COPS=3D3,2\r
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:> AT+COPS?\r
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:< \r\n+COPS: 0,2,"24405",2\r\n\r\=
nOK\r\n
Jun  8 13:47:04 tukki ofonod[12996]: drivers/atmodem/network-registration.c=
:cops_numeric_cb() Cops numeric got mcc: 244, mnc: 05
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:> AT+CGREG?\r
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:< \r\n+CGREG: 2,1,5AA,0\r\n\r\nOK=
\r\n
Jun  8 13:47:04 tukki ofonod[12996]: Pcui:> AT+CRSM=3D192,28486\r
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r=
\n
Jun  8 13:47:05 tukki ofonod[12996]: drivers/atmodem/sim.c:at_crsm_info_cb(=
) crsm_info_cb: 90, 00, 0
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:> AT+CMGF=3D0\r
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:> AT+COPS=3D3,0\r
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:> AT+COPS?\r
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\n+COPS: 0,0,"Saunalahti",2\r=
\n\r\nOK\r\n
Jun  8 13:47:05 tukki ofonod[12996]: drivers/atmodem/network-registration.c=
:cops_cb() cops_cb: Saunalahti, 244 05 2
Jun  8 13:47:05 tukki ofonod[12996]: src/network.c:current_operator_callbac=
k() 0x1d4a0b0, 0x1d4f1a0
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:> AT+COPS=3D3,0\r
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:> AT+COPS?\r
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\n+COPS: 0,0,"Saunalahti",2\r=
\n\r\nOK\r\n
Jun  8 13:47:05 tukki ofonod[12996]: drivers/atmodem/network-registration.c=
:cops_cb() cops_cb: Saunalahti, 244 05 2
Jun  8 13:47:05 tukki ofonod[12996]: src/network.c:current_operator_callbac=
k() 0x1d4a0b0, 0x1d4f1a0
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:> AT+CRSM=3D192,28488\r
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r=
\n
Jun  8 13:47:05 tukki ofonod[12996]: drivers/atmodem/sim.c:at_crsm_info_cb(=
) crsm_info_cb: 90, 00, 0
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:> AT+CPMS=3D"ME","ME","ME"\r
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\n+CPMS: 0,23,0,23,0,23\r\n\r=
\nOK\r\n
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:> AT+CSCB=3D0,"4352-4356"\r
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\n+CMS ERROR: 302\r\n
Jun  8 13:47:05 tukki ofonod[12996]: Setting Cell Broadcast topics failed
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:> AT+CNMI=3D?\r
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\n+CNMI: (0,1,2),(0,1,2,3),(0=
,2),(0,1,2),(0,1)\r\n\r\nOK\r\n
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:> AT+CNMI=3D1,1,2,1,0\r
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:> AT+CMGL=3D4\r
Jun  8 13:47:05 tukki connmand[12966]: plugins/ofono.c:modem_changed() path=
 /huawei0
Jun  8 13:47:05 tukki ofonod[12996]: Pcui:< \r\nOK\r\n
Jun  8 13:47:05 tukki connmand[12966]: src/rtnl.c:rtnl_message() buf 0x7fff=
83cb7160 len 64
Jun  8 13:47:05 tukki connmand[12966]: src/rtnl.c:rtnl_message() NEWLINK le=
n 64 type 16 flags 0x0000 seq 0
Jun  8 13:47:05 tukki connmand[12966]: src/ipconfig.c:__connman_ipconfig_ne=
wlink() index 5
Jun  8 13:47:05 tukki connmand[12966]: plugins/wifi.c:wifi_newlink() index =
5 flags 4099 change 0
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:supplicant_filt=
er() task 0x10c2a30 member Scanning
Jun  8 13:47:05 tukki connmand[12966]: wlan0 scanning finished
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:supplicant_filt=
er() task 0x10c2a30 member ScanResultsAvailable
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:scan_results_av=
ailable() task 0x10c2a30
Jun  8 13:47:05 tukki connmand[12966]: src/device.c:connman_device_set_scan=
ning() device 0x10d5160 scanning 1
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:supplicant_filt=
er() task 0x10c2a30 member StateChange
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:state_change() =
state SCANNING =3D=3D> DISCONNECTED
Jun  8 13:47:05 tukki connmand[12966]: wlan0 DISCONNECTED (scanning)
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:scan_results_re=
ply() task 0x10c2a30
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:properties_repl=
y() task 0x10c2a30
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:properties_repl=
y() capabilties 17 frequency 2462 quality 55 noise 0 level 201 maxrate 5400=
0000
Jun  8 13:47:05 tukki connmand[12966]: src/device.c:connman_device_get_netw=
ork() device 0x10d5160 identifier 0026f2f7cfb2
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_na=
me() network 0x10d6a00 name valo
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d6a00 name 0026f2f7cfb2
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
name Name type 115 value 0x7fff83cb7df8
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10d6c20
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_bl=
ob() network 0x10d6a00 key WiFi.SSID size 4
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_array_prope=
rty() element 0x10d6a00 name 0026f2f7cfb2
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_array_prope=
rty() name WiFi.SSID type 121 value 0x7fff83cb7dd8
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10cb8b0
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_st=
ring() network 0x10d6a00 key WiFi.Mode value managed
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d6a00 name 0026f2f7cfb2
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
name WiFi.Mode type 115 value 0x7fff83cb7dd8
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10cdfb0
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:properties_repl=
y() valo (managed rsn) strength 78 (no WPS)
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_av=
ailable() network 0x10d6a00 available 1
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_st=
rength() network 0x10d6a00 strengh 78
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d6a00 name 0026f2f7cfb2
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
name Strength type 121 value 0x7fff83cb7dfc
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10ce3e0
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_ui=
nt16() network 0x10d6a00 key Frequency value 2462
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_ui=
nt16() network 0x10d6a00 key WiFi.Channel value 11
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_st=
ring() network 0x10d6a00 key WiFi.Security value rsn
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d6a00 name 0026f2f7cfb2
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
name WiFi.Security type 115 value 0x7fff83cb7dd8
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10d93c0
Jun  8 13:47:05 tukki connmand[12966]: src/profile.c:__connman_profile_upda=
te_network() network 0x10d6a00
Jun  8 13:47:05 tukki connmand[12966]: src/service.c:__connman_service_upda=
te_from_network() network 0x10d6a00
Jun  8 13:47:05 tukki connmand[12966]: src/service.c:__connman_service_look=
up_from_network() network 0x10d6a00
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_get_ui=
nt8() network 0x10d6a00 key Strength
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_get_bo=
ol() network 0x10d6a00 key Roaming
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:properties_repl=
y() task 0x10c2a30
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:properties_repl=
y() capabilties 1 frequency 2437 quality 24 noise 0 level 170 maxrate 54000=
000
Jun  8 13:47:05 tukki connmand[12966]: src/device.c:connman_device_get_netw=
ork() device 0x10d5160 identifier 0013493c5c5d
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_na=
me() network 0x10cd8f0 name ZyXEL
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10cd8f0 name 0013493c5c5d
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
name Name type 115 value 0x7fff83cb7df8
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10c9c30
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_bl=
ob() network 0x10cd8f0 key WiFi.SSID size 5
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_array_prope=
rty() element 0x10cd8f0 name 0013493c5c5d
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_array_prope=
rty() name WiFi.SSID type 121 value 0x7fff83cb7dd8
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10cc9a0
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_st=
ring() network 0x10cd8f0 key WiFi.Mode value managed
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10cd8f0 name 0013493c5c5d
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
name WiFi.Mode type 115 value 0x7fff83cb7dd8
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10c4010
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:properties_repl=
y() ZyXEL (managed none) strength 34 (no WPS)
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_av=
ailable() network 0x10cd8f0 available 1
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_st=
rength() network 0x10cd8f0 strengh 34
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10cd8f0 name 0013493c5c5d
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
name Strength type 121 value 0x7fff83cb7dfc
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10cc830
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_ui=
nt16() network 0x10cd8f0 key Frequency value 2437
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_ui=
nt16() network 0x10cd8f0 key WiFi.Channel value 6
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_set_st=
ring() network 0x10cd8f0 key WiFi.Security value none
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10cd8f0 name 0013493c5c5d
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:set_static_property() =
name WiFi.Security type 115 value 0x7fff83cb7dd8
Jun  8 13:47:05 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10d9c90
Jun  8 13:47:05 tukki connmand[12966]: src/profile.c:__connman_profile_upda=
te_network() network 0x10cd8f0
Jun  8 13:47:05 tukki connmand[12966]: src/service.c:__connman_service_upda=
te_from_network() network 0x10cd8f0
Jun  8 13:47:05 tukki connmand[12966]: src/service.c:__connman_service_look=
up_from_network() network 0x10cd8f0
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_get_ui=
nt8() network 0x10cd8f0 key Strength
Jun  8 13:47:05 tukki connmand[12966]: src/network.c:connman_network_get_bo=
ol() network 0x10cd8f0 key Roaming
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:hidden_block_en=
able() network (nil)
Jun  8 13:47:05 tukki connmand[12966]: plugins/supplicant.c:hidden_block_en=
able() dolce num of scans 1 enabled 1
Jun  8 13:47:05 tukki connmand[12966]: src/device.c:connman_device_set_scan=
ning() device 0x10d5160 scanning 0
Jun  8 13:47:05 tukki connmand[12966]: src/service.c:get_properties() servi=
ce 0x10cd7c0
Jun  8 13:47:05 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c9160
Jun  8 13:47:06 tukki ofonod[12996]: Pcui:< \r\n^RSSI:20\r\n
Jun  8 13:47:09 tukki ofonod[12996]: Pcui:< \r\n^RSSI:20\r\n
Jun  8 13:47:10 tukki connmand[12966]: src/device.c:device_scan_trigger() d=
evice 0x10ca360
Jun  8 13:47:15 tukki connmand[12966]: src/device.c:device_scan_trigger() d=
evice 0x10ca360
Jun  8 13:47:15 tukki connmand[12966]: src/manager.c:get_properties() conn =
0x10c2720
Jun  8 13:47:15 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c9160
Jun  8 13:47:15 tukki connmand[12966]: src/profile.c:__connman_profile_acti=
ve_path() =

Jun  8 13:47:15 tukki connmand[12966]: src/profile.c:__connman_profile_get_=
offlinemode() offlinemode 0
Jun  8 13:47:15 tukki connmand[12966]: src/service.c:get_properties() servi=
ce 0x10cf520
Jun  8 13:47:15 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c9160
Jun  8 13:47:16 tukki kernel: [46831.761536] ISO 9660 Extensions: Microsoft=
 Joliet Level 1
Jun  8 13:47:16 tukki kernel: [46831.764523] ISOFS: changing to secondary r=
oot
Jun  8 13:47:18 tukki ofonod[12996]: Pcui:< \r\n^RSSI:20\r\n
Jun  8 13:47:20 tukki connmand[12966]: src/device.c:device_scan_trigger() d=
evice 0x10ca360
Jun  8 13:47:21 tukki ofonod[12996]: Pcui:< \r\n^RSSI:20\r\n
Jun  8 13:47:24 tukki ofonod[12996]: Pcui:< \r\n^RSSI:20\r\n
Jun  8 13:47:25 tukki connmand[12966]: src/device.c:device_scan_trigger() d=
evice 0x10ca360
Jun  8 13:47:30 tukki ofonod[12996]: Pcui:< \r\n^BOOT:38645652,0,0,0,87\r\n
Jun  8 13:47:30 tukki connmand[12966]: src/device.c:device_scan_trigger() d=
evice 0x10ca360
Jun  8 13:47:30 tukki ofonod[12996]: Pcui:< \r\n^RSSI:20\r\n
Jun  8 13:47:33 tukki ofonod[12996]: Pcui:< \r\n^RSSI:20\r\n
Jun  8 13:47:35 tukki connmand[12966]: src/device.c:device_scan_trigger() d=
evice 0x10ca360
Jun  8 13:47:39 tukki connmand[12966]: src/manager.c:get_properties() conn =
0x10c2720
Jun  8 13:47:39 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c9160
Jun  8 13:47:39 tukki connmand[12966]: src/profile.c:__connman_profile_acti=
ve_path() =

Jun  8 13:47:39 tukki connmand[12966]: src/profile.c:__connman_profile_get_=
offlinemode() offlinemode 0
Jun  8 13:47:39 tukki connmand[12966]: src/service.c:get_properties() servi=
ce 0x10cd7c0
Jun  8 13:47:39 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c9160
Jun  8 13:47:39 tukki connmand[12966]: src/service.c:get_properties() servi=
ce 0x10d8fa0
Jun  8 13:47:39 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c9160
Jun  8 13:47:39 tukki connmand[12966]: src/service.c:get_properties() servi=
ce 0x10cf520
Jun  8 13:47:39 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c9160
Jun  8 13:47:39 tukki connmand[12966]: src/service.c:get_properties() servi=
ce 0x10cfd70
Jun  8 13:47:39 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c9160
Jun  8 13:47:39 tukki ofonod[12996]: Pcui:< \r\n^RSSI:20\r\n
Jun  8 13:47:40 tukki connmand[12966]: src/device.c:device_scan_trigger() d=
evice 0x10ca360
Jun  8 13:47:45 tukki connmand[12966]: src/device.c:device_scan_trigger() d=
evice 0x10ca360
Jun  8 13:47:48 tukki connmand[12966]: src/manager.c:get_properties() conn =
0x10c2720
Jun  8 13:47:48 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c9160
Jun  8 13:47:48 tukki connmand[12966]: src/profile.c:__connman_profile_acti=
ve_path() =

Jun  8 13:47:48 tukki connmand[12966]: src/profile.c:__connman_profile_get_=
offlinemode() offlinemode 0
Jun  8 13:47:48 tukki connmand[12966]: src/service.c:get_properties() servi=
ce 0x10cf520
Jun  8 13:47:48 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10c9160
Jun  8 13:47:48 tukki ofonod[12996]: Pcui:< \r\n^RSSI:20\r\n
Jun  8 13:47:50 tukki connmand[12966]: src/device.c:device_scan_trigger() d=
evice 0x10ca360
Jun  8 13:47:54 tukki connmand[12966]: src/manager.c:request_scan() conn 0x=
10c2720
Jun  8 13:47:54 tukki connmand[12966]: plugins/wifi.c:wifi_scan() device 0x=
10d5160
Jun  8 13:47:54 tukki connmand[12966]: plugins/supplicant.c:supplicant_scan=
() device 0x10d5160
Jun  8 13:47:54 tukki connmand[12966]: plugins/supplicant.c:initiate_scan()=
 task 0x10c2a30
Jun  8 13:47:54 tukki connmand[12966]: plugins/supplicant.c:scan_reply() ta=
sk 0x10c2a30
Jun  8 13:47:54 tukki connmand[12966]: src/device.c:connman_device_set_scan=
ning() device 0x10d5160 scanning 1
Jun  8 13:47:54 tukki connmand[12966]: src/network.c:connman_network_set_av=
ailable() network 0x10cd8f0 available 0
Jun  8 13:47:54 tukki connmand[12966]: src/network.c:connman_network_set_av=
ailable() network 0x10d6a00 available 0
Jun  8 13:47:54 tukki connmand[12966]: plugins/supplicant.c:supplicant_filt=
er() task 0x10c2a30 member StateChange
Jun  8 13:47:54 tukki connmand[12966]: plugins/supplicant.c:state_change() =
state DISCONNECTED =3D=3D> SCANNING
Jun  8 13:47:54 tukki connmand[12966]: wlan0 SCANNING (scanning)
Jun  8 13:47:54 tukki connmand[12966]: plugins/supplicant.c:supplicant_filt=
er() task 0x10c2a30 member Scanning
Jun  8 13:47:54 tukki connmand[12966]: wlan0 scanning started
Jun  8 13:47:54 tukki connmand[12966]: src/service.c:connect_service() serv=
ice 0x10cf520
Jun  8 13:47:54 tukki connmand[12966]: src/service.c:__connman_service_conn=
ect() service 0x10cf520
Jun  8 13:47:54 tukki connmand[12966]: src/network.c:connman_network_set_st=
ring() network 0x10d0810 key Cellular.APN value internet
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:set_static_property() =
name Cellular.APN type 115 value 0x7fff83cb7e28
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10ca150
Jun  8 13:47:54 tukki connmand[12966]: plugins/ofono.c:network_setup() =

Jun  8 13:47:54 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key Cellular.APN
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:54 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key Path
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:54 tukki connmand[12966]: plugins/ofono.c:set_apn() path /huaw=
ei0/primarycontext1, apn internet
Jun  8 13:47:54 tukki connmand[12966]: src/network.c:connman_network_set_st=
ring() network 0x10d0810 key Cellular.Username value (null)
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:set_static_property() =
name Cellular.Username type 115 value 0x7fff83cb7e28
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10ce170
Jun  8 13:47:54 tukki connmand[12966]: plugins/ofono.c:network_setup() =

Jun  8 13:47:54 tukki connmand[12966]: src/network.c:connman_network_set_st=
ring() network 0x10d0810 key Cellular.Password value (null)
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:set_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:set_static_property() =
name Cellular.Password type 115 value 0x7fff83cb7e28
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:unregister_property() =
property 0x10cec30
Jun  8 13:47:54 tukki connmand[12966]: plugins/ofono.c:network_setup() =

Jun  8 13:47:54 tukki connmand[12966]: src/ipconfig.c:__connman_ipconfig_en=
able() ipconfig (nil)
Jun  8 13:47:54 tukki connmand[12966]: src/network.c:__connman_network_conn=
ect() network 0x10d0810
Jun  8 13:47:54 tukki connmand[12966]: src/device.c:__connman_device_discon=
nect() device 0x10ca360
Jun  8 13:47:54 tukki connmand[12966]: src/device.c:connman_device_set_disc=
onnected() device 0x10ca360 disconnected 1
Jun  8 13:47:54 tukki connmand[12966]: src/network.c:__connman_network_disc=
onnect() network 0x10d0810
Jun  8 13:47:54 tukki connmand[12966]: src/network.c:connman_network_get_st=
ring() network 0x10d0810 key Path
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:get_static_property() =
element 0x10d0810 name huawei0_primarycontext1
Jun  8 13:47:54 tukki connmand[12966]: plugins/ofono.c:set_network_active()=
 network 0x10d0810, path /huawei0/primarycontext1, active 1
Jun  8 13:47:54 tukki connmand[12966]: src/element.c:connman_element_ref() =
element 0x10d0810 name huawei0_primarycontext1 refcount 4
Jun  8 13:47:54 tukki connmand[12966]: src/network.c:connman_network_set_as=
sociating() network 0x10d0810 associating 1
Jun  8 13:47:54 tukki connmand[12966]: src/service.c:__connman_service_look=
up_from_network() network 0x10d0810
Jun  8 13:47:54 tukki connmand[12966]: src/service.c:__connman_service_indi=
cate_state() service 0x10cf520 state 2
Jun  8 13:47:54 tukki ofonod[12996]: Modem:> AT+CGDCONT=3D1,"IP","internet"=
\r
Jun  8 13:47:54 tukki connmand[12966]: src/profile.c:__connman_profile_chan=
ged() =

Jun  8 13:47:54 tukki connmand[12966]: src/connection.c:find_active_gateway=
() =

Jun  8 13:47:54 tukki connmand[12966]: src/service.c:get_properties() servi=
ce 0x10cf520
Jun  8 13:47:54 tukki connmand[12966]: src/security.c:__connman_security_ch=
eck_privilege() message 0x10cc330
Jun  8 13:47:54 tukki ofonod[12996]: Modem:< \r\nOK\r\n
Jun  8 13:47:54 tukki ofonod[12996]: Modem:> AT+CGDATA=3D"PPP",1\r
Jun  8 13:47:54 tukki ofonod[12996]: Modem:< \r\nCONNECT\r\n

--===============1066332412253798661==--


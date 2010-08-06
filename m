Content-Type: multipart/mixed; boundary="===============2569107472526182656=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH] huawei: Fix SIM state logic
Date: Fri, 06 Aug 2010 09:20:46 +0300
Message-ID: <87lj8kuurl.fsf@potku.valot.fi>
In-Reply-To: <1281032298-30607-2-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2569107472526182656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joao,

Jo=C3=A3o Paulo Rechi Vita <jprvita@profusion.mobi> writes:

> Add support for voice-only SIM cards and enable phonebook atom for
> non-voice modems.

Please use version numbers (v2, v3 etc) in patches to make it clear
what's the latest version. For example, git format-patch has
--subject-prefix which you can use.

I noticed that the patch was already applied, so I tested the current
git with my Huawei E1552. Here are my findings.

Good news is that I didn't see any regressions. I tested with my PIN
unlocked Saunalahti prepaid SIM and had no issues. So the patch is good
from my point of view.

The bad news is that it still doesn't handle PIN locked SIMs properly. I
tested my Elisa SIM which is PIN locked:

1. I plugged in the modem while ofono wasn't running and I didn't get
   any PIN query.

2. Next I restarted ofono and got the PIN query from ofono. I entered
   it, but connman wasn't able to see any data connections from ofono. I
   don't know if this was due to a bug in ofono or in connman.

3. Again I restarted ofono but kept the modem plugged the whole time (so
   that the SIM would be powered on). Now connman saw the data
   connections (for some reason I get two with my Elisa SIM).

I used my PIN query GUI so there's a small chance that bugs in GUI
caused some of the issues.

Here's the log from step 1 above:

Aug  6 08:44:00 tukki kernel: [16033.310107] usb 7-1: new high speed USB de=
vice using ehci_hcd and address 14
Aug  6 08:44:00 tukki kernel: [16033.471353] usb 7-1: New USB device found,=
 idVendor=3D12d1, idProduct=3D1001
Aug  6 08:44:00 tukki kernel: [16033.471364] usb 7-1: New USB device string=
s: Mfr=3D2, Product=3D1, SerialNumber=3D0
Aug  6 08:44:00 tukki kernel: [16033.471372] usb 7-1: Product: HUAWEI Mobile
Aug  6 08:44:00 tukki kernel: [16033.471379] usb 7-1: Manufacturer: HUAWEI =
Technology
Aug  6 08:44:00 tukki kernel: [16033.476711] option 7-1:1.0: GSM modem (1-p=
ort) converter detected
Aug  6 08:44:00 tukki kernel: [16033.477332] usb 7-1: GSM modem (1-port) co=
nverter now attached to ttyUSB0
Aug  6 08:44:00 tukki kernel: [16033.479483] option 7-1:1.1: GSM modem (1-p=
ort) converter detected
Aug  6 08:44:00 tukki kernel: [16033.480019] usb 7-1: GSM modem (1-port) co=
nverter now attached to ttyUSB1
Aug  6 08:44:00 tukki kernel: [16033.480830] option 7-1:1.2: GSM modem (1-p=
ort) converter detected
Aug  6 08:44:00 tukki kernel: [16033.481334] usb 7-1: GSM modem (1-port) co=
nverter now attached to ttyUSB2
Aug  6 08:44:00 tukki kernel: [16033.482870] scsi46 : usb-storage 7-1:1.3
Aug  6 08:44:00 tukki kernel: [16033.484836] scsi47 : usb-storage 7-1:1.4
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:ofono_modem_create() name: =
(null), type: huawei
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:set_modem_property() modem =
0x6cd060 property Path
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:set_modem_property() modem =
0x6cd060 property Registered
Aug  6 08:44:00 tukki ofonod[7543]: plugins/udev.c:add_modem() /devices/pci=
0000:00/0000:00:1d.7/usb7/7-1/7-1:1.0/ttyUSB0/tty/ttyUSB0 (huawei)
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:get_modem_property() modem =
0x6cd060 property ModemRegistered
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:get_modem_property() modem =
0x6cd060 property PcuiRegistered
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:set_modem_property() modem =
0x6cd060 property Modem
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:set_modem_property() modem =
0x6cd060 property ModemRegistered
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:get_modem_property() modem =
0x6cd060 property Path
Aug  6 08:44:00 tukki ofonod[7543]: plugins/udev.c:add_modem() /devices/pci=
0000:00/0000:00:1d.7/usb7/7-1/7-1:1.1/ttyUSB1/tty/ttyUSB1 (huawei)
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:get_modem_property() modem =
0x6cd060 property ModemRegistered
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:get_modem_property() modem =
0x6cd060 property PcuiRegistered
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:get_modem_property() modem =
0x6cd060 property Path
Aug  6 08:44:00 tukki ofonod[7543]: plugins/udev.c:add_modem() /devices/pci=
0000:00/0000:00:1d.7/usb7/7-1/7-1:1.2/ttyUSB2/tty/ttyUSB2 (huawei)
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:get_modem_property() modem =
0x6cd060 property ModemRegistered
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:get_modem_property() modem =
0x6cd060 property PcuiRegistered
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:set_modem_property() modem =
0x6cd060 property Pcui
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:set_modem_property() modem =
0x6cd060 property PcuiRegistered
Aug  6 08:44:00 tukki ofonod[7543]: plugins/huawei.c:huawei_probe() 0x6cd060
Aug  6 08:44:00 tukki ofonod[7543]: plugins/huawei.c:huawei_enable() 0x6cd0=
60
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:get_modem_property() modem =
0x6cd060 property Modem
Aug  6 08:44:00 tukki ofonod[7543]: plugins/huawei.c:open_device() Modem /d=
ev/ttyUSB0
Aug  6 08:44:00 tukki ofonod[7543]: src/modem.c:get_modem_property() modem =
0x6cd060 property Pcui
Aug  6 08:44:00 tukki ofonod[7543]: plugins/huawei.c:open_device() Pcui /de=
v/ttyUSB2
Aug  6 08:44:00 tukki ofonod[7543]: Pcui:> ATE0\r
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:< ATE0\r\r\nOK\r\n
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:> AT+CFUN=3D1\r
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:< \r\nOK\r\n
Aug  6 08:44:01 tukki ofonod[7543]: plugins/huawei.c:cfun_enable() =

Aug  6 08:44:01 tukki ofonod[7543]: plugins/huawei.c:huawei_pre_sim() 0x6cd=
060
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:> AT^SYSINFO\r
Aug  6 08:44:01 tukki ofonod[7543]: src/sim.c:ofono_sim_add_state_watch() 0=
x6cd4a0
Aug  6 08:44:01 tukki ofonod[7543]: src/sim.c:ofono_sim_add_state_watch() 0=
x6cd4a0
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:< \r\n^SYSINFO:0,0,0,0,255,,0\r\n\=
r\nOK\r\n
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:> AT+CGMI\r
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:< \r\nhuawei\r\n\r\nOK\r\n
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:> AT+CGMM\r
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:< \r\nE1552\r\n\r\nOK\r\n
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:> AT+CGMR\r
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:< \r\n11.608.13.02.00\r\n\r\nOK\r\n
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:> AT+CGSN\r
Aug  6 08:44:01 tukki ofonod[7543]: Pcui:< \r\n353143038645652\r\n\r\nOK\r\n
Aug  6 08:44:01 tukki kernel: [16034.489811] scsi 46:0:0:0: CD-ROM         =
   HUAWEI   Mass Storage     2.31 PQ: 0 ANSI: 2
Aug  6 08:44:01 tukki usb-modeswitch: switched to 12d1:1001 (HUAWEI Technol=
ogy: HUAWEI Mobile)
Aug  6 08:44:01 tukki kernel: [16034.494501] scsi 47:0:0:0: Direct-Access  =
   HUAWEI   MMC Storage      2.31 PQ: 0 ANSI: 2
Aug  6 08:44:01 tukki kernel: [16034.514026] sr0: scsi-1 drive
Aug  6 08:44:01 tukki kernel: [16034.516541] sr 46:0:0:0: Attached scsi CD-=
ROM sr0
Aug  6 08:44:01 tukki kernel: [16034.525257] sr 46:0:0:0: Attached scsi gen=
eric sg1 type 5
Aug  6 08:44:01 tukki kernel: [16034.535764] sd 47:0:0:0: Attached scsi gen=
eric sg2 type 0
Aug  6 08:44:01 tukki kernel: [16034.549941] sd 47:0:0:0: [sdb] Attached SC=
SI removable disk
Aug  6 08:44:02 tukki ofonod[7543]: Pcui:< \r\n^STIN:0,0,0\r\n
Aug  6 08:44:02 tukki ofonod[7543]: Pcui:< \r\n^BOOT:38645652,0,0,0,87\r\n
Aug  6 08:44:03 tukki ofonod[7543]: Pcui:< \r\n^SRVST:1\r\n
Aug  6 08:44:03 tukki ofonod[7543]: Pcui:< \r\n^MODE:5,4\r\n
Aug  6 08:44:04 tukki ofonod[7543]: Pcui:< \r\n^RSSI:1\r\n
Aug  6 08:44:10 tukki ofonod[7543]: Pcui:< \r\n^RSSI:0\r\n
Aug  6 08:44:13 tukki ofonod[7543]: Pcui:< \r\n^RSSI:0\r\n
Aug  6 08:44:14 tukki kernel: [16047.278939] ISO 9660 Extensions: Microsoft=
 Joliet Level 1
Aug  6 08:44:14 tukki kernel: [16047.281927] ISOFS: changing to secondary r=
oot
Aug  6 08:44:16 tukki ofonod[7543]: Pcui:< \r\n^RSSI:0\r\n
Aug  6 08:44:19 tukki ofonod[7543]: Pcui:< \r\n^RSSI:0\r\n
Aug  6 08:44:22 tukki ofonod[7543]: Pcui:< \r\n^RSSI:25\r\n
Aug  6 08:44:31 tukki ofonod[7543]: Pcui:< \r\n^RSSI:25\r\n
Aug  6 08:44:32 tukki ofonod[7543]: Pcui:< \r\n^BOOT:38645652,0,0,0,87\r\n
Aug  6 08:44:34 tukki ofonod[7543]: Pcui:< \r\n^RSSI:25\r\n
Aug  6 08:44:40 tukki ofonod[7543]: Pcui:< \r\n^RSSI:25\r\n

Step 2:

Aug  6 08:45:08 tukki ofonod[8260]: oFono version 0.26
Aug  6 08:45:08 tukki ofonod[8260]: src/plugin.c:__ofono_plugin_init() =

Aug  6 08:45:08 tukki ofonod[8260]: src/nettime.c:ofono_nettime_driver_regi=
ster() driver: 0x6b5c40 name: Example Network Time
Aug  6 08:45:08 tukki ofonod[8260]: src/history.c:ofono_history_driver_regi=
ster() driver: 0x6b5bc0 name: Example Call History
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5b20, name: ste
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5a80, name: palmpre
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5840, name: novatel
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b57a0, name: huawei
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5700, name: hso
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5640, name: mbm
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b55a0, name: calypso
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5500, name: wavecom
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5460, name: g1
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b53c0, name: atgen
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5320, name: phonesim
Aug  6 08:45:08 tukki ofonod[8260]: src/voicecall.c:ofono_voicecall_driver_=
register() driver: 0x6b5180, name: stemodem
Aug  6 08:45:08 tukki ofonod[8260]: src/gprs.c:ofono_gprs_context_driver_re=
gister() driver: 0x6b5220, name: stemodem
Aug  6 08:45:08 tukki ofonod[8260]: src/gprs.c:ofono_gprs_context_driver_re=
gister() driver: 0x6b50c0, name: hsomodem
Aug  6 08:45:08 tukki ofonod[8260]: src/radio-settings.c:ofono_radio_settin=
gs_driver_register() driver: 0x6b5100, name: hsomodem
Aug  6 08:45:08 tukki ofonod[8260]: src/gprs.c:ofono_gprs_context_driver_re=
gister() driver: 0x6b4fe0, name: mbm
Aug  6 08:45:08 tukki ofonod[8260]: src/stk.c:ofono_stk_driver_register() d=
river: 0x6b5040, name: mbmmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/voicecall.c:ofono_voicecall_driver_=
register() driver: 0x6b4e20, name: hfpmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/network.c:ofono_netreg_driver_regis=
ter() driver: 0x6b4ec0, name: hfpmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/call-volume.c:ofono_call_volume_dri=
ver_register() driver: 0x6b4f40, name: hfpmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/voicecall.c:ofono_voicecall_driver_=
register() driver: 0x6b4d40, name: calypsomodem
Aug  6 08:45:08 tukki ofonod[8260]: src/radio-settings.c:ofono_radio_settin=
gs_driver_register() driver: 0x6b4cc0, name: nwmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/voicecall.c:ofono_voicecall_driver_=
register() driver: 0x6b49c0, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_devinfo_driver_regist=
er() driver: 0x6b4b40, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/call-barring.c:ofono_call_barring_d=
river_register() driver: 0x6b4a80, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/call-forwarding.c:ofono_call_forwar=
ding_driver_register() driver: 0x6b46a0, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/call-meter.c:ofono_call_meter_drive=
r_register() driver: 0x6b4700, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/call-settings.c:ofono_call_settings=
_driver_register() driver: 0x6b4500, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/phonebook.c:ofono_phonebook_driver_=
register() driver: 0x6b4ac0, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/ssn.c:ofono_ssn_driver_register() d=
river: 0x6b4b10, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/ussd.c:ofono_ussd_driver_register()=
 driver: 0x6b4980, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/sms.c:ofono_sms_driver_register() d=
river: 0x6b45a0, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/sim.c:ofono_sim_driver_register() d=
river: 0x6b4860, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/stk.c:ofono_stk_driver_register() d=
river: 0x6b4920, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/network.c:ofono_netreg_driver_regis=
ter() driver: 0x6b47a0, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/cbs.c:ofono_cbs_driver_register() d=
river: 0x6b4660, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/call-volume.c:ofono_call_volume_dri=
ver_register() driver: 0x6b4b80, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/gprs.c:ofono_gprs_driver_register()=
 driver: 0x6b4be0, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/gprs.c:ofono_gprs_context_driver_re=
gister() driver: 0x6b4c40, name: atmodem
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_devinfo_driver_regist=
er() driver: 0x6b3d40, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/phonebook.c:ofono_phonebook_driver_=
register() driver: 0x6b3d20, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/network.c:ofono_netreg_driver_regis=
ter() driver: 0x6b3d80, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/voicecall.c:ofono_voicecall_driver_=
register() driver: 0x6b3de0, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/sms.c:ofono_sms_driver_register() d=
river: 0x6b3e80, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/cbs.c:ofono_cbs_driver_register() d=
river: 0x6b3ec0, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/sim.c:ofono_sim_driver_register() d=
river: 0x6b3f00, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/ssn.c:ofono_ssn_driver_register() d=
river: 0x6b3f90, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/ussd.c:ofono_ussd_driver_register()=
 driver: 0x6b3fc0, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/call-forwarding.c:ofono_call_forwar=
ding_driver_register() driver: 0x6b4000, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/call-settings.c:ofono_call_settings=
_driver_register() driver: 0x6b4040, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/call-barring.c:ofono_call_barring_d=
river_register() driver: 0x6b40a0, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/call-meter.c:ofono_call_meter_drive=
r_register() driver: 0x6b40e0, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/radio-settings.c:ofono_radio_settin=
gs_driver_register() driver: 0x6b4140, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/gprs.c:ofono_gprs_driver_register()=
 driver: 0x6b4180, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/gprs.c:ofono_gprs_context_driver_re=
gister() driver: 0x6b41c0, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b3cc0, name: isimodem
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:ofono_modem_create() name: =
(null), type: huawei
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:set_modem_property() modem =
0x6cb030 property Path
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:set_modem_property() modem =
0x6cb030 property Registered
Aug  6 08:45:08 tukki ofonod[8260]: plugins/udev.c:add_modem() /devices/pci=
0000:00/0000:00:1d.7/usb7/7-1/7-1:1.0/ttyUSB0/tty/ttyUSB0 (huawei)
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:get_modem_property() modem =
0x6cb030 property ModemRegistered
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:get_modem_property() modem =
0x6cb030 property PcuiRegistered
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:set_modem_property() modem =
0x6cb030 property Modem
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:set_modem_property() modem =
0x6cb030 property ModemRegistered
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:get_modem_property() modem =
0x6cb030 property Path
Aug  6 08:45:08 tukki ofonod[8260]: plugins/udev.c:add_modem() /devices/pci=
0000:00/0000:00:1d.7/usb7/7-1/7-1:1.1/ttyUSB1/tty/ttyUSB1 (huawei)
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:get_modem_property() modem =
0x6cb030 property ModemRegistered
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:get_modem_property() modem =
0x6cb030 property PcuiRegistered
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:get_modem_property() modem =
0x6cb030 property Path
Aug  6 08:45:08 tukki ofonod[8260]: plugins/udev.c:add_modem() /devices/pci=
0000:00/0000:00:1d.7/usb7/7-1/7-1:1.2/ttyUSB2/tty/ttyUSB2 (huawei)
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:get_modem_property() modem =
0x6cb030 property ModemRegistered
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:get_modem_property() modem =
0x6cb030 property PcuiRegistered
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:set_modem_property() modem =
0x6cb030 property Pcui
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:set_modem_property() modem =
0x6cb030 property PcuiRegistered
Aug  6 08:45:08 tukki ofonod[8260]: plugins/huawei.c:huawei_probe() 0x6cb030
Aug  6 08:45:08 tukki ofonod[8260]: plugins/huawei.c:huawei_enable() 0x6cb0=
30
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:get_modem_property() modem =
0x6cb030 property Modem
Aug  6 08:45:08 tukki ofonod[8260]: plugins/huawei.c:open_device() Modem /d=
ev/ttyUSB0
Aug  6 08:45:08 tukki ofonod[8260]: src/modem.c:get_modem_property() modem =
0x6cb030 property Pcui
Aug  6 08:45:08 tukki ofonod[8260]: plugins/huawei.c:open_device() Pcui /de=
v/ttyUSB2
Aug  6 08:45:08 tukki ofonod[8260]: Pcui:> ATE0\r
Aug  6 08:45:08 tukki connmand[3713]: Operation already in progress
Aug  6 08:45:08 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:08 tukki ofonod[8260]: Pcui:> AT+CFUN=3D1\r
Aug  6 08:45:08 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:08 tukki ofonod[8260]: plugins/huawei.c:cfun_enable() =

Aug  6 08:45:08 tukki ofonod[8260]: plugins/huawei.c:huawei_pre_sim() 0x6cb=
030
Aug  6 08:45:08 tukki ofonod[8260]: Pcui:> AT^SYSINFO\r
Aug  6 08:45:08 tukki ofonod[8260]: src/sim.c:ofono_sim_add_state_watch() 0=
x6c76a0
Aug  6 08:45:08 tukki ofonod[8260]: src/sim.c:ofono_sim_add_state_watch() 0=
x6c76a0
Aug  6 08:45:08 tukki ofonod[8260]: Pcui:< \r\n^SYSINFO:0,0,0,0,0,,0\r\n\r\=
nOK\r\n
Aug  6 08:45:08 tukki ofonod[8260]: Pcui:> AT+CGMI\r
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:< \r\nhuawei\r\n\r\nOK\r\n
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:> AT+CRSM=3D176,28590,0,0,1\r
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:< \r\n+CME ERROR: SIM PIN required=
\r\n
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:> AT+CGMM\r
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:< \r\nE1552\r\n\r\nOK\r\n
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:> AT+CPIN?\r
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:< \r\n+CPIN: SIM PIN\r\n\r\nOK\r\n
Aug  6 08:45:09 tukki ofonod[8260]: drivers/atmodem/sim.c:at_cpin_cb() crsm=
_pin_cb: SIM PIN
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:> AT+CRSM=3D192,12258\r
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:< \r\n+CME ERROR: SIM PIN required=
\r\n
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:> AT+CGMR\r
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:< \r\n11.608.13.02.00\r\n\r\nOK\r\n
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:> AT+CRSM=3D192,28421\r
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:< \r\n+CME ERROR: SIM PIN required=
\r\n
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:> AT+CGSN\r
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:< \r\n353143038645652\r\n\r\nOK\r\n
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:> AT+CRSM=3D192,12037\r
Aug  6 08:45:09 tukki ofonod[8260]: Pcui:< \r\n+CME ERROR: SIM PIN required=
\r\n
Aug  6 08:45:10 tukki ofonod[8260]: Pcui:< \r\n^RSSI:27\r\n\r\n^SRVST:1\r\n=
\r\n^MODE:5,4\r\n
Aug  6 08:45:12 tukki ofonod[8260]: Pcui:< \r\n^RSSI:3\r\n
Aug  6 08:45:15 tukki ofonod[8260]: Pcui:< \r\n^RSSI:3\r\n
Aug  6 08:45:18 tukki ofonod[8260]: Pcui:< \r\n^RSSI:23\r\n
Aug  6 08:45:20 tukki ofonod[8260]: Pcui:> AT+CPIN=3D"<kvaloremovedpin>"\r
Aug  6 08:45:21 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:21 tukki ofonod[8260]: Pcui:> AT+CPIN?\r
Aug  6 08:45:21 tukki ofonod[8260]: Pcui:< \r\n+CPIN: READY\r\n\r\nOK\r\n
Aug  6 08:45:21 tukki ofonod[8260]: drivers/atmodem/sim.c:at_cpin_cb() crsm=
_pin_cb: READY
Aug  6 08:45:21 tukki ofonod[8260]: Pcui:> AT+CIMI\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\n<kvaloremoved>\r\n\r\nOK\r\n
Aug  6 08:45:22 tukki ofonod[8260]: drivers/atmodem/sim.c:at_cimi_cb() cimi=
_cb: <kvaloremoved>
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CRSM=3D192,28438\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\n+CRSM: 106,130,""\r\n\r\nOK\=
r\n
Aug  6 08:45:22 tukki ofonod[8260]: plugins/huawei.c:huawei_post_sim() 0x6c=
b030
Aug  6 08:45:22 tukki ofonod[8260]: Example History Probe for modem: 0x6cb0=
30
Aug  6 08:45:22 tukki ofonod[8260]: Example Network Time Probe for modem: 0=
x6cb030
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CREG=3D?\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\n+CREG: (0-2)\r\n\r\nOK\r\n
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CSMS=3D?\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\n+CSMS: (0-1)\r\n\r\nOK\r\n
Aug  6 08:45:22 tukki ofonod[8260]: drivers/atmodem/sms.c:at_csms_query_cb(=
) CSMS query parsed successfully
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CSCB=3D?\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\n+CSCB: (0-1)\r\n\r\nOK\r\n
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CUSD=3D1\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CSCS=3D?\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\n+CSCS: ("IRA","GSM","UCS2")\=
r\n\r\nOK\r\n
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CRSM=3D192,28480\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:45:22 tukki ofonod[8260]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CREG=3D2\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CSMS=3D1\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CSCB=3D1,"0-65535"\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\n+CMS ERROR: 500\r\n
Aug  6 08:45:22 tukki ofonod[8260]: src/cbs.c:cbs_got_imsi() Got IMSI: 2440=
52260426298
Aug  6 08:45:22 tukki ofonod[8260]: src/network.c:__ofono_netreg_add_status=
_watch() 0x6cb1f0
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CPBS=3D?\r
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:< \r\n+CME ERROR: SIM busy\r\n
Aug  6 08:45:22 tukki ofonod[8260]: Phonebook not supported by this modem. =
 If this is in error please submit patches to support this hardware
Aug  6 08:45:22 tukki ofonod[8260]: src/phonebook.c:phonebook_remove() atom=
: 0x6cb900
Aug  6 08:45:22 tukki ofonod[8260]: Pcui:> AT+CRSM=3D192,28589\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n^SIMST:1\r\n\r\n^SRVST:2\r\n=
\r\n+CREG: 1,5AA,3519\r\n
Aug  6 08:45:23 tukki ofonod[8260]: src/cbs.c:cbs_location_changed() 1, 145=
0, 13593, -1, (null)(null)
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CREG?\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+CREG: 2,1,5AA,3519\r\n\r\nO=
K\r\n
Aug  6 08:45:23 tukki ofonod[8260]: src/cbs.c:cbs_location_changed() 1, 145=
0, 13593, -1, (null)(null)
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CSMS?\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+CSMS: ,1,1,1\r\n\r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+COPS=3D3,2\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+COPS?\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+COPS: 0,2,"24405",2\r\n\r\n=
OK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: drivers/atmodem/network-registration.c:=
cops_numeric_cb() Cops numeric got mcc: 244, mnc: 05
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CRSM=3D192,28489\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+COPS=3D3,2\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+COPS?\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+COPS: 0,2,"24405",2\r\n\r\n=
OK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: drivers/atmodem/network-registration.c:=
cops_numeric_cb() Cops numeric got mcc: 244, mnc: 05
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CSQ\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+CSQ: 3,99\r\n\r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: drivers/atmodem/network-registration.c:=
csq_cb() csq_cb: 3
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CMGF=3D?\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+CMGF: (0-1)\r\n\r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+COPS=3D3,0\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+COPS?\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+COPS: 0,0,"elisa",2\r\n\r\n=
OK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: drivers/atmodem/network-registration.c:=
cops_cb() cops_cb: elisa, 244 05 2
Aug  6 08:45:23 tukki ofonod[8260]: src/network.c:current_operator_callback=
() 0x6cb1f0, (nil)
Aug  6 08:45:23 tukki ofonod[8260]: src/cbs.c:cbs_location_changed() 1, 145=
0, 13593, -1, 24405
Aug  6 08:45:23 tukki ofonod[8260]: src/cbs.c:cbs_location_changed() 1, 0, 0
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CRSM=3D192,28613\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+COPS=3D3,0\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+COPS?\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+COPS: 0,0,"elisa",2\r\n\r\n=
OK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: drivers/atmodem/network-registration.c:=
cops_cb() cops_cb: elisa, 244 05 2
Aug  6 08:45:23 tukki ofonod[8260]: src/network.c:current_operator_callback=
() 0x6cb1f0, 0x6cd240
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CPMS=3D?\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+CPMS: ("ME","MT","SM","SR")=
,("ME","MT","SM","SR"),("ME","MT","SM","SR")\r\n\r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CRSM=3D192,28488\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CMGF=3D0\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CSCB=3D1\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+CMS ERROR: 500\r\n
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CSCB=3D0,"4352-4356"\r
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:< \r\n+CMS ERROR: 500\r\n
Aug  6 08:45:23 tukki ofonod[8260]: Setting Cell Broadcast topics failed
Aug  6 08:45:23 tukki ofonod[8260]: Pcui:> AT+CRSM=3D192,28621\r
Aug  6 08:45:24 tukki ofonod[8260]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:45:24 tukki ofonod[8260]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:45:24 tukki ofonod[8260]: Pcui:> AT+CPMS=3D"ME","ME","ME"\r
Aug  6 08:45:24 tukki ofonod[8260]: Pcui:< \r\n+CMS ERROR: 500\r\n
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:> AT+CPMS=3D"ME","ME","ME"\r
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:< \r\n+CMS ERROR: 500\r\n
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:< \r\n^RSSI:3\r\n
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:< \r\n+CREG: 1,5AA,3519\r\n
Aug  6 08:45:25 tukki ofonod[8260]: src/cbs.c:cbs_location_changed() 1, 145=
0, 13593, -1, 24405
Aug  6 08:45:25 tukki ofonod[8260]: src/cbs.c:cbs_location_changed() 0, 1, 0
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:> AT+COPS=3D3,2\r
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:> AT+COPS?\r
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:< \r\n+COPS: 0,2,"24405",2\r\n\r\n=
OK\r\n
Aug  6 08:45:25 tukki ofonod[8260]: drivers/atmodem/network-registration.c:=
cops_numeric_cb() Cops numeric got mcc: 244, mnc: 05
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:> AT+COPS=3D3,0\r
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:> AT+COPS?\r
Aug  6 08:45:25 tukki ofonod[8260]: Pcui:< \r\n+COPS: 0,0,"elisa",2\r\n\r\n=
OK\r\n
Aug  6 08:45:25 tukki ofonod[8260]: drivers/atmodem/network-registration.c:=
cops_cb() cops_cb: elisa, 244 05 2
Aug  6 08:45:25 tukki ofonod[8260]: src/network.c:current_operator_callback=
() 0x6cb1f0, 0x6cd240
Aug  6 08:45:26 tukki ofonod[8260]: Pcui:> AT+CPMS=3D"ME","ME","ME"\r
Aug  6 08:45:26 tukki ofonod[8260]: Pcui:< \r\n+CPMS: 0,23,0,23,0,23\r\n\r\=
nOK\r\n
Aug  6 08:45:26 tukki ofonod[8260]: Pcui:> AT+CNMI=3D?\r
Aug  6 08:45:26 tukki ofonod[8260]: Pcui:< \r\n+CNMI: (0,1,2),(0,1,2,3),(0,=
2),(0,1,2),(0,1)\r\n\r\nOK\r\n
Aug  6 08:45:26 tukki ofonod[8260]: Pcui:> AT+CNMI=3D1,1,2,1,0\r
Aug  6 08:45:26 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:26 tukki ofonod[8260]: Pcui:> AT+CMGL=3D4\r
Aug  6 08:45:26 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:26 tukki ofonod[8260]: Pcui:> AT+CGSMS=3D3\r
Aug  6 08:45:26 tukki ofonod[8260]: Pcui:< \r\nOK\r\n
Aug  6 08:45:28 tukki ofonod[8260]: Pcui:< \r\n^RSSI:3\r\n
Aug  6 08:45:31 tukki ofonod[8260]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:45:32 tukki ofonod[8260]: Pcui:< \r\n^BOOT:38645652,0,0,0,87\r\n
Aug  6 08:45:34 tukki ofonod[8260]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:45:45 tukki ofonod[8260]: last message repeated 2 times

Step 3:

Aug  6 08:46:30 tukki ofonod[8264]: oFono version 0.26
Aug  6 08:46:30 tukki ofonod[8264]: src/plugin.c:__ofono_plugin_init() =

Aug  6 08:46:30 tukki ofonod[8264]: src/nettime.c:ofono_nettime_driver_regi=
ster() driver: 0x6b5c40 name: Example Network Time
Aug  6 08:46:30 tukki ofonod[8264]: src/history.c:ofono_history_driver_regi=
ster() driver: 0x6b5bc0 name: Example Call History
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5b20, name: ste
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5a80, name: palmpre
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5840, name: novatel
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b57a0, name: huawei
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5700, name: hso
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5640, name: mbm
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b55a0, name: calypso
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5500, name: wavecom
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5460, name: g1
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b53c0, name: atgen
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b5320, name: phonesim
Aug  6 08:46:30 tukki ofonod[8264]: src/voicecall.c:ofono_voicecall_driver_=
register() driver: 0x6b5180, name: stemodem
Aug  6 08:46:30 tukki ofonod[8264]: src/gprs.c:ofono_gprs_context_driver_re=
gister() driver: 0x6b5220, name: stemodem
Aug  6 08:46:30 tukki ofonod[8264]: src/gprs.c:ofono_gprs_context_driver_re=
gister() driver: 0x6b50c0, name: hsomodem
Aug  6 08:46:30 tukki ofonod[8264]: src/radio-settings.c:ofono_radio_settin=
gs_driver_register() driver: 0x6b5100, name: hsomodem
Aug  6 08:46:30 tukki ofonod[8264]: src/gprs.c:ofono_gprs_context_driver_re=
gister() driver: 0x6b4fe0, name: mbm
Aug  6 08:46:30 tukki ofonod[8264]: src/stk.c:ofono_stk_driver_register() d=
river: 0x6b5040, name: mbmmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/voicecall.c:ofono_voicecall_driver_=
register() driver: 0x6b4e20, name: hfpmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/network.c:ofono_netreg_driver_regis=
ter() driver: 0x6b4ec0, name: hfpmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/call-volume.c:ofono_call_volume_dri=
ver_register() driver: 0x6b4f40, name: hfpmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/voicecall.c:ofono_voicecall_driver_=
register() driver: 0x6b4d40, name: calypsomodem
Aug  6 08:46:30 tukki ofonod[8264]: src/radio-settings.c:ofono_radio_settin=
gs_driver_register() driver: 0x6b4cc0, name: nwmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/voicecall.c:ofono_voicecall_driver_=
register() driver: 0x6b49c0, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_devinfo_driver_regist=
er() driver: 0x6b4b40, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/call-barring.c:ofono_call_barring_d=
river_register() driver: 0x6b4a80, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/call-forwarding.c:ofono_call_forwar=
ding_driver_register() driver: 0x6b46a0, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/call-meter.c:ofono_call_meter_drive=
r_register() driver: 0x6b4700, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/call-settings.c:ofono_call_settings=
_driver_register() driver: 0x6b4500, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/phonebook.c:ofono_phonebook_driver_=
register() driver: 0x6b4ac0, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/ssn.c:ofono_ssn_driver_register() d=
river: 0x6b4b10, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/ussd.c:ofono_ussd_driver_register()=
 driver: 0x6b4980, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/sms.c:ofono_sms_driver_register() d=
river: 0x6b45a0, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/sim.c:ofono_sim_driver_register() d=
river: 0x6b4860, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/stk.c:ofono_stk_driver_register() d=
river: 0x6b4920, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/network.c:ofono_netreg_driver_regis=
ter() driver: 0x6b47a0, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/cbs.c:ofono_cbs_driver_register() d=
river: 0x6b4660, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/call-volume.c:ofono_call_volume_dri=
ver_register() driver: 0x6b4b80, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/gprs.c:ofono_gprs_driver_register()=
 driver: 0x6b4be0, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/gprs.c:ofono_gprs_context_driver_re=
gister() driver: 0x6b4c40, name: atmodem
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_devinfo_driver_regist=
er() driver: 0x6b3d40, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/phonebook.c:ofono_phonebook_driver_=
register() driver: 0x6b3d20, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/network.c:ofono_netreg_driver_regis=
ter() driver: 0x6b3d80, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/voicecall.c:ofono_voicecall_driver_=
register() driver: 0x6b3de0, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/sms.c:ofono_sms_driver_register() d=
river: 0x6b3e80, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/cbs.c:ofono_cbs_driver_register() d=
river: 0x6b3ec0, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/sim.c:ofono_sim_driver_register() d=
river: 0x6b3f00, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/ssn.c:ofono_ssn_driver_register() d=
river: 0x6b3f90, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/ussd.c:ofono_ussd_driver_register()=
 driver: 0x6b3fc0, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/call-forwarding.c:ofono_call_forwar=
ding_driver_register() driver: 0x6b4000, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/call-settings.c:ofono_call_settings=
_driver_register() driver: 0x6b4040, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/call-barring.c:ofono_call_barring_d=
river_register() driver: 0x6b40a0, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/call-meter.c:ofono_call_meter_drive=
r_register() driver: 0x6b40e0, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/radio-settings.c:ofono_radio_settin=
gs_driver_register() driver: 0x6b4140, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/gprs.c:ofono_gprs_driver_register()=
 driver: 0x6b4180, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/gprs.c:ofono_gprs_context_driver_re=
gister() driver: 0x6b41c0, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_driver_register=
() driver: 0x6b3cc0, name: isimodem
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:ofono_modem_create() name: =
(null), type: huawei
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:set_modem_property() modem =
0x6cb030 property Path
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:set_modem_property() modem =
0x6cb030 property Registered
Aug  6 08:46:30 tukki ofonod[8264]: plugins/udev.c:add_modem() /devices/pci=
0000:00/0000:00:1d.7/usb7/7-1/7-1:1.0/ttyUSB0/tty/ttyUSB0 (huawei)
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:get_modem_property() modem =
0x6cb030 property ModemRegistered
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:get_modem_property() modem =
0x6cb030 property PcuiRegistered
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:set_modem_property() modem =
0x6cb030 property Modem
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:set_modem_property() modem =
0x6cb030 property ModemRegistered
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:get_modem_property() modem =
0x6cb030 property Path
Aug  6 08:46:30 tukki ofonod[8264]: plugins/udev.c:add_modem() /devices/pci=
0000:00/0000:00:1d.7/usb7/7-1/7-1:1.1/ttyUSB1/tty/ttyUSB1 (huawei)
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:get_modem_property() modem =
0x6cb030 property ModemRegistered
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:get_modem_property() modem =
0x6cb030 property PcuiRegistered
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:get_modem_property() modem =
0x6cb030 property Path
Aug  6 08:46:30 tukki ofonod[8264]: plugins/udev.c:add_modem() /devices/pci=
0000:00/0000:00:1d.7/usb7/7-1/7-1:1.2/ttyUSB2/tty/ttyUSB2 (huawei)
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:get_modem_property() modem =
0x6cb030 property ModemRegistered
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:get_modem_property() modem =
0x6cb030 property PcuiRegistered
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:set_modem_property() modem =
0x6cb030 property Pcui
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:set_modem_property() modem =
0x6cb030 property PcuiRegistered
Aug  6 08:46:30 tukki ofonod[8264]: plugins/huawei.c:huawei_probe() 0x6cb030
Aug  6 08:46:30 tukki ofonod[8264]: plugins/huawei.c:huawei_enable() 0x6cb0=
30
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:get_modem_property() modem =
0x6cb030 property Modem
Aug  6 08:46:30 tukki ofonod[8264]: plugins/huawei.c:open_device() Modem /d=
ev/ttyUSB0
Aug  6 08:46:30 tukki ofonod[8264]: src/modem.c:get_modem_property() modem =
0x6cb030 property Pcui
Aug  6 08:46:30 tukki ofonod[8264]: plugins/huawei.c:open_device() Pcui /de=
v/ttyUSB2
Aug  6 08:46:30 tukki ofonod[8264]: Pcui:> ATE0\r
Aug  6 08:46:30 tukki connmand[3713]: Operation already in progress
Aug  6 08:46:30 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:30 tukki ofonod[8264]: Pcui:> AT+CFUN=3D1\r
Aug  6 08:46:30 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:30 tukki ofonod[8264]: plugins/huawei.c:cfun_enable() =

Aug  6 08:46:30 tukki ofonod[8264]: plugins/huawei.c:huawei_pre_sim() 0x6cb=
030
Aug  6 08:46:30 tukki ofonod[8264]: Pcui:> AT^SYSINFO\r
Aug  6 08:46:30 tukki ofonod[8264]: src/sim.c:ofono_sim_add_state_watch() 0=
x6c76a0
Aug  6 08:46:30 tukki ofonod[8264]: src/sim.c:ofono_sim_add_state_watch() 0=
x6c76a0
Aug  6 08:46:30 tukki ofonod[8264]: Pcui:< \r\n^SYSINFO:0,3,0,0,1,,0\r\n\r\=
nOK\r\n
Aug  6 08:46:30 tukki ofonod[8264]: Pcui:> AT+CGMI\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\nhuawei\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CRSM=3D176,28590,0,0,1\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CRSM: 106,130,""\r\n\r\nOK\=
r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CGMM\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\nE1552\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CPIN?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CPIN: READY\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/sim.c:at_cpin_cb() crsm=
_pin_cb: READY
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CRSM=3D192,12258\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CGMR\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n11.608.13.02.00\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CIMI\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n<kvaloremoved>\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/sim.c:at_cimi_cb() cimi=
_cb: <kvaloremoved>
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CRSM=3D192,28421\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CGSN\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n353143038645652\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CRSM=3D192,12037\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CRSM=3D192,28438\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CRSM: 106,130,""\r\n\r\nOK\=
r\n
Aug  6 08:46:31 tukki ofonod[8264]: plugins/huawei.c:huawei_post_sim() 0x6c=
b030
Aug  6 08:46:31 tukki ofonod[8264]: src/modem.c:get_modem_property() modem =
0x6cb030 property HasVoice
Aug  6 08:46:31 tukki ofonod[8264]: Example History Probe for modem: 0x6cb0=
30
Aug  6 08:46:31 tukki ofonod[8264]: Example Network Time Probe for modem: 0=
x6cb030
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CREG=3D?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CREG: (0-2)\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CSMS=3D?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CSMS: (0-1)\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/sms.c:at_csms_query_cb(=
) CSMS query parsed successfully
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CSCB=3D?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CSCB: (0-1)\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CUSD=3D1\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CSCS=3D?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CSCS: ("IRA","GSM","UCS2")\=
r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CGDCONT=3D?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CGDCONT: (1-16),"IP",,,(0-2=
),(0-3)\r\n+CGDCONT: (1-16),"PPP",,,(0-2),(0-3)\r\n+CGDCONT: (1-16),"IPV6",=
,,(0-2),(0-3)\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CRSM=3D192,28480\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n^SRVST:1\r\n\r\n+CREG: 2,5AA=
,5578\r\n\r\n^SRVST:2\r\n\r\n+CREG: 1,5AA,5578\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CREG=3D2\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CSMS=3D1\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CSCB=3D1,"0-65535"\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: src/cbs.c:cbs_got_imsi() Got IMSI: 2440=
52260426298
Aug  6 08:46:31 tukki ofonod[8264]: src/network.c:__ofono_netreg_add_status=
_watch() 0x6ca7f0
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CPBS=3D?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CPBS: ("SM","EN","ON")\r\n\=
r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CGREG=3D?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CRSM=3D192,28589\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CREG?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CREG: 2,1,5AA,5578\r\n\r\nO=
K\r\n
Aug  6 08:46:31 tukki ofonod[8264]: src/cbs.c:cbs_location_changed() 1, 145=
0, 21880, -1, (null)(null)
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CSMS?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CSMS: ,1,1,1\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CGREG=3D2\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CGAUTO=3D0\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\nERROR\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CGEREP=3D2,1\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: src/network.c:__ofono_netreg_add_status=
_watch() 0x6ca7f0
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CRSM=3D192,28489\r
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:connman_device_create() =
node 244052260426298 type 5
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:connman_device_create() =
device 0x7f156eec8840
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:__connman_element_initi=
alize() element 0x7f156eec8840
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Type type 115 value 0x7fff37722248
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:connman_device_set_strin=
g() device 0x7f156eec8840 key Path value /huawei0
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Path type 115 value 0x7fff37722268
Aug  6 08:46:31 tukki connmand[3713]: src/storage.c:__connman_storage_load_=
device() device 0x7f156eec8840
Aug  6 08:46:31 tukki connmand[3713]: src/profile.c:__connman_profile_activ=
e_ident() =

Aug  6 08:46:31 tukki connmand[3713]: src/device.c:device_load() device 0x7=
f156eec8840
Aug  6 08:46:31 tukki connmand[3713]: src/storage.c:__connman_storage_open(=
) ident default suffix profile
Aug  6 08:46:31 tukki connmand[3713]: src/storage.c:__connman_storage_open(=
) keyfile 0x7f156eedb540
Aug  6 08:46:31 tukki connmand[3713]: src/storage.c:__connman_storage_close=
() ident default suffix profile keyfile 0x7f156eedb540 save 0
Aug  6 08:46:31 tukki connmand[3713]: src/profile.c:__connman_profile_get_o=
fflinemode() offlinemode 0
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:connman_element_registe=
r() element 0x7f156eec8840 name 244052260426298 parent (nil)
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:connman_element_ref() e=
lement 0x7f156eec8840 name 244052260426298 refcount 2
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:register_element() elem=
ent 0x7f156eec8840 path /org/moblin/connman/device/244052260426298
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:probe_element() element=
 0x7f156eec8840 name 244052260426298
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:probe_element() driver =
0x7f156d531ce0 name device
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:device_probe() element 0=
x7f156eec8840 name 244052260426298
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:device_probe() driver 0x=
7f156b5b22e0 name modem
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:setup_device() device 0x=
7f156eec8840
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:register_interface() ele=
ment 0x7f156eec8840 name 244052260426298
Aug  6 08:46:31 tukki connmand[3713]: src/technology.c:__connman_technology=
_add_device() device 0x7f156eec8840
Aug  6 08:46:31 tukki connmand[3713]: src/notifier.c:__connman_notifier_reg=
ister() type 6
Aug  6 08:46:31 tukki connmand[3713]: src/notifier.c:technology_registered(=
) type 6 registered 1
Aug  6 08:46:31 tukki connmand[3713]: src/technology.c:technology_get() typ=
e 6
Aug  6 08:46:31 tukki connmand[3713]: src/technology.c:technology_find() ty=
pe 6
Aug  6 08:46:31 tukki connmand[3713]: src/technology.c:technology_get() dri=
ver 0x7f156bbbf2a0 name bluetooth
Aug  6 08:46:31 tukki connmand[3713]: src/technology.c:technology_get() tec=
hnology 0x7f156eebdff0
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:__connman_device_enable(=
) device 0x7f156eec8840
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:connman_device_get_strin=
g() device 0x7f156eec8840 key Path
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:connman_device_get_strin=
g() device 0x7f156eec8840 key Path
Aug  6 08:46:31 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:connman_device_set_power=
ed() driver 0x7f156eec8840 powered 1
Aug  6 08:46:31 tukki connmand[3713]: src/device.c:__connman_device_enable(=
) device 0x7f156eec8840
Aug  6 08:46:31 tukki connmand[3713]: src/technology.c:__connman_technology=
_enable_device() device 0x7f156eec8840
Aug  6 08:46:31 tukki connmand[3713]: src/notifier.c:__connman_notifier_ena=
ble() type 6
Aug  6 08:46:31 tukki connmand[3713]: src/notifier.c:technology_enabled() t=
ype 6 enabled 1
Aug  6 08:46:31 tukki connmand[3713]: src/manager.c:technology_notify() typ=
e 6 enabled 1
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+COPS=3D3,2\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+COPS?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+COPS: 0,2,"24405",2\r\n\r\n=
OK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/network-registration.c:=
cops_numeric_cb() Cops numeric got mcc: 244, mnc: 05
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CSQ\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CSQ: 23,99\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/network-registration.c:=
csq_cb() csq_cb: 23
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CMGF=3D?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CMGF: (0-1)\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CGATT=3D1\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n^SRVST:1\r\n\r\n+CREG: 2,5AA=
,5578\r\n\r\n+CGREG: 2,5AA,5578\r\n\r\n^SRVST:2\r\n\r\n+CREG: 1,5AA,5578\r\=
n\r\n+CGREG: 0,5AA,5578\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: src/network.c:current_operator_callback=
() 0x6ca7f0, (nil)
Aug  6 08:46:31 tukki ofonod[8264]: src/gprs.c:netreg_status_changed() 2
Aug  6 08:46:31 tukki ofonod[8264]: src/cbs.c:cbs_location_changed() 2, 145=
0, 21880, -1, (null)(null)
Aug  6 08:46:31 tukki ofonod[8264]: src/gprs.c:netreg_status_changed() 1
Aug  6 08:46:31 tukki ofonod[8264]: src/cbs.c:cbs_location_changed() 1, 145=
0, 21880, -1, (null)(null)
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CRSM=3D192,28613\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+COPS=3D3,0\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+COPS?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+COPS: 0,0,"elisa",2\r\n\r\n=
OK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/network-registration.c:=
cops_cb() cops_cb: elisa, 244 05 2
Aug  6 08:46:31 tukki ofonod[8264]: src/network.c:current_operator_callback=
() 0x6ca7f0, (nil)
Aug  6 08:46:31 tukki ofonod[8264]: src/gprs.c:netreg_status_changed() 1
Aug  6 08:46:31 tukki ofonod[8264]: src/cbs.c:cbs_location_changed() 1, 145=
0, 21880, -1, 24405
Aug  6 08:46:31 tukki ofonod[8264]: src/cbs.c:cbs_location_changed() 1, 0, 0
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CPMS=3D?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CPMS: ("ME","MT","SM","SR")=
,("ME","MT","SM","SR"),("ME","MT","SM","SR")\r\n\r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+COPS=3D3,2\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+COPS?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+COPS: 0,2,"24405",2\r\n\r\n=
OK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: drivers/atmodem/network-registration.c:=
cops_numeric_cb() Cops numeric got mcc: 244, mnc: 05
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CGREG?\r
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:< \r\n+CGREG: 2,0,5AA,5578\r\n\r\n=
OK\r\n
Aug  6 08:46:31 tukki ofonod[8264]: Pcui:> AT+CRSM=3D192,28488\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:46:32 tukki ofonod[8264]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:> AT+CMGF=3D0\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:> AT+COPS=3D3,0\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:> AT+COPS?\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\n+COPS: 0,0,"elisa",2\r\n\r\n=
OK\r\n
Aug  6 08:46:32 tukki ofonod[8264]: drivers/atmodem/network-registration.c:=
cops_cb() cops_cb: elisa, 244 05 2
Aug  6 08:46:32 tukki ofonod[8264]: src/network.c:current_operator_callback=
() 0x6ca7f0, 0x6ceb40
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:> AT+CSCB=3D1\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\n^BOOT:38645652,0,0,0,87\r\n
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:> AT+CSCB=3D0,"4352-4356"\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:> AT+CRSM=3D192,28621\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
Aug  6 08:46:32 tukki ofonod[8264]: drivers/atmodem/sim.c:at_crsm_info_cb()=
 crsm_info_cb: 90, 00, 0
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:> AT+CPMS=3D"ME","ME","ME"\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\n+CPMS: 0,23,0,23,0,23\r\n\r\=
nOK\r\n
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:> AT+CNMI=3D?\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\n+CNMI: (0,1,2),(0,1,2,3),(0,=
2),(0,1,2),(0,1)\r\n\r\nOK\r\n
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:> AT+CNMI=3D1,1,2,1,0\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:> AT+CMGL=3D4\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:> AT+CGSMS=3D3\r
Aug  6 08:46:32 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:34 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:46:34 tukki ofonod[8264]: Pcui:< \r\n+CREG: 1,5AA,5578\r\n\r\n+CG=
REG: 1,5AA,5578\r\n
Aug  6 08:46:34 tukki ofonod[8264]: src/gprs.c:netreg_status_changed() 1
Aug  6 08:46:34 tukki ofonod[8264]: src/cbs.c:cbs_location_changed() 1, 145=
0, 21880, -1, 24405
Aug  6 08:46:34 tukki ofonod[8264]: src/cbs.c:cbs_location_changed() 0, 1, 0
Aug  6 08:46:34 tukki ofonod[8264]: Pcui:> AT+COPS=3D3,2\r
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_get_strin=
g() device 0x7f156eec8840 key Path
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_set_power=
ed() driver 0x7f156eec8840 powered 1
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_get_netwo=
rk() device 0x7f156eec8840 identifier /huawei0/primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_create(=
) identifier primarycontext1 type 10
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_create(=
) network 0x7f156eee8600
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:__connman_element_initi=
alize() element 0x7f156eee8600
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Type type 115 value 0x7fff37722178
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Strength type 121 value 0x7fff3772217c
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_set_str=
ing() network 0x7f156eee8600 key Path value /huawei0/primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Path type 115 value 0x7fff37722188
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_set_ava=
ilable() network 0x7f156eee8600 available 1
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_get_strin=
g() device 0x7f156eec8840 key MCC
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeba060 name (null)
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_get_strin=
g() device 0x7f156eec8840 key MNC
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeba060 name (null)
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_add_netwo=
rk() device 0x7f156eec8840 network 0x7f156eee8600
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:connman_element_registe=
r() element 0x7f156eee8600 name primarycontext1 parent 0x7f156eec8840
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:connman_element_ref() e=
lement 0x7f156eee8600 name primarycontext1 refcount 2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:register_element() elem=
ent 0x7f156eee8600 path /org/moblin/connman/device/244052260426298/primaryc=
ontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:probe_element() element=
 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:probe_element() driver =
0x7f156d531e60 name network
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:network_probe() element=
 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:network_probe() driver =
0x7f156b5b2320 name network
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Path
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:register_interface() el=
ement 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:__connman_element_list(=
) =

Aug  6 08:46:34 tukki connmand[3713]: src/element.c:append_path() element 0=
x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:append_path() element 0=
x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_get_netwo=
rk() device 0x7f156eec8840 identifier /huawei0/primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_create(=
) identifier primarycontext2 type 10
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_create(=
) network 0x7f156eeeccd0
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:__connman_element_initi=
alize() element 0x7f156eeeccd0
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Type type 115 value 0x7fff37722178
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:34 tukki ofonod[8264]: Pcui:> AT+COPS?\r
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Strength type 121 value 0x7fff3772217c
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_set_str=
ing() network 0x7f156eeeccd0 key Path value /huawei0/primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Path type 115 value 0x7fff37722188
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_set_ava=
ilable() network 0x7f156eeeccd0 available 1
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eeeccd0
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_get_strin=
g() device 0x7f156eec8840 key MCC
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeba060 name (null)
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_get_strin=
g() device 0x7f156eec8840 key MNC
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeba060 name (null)
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_add_netwo=
rk() device 0x7f156eec8840 network 0x7f156eeeccd0
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:connman_element_registe=
r() element 0x7f156eeeccd0 name primarycontext2 parent 0x7f156eec8840
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:connman_element_ref() e=
lement 0x7f156eeeccd0 name primarycontext2 refcount 2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:register_element() elem=
ent 0x7f156eeeccd0 path /org/moblin/connman/device/244052260426298/primaryc=
ontext2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:probe_element() element=
 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:probe_element() driver =
0x7f156d531e60 name network
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:network_probe() element=
 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:network_probe() driver =
0x7f156b5b2320 name network
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eeeccd0 key Path
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:register_interface() el=
ement 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:__connman_element_list(=
) =

Aug  6 08:46:34 tukki connmand[3713]: src/element.c:append_path() element 0=
x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki ofonod[8264]: Pcui:< \r\n+COPS: 0,2,"24405",2\r\n\r\n=
OK\r\n
Aug  6 08:46:34 tukki ofonod[8264]: drivers/atmodem/network-registration.c:=
cops_numeric_cb() Cops numeric got mcc: 244, mnc: 05
Aug  6 08:46:34 tukki ofonod[8264]: Pcui:> AT+COPS=3D3,0\r
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:append_path() element 0=
x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:append_path() element 0=
x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_get_strin=
g() device 0x7f156eec8840 key Path
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/device.c:connman_device_get_strin=
g() device 0x7f156eec8840 key Path
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki ofonod[8264]: Pcui:< \r\nOK\r\n
Aug  6 08:46:34 tukki ofonod[8264]: Pcui:> AT+COPS?\r
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_set_roa=
ming() network 0x7f156eee8600 roaming 0
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_set_nam=
e() network 0x7f156eee8600 name elisa
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Name type 115 value 0x7fff37722298
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Path
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/profile.c:__connman_profile_add_n=
etwork() network 0x7f156eee8600
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:__connman_service_creat=
e_from_network() network 0x7f156eee8600
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:connman_service_create(=
) service 0x7f156eecaf00
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:__connman_service_initi=
alize() service 0x7f156eecaf00
Aug  6 08:46:34 tukki connmand[3713]: src/location.c:__connman_location_cre=
ate() service 0x7f156eecaf00
Aug  6 08:46:34 tukki connmand[3713]: src/location.c:__connman_location_cre=
ate() location 0x7f156eeea1c0
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:__connman_service_get()=
 service 0x7f156eecaf00
Aug  6 08:46:34 tukki connmand[3713]: src/profile.c:__connman_profile_activ=
e_ident() =

Aug  6 08:46:34 tukki connmand[3713]: src/service.c:update_from_network() s=
ervice 0x7f156eecaf00 network 0x7f156eee8600
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Name
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_uin=
t8() network 0x7f156eee8600 key Strength
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_boo=
l() network 0x7f156eee8600 key Roaming
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key WiFi.Mode
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key WiFi.Security
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Cellular.MCC
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeba060 name (null)
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Cellular.MNC
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeba060 name (null)
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_uin=
t8() network 0x7f156eee8600 key Cellular.Mode
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeba060 name (null)
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:connman_element_ref() e=
lement 0x7f156eee8600 name primarycontext1 refcount 3
Aug  6 08:46:34 tukki connmand[3713]: src/profile.c:__connman_profile_activ=
e_path() =

Aug  6 08:46:34 tukki connmand[3713]: src/service.c:service_register() serv=
ice 0x7f156eecaf00
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:service_register() path=
 /profile/default/cellular_244052260426298_primarycontext1
Aug  6 08:46:34 tukki connmand[3713]: src/config.c:__connman_config_provisi=
on_service() service 0x7f156eecaf00
Aug  6 08:46:34 tukki connmand[3713]: src/storage.c:__connman_storage_load_=
service() service 0x7f156eecaf00
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:service_load() service =
0x7f156eecaf00
Aug  6 08:46:34 tukki connmand[3713]: src/profile.c:__connman_profile_chang=
ed() =

Aug  6 08:46:34 tukki connmand[3713]: src/connection.c:find_active_gateway(=
) =

Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_set_roa=
ming() network 0x7f156eeeccd0 roaming 0
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_set_nam=
e() network 0x7f156eeeccd0 name elisa
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Name type 115 value 0x7fff37722298
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eeeccd0 key Path
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/profile.c:__connman_profile_add_n=
etwork() network 0x7f156eeeccd0
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:__connman_service_creat=
e_from_network() network 0x7f156eeeccd0
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:connman_service_create(=
) service 0x7f156eeee300
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:__connman_service_initi=
alize() service 0x7f156eeee300
Aug  6 08:46:34 tukki connmand[3713]: src/location.c:__connman_location_cre=
ate() service 0x7f156eeee300
Aug  6 08:46:34 tukki connmand[3713]: src/location.c:__connman_location_cre=
ate() location 0x7f156eee8420
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:__connman_service_get()=
 service 0x7f156eeee300
Aug  6 08:46:34 tukki connmand[3713]: src/profile.c:__connman_profile_activ=
e_ident() =

Aug  6 08:46:34 tukki connmand[3713]: src/service.c:update_from_network() s=
ervice 0x7f156eeee300 network 0x7f156eeeccd0
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eeeccd0 key Name
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_uin=
t8() network 0x7f156eeeccd0 key Strength
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_boo=
l() network 0x7f156eeeccd0 key Roaming
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eeeccd0 key WiFi.Mode
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eeeccd0 key WiFi.Security
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eeeccd0 key Cellular.MCC
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeba060 name (null)
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eeeccd0 key Cellular.MNC
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeba060 name (null)
Aug  6 08:46:34 tukki connmand[3713]: src/network.c:connman_network_get_uin=
t8() network 0x7f156eeeccd0 key Cellular.Mode
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeeccd0 name primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eec8840 name 244052260426298
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eeba060 name (null)
Aug  6 08:46:34 tukki connmand[3713]: src/element.c:connman_element_ref() e=
lement 0x7f156eeeccd0 name primarycontext2 refcount 3
Aug  6 08:46:34 tukki connmand[3713]: src/profile.c:__connman_profile_activ=
e_path() =

Aug  6 08:46:34 tukki connmand[3713]: src/service.c:service_register() serv=
ice 0x7f156eeee300
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:service_register() path=
 /profile/default/cellular_244052260426298_primarycontext2
Aug  6 08:46:34 tukki connmand[3713]: src/config.c:__connman_config_provisi=
on_service() service 0x7f156eeee300
Aug  6 08:46:34 tukki connmand[3713]: src/storage.c:__connman_storage_load_=
service() service 0x7f156eeee300
Aug  6 08:46:34 tukki connmand[3713]: src/service.c:service_load() service =
0x7f156eeee300
Aug  6 08:46:34 tukki connmand[3713]: src/profile.c:__connman_profile_chang=
ed() =

Aug  6 08:46:34 tukki connmand[3713]: src/connection.c:find_active_gateway(=
) =

Aug  6 08:46:34 tukki ofonod[8264]: Pcui:< \r\n+COPS: 0,0,"elisa",2\r\n\r\n=
OK\r\n
Aug  6 08:46:34 tukki ofonod[8264]: drivers/atmodem/network-registration.c:=
cops_cb() cops_cb: elisa, 244 05 2
Aug  6 08:46:34 tukki ofonod[8264]: src/network.c:current_operator_callback=
() 0x6ca7f0, 0x6ceb40
Aug  6 08:46:36 tukki connmand[3713]: src/service.c:get_properties() servic=
e 0x7f156eecaf00
Aug  6 08:46:36 tukki connmand[3713]: src/security.c:__connman_security_che=
ck_privilege() message 0x7f156eecc030
Aug  6 08:46:36 tukki connmand[3713]: src/service.c:get_properties() servic=
e 0x7f156eeee300
Aug  6 08:46:36 tukki connmand[3713]: src/security.c:__connman_security_che=
ck_privilege() message 0x7f156eeb9110
Aug  6 08:46:37 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:46:45 tukki connmand[3713]: src/manager.c:request_scan() conn 0x7=
f156eeb7710
Aug  6 08:46:45 tukki wpa_supplicant[3728]: Setting scan request: 0 sec 0 u=
sec
Aug  6 08:46:45 tukki wpa_supplicant[3728]: State: DISCONNECTED -> SCANNING
Aug  6 08:46:45 tukki wpa_supplicant[3728]: Starting AP scan for wildcard S=
SID
Aug  6 08:46:45 tukki connmand[3713]: src/device.c:connman_device_set_scann=
ing() device 0x7f156eed0220 scanning 1
Aug  6 08:46:45 tukki connmand[3713]: src/network.c:connman_network_set_ava=
ilable() network 0x7f156eeb9d60 available 0
Aug  6 08:46:45 tukki connmand[3713]: wlan0 SCANNING (scanning)
Aug  6 08:46:45 tukki connmand[3713]: wlan0 scanning started
Aug  6 08:46:45 tukki wpa_supplicant[3728]: Scan requested (ret=3D0) - scan=
 timeout 30 seconds
Aug  6 08:46:45 tukki wpa_supplicant[3728]: nl80211: Event message available
Aug  6 08:46:45 tukki wpa_supplicant[3728]: nl80211: Scan trigger
Aug  6 08:46:46 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:46:46 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 64
Aug  6 08:46:46 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWLINK len=
 64 type 16 flags 0x0000 seq 0
Aug  6 08:46:46 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
link() index 3
Aug  6 08:46:46 tukki wpa_supplicant[3728]: nl80211: Event message available
Aug  6 08:46:46 tukki wpa_supplicant[3728]: nl80211: New scan results avail=
able
Aug  6 08:46:46 tukki wpa_supplicant[3728]: Received scan results (1 BSSes)
Aug  6 08:46:46 tukki wpa_supplicant[3728]: nl80211: Scan results indicates=
 BSS status with 00:26:f2:f7:cf:b2 as authenticated
Aug  6 08:46:46 tukki wpa_supplicant[3728]: BSS: Start scan result update 42
Aug  6 08:46:46 tukki wpa_supplicant[3728]: New scan results available
Aug  6 08:46:46 tukki wpa_supplicant[3728]: State: SCANNING -> DISCONNECTED
Aug  6 08:46:46 tukki wpa_supplicant[3728]: wpa_driver_nl80211_set_operstat=
e: operstate 0->0 (DORMANT)
Aug  6 08:46:46 tukki wpa_supplicant[3728]: netlink: Operstate: linkmode=3D=
-1, operstate=3D5
Aug  6 08:46:46 tukki connmand[3713]: wlan0 scanning finished
Aug  6 08:46:46 tukki connmand[3713]: src/device.c:connman_device_set_scann=
ing() device 0x7f156eed0220 scanning 1
Aug  6 08:46:46 tukki connmand[3713]: wlan0 DISCONNECTED (scanning)
Aug  6 08:46:46 tukki wpa_supplicant[3728]: RTM_NEWLINK: operstate=3D0 ifi_=
flags=3D0x1003 ([UP])
Aug  6 08:46:46 tukki wpa_supplicant[3728]: RTM_NEWLINK, IFLA_IFNAME: Inter=
face 'wlan0' added
Aug  6 08:46:46 tukki connmand[3713]: src/device.c:connman_device_get_netwo=
rk() device 0x7f156eed0220 identifier 0026f2f7cfb2
Aug  6 08:46:46 tukki connmand[3713]: src/network.c:connman_network_set_nam=
e() network 0x7f156eeb9d60 name valo
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeb9d60 name 0026f2f7cfb2
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Name type 115 value 0x7fff37722168
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:unregister_property() p=
roperty 0x7f156eeb9a50
Aug  6 08:46:46 tukki connmand[3713]: src/network.c:connman_network_set_blo=
b() network 0x7f156eeb9d60 key WiFi.SSID size 4
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:set_static_array_proper=
ty() element 0x7f156eeb9d60 name 0026f2f7cfb2
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:set_static_array_proper=
ty() name WiFi.SSID type 121 value 0x7fff37722148
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:unregister_property() p=
roperty 0x7f156eee4ed0
Aug  6 08:46:46 tukki connmand[3713]: src/network.c:connman_network_set_str=
ing() network 0x7f156eeb9d60 key WiFi.Mode value managed
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeb9d60 name 0026f2f7cfb2
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:set_static_property() n=
ame WiFi.Mode type 115 value 0x7fff37722148
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:unregister_property() p=
roperty 0x7f156eeb7be0
Aug  6 08:46:46 tukki connmand[3713]: src/network.c:connman_network_set_ava=
ilable() network 0x7f156eeb9d60 available 1
Aug  6 08:46:46 tukki connmand[3713]: src/network.c:connman_network_set_str=
ength() network 0x7f156eeb9d60 strengh 69
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeb9d60 name 0026f2f7cfb2
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Strength type 121 value 0x7fff3772216c
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:unregister_property() p=
roperty 0x7f156eecc230
Aug  6 08:46:46 tukki connmand[3713]: src/network.c:connman_network_set_uin=
t16() network 0x7f156eeb9d60 key Frequency value 2462
Aug  6 08:46:46 tukki connmand[3713]: src/network.c:connman_network_set_uin=
t16() network 0x7f156eeb9d60 key WiFi.Channel value 11
Aug  6 08:46:46 tukki connmand[3713]: src/network.c:connman_network_set_str=
ing() network 0x7f156eeb9d60 key WiFi.Security value rsn
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeb9d60 name 0026f2f7cfb2
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:set_static_property() n=
ame WiFi.Security type 115 value 0x7fff37722148
Aug  6 08:46:46 tukki connmand[3713]: src/element.c:unregister_property() p=
roperty 0x7f156eed1da0
Aug  6 08:46:46 tukki connmand[3713]: src/profile.c:__connman_profile_updat=
e_network() network 0x7f156eeb9d60
Aug  6 08:46:46 tukki connmand[3713]: src/service.c:__connman_service_updat=
e_from_network() network 0x7f156eeb9d60
Aug  6 08:46:46 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eeb9d60
Aug  6 08:46:46 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eeb9d60 key Name
Aug  6 08:46:46 tukki connmand[3713]: src/network.c:connman_network_get_uin=
t8() network 0x7f156eeb9d60 key Strength
Aug  6 08:46:46 tukki connmand[3713]: src/network.c:connman_network_get_boo=
l() network 0x7f156eeb9d60 key Roaming
Aug  6 08:46:46 tukki connmand[3713]: src/device.c:connman_device_set_scann=
ing() device 0x7f156eed0220 scanning 0
Aug  6 08:46:49 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:02 tukki ofonod[8264]: Pcui:< \r\n^BOOT:38645652,0,0,0,87\r\n
Aug  6 08:47:10 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:10 tukki kvalo: kvalo pin locked ofono restart 1 no pin asked
Aug  6 08:47:13 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:15 tukki connmand[3713]: src/manager.c:request_scan() conn 0x7=
f156eeb7710
Aug  6 08:47:15 tukki wpa_supplicant[3728]: Setting scan request: 0 sec 0 u=
sec
Aug  6 08:47:15 tukki wpa_supplicant[3728]: State: DISCONNECTED -> SCANNING
Aug  6 08:47:15 tukki wpa_supplicant[3728]: Starting AP scan for wildcard S=
SID
Aug  6 08:47:15 tukki connmand[3713]: src/device.c:connman_device_set_scann=
ing() device 0x7f156eed0220 scanning 1
Aug  6 08:47:15 tukki connmand[3713]: src/network.c:connman_network_set_ava=
ilable() network 0x7f156eeb9d60 available 0
Aug  6 08:47:15 tukki connmand[3713]: wlan0 SCANNING (scanning)
Aug  6 08:47:15 tukki connmand[3713]: wlan0 scanning started
Aug  6 08:47:15 tukki wpa_supplicant[3728]: Scan requested (ret=3D0) - scan=
 timeout 30 seconds
Aug  6 08:47:15 tukki wpa_supplicant[3728]: nl80211: Event message available
Aug  6 08:47:15 tukki wpa_supplicant[3728]: nl80211: Scan trigger
Aug  6 08:47:16 tukki connmand[3713]: src/service.c:connect_service() servi=
ce 0x7f156eecaf00
Aug  6 08:47:16 tukki connmand[3713]: src/service.c:__connman_service_conne=
ct() service 0x7f156eecaf00
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_str=
ing() network 0x7f156eee8600 key Cellular.APN value internet
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Cellular.APN type 115 value 0x7fff377222c8
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Cellular.APN
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Path
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_str=
ing() network 0x7f156eee8600 key Cellular.Username value (null)
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Cellular.Username type 115 value 0x7fff377222c8
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_str=
ing() network 0x7f156eee8600 key Cellular.Password value (null)
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Cellular.Password type 115 value 0x7fff377222c8
Aug  6 08:47:16 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_ena=
ble() ipconfig (nil)
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:__connman_network_conne=
ct() network 0x7f156eee8600
Aug  6 08:47:16 tukki connmand[3713]: src/device.c:__connman_device_disconn=
ect() device 0x7f156eec8840
Aug  6 08:47:16 tukki connmand[3713]: src/device.c:connman_device_set_disco=
nnected() device 0x7f156eec8840 disconnected 1
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:__connman_network_disco=
nnect() network 0x7f156eee8600
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:__connman_network_disco=
nnect() network 0x7f156eeeccd0
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Path
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:connman_element_ref() e=
lement 0x7f156eee8600 name primarycontext1 refcount 4
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_ass=
ociating() network 0x7f156eee8600 associating 1
Aug  6 08:47:16 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:16 tukki connmand[3713]: src/service.c:__connman_service_indic=
ate_state() service 0x7f156eecaf00 state 2
Aug  6 08:47:16 tukki connmand[3713]: src/profile.c:__connman_profile_chang=
ed() =

Aug  6 08:47:16 tukki connmand[3713]: src/connection.c:find_active_gateway(=
) =

Aug  6 08:47:16 tukki ofonod[8264]: Modem:> AT+CGDCONT=3D1,"IP","internet"\r
Aug  6 08:47:16 tukki ofonod[8264]: Modem:< \r\nOK\r\n
Aug  6 08:47:16 tukki ofonod[8264]: Modem:> AT+CGDATA=3D"PPP",1\r
Aug  6 08:47:16 tukki ofonod[8264]: Modem:< \r\nCONNECT\r\n
Aug  6 08:47:16 tukki wpa_supplicant[3728]: nl80211: Event message available
Aug  6 08:47:16 tukki wpa_supplicant[3728]: nl80211: New scan results avail=
able
Aug  6 08:47:16 tukki wpa_supplicant[3728]: Received scan results (1 BSSes)
Aug  6 08:47:16 tukki wpa_supplicant[3728]: nl80211: Scan results indicates=
 BSS status with 00:26:f2:f7:cf:b2 as authenticated
Aug  6 08:47:16 tukki wpa_supplicant[3728]: BSS: Start scan result update 43
Aug  6 08:47:16 tukki wpa_supplicant[3728]: New scan results available
Aug  6 08:47:16 tukki wpa_supplicant[3728]: State: SCANNING -> DISCONNECTED
Aug  6 08:47:16 tukki wpa_supplicant[3728]: wpa_driver_nl80211_set_operstat=
e: operstate 0->0 (DORMANT)
Aug  6 08:47:16 tukki wpa_supplicant[3728]: netlink: Operstate: linkmode=3D=
-1, operstate=3D5
Aug  6 08:47:16 tukki wpa_supplicant[3728]: RTM_NEWLINK: operstate=3D0 ifi_=
flags=3D0x1003 ([UP])
Aug  6 08:47:16 tukki wpa_supplicant[3728]: RTM_NEWLINK, IFLA_IFNAME: Inter=
face 'wlan0' added
Aug  6 08:47:16 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 64
Aug  6 08:47:16 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWLINK len=
 64 type 16 flags 0x0000 seq 0
Aug  6 08:47:16 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
link() index 3
Aug  6 08:47:16 tukki connmand[3713]: wlan0 scanning finished
Aug  6 08:47:16 tukki connmand[3713]: src/device.c:connman_device_set_scann=
ing() device 0x7f156eed0220 scanning 1
Aug  6 08:47:16 tukki connmand[3713]: wlan0 DISCONNECTED (scanning)
Aug  6 08:47:16 tukki connmand[3713]: src/device.c:connman_device_get_netwo=
rk() device 0x7f156eed0220 identifier 0026f2f7cfb2
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_nam=
e() network 0x7f156eeb9d60 name valo
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeb9d60 name 0026f2f7cfb2
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Name type 115 value 0x7fff37722168
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:unregister_property() p=
roperty 0x7f156eef8440
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_blo=
b() network 0x7f156eeb9d60 key WiFi.SSID size 4
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_array_proper=
ty() element 0x7f156eeb9d60 name 0026f2f7cfb2
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_array_proper=
ty() name WiFi.SSID type 121 value 0x7fff37722148
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:unregister_property() p=
roperty 0x7f156eeb9a50
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_str=
ing() network 0x7f156eeb9d60 key WiFi.Mode value managed
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeb9d60 name 0026f2f7cfb2
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() n=
ame WiFi.Mode type 115 value 0x7fff37722148
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:unregister_property() p=
roperty 0x7f156eee4ed0
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_ava=
ilable() network 0x7f156eeb9d60 available 1
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_str=
ength() network 0x7f156eeb9d60 strengh 63
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeb9d60 name 0026f2f7cfb2
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() n=
ame Strength type 121 value 0x7fff3772216c
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:unregister_property() p=
roperty 0x7f156eeb7be0
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_uin=
t16() network 0x7f156eeb9d60 key Frequency value 2462
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_uin=
t16() network 0x7f156eeb9d60 key WiFi.Channel value 11
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_set_str=
ing() network 0x7f156eeb9d60 key WiFi.Security value rsn
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() e=
lement 0x7f156eeb9d60 name 0026f2f7cfb2
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:set_static_property() n=
ame WiFi.Security type 115 value 0x7fff37722148
Aug  6 08:47:16 tukki connmand[3713]: src/element.c:unregister_property() p=
roperty 0x7f156eecc230
Aug  6 08:47:16 tukki connmand[3713]: src/profile.c:__connman_profile_updat=
e_network() network 0x7f156eeb9d60
Aug  6 08:47:16 tukki connmand[3713]: src/service.c:__connman_service_updat=
e_from_network() network 0x7f156eeb9d60
Aug  6 08:47:16 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eeb9d60
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eeb9d60 key Name
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_get_uin=
t8() network 0x7f156eeb9d60 key Strength
Aug  6 08:47:16 tukki connmand[3713]: src/network.c:connman_network_get_boo=
l() network 0x7f156eeb9d60 key Roaming
Aug  6 08:47:16 tukki connmand[3713]: src/device.c:connman_device_set_scann=
ing() device 0x7f156eed0220 scanning 0
Aug  6 08:47:18 tukki connmand[3713]: src/udev.c:print_device() =3D=3D=3D a=
dd =3D=3D=3D
Aug  6 08:47:18 tukki connmand[3713]: src/udev.c:print_properties() DEVPATH=
 =3D /devices/virtual/net/ppp0
Aug  6 08:47:18 tukki connmand[3713]: src/udev.c:print_properties() INTERFA=
CE =3D ppp0
Aug  6 08:47:18 tukki connmand[3713]: src/udev.c:print_properties() IFINDEX=
 =3D 12
Aug  6 08:47:18 tukki connmand[3713]: src/udev.c:add_net_device() =

Aug  6 08:47:18 tukki kernel: [16231.018929] ppp0: Disabled Privacy Extensi=
ons
Aug  6 08:47:18 tukki wpa_supplicant[3728]: nl80211: Ignore event for forei=
gn ifindex 12
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 420
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWLINK len=
 420 type 16 flags 0x0000 seq 0
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
link() index 12
Aug  6 08:47:18 tukki connmand[3713]: ppp0 {create} index 12 type 65534 <NO=
NE>
Aug  6 08:47:18 tukki connmand[3713]: ppp0 {update} flags 4240 <DOWN>
Aug  6 08:47:18 tukki connmand[3713]: ppp0 {newlink} index 12 operstate 2 <=
DOWN>
Aug  6 08:47:18 tukki ofonod[8264]: src/gprs.c:pri_activate_callback() 0x6c=
dfc0 ppp0
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:connman_element_unref()=
 element 0x7f156eee8600 name primarycontext1 refcount 3
Aug  6 08:47:18 tukki connmand[3713]: src/device.c:connman_device_get_netwo=
rk() device 0x7f156eec8840 identifier primarycontext1
Aug  6 08:47:18 tukki wpa_supplicant[3728]: nl80211: Ignore event for forei=
gn ifindex 12
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 424
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWLINK len=
 424 type 16 flags 0x0000 seq 0
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
link() index 12
Aug  6 08:47:18 tukki connmand[3713]: ppp0 {update} flags 69841 <UP,RUNNING=
,LOWER_UP>
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_low=
er_up() ipconfig (nil)
Aug  6 08:47:18 tukki connmand[3713]: ppp0 {newlink} index 12 operstate 0 <=
UNKNOWN>
Aug  6 08:47:18 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Path
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:connman_ipconfig_creat=
e() index 12
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:connman_ipconfig_creat=
e() ipconfig 0x7f156eecd7c0
Aug  6 08:47:18 tukki connmand[3713]: src/storage.c:__connman_storage_open(=
) ident default suffix profile
Aug  6 08:47:18 tukki connmand[3713]: src/storage.c:__connman_storage_open(=
) keyfile 0x7f156eec1590
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_loa=
d() ipconfig 0x7f156eecd7c0 identifier cellular_244052260426298_primarycont=
ext1
Aug  6 08:47:18 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Path
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/network.c:connman_network_set_con=
nected() network 0x7f156eee8600 connected 1
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/network.c:set_connected() method 2
Aug  6 08:47:18 tukki connmand[3713]: src/network.c:set_connected_fixed() =

Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/network.c:set_configuration() net=
work 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Name
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:connman_element_ref() e=
lement 0x7f156eee8600 name primarycontext1 refcount 4
Aug  6 08:47:18 tukki connmand[3713]: src/device.c:connman_device_set_disco=
nnected() device 0x7f156eec8840 disconnected 0
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_indic=
ate_state() service 0x7f156eecaf00 state 3
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_ena=
ble() ipconfig 0x7f156eecd7c0
Aug  6 08:47:18 tukki connmand[3713]: ppp0 up
Aug  6 08:47:18 tukki connmand[3713]: ppp0 lower up
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_stats=
_start() service 0x7f156eecaf00
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:send_getlink() =

Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:send_request() GETLINK len=
 17 type 18 flags 0x0301 seq 15
Aug  6 08:47:18 tukki connmand[3713]: src/profile.c:__connman_profile_chang=
ed() =

Aug  6 08:47:18 tukki connmand[3713]: src/connection.c:find_active_gateway(=
) =

Aug  6 08:47:18 tukki connmand[3713]: src/element.c:connman_element_create(=
) element 0x7f156eecc100
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:__connman_element_initi=
alize() element 0x7f156eecc100
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:connman_element_registe=
r() element 0x7f156eecc100 name (null) parent 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:connman_element_ref() e=
lement 0x7f156eecc100 name (null) refcount 2
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:register_element() elem=
ent 0x7f156eecc100 path /org/moblin/connman/device/244052260426298/primaryc=
ontext1/ipv4
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:probe_element() element=
 0x7f156eecc100 name ipv4
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:probe_element() driver =
0x7f156d532860 name ipv4
Aug  6 08:47:18 tukki connmand[3713]: src/ipv4.c:ipv4_probe() element 0x7f1=
56eecc100 name ipv4
Aug  6 08:47:18 tukki connmand[3713]: src/ipv4.c:ipv4_probe() address 84.23=
1.119.24
Aug  6 08:47:18 tukki connmand[3713]: src/ipv4.c:ipv4_probe() netmask 255.2=
55.255.255
Aug  6 08:47:18 tukki connmand[3713]: src/ipv4.c:ipv4_probe() broadcast (nu=
ll)
Aug  6 08:47:18 tukki connmand[3713]: src/ipv4.c:set_ipv4() element 0x7f156=
eecc100 ipv4 0x7fff37722000
Aug  6 08:47:18 tukki connmand[3713]: src/ipv4.c:set_ipv4() ifname ppp0
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_appen=
d_nameserver() service 0x7f156eecaf00 nameserver 193.229.0.40 193.229.0.42
Aug  6 08:47:18 tukki connmand[3713]: src/timeserver.c:connman_timeserver_a=
ppend() server (null)
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:connman_element_create(=
) element 0x7f156eeedd00
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:__connman_element_initi=
alize() element 0x7f156eeedd00
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:connman_element_registe=
r() element 0x7f156eeedd00 name (null) parent 0x7f156eecc100
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:connman_element_ref() e=
lement 0x7f156eeedd00 name (null) refcount 2
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:register_element() elem=
ent 0x7f156eeedd00 path /org/moblin/connman/device/244052260426298/primaryc=
ontext1/ipv4/connection
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:probe_element() element=
 0x7f156eeedd00 name connection
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:probe_element() driver =
0x7f156d531f40 name connection
Aug  6 08:47:18 tukki connmand[3713]: src/connection.c:connection_probe() e=
lement 0x7f156eeedd00 name connection
Aug  6 08:47:18 tukki connmand[3713]: src/connection.c:connection_probe() g=
ateway (null)
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:connman_element_update(=
) element 0x7f156eeedd00 name connection
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:update_element() elemen=
t 0x7f156eeedd00 name connection
Aug  6 08:47:18 tukki connmand[3713]: src/connection.c:find_active_gateway(=
) =

Aug  6 08:47:18 tukki connmand[3713]: src/element.c:__connman_element_forea=
ch() =

Aug  6 08:47:18 tukki connmand[3713]: src/element.c:foreach_callback() elem=
ent 0x7f156eeba060 name (null)
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:foreach_callback() elem=
ent 0x7f156eed0220 name 0026b6675606
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:foreach_callback() elem=
ent 0x7f156eeb9d60 name 0026f2f7cfb2
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:foreach_callback() elem=
ent 0x7f156eed24a0 name 00245416e421
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:foreach_callback() elem=
ent 0x7f156eee5030 name 0c6076e3999f
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:foreach_callback() elem=
ent 0x7f156eeccf70 name 000272402703
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:foreach_callback() elem=
ent 0x7f156eec8840 name 244052260426298
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:foreach_callback() elem=
ent 0x7f156eee8600 name primarycontext1
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:foreach_callback() elem=
ent 0x7f156eecc100 name ipv4
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:foreach_callback() elem=
ent 0x7f156eeedd00 name connection
Aug  6 08:47:18 tukki connmand[3713]: src/connection.c:find_element() eleme=
nt 0x7f156eeedd00 name connection
Aug  6 08:47:18 tukki connmand[3713]: src/element.c:foreach_callback() elem=
ent 0x7f156eeeccd0 name primarycontext2
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/inet.c:connman_inet_add_host_rout=
e() ifname ppp0
Aug  6 08:47:18 tukki connmand[3713]: src/inet.c:connman_inet_compare_subne=
t() host 193.229.0.40 193.229.0.42
Aug  6 08:47:18 tukki connmand[3713]: src/inet.c:connman_inet_add_host_rout=
e() ifname ppp0
Aug  6 08:47:18 tukki connmand[3713]: Adding host route failed (Invalid arg=
ument)
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_indic=
ate_state() service 0x7f156eecaf00 state 4
Aug  6 08:47:18 tukki connmand[3713]: src/profile.c:__connman_profile_chang=
ed() =

Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/connection.c:find_active_gateway(=
) =

Aug  6 08:47:18 tukki connmand[3713]: src/storage.c:__connman_storage_save_=
service() service 0x7f156eecaf00
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:service_save() service =
0x7f156eecaf00
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_sav=
e() ipconfig 0x7f156eecd7c0 identifier cellular_244052260426298_primarycont=
ext1
Aug  6 08:47:18 tukki connmand[3713]: src/resolver.c:connman_resolver_remov=
e_all() interface ppp0
Aug  6 08:47:18 tukki connmand[3713]: src/resolver.c:connman_resolver_appen=
d() interface ppp0 domain (null) server 193.229.0.40 193.229.0.42
Aug  6 08:47:18 tukki connmand[3713]: src/resolver.c:append_resolver() inte=
rface ppp0 domain (null) server 193.229.0.40 193.229.0.42 flags 0
Aug  6 08:47:18 tukki connmand[3713]: src/resolver.c:resolvfile_append() in=
terface ppp0 server 193.229.0.40 193.229.0.42
Aug  6 08:47:18 tukki connmand[3713]: src/notifier.c:__connman_notifier_con=
nect() type 6
Aug  6 08:47:18 tukki connmand[3713]: src/notifier.c:technology_connected()=
 type 6 connected 1
Aug  6 08:47:18 tukki connmand[3713]: src/tethering.c:__connman_tethering_u=
pdate_interface() interface ppp0
Aug  6 08:47:18 tukki connmand[3713]: src/profile.c:__connman_profile_chang=
ed() =

Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/connection.c:find_active_gateway(=
) =

Aug  6 08:47:18 tukki connmand[3713]: src/connection.c:set_default_gateway(=
) gateway 0.0.0.0
Aug  6 08:47:18 tukki connmand[3713]: src/inet.c:connman_inet_set_gateway_i=
nterface() =

Aug  6 08:47:18 tukki connmand[3713]: src/inet.c:connman_inet_set_gateway_i=
nterface() ifname ppp0
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_indic=
ate_default() service 0x7f156eecaf00
Aug  6 08:47:18 tukki connmand[3713]: src/tethering.c:__connman_tethering_u=
pdate_interface() interface ppp0
Aug  6 08:47:18 tukki connmand[3713]: src/location.c:__connman_location_det=
ect() service 0x7f156eecaf00
Aug  6 08:47:18 tukki connmand[3713]: src/location.c:connman_location_repor=
t_result() location 0x7f156eeea1c0 result 2
Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_indic=
ate_state() service 0x7f156eecaf00 state 5
Aug  6 08:47:18 tukki connmand[3713]: src/timeserver.c:connman_timeserver_s=
ync() =

Aug  6 08:47:18 tukki connmand[3713]: src/profile.c:__connman_profile_chang=
ed() =

Aug  6 08:47:18 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:47:18 tukki connmand[3713]: src/connection.c:find_active_gateway(=
) =

Aug  6 08:47:18 tukki connmand[3713]: src/network.c:connman_network_set_ass=
ociating() network 0x7f156eee8600 associating 0
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 2164
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWLINK len=
 428 type 16 flags 0x0002 seq 15
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
link() index 1
Aug  6 08:47:18 tukki connmand[3713]: lo {newlink} index 1 operstate 0 <UNK=
NOWN>
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWLINK len=
 444 type 16 flags 0x0002 seq 15
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
link() index 2
Aug  6 08:47:18 tukki connmand[3713]: eth0 {newlink} index 2 address 00:24:=
54:16:E4:21 mtu 1500
Aug  6 08:47:18 tukki connmand[3713]: eth0 {newlink} index 2 operstate 2 <D=
OWN>
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWLINK len=
 436 type 16 flags 0x0002 seq 15
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
link() index 3
Aug  6 08:47:18 tukki connmand[3713]: wlan0 {RX} 140593 packets 119604209 b=
ytes
Aug  6 08:47:18 tukki connmand[3713]: wlan0 {TX} 136848 packets 99546867 by=
tes
Aug  6 08:47:18 tukki connmand[3713]: wlan0 {newlink} index 3 address 00:26=
:B6:67:56:06 mtu 1500
Aug  6 08:47:18 tukki connmand[3713]: wlan0 {newlink} index 3 operstate 2 <=
DOWN>
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWLINK len=
 432 type 16 flags 0x0002 seq 15
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
link() index 4
Aug  6 08:47:18 tukki connmand[3713]: pan0 {newlink} index 4 address 1A:5C:=
A0:F1:B7:A1 mtu 1500
Aug  6 08:47:18 tukki connmand[3713]: pan0 {newlink} index 4 operstate 2 <D=
OWN>
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWLINK len=
 424 type 16 flags 0x0002 seq 15
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
link() index 12
Aug  6 08:47:18 tukki connmand[3713]: ppp0 {newlink} index 12 operstate 0 <=
UNKNOWN>
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 52
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWADDR len=
 52 type 20 flags 0x0000 seq 0
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
addr() index 12
Aug  6 08:47:18 tukki connmand[3713]: ppp0 {add} address 84.231.119.24/32 l=
abel ppp0
Aug  6 08:47:18 tukki connmand[3713]: ppp0 ip bound
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 60
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWROUTE le=
n 60 type 24 flags 0x0000 seq 0
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 52
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() DELADDR len=
 52 type 21 flags 0x0000 seq 0
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_del=
addr() index 12
Aug  6 08:47:18 tukki connmand[3713]: ppp0 {del} address 84.231.119.24/32 l=
abel ppp0
Aug  6 08:47:18 tukki connmand[3713]: ppp0 ip release
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 60
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() DELROUTE le=
n 60 type 25 flags 0x0000 seq 0
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 60
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWADDR len=
 60 type 20 flags 0x0000 seq 0
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
addr() index 12
Aug  6 08:47:18 tukki connmand[3713]: ppp0 {add} address 84.231.119.24/32 l=
abel ppp0
Aug  6 08:47:18 tukki connmand[3713]: ppp0 ip bound
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 60
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWROUTE le=
n 60 type 24 flags 0x0000 seq 0
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 60
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWROUTE le=
n 60 type 24 flags 0x0000 seq 0
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 52
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWROUTE le=
n 52 type 24 flags 0x0000 seq 0
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
route() index 12
Aug  6 08:47:18 tukki connmand[3713]: ppp0 {add} route 0.0.0.0 gw 0.0.0.0 s=
cope 253 <LINK>
Aug  6 08:47:18 tukki connmand[3713]: src/connection.c:connection_newgatewa=
y() index 12 gateway 0.0.0.0
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 44
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWROUTE le=
n 44 type 24 flags 0x0000 seq 0
Aug  6 08:47:18 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
route() index 12
Aug  6 08:47:18 tukki connmand[3713]: ppp0 {add} route 0.0.0.0 gw 0.0.0.0 s=
cope 253 <LINK>
Aug  6 08:47:18 tukki connmand[3713]: src/connection.c:connection_newgatewa=
y() index 12 gateway 0.0.0.0
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 20
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:rtnl_message() DONE len 20=
 type 3 flags 0x0002 seq 15
Aug  6 08:47:18 tukki connmand[3713]: src/rtnl.c:process_response() seq 15
Aug  6 08:47:19 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:21 tukki connmand[3713]: src/device.c:device_scan_trigger() de=
vice 0x7f156eec8840
Aug  6 08:47:22 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:22 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000002,00000021=
,00000000,0000000000000043,0000000000000000,0003E800,0003E800\r\n
Aug  6 08:47:24 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000004,00000186=
,000000EF,0000000000000350,00000000000001DF,0003E800,0003E800\r\n
Aug  6 08:47:25 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:25 tukki ofonod[8264]: Pcui:< \r\n^MODE:5,5\r\n
Aug  6 08:47:26 tukki connmand[3713]: src/device.c:device_scan_trigger() de=
vice 0x7f156eec8840
Aug  6 08:47:26 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000006,0000075C=
,00000497,0000000000001208,0000000000000B0E,0003E800,0003E800\r\n
Aug  6 08:47:28 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:28 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000008,000004D1=
,00000304,0000000000001BAB,0000000000001116,0003E800,0003E800\r\n
Aug  6 08:47:30 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:0000000A,00000099=
,0000030D,0000000000001CDD,0000000000001731,0003E800,0003E800\r\n
Aug  6 08:47:31 tukki connmand[3713]: src/device.c:device_scan_trigger() de=
vice 0x7f156eec8840
Aug  6 08:47:32 tukki ofonod[8264]: Pcui:< \r\n^BOOT:38645652,0,0,0,87\r\n
Aug  6 08:47:32 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:0000000C,00000C04=
,00000492,00000000000034E5,0000000000002055,0003E800,0003E800\r\n
Aug  6 08:47:34 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:0000000E,00000473=
,000000ED,0000000000003DCB,000000000000222F,0003E800,0003E800\r\n
Aug  6 08:47:36 tukki connmand[3713]: src/device.c:device_scan_trigger() de=
vice 0x7f156eec8840
Aug  6 08:47:36 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000010,00001970=
,00017362,00000000000070AC,00000000000308F4,0003E800,0003E800\r\n
Aug  6 08:47:37 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:38 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000012,0000028A=
,00005E1C,00000000000075C0,000000000003C52C,0003E800,0003E800\r\n
Aug  6 08:47:40 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:40 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000014,00000000=
,00000000,00000000000075C0,000000000003C52C,0003E800,0003E800\r\n
Aug  6 08:47:41 tukki connmand[3713]: src/device.c:device_scan_trigger() de=
vice 0x7f156eec8840
Aug  6 08:47:42 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000016,00000000=
,00000000,00000000000075C0,000000000003C52C,0003E800,0003E800\r\n
Aug  6 08:47:43 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:43 tukki ofonod[8264]: Pcui:< \r\n^MODE:5,4\r\n
Aug  6 08:47:44 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000018,00000000=
,00000000,00000000000075C0,000000000003C52C,0003E800,0003E800\r\n
Aug  6 08:47:46 tukki connmand[3713]: src/device.c:device_scan_trigger() de=
vice 0x7f156eec8840
Aug  6 08:47:46 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:46 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:0000001A,00000000=
,00000000,00000000000075C0,000000000003C52C,0003E800,0003E800\r\n
Aug  6 08:47:47 tukki ofonod[8264]: Pcui:< \r\n^MODE:5,5\r\n
Aug  6 08:47:48 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:0000001C,000003E0=
,00000034,0000000000007D80,000000000003C594,0003E800,0003E800\r\n
Aug  6 08:47:49 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:50 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:0000001E,0000001A=
,000000F1,0000000000007DB4,000000000003C776,0003E800,0003E800\r\n
Aug  6 08:47:51 tukki connmand[3713]: src/device.c:device_scan_trigger() de=
vice 0x7f156eec8840
Aug  6 08:47:52 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:52 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000020,00000000=
,00000000,0000000000007DB4,000000000003C776,0003E800,0003E800\r\n
Aug  6 08:47:54 tukki ofonod[8264]: Pcui:< \r\n^MODE:5,4\r\n
Aug  6 08:47:54 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000022,00000000=
,00000000,0000000000007DB4,000000000003C776,0003E800,0003E800\r\n
Aug  6 08:47:55 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:47:56 tukki connmand[3713]: src/device.c:device_scan_trigger() de=
vice 0x7f156eec8840
Aug  6 08:47:56 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000024,00000000=
,00000000,0000000000007DB4,000000000003C776,0003E800,0003E800\r\n
Aug  6 08:47:58 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000026,00000000=
,00000000,0000000000007DB4,000000000003C776,0003E800,0003E800\r\n
Aug  6 08:48:00 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000028,00000000=
,00000000,0000000000007DB4,000000000003C776,0003E800,0003E800\r\n
Aug  6 08:48:01 tukki connmand[3713]: src/device.c:device_scan_trigger() de=
vice 0x7f156eec8840
Aug  6 08:48:01 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:48:02 tukki ofonod[8264]: Pcui:< \r\n^BOOT:38645652,0,0,0,87\r\n
Aug  6 08:48:02 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:0000002A,00000000=
,00000000,0000000000007DB4,000000000003C776,0003E800,0003E800\r\n
Aug  6 08:48:04 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:48:04 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:0000002C,00000000=
,00000000,0000000000007DB4,000000000003C776,0003E800,0003E800\r\n
Aug  6 08:48:06 tukki connmand[3713]: src/device.c:device_scan_trigger() de=
vice 0x7f156eec8840
Aug  6 08:48:06 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:0000002E,00000000=
,00000000,0000000000007DB4,000000000003C776,0003E800,0003E800\r\n
Aug  6 08:48:07 tukki ofonod[8264]: Pcui:< \r\n^RSSI:
Aug  6 08:48:07 tukki ofonod[8264]: Pcui:< 22\r\n
Aug  6 08:48:07 tukki ofonod[8264]: Pcui:< \r\n^MODE:5,5\r\n
Aug  6 08:48:08 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000030,0000005A=
,0000009C,0000000000007E68,000000000003C8AE,0003E800,0003E800\r\n
Aug  6 08:48:10 tukki ofonod[8264]: Pcui:< \r\n^RSSI:22\r\n
Aug  6 08:48:10 tukki ofonod[8264]: Pcui:< \r\n^DSFLOWRPT:00000032,00000000=
,00000000,0000000000007E68,000000000003C8AE,0003E800,0003E800\r\n
Aug  6 08:48:11 tukki connmand[3713]: src/device.c:device_scan_trigger() de=
vice 0x7f156eec8840
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:disconnect_service() se=
rvice 0x7f156eecaf00
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_disco=
nnect() service 0x7f156eecaf00
Aug  6 08:48:11 tukki connmand[3713]: src/network.c:__connman_network_disco=
nnect() network 0x7f156eee8600
Aug  6 08:48:11 tukki connmand[3713]: src/network.c:connman_network_get_str=
ing() network 0x7f156eee8600 key Path
Aug  6 08:48:11 tukki connmand[3713]: src/element.c:get_static_property() e=
lement 0x7f156eee8600 name primarycontext1
Aug  6 08:48:11 tukki connmand[3713]: src/element.c:connman_element_ref() e=
lement 0x7f156eee8600 name primarycontext1 refcount 5
Aug  6 08:48:11 tukki connmand[3713]: src/network.c:connman_network_set_con=
nected() network 0x7f156eee8600 connected 0
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:48:11 tukki connmand[3713]: src/network.c:set_connected() method 2
Aug  6 08:48:11 tukki connmand[3713]: src/element.c:connman_element_unregis=
ter_children() element 0x7f156eee8600 name primarycontext1
Aug  6 08:48:11 tukki connmand[3713]: src/element.c:remove_element() elemen=
t 0x7f156eeedd00 name connection
Aug  6 08:48:11 tukki ofonod[8264]: drivers/atmodem/gprs-context.c:at_gprs_=
deactivate_primary() =

Aug  6 08:48:11 tukki connmand[3713]: src/connection.c:connection_remove() =
element 0x7f156eeedd00 name connection
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:48:11 tukki connmand[3713]: src/inet.c:connman_inet_del_host_rout=
e() ifname ppp0
Aug  6 08:48:11 tukki wpa_supplicant[3728]: nl80211: Ignore event for forei=
gn ifindex 12
Aug  6 08:48:11 tukki wpa_supplicant[3728]: RTM_DELLINK, IFLA_IFNAME: Inter=
face 'ppp0' removed
Aug  6 08:48:11 tukki connmand[3713]: Deleting host route failed (No such d=
evice)
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_indic=
ate_state() service 0x7f156eecaf00 state 6
Aug  6 08:48:11 tukki connmand[3713]: src/location.c:__connman_location_fin=
ish() service 0x7f156eecaf00
Aug  6 08:48:11 tukki connmand[3713]: src/tethering.c:__connman_tethering_u=
pdate_interface() interface (null)
Aug  6 08:48:11 tukki connmand[3713]: src/resolver.c:connman_resolver_remov=
e_all() interface ppp0
Aug  6 08:48:11 tukki connmand[3713]: src/resolver.c:resolvfile_remove() in=
terface ppp0 server 193.229.0.40 193.229.0.42
Aug  6 08:48:11 tukki connmand[3713]: src/notifier.c:__connman_notifier_dis=
connect() type 6
Aug  6 08:48:11 tukki connmand[3713]: src/notifier.c:technology_connected()=
 type 6 connected 0
Aug  6 08:48:11 tukki connmand[3713]: src/profile.c:__connman_profile_chang=
ed() =

Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:48:11 tukki connmand[3713]: src/connection.c:find_active_gateway(=
) =

Aug  6 08:48:11 tukki connmand[3713]: src/element.c:connman_element_update(=
) element 0x7f156eeedd00 name connection
Aug  6 08:48:11 tukki connmand[3713]: src/connection.c:connection_remove() =
gateway 0.0.0.0
Aug  6 08:48:11 tukki connmand[3713]: src/connection.c:remove_gateway() gat=
eway 0.0.0.0
Aug  6 08:48:11 tukki connmand[3713]: src/inet.c:connman_inet_clear_gateway=
_interface() =

Aug  6 08:48:11 tukki connmand[3713]: src/element.c:connman_element_unref()=
 element 0x7f156eeedd00 name connection refcount 1
Aug  6 08:48:11 tukki connmand[3713]: src/element.c:remove_element() elemen=
t 0x7f156eecc100 name ipv4
Aug  6 08:48:11 tukki connmand[3713]: src/ipv4.c:ipv4_remove() element 0x7f=
156eecc100 name ipv4
Aug  6 08:48:11 tukki connmand[3713]: src/timeserver.c:connman_timeserver_r=
emove() server (null)
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_remov=
e_nameserver() service 0x7f156eecaf00 nameserver 193.229.0.40 193.229.0.42
Aug  6 08:48:11 tukki connmand[3713]: src/resolver.c:connman_resolver_remov=
e_all() interface ppp0
Aug  6 08:48:11 tukki connmand[3713]: src/ipv4.c:clear_ipv4() element 0x7f1=
56eecc100
Aug  6 08:48:11 tukki connmand[3713]: src/element.c:connman_element_unref()=
 element 0x7f156eecc100 name ipv4 refcount 1
Aug  6 08:48:11 tukki connmand[3713]: src/element.c:remove_element() elemen=
t 0x7f156eee8600 name primarycontext1
Aug  6 08:48:11 tukki connmand[3713]: src/element.c:connman_element_unref()=
 element 0x7f156eee8600 name primarycontext1 refcount 4
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_indic=
ate_state() service 0x7f156eecaf00 state 1
Aug  6 08:48:11 tukki connmand[3713]: src/profile.c:__connman_profile_chang=
ed() =

Aug  6 08:48:11 tukki connmand[3713]: src/connection.c:find_active_gateway(=
) =

Aug  6 08:48:11 tukki connmand[3713]: src/network.c:connman_network_set_ass=
ociating() network 0x7f156eee8600 associating 0
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:48:11 tukki connmand[3713]: src/network.c:set_connected() method 2
Aug  6 08:48:11 tukki connmand[3713]: src/element.c:connman_element_unregis=
ter_children() element 0x7f156eee8600 name primarycontext1
Aug  6 08:48:11 tukki connmand[3713]: src/element.c:remove_element() elemen=
t 0x7f156eee8600 name primarycontext1
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_looku=
p_from_network() network 0x7f156eee8600
Aug  6 08:48:11 tukki connmand[3713]: src/service.c:__connman_service_indic=
ate_state() service 0x7f156eecaf00 state 1
Aug  6 08:48:11 tukki connmand[3713]: src/network.c:connman_network_set_ass=
ociating() network 0x7f156eee8600 associating 0
Aug  6 08:48:11 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_cle=
ar_address() =

Aug  6 08:48:11 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_cle=
ar_address() method 2
Aug  6 08:48:11 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_dis=
able() ipconfig 0x7f156eecd7c0
Aug  6 08:48:11 tukki connmand[3713]: src/rtnl.c:rtnl_message() buf 0x7fff3=
77214c0 len 424
Aug  6 08:48:11 tukki connmand[3713]: src/rtnl.c:rtnl_message() NEWLINK len=
 424 type 16 flags 0x0000 seq 0
Aug  6 08:48:11 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_new=
link() index 12
Aug  6 08:48:11 tukki connmand[3713]: ppp0 {RX} 271 packets 247982 bytes
Aug  6 08:48:11 tukki connmand[3713]: ppp0 {TX} 221 packets 32360 bytes
Aug  6 08:48:11 tukki connmand[3713]: ppp0 {update} flags 4240 <DOWN>
Aug  6 08:48:11 tukki connmand[3713]: src/ipconfig.c:__connman_ipconfig_low=
er_down() ipconfig (nil)
Aug  6 08:48:11 tukki connmand[3713]: ppp0 {newlink} index 12 operstate 2 <=
DOWN>


-- =

Kalle Valo

--===============2569107472526182656==--


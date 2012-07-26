Content-Type: multipart/mixed; boundary="===============2918344096729384410=="
MIME-Version: 1.0
From: Andrea Galbusera <gizero@gmail.com>
Subject: Re: Testing Telit GT864-3G compatibility with ofono
Date: Thu, 26 Jul 2012 11:53:37 +0200
Message-ID: <CAC+thW2AZ4nQYRXGm3ta0AEb1Zvofs3=o4h8eiQN+9oxeA+HSQ@mail.gmail.com>
In-Reply-To: <ED4DEEB78293B34A9D0EAC02A474A46E194CB98F@IRSMSX102.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2918344096729384410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

Thank you for suggestions: please, see comments below.

On Thu, Jul 26, 2012 at 10:06 AM, Aygon, Bertrand
<bertrand.aygon@intel.com> wrote:
>
> Hi,
>
> I'm doing some tests with Telit GT864-3G terminal connected to USB with o=
fono 1.9. This modem uses UC864-E core. Since ofono provides a driver for U=
C864-G core, I hope managing it with ofono should be quite straightforward.=
 One difference between the two cores is that UC864-G does expose 4 serial =
devices: after a quick fix I got "modem" and "aux" channel correctly assign=
ed. The problem I see here when I run enable-modem is ofono getting stuck a=
fter trying to check PIN authentication state: note that the sim I use is p=
in-unlocked and I tried with sims by two different italian providers.
> Looking closer at the logs, attached below, it seems the problem relates =
with calls to +CRSM always returning error. I suspect one of those commands=
 or maybe the timing they are executed with, is messing up the modem, since=
 +CPIN? returns with success before the sequence of +CRSM and sistematiccal=
ly fails after that (modem reboot required to recover).
>
> Is anybody having similar behaviour with Telit modems? Any suggestion how=
 to workaround or closer debug this issue?
>
> Regards,
> Andrea
>
> Here is the log:
>
> $ sudo OFONO_AT_DEBUG=3Dy /home/gizero/local/sbin/ofonod -n -d
>
> ofonod[5812]: oFono version 1.9
> ofonod[5812]: src/plugin.c:__ofono_plugin_init()
> ofonod[5812]: plugins/push-notification.c:push_notification_init()
> ofonod[5812]: plugins/smart-messaging.c:smart_messaging_init()
> ofonod[5812]: examples/emulator.c:example_emulator_init()
> ofonod[5812]: src/gprs-provision.c:ofono_gprs_provision_driver_register()=
 driver: 0x818fa80 name: Example GPRS context provisioning
> ofonod[5812]: src/nettime.c:ofono_nettime_driver_register() driver: 0x818=
fa40 name: Example Network Time
> ofonod[5812]: src/history.c:ofono_history_driver_register() driver: 0x818=
fa00 name: Example Call History
> ofonod[5812]: src/cdma-provision.c:ofono_cdma_provision_driver_register()=
 driver: 0x818f9c0 name: CDMA provisioning
> ofonod[5812]: src/gprs-provision.c:ofono_gprs_provision_driver_register()=
 driver: 0x818f980 name: Provisioning
> ofonod[5812]: plugins/connman.c:connman_init()
> ofonod[5812]: src/private-network.c:ofono_private_network_driver_register=
() driver: 0x818f940, name: ConnMan Private Network
> ofonod[5812]: plugins/dun_gw.c:dun_gw_init()
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f880=
, name: hfp
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f820=
, name: sap
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f7a0=
, name: telit
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f700=
, name: sim900
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f6a0=
, name: samsung
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f640=
, name: speedupcdma
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f5e0=
, name: speedup
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f580=
, name: alcatel
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f520=
, name: icera
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f4c0=
, name: linktop
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f460=
, name: nokiacdma
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f400=
, name: nokia
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f3a0=
, name: tc65
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f300=
, name: ste
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f2a0=
, name: ifx
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f240=
, name: palmpre
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f1e0=
, name: novatel
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f180=
, name: sierra
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f100=
, name: huawei
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f0a0=
, name: zte
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818f040=
, name: hso
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818efe0=
, name: mbm
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818ef80=
, name: calypso
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818ef20=
, name: wavecom
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818eec0=
, name: g1
> ofonod[5812]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()=
 driver: 0x818ee40, name: cdmamodem
> ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x818ee=
60, name: cdmamodem
> ofonod[5812]: src/cdma-connman.c:ofono_cdma_connman_driver_register() dri=
ver: 0x818ee84, name: cdmamodem
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818eda0=
, name: phonesim
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818ede0=
, name: localhfp
> ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x8=
18ed74, name: phonesim
> ofonod[5812]: src/ctm.c:ofono_ctm_driver_register() driver: 0x818ed60, na=
me: phonesim
> ofonod[5812]: plugins/phonesim.c:parse_config() filename /home/gizero/loc=
al/etc/ofono/phonesim.conf
> ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818ed20, =
name: speedupmodem
> ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0=
x818ec00, name: hfpmodem
> ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x818ec=
bc, name: hfpmodem
> ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver: 0x818e=
c60, name: hfpmodem
> ofonod[5812]: src/call-volume.c:ofono_call_volume_driver_register() drive=
r: 0x818ec94, name: hfpmodem
> ofonod[5812]: src/handsfree.c:ofono_handsfree_driver_register() driver: 0=
x818ecd8, name: hfpmodem
> ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver: 0x818e=
b80, name: dunmodem
> ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818ebac, =
name: dunmodem
> ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0=
x818eaa0, name: stemodem
> ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x8=
18eb2c, name: stemodem
> ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()=
 driver: 0x818eb00, name: stemodem
> ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0=
x818e960, name: ifxmodem
> ofonod[5812]: src/audio-settings.c:ofono_audio_settings_driver_register()=
 driver: 0x818e9b0, name: ifxmodem
> ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()=
 driver: 0x818e9e0, name: ifxmodem
> ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x8=
18ea0c, name: ifxmodem
> ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818ea34, na=
me: ifxmodem
> ofonod[5812]: src/ctm.c:ofono_ctm_driver_register() driver: 0x818ea5c, na=
me: ifxmodem
> ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x8=
18e8e0, name: hsomodem
> ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()=
 driver: 0x818e900, name: hsomodem
> ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x8=
18e840, name: mbmmodem
> ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818e868, na=
me: mbmmodem
> ofonod[5812]: src/location-reporting.c:ofono_location_reporting_driver_re=
gister() driver: 0x818e888, name: mbmmodem
> ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0=
x818e7a0, name: calypsomodem
> ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818e7e8, na=
me: calypsomodem
> ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818e680, =
name: huaweimodem
> ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0=
x818e6a0, name: huaweimodem
> ofonod[5812]: src/audio-settings.c:ofono_audio_settings_driver_register()=
 driver: 0x818e6e8, name: huaweimodem
> ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()=
 driver: 0x818e720, name: huaweimodem
> ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x8=
18e6fc, name: huaweimodem
> ofonod[5812]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register() drive=
r: 0x818e74c, name: huaweimodem
> ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x8=
18e5e0, name: iceramodem
> ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()=
 driver: 0x818e620, name: iceramodem
> ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()=
 driver: 0x818e580, name: ztemodem
> ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x8=
18e540, name: swmodem
> ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()=
 driver: 0x818e4e0, name: nwmodem
> ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0=
x818e340, name: atmodem
> ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x818e3=
e0, name: atmodem
> ofonod[5812]: src/call-barring.c:ofono_call_barring_driver_register() dri=
ver: 0x818e398, name: atmodem
> ofonod[5812]: src/call-forwarding.c:ofono_call_forwarding_driver_register=
() driver: 0x818e0e0, name: atmodem
> ofonod[5812]: src/call-meter.c:ofono_call_meter_driver_register() driver:=
 0x818e120, name: atmodem
> ofonod[5812]: src/call-settings.c:ofono_call_settings_driver_register() d=
river: 0x818dfe0, name: atmodem
> ofonod[5812]: src/phonebook.c:ofono_phonebook_driver_register() driver: 0=
x818e3b8, name: atmodem
> ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818e304, =
name: atmodem
> ofonod[5812]: src/sms.c:ofono_sms_driver_register() driver: 0x818e060, na=
me: atmodem
> ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818e1e0, na=
me: atmodem
> ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818e240, na=
me: atmodem-noef
> ofonod[5812]: src/stk.c:ofono_stk_driver_register() driver: 0x818e2e4, na=
me: atmodem
> ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver: 0x818e=
180, name: atmodem
> ofonod[5812]: src/cbs.c:ofono_cbs_driver_register() driver: 0x818e0c0, na=
me: atmodem
> ofonod[5812]: src/call-volume.c:ofono_call_volume_driver_register() drive=
r: 0x818e404, name: atmodem
> ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818e434, =
name: atmodem
> ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x8=
18e458, name: atmodem
> ofonod[5812]: src/sim-auth.c:ofono_sim_auth_driver_register() driver: 0x8=
18e470, name: atmodem
> ofonod[5812]: src/gnss.c:ofono_gnss_driver_register() driver: 0x818e488, =
name: atmodem
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818ddc0=
, name: gobi
> ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x818db=
e0, name: qmimodem
> ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver: 0x818d=
c60, name: qmimodem
> ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0=
x818dc00, name: qmimodem
> ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818dca0, na=
me: qmimodem-legacy
> ofonod[5812]: src/sms.c:ofono_sms_driver_register() driver: 0x818dd00, na=
me: qmimodem
> ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818dd20, =
name: qmimodem
> ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818dd34, =
name: qmimodem
> ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x8=
18dd48, name: qmimodem
> ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()=
 driver: 0x818dd60, name: qmimodem
> ofonod[5812]: src/location-reporting.c:ofono_location_reporting_driver_re=
gister() driver: 0x818dd84, name: qmimodem
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818db80=
, name: u8500
> ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x818db=
60, name: u8500
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818db00=
, name: n900
> ofonod[5812]: src/modem.c:ofono_modem_driver_register() driver: 0x818daa0=
, name: isiusb
> ofonod[5812]: src/modem.c:ofono_devinfo_driver_register() driver: 0x818d7=
90, name: isimodem
> ofonod[5812]: src/phonebook.c:ofono_phonebook_driver_register() driver: 0=
x818d780, name: isimodem
> ofonod[5812]: src/network.c:ofono_netreg_driver_register() driver: 0x818d=
7c0, name: isimodem
> ofonod[5812]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0=
x818d800, name: isimodem
> ofonod[5812]: src/sms.c:ofono_sms_driver_register() driver: 0x818d860, na=
me: isimodem
> ofonod[5812]: src/cbs.c:ofono_cbs_driver_register() driver: 0x818d880, na=
me: isimodem
> ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818d8a0, na=
me: isimodem
> ofonod[5812]: src/ussd.c:ofono_ussd_driver_register() driver: 0x818d8e8, =
name: isimodem
> ofonod[5812]: src/call-forwarding.c:ofono_call_forwarding_driver_register=
() driver: 0x818d900, name: isimodem
> ofonod[5812]: src/call-settings.c:ofono_call_settings_driver_register() d=
river: 0x818d920, name: isimodem
> ofonod[5812]: src/call-barring.c:ofono_call_barring_driver_register() dri=
ver: 0x818d950, name: isimodem
> ofonod[5812]: src/call-meter.c:ofono_call_meter_driver_register() driver:=
 0x818d980, name: isimodem
> ofonod[5812]: src/radio-settings.c:ofono_radio_settings_driver_register()=
 driver: 0x818d9c0, name: isimodem
> ofonod[5812]: src/gprs.c:ofono_gprs_driver_register() driver: 0x818d9e4, =
name: isimodem
> ofonod[5812]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x8=
18d9f8, name: isimodem
> ofonod[5812]: src/audio-settings.c:ofono_audio_settings_driver_register()=
 driver: 0x818da10, name: isimodem
> ofonod[5812]: src/sim.c:ofono_sim_driver_register() driver: 0x818da20, na=
me: wgmodem2.5
> ofonod[5812]: plugins/udevng.c:udev_start()
> ofonod[5812]: plugins/udevng.c:enumerate_devices()
> ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb [8087:0024]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb [067b:2303]
> ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb [046d:c310]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb [174c:5106]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb-storage [(null):(nu=
ll)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb [8087:0024]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb [067b:2303]
> ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb [046d:c016]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb [058f:6362]
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb-storage [(null):(nu=
ll)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
> ofonod[5812]: src/private-network.c:ofono_private_network_driver_register=
() driver: 0x818fae0, name: Example Private Network Driver
> ofonod[5812]: plugins/bluetooth.c:manager_properties_cb()
> ofonod[5812]: plugins/bluetooth.c:parse_adapters()
>
> > here I connect the modem to the USB
>
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb [1bc7:1003]
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
> ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0000:=
00:1a.0/usb1/1-1/1-1.4
> ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0000:=
00:1a.0/usb1/1-1/1-1.4/1-1.4:1.1/ttyUSB3/tty/ttyUSB3
> ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB3 (telit) 255/255/=
255 [01] =3D=3D> (null) (null)
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
> ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0000:=
00:1a.0/usb1/1-1/1-1.4
> ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0000:=
00:1a.0/usb1/1-1/1-1.4/1-1.4:1.2/ttyUSB4/tty/ttyUSB4
> ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB4 (telit) 255/255/=
255 [02] =3D=3D> (null) (null)
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
> ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0000:=
00:1a.0/usb1/1-1/1-1.4
> ofonod[5812]: plugins/udevng.c:add_device() /sys/devices/pci0000:00/0000:=
00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/ttyUSB2/tty/ttyUSB2
> ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB2 (telit) 255/255/=
255 [00] =3D=3D> (null) (null)
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[5812]: plugins/udevng.c:check_modem_list()
> ofonod[5812]: plugins/udevng.c:create_modem() /sys/devices/pci0000:00/000=
0:00:1a.0/usb1/1-1/1-1.4
> ofonod[5812]: plugins/udevng.c:create_modem() driver=3Dtelit
> ofonod[5812]: src/modem.c:ofono_modem_create() name: (null), type: telit
> ofonod[5812]: plugins/udevng.c:setup_telit() /sys/devices/pci0000:00/0000=
:00:1a.0/usb1/1-1/1-1.4
> ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB2 255/255/255 00 =
(null)
> ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB3 255/255/255 01 =
(null)
> ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB4 255/255/255 02 =
(null)
> ofonod[5812]: plugins/udevng.c:setup_telit() modem=3D/dev/ttyUSB2 aux=3D/=
dev/ttyUSB4 gps=3D(null) diag=3D/dev/ttyUSB3
> ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 property M=
odem
> ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 property D=
ata
> ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 property G=
PS
> ofonod[5812]: src/modem.c:ofono_modem_register() 0x8e0f140
> ofonod[5812]: plugins/telit.c:telit_probe() 0x8e0f140
> ofonod[5812]: src/modem.c:emit_modem_added() 0x8e0f140
> ofonod[5812]: src/modem.c:call_modemwatches() 0x8e0f140 added:1
> ofonod[5812]: plugins/hfp_ag.c:modem_watch() modem: 0x8e0f140, added: 1
> ofonod[5812]: plugins/dun_gw.c:modem_watch() modem: 0x8e0f140, added: 1
> ofonod[5812]: examples/emulator.c:modem_watch() modem: 0x8e0f140, added: 1
> ofonod[5812]: plugins/smart-messaging.c:modem_watch() modem: 0x8e0f140, a=
dded: 1
> ofonod[5812]: plugins/push-notification.c:modem_watch() modem: 0x8e0f140,=
 added: 1
>
> $ enable-modem /telit_0
>
> ofonod[5812]: plugins/telit.c:telit_enable() 0x8e0f140
> ofonod[5812]: src/modem.c:get_modem_property() modem 0x8e0f140 property M=
odem
> ofonod[5812]: plugins/telit.c:open_device() Modem /dev/ttyUSB2
> ofonod[5812]: Modem: > ATE0 +CMEE=3D1\r
> ofonod[5812]: Modem: < \r\nOK\r\n
> ofonod[5812]: Modem: > AT+CFUN=3D4\r
> ofonod[5812]: Modem: < \r\nOK\r\n
> ofonod[5812]: plugins/telit.c:cfun_enable_cb() 0x8e0f140
> ofonod[5812]: examples/emulator.c:powered_watch() Adding modem 0x8e0f140 =
to the list
> ofonod[5812]: examples/emulator.c:create_tcp() Created server_watch: 38
> ofonod[5812]: examples/emulator.c:create_tcp() Created server_watch: 39
> ofonod[5812]: src/modem.c:modem_change_state() old state: 0, new state: 1
> ofonod[5812]: plugins/telit.c:telit_pre_sim() 0x8e0f140
> ofonod[5812]: drivers/atmodem/sim.c:at_sim_probe() GIZERO at_sim_probe: v=
endor 15
> ofonod[5812]: Modem: > AT+GCAP\r
> ofonod[5812]: src/sim.c:ofono_sim_add_state_watch() 0x8e06a90
> ofonod[5812]: src/sim.c:ofono_sim_add_state_watch() 0x8e06a90
> ofonod[5812]: src/sim.c:ofono_sim_add_state_watch() 0x8e06a90
> ofonod[5812]: Modem: < \r\n+GCAP: +CGSM,+DS,+FCLASS,+MS,+ES\r\n\r\nOK\r\n
> ofonod[5812]: Modem: > AT+CRC=3D1\r
> ofonod[5812]: Modem: < \r\nOK\r\n
> ofonod[5812]: Modem: > AT+CLIP=3D1\r
> ofonod[5812]: Modem: < \r\nOK\r\n
> ofonod[5812]: Modem: > AT+CDIP=3D1\r
> ofonod[5812]: Modem: < \r\nERROR\r\n
> ofonod[5812]: Modem: > AT+CNAP=3D1\r
> ofonod[5812]: Modem: < \r\nERROR\r\n
> ofonod[5812]: Modem: > AT+COLP=3D1\r
> ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
> ofonod[5812]: Modem: > AT+CSSN=3D1,1\r
> ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
> ofonod[5812]: Modem: > AT+VTD?\r
> ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
> ofonod[5812]: Modem: > AT+CCWA=3D1\r
> ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
> ofonod[5812]: drivers/atmodem/voicecall.c:at_voicecall_initialized() voic=
ecall_init: registering to notifications
> ofonod[5812]: src/sim.c:ofono_sim_add_state_watch() 0x8e06a90
> ofonod[5812]: Modem: > AT#QSS=3D1\r
> ofonod[5812]: Modem: < \r\nOK\r\n
> ofonod[5812]: Modem: > AT#QSS?\r
> ofonod[5812]: Modem: < \r\n#QSS: 1,1\r\n\r\nOK\r\n
> ofonod[5812]: plugins/telit.c:telit_qss_cb() 0x8e0f140
> ofonod[5812]: plugins/telit.c:switch_sim_state_status() 0x8e0f140
> ofonod[5812]: plugins/telit.c:switch_sim_state_status() SIM inserted
> ofonod[5812]: Modem: > AT+CGMI\r
> ofonod[5812]: Modem: < \r\nTelit\r\n\r\nOK\r\n
> ofonod[5812]: Modem: > AT+CLCC\r
> ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
> ofonod[5812]: Modem: > AT+CGMM\r
> ofonod[5812]: Modem: < \r\nUC864-E\r\n\r\nOK\r\n
> ofonod[5812]: Modem: > AT+CGMR\r
> ofonod[5812]: Modem: < \r\n08.01.005\r\n\r\nOK\r\n
> ofonod[5812]: Modem: > AT+CGSN\r
> ofonod[5812]: Modem: < \r\n352636020412768\r\n\r\nOK\r\n
> ofonod[5812]: plugins/telit.c:sim_inserted_timeout_cb() 0x8e0f140
> ofonod[5812]: Modem: > AT+CRSM=3D192,28599\r
> ofonod[5812]: Modem: < \r\n+CME ERROR: 100\r\n
> ofonod[5812]: src/voicecall.c:ecc_g2_read_cb() 0
> ofonod[5812]: Modem: > AT+CRSM=3D192,28599\r
> ofonod[5812]: Modem: < \r\n+CME ERROR: 100\r\n
> ofonod[5812]: src/voicecall.c:ecc_g3_read_cb() 0
> ofonod[5812]: Modem: > AT+CRSM=3D192,12258\r
> ofonod[5812]: Modem: < \r\n+CME ERROR: 100\r\n
> ofonod[5812]: Modem: > AT+CRSM=3D192,28421\r
> ofonod[5812]: Modem: < \r\n+CME ERROR: 100\r\n
> ofonod[5812]: Modem: > AT+CRSM=3D192,12037\r
> ofonod[5812]: Modem: < \r\n+CME ERROR: 100\r\n
> ofonod[5812]: Modem: > AT+CPIN?\r
> ofonod[5812]: Modem: < \r\n+CME ERROR: 10\r\n
> ofonod[5812]: Querying PIN authentication state failed
>
> According to your log, there is no SIM inserted, this is why you got thos=
e errors.

Why are you inferring this? What I see in the log is
switch_sim_state_status() reporting the SIM being inserted... That is
the only report of SIM presence I can see.

ofonod[5812]: plugins/telit.c:telit_qss_cb() 0x8e0f140
ofonod[5812]: plugins/telit.c:switch_sim_state_status() 0x8e0f140
ofonod[5812]: plugins/telit.c:switch_sim_state_status() SIM inserted

> But the enable-modem looks good. Did you do a ./list-modems to see the cu=
rrent modem info?

This is what ./list-modems reports after connecting the modem:

[ /telit_0 ]
    Features =3D
    Emergency =3D 0
    Powered =3D 0
    Lockdown =3D 0
    Interfaces =3D
    Online =3D 0
    Type =3D hardware

After issuing ./enable-modem I get:

[ /telit_0 ]
    Features =3D sim
    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.VoiceCallManager org.ofono.SimManager
    Online =3D 0
    Model =3D UC864-E
    Revision =3D 08.01.005
    Type =3D hardware
    Serial =3D 352636020412669
    Manufacturer =3D Telit
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 08 000 999 110 112 911 118 119
    [ org.ofono.SimManager ]
        Retries =3D
        FixedDialing =3D 0
        SubscriberNumbers =3D
        BarredDialing =3D 0
        LockedPins =3D
        PinRequired =3D none
        Present =3D 1

which I guess confirms the sim presence

> And if you insert a SIM, did you tried an ./online-modem?

The sim has always been inserted and is working fine. Just tried to
remove and re-insert and I see the following in the logs:

------------ sim removed ---------------

ofonod[27250]: Modem: < \r\n#QSS: 0\r\n
ofonod[27250]: plugins/telit.c:telit_qss_notify() 0x9a3c140
ofonod[27250]: plugins/telit.c:switch_sim_state_status() 0x9a3c140
ofonod[27250]: plugins/telit.c:switch_sim_state_status() SIM not inserted
ofonod[27250]: src/modem.c:modem_change_state() old state: 1, new state: 1

------------ sim inserted ---------------

ofonod[27250]: Modem: < \r\n#QSS: 1\r\n
ofonod[27250]: plugins/telit.c:telit_qss_notify() 0x9a3c140
ofonod[27250]: plugins/telit.c:switch_sim_state_status() 0x9a3c140
ofonod[27250]: plugins/telit.c:switch_sim_state_status() SIM inserted
ofonod[27250]: plugins/telit.c:sim_inserted_timeout_cb() 0x9a3c140
ofonod[27250]: Modem: > AT+CRSM=3D192,28599\r
ofonod[27250]: Modem: < \r\n+CME ERROR: 3\r\n
ofonod[27250]: src/voicecall.c:ecc_g2_read_cb() 0
ofonod[27250]: Modem: > AT+CRSM=3D192,28599\r
ofonod[27250]: Modem: < \r\n+CME ERROR: 3\r\n
ofonod[27250]: src/voicecall.c:ecc_g3_read_cb() 0
ofonod[27250]: Modem: > AT+CRSM=3D192,12258\r
ofonod[27250]: Modem: < \r\n+CME ERROR: 3\r\n
ofonod[27250]: Modem: > AT+CRSM=3D192,28421\r
ofonod[27250]: Modem: < \r\n+CME ERROR: 3\r\n
ofonod[27250]: Modem: > AT+CRSM=3D192,12037\r
ofonod[27250]: Modem: < \r\n+CME ERROR: 3\r\n
ofonod[27250]: Modem: > AT+CPIN?\r
ofonod[27250]: Modem: < \r\n+CME ERROR: 10\r\n
ofonod[27250]: Querying PIN authentication state failed

Running ./online-modem reports:

ofonod[27250]: plugins/telit.c:telit_set_online() modem 0x9a3c140 online
ofonod[27250]: Modem: > AT+CFUN=3D1\r
ofonod[27250]: Modem: < \r\nOK\r\n
ofonod[27250]: src/modem.c:common_online_cb() Online in PRE SIM state

and ./list-modems updates as follows:

[ /telit_0 ]
    Features =3D sim
    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.VoiceCallManager org.ofono.SimManager
    Online =3D 1
    Model =3D UC864-E
    Revision =3D 08.01.005
    Type =3D hardware
    Serial =3D 352636020412669
    Manufacturer =3D Telit
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 08 000 999 110 112 911 118 119
    [ org.ofono.SimManager ]
        Retries =3D
        FixedDialing =3D 0
        SubscriberNumbers =3D
        BarredDialing =3D 0
        LockedPins =3D
        PinRequired =3D none
        Present =3D 1


I need to look@some more documentation but I'm suspecting +CPIN
here is run when +CFUN=3D4 which is probably the reason for +CPIN to
fail, since the modem documentation says:

"
Note: issuing AT+CFUN=3D4[,0] actually causes the module to perform either a
network deregistration and a SIM deactivation.
"

--===============2918344096729384410==--


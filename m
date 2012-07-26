Content-Type: multipart/mixed; boundary="===============4074688363740820399=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: Testing Telit GT864-3G compatibility with ofono
Date: Thu, 26 Jul 2012 11:16:07 +0200
Message-ID: <50110AD7.80005@linux.intel.com>
In-Reply-To: <CAC+thW2AnS0U5CGst4CiBfpbY5LZq=RX0-wKBmnmjbxwOkQWNQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4074688363740820399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 07/25/2012 02:50 PM, Andrea Galbusera wrote:
> Hi,
>
> I'm doing some tests with Telit GT864-3G terminal connected to USB with
> ofono 1.9. This modem uses UC864-E core. Since ofono provides a driver
> for UC864-G core, I hope managing it with ofono should be quite
> straightforward. One difference between the two cores is that UC864-G
> does expose 4 serial devices: after a quick fix I got "modem" and "aux"
> channel correctly assigned. The problem I see here when I run
> enable-modem is ofono getting stuck after trying to check PIN
> authentication state: note that the sim I use is pin-unlocked and I
> tried with sims by two different italian providers.
> Looking closer at the logs, attached below, it seems the problem relates
> with calls to +CRSM always returning error. I suspect one of those
> commands or maybe the timing they are executed with, is messing up the
> modem, since +CPIN? returns with success before the sequence of +CRSM
> and sistematiccally fails after that (modem reboot required to recover).
>
> Is anybody having similar behaviour with Telit modems? Any suggestion
> how to workaround or closer debug this issue?
>
> Regards,
> Andrea
>
> Here is the log:
>

<snip>

>
>  > here I connect the modem to the USB
>
> ofonod[5812]: plugins/udevng.c:check_usb_device() usb [1bc7:1003]
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
> ofonod[5812]: plugins/udevng.c:add_device()
> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
> ofonod[5812]: plugins/udevng.c:add_device()
> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.1/ttyUSB3/tty=
/ttyUSB3
> ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB3 (telit)
> 255/255/255 [01] =3D=3D> (null) (null)
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
> ofonod[5812]: plugins/udevng.c:add_device()
> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
> ofonod[5812]: plugins/udevng.c:add_device()
> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.2/ttyUSB4/tty=
/ttyUSB4
> ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB4 (telit)
> 255/255/255 [02] =3D=3D> (null) (null)
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
> ofonod[5812]: plugins/udevng.c:add_device()
> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
> ofonod[5812]: plugins/udevng.c:add_device()
> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/ttyUSB2/tty=
/ttyUSB2
> ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB2 (telit)
> 255/255/255 [00] =3D=3D> (null) (null)
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[5812]: plugins/udevng.c:check_modem_list()
> ofonod[5812]: plugins/udevng.c:create_modem()
> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
> ofonod[5812]: plugins/udevng.c:create_modem() driver=3Dtelit
> ofonod[5812]: src/modem.c:ofono_modem_create() name: (null), type: telit
> ofonod[5812]: plugins/udevng.c:setup_telit()
> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
> ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB2 255/255/255 00
> (null)
> ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB3 255/255/255 01
> (null)
> ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB4 255/255/255 02
> (null)
> ofonod[5812]: plugins/udevng.c:setup_telit() modem=3D/dev/ttyUSB2
> aux=3D/dev/ttyUSB4 gps=3D(null) diag=3D/dev/ttyUSB3
> ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 property
> Modem
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
> ofonod[5812]: plugins/smart-messaging.c:modem_watch() modem: 0x8e0f140,
> added: 1
> ofonod[5812]: plugins/push-notification.c:modem_watch() modem:
> 0x8e0f140, added: 1
>
> $ enable-modem /telit_0
>
> ofonod[5812]: plugins/telit.c:telit_enable() 0x8e0f140
> ofonod[5812]: src/modem.c:get_modem_property() modem 0x8e0f140 property
> Modem
> ofonod[5812]: plugins/telit.c:open_device() Modem /dev/ttyUSB2


First, I suggest to try with the auxiliary port /dev/ttyUSB4. Perhaps =

with this revision, the modem port is not supporting SIM access request.

If it works, then I presume you would need to change the telit plugin to =

use the auxiliary port by default and the modem port only for =

'gprs_context' purpose.

Regards,

Philippe.

> ofonod[5812]: Modem: > ATE0 +CMEE=3D1\r
> ofonod[5812]: Modem: < \r\nOK\r\n
> ofonod[5812]: Modem: > AT+CFUN=3D4\r
> ofonod[5812]: Modem: < \r\nOK\r\n
> ofonod[5812]: plugins/telit.c:cfun_enable_cb() 0x8e0f140
> ofonod[5812]: examples/emulator.c:powered_watch() Adding modem 0x8e0f140
> to the list
> ofonod[5812]: examples/emulator.c:create_tcp() Created server_watch: 38
> ofonod[5812]: examples/emulator.c:create_tcp() Created server_watch: 39
> ofonod[5812]: src/modem.c:modem_change_state() old state: 0, new state: 1
> ofonod[5812]: plugins/telit.c:telit_pre_sim() 0x8e0f140
> ofonod[5812]: drivers/atmodem/sim.c:at_sim_probe() GIZERO at_sim_probe:
> vendor 15
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
> ofonod[5812]: drivers/atmodem/voicecall.c:at_voicecall_initialized()
> voicecall_init: registering to notifications
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
>
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono


--===============4074688363740820399==--


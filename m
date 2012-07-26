Content-Type: multipart/mixed; boundary="===============8443539209639644908=="
MIME-Version: 1.0
From: Andrea Galbusera <gizero@gmail.com>
Subject: Re: Testing Telit GT864-3G compatibility with ofono
Date: Thu, 26 Jul 2012 15:21:01 +0200
Message-ID: <CAC+thW2wWVXrX_hx5AhUAskNf-3f1MsCv4Ho0j8LUPJ4mNmCag@mail.gmail.com>
In-Reply-To: <50110AD7.80005@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8443539209639644908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Thu, Jul 26, 2012 at 11:16 AM, Philippe Nunes
<philippe.nunes@linux.intel.com> wrote:
> Hi,
>
>
> On 07/25/2012 02:50 PM, Andrea Galbusera wrote:
>>
>> Hi,
>>
>> I'm doing some tests with Telit GT864-3G terminal connected to USB with
>> ofono 1.9. This modem uses UC864-E core. Since ofono provides a driver
>> for UC864-G core, I hope managing it with ofono should be quite
>> straightforward. One difference between the two cores is that UC864-G
>> does expose 4 serial devices: after a quick fix I got "modem" and "aux"
>> channel correctly assigned. The problem I see here when I run
>> enable-modem is ofono getting stuck after trying to check PIN
>> authentication state: note that the sim I use is pin-unlocked and I
>> tried with sims by two different italian providers.
>> Looking closer at the logs, attached below, it seems the problem relates
>> with calls to +CRSM always returning error. I suspect one of those
>> commands or maybe the timing they are executed with, is messing up the
>> modem, since +CPIN? returns with success before the sequence of +CRSM
>> and sistematiccally fails after that (modem reboot required to recover).
>>
>> Is anybody having similar behaviour with Telit modems? Any suggestion
>> how to workaround or closer debug this issue?
>>
>> Regards,
>> Andrea
>>
>> Here is the log:
>>
>
> <snip>
>
>
>>
>>  > here I connect the modem to the USB
>>
>> ofonod[5812]: plugins/udevng.c:check_usb_device() usb [1bc7:1003]
>> ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
>> ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
>> ofonod[5812]: plugins/udevng.c:check_usb_device() option [(null):(null)]
>> ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
>> ofonod[5812]: plugins/udevng.c:add_device()
>> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
>> ofonod[5812]: plugins/udevng.c:add_device()
>>
>> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.1/ttyUSB3/tt=
y/ttyUSB3
>> ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB3 (telit)
>> 255/255/255 [01] =3D=3D> (null) (null)
>> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
>> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
>> ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
>> ofonod[5812]: plugins/udevng.c:add_device()
>> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
>> ofonod[5812]: plugins/udevng.c:add_device()
>>
>> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.2/ttyUSB4/tt=
y/ttyUSB4
>> ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB4 (telit)
>> 255/255/255 [02] =3D=3D> (null) (null)
>> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
>> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
>> ofonod[5812]: plugins/udevng.c:check_usb_device() option [1bc7:1003]
>> ofonod[5812]: plugins/udevng.c:add_device()
>> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
>> ofonod[5812]: plugins/udevng.c:add_device()
>>
>> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/ttyUSB2/tt=
y/ttyUSB2
>> ofonod[5812]: plugins/udevng.c:add_device() /dev/ttyUSB2 (telit)
>> 255/255/255 [00] =3D=3D> (null) (null)
>> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty add
>> ofonod[5812]: plugins/udev.c:udev_event() subsystem tty finished
>> ofonod[5812]: plugins/udevng.c:check_modem_list()
>> ofonod[5812]: plugins/udevng.c:create_modem()
>> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
>> ofonod[5812]: plugins/udevng.c:create_modem() driver=3Dtelit
>> ofonod[5812]: src/modem.c:ofono_modem_create() name: (null), type: telit
>> ofonod[5812]: plugins/udevng.c:setup_telit()
>> /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4
>> ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB2 255/255/255 00
>> (null)
>> ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB3 255/255/255 01
>> (null)
>> ofonod[5812]: plugins/udevng.c:setup_telit() /dev/ttyUSB4 255/255/255 02
>> (null)
>> ofonod[5812]: plugins/udevng.c:setup_telit() modem=3D/dev/ttyUSB2
>> aux=3D/dev/ttyUSB4 gps=3D(null) diag=3D/dev/ttyUSB3
>> ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 property
>> Modem
>> ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 property
>> Data
>> ofonod[5812]: src/modem.c:set_modem_property() modem 0x8e0f140 property
>> GPS
>> ofonod[5812]: src/modem.c:ofono_modem_register() 0x8e0f140
>> ofonod[5812]: plugins/telit.c:telit_probe() 0x8e0f140
>> ofonod[5812]: src/modem.c:emit_modem_added() 0x8e0f140
>> ofonod[5812]: src/modem.c:call_modemwatches() 0x8e0f140 added:1
>> ofonod[5812]: plugins/hfp_ag.c:modem_watch() modem: 0x8e0f140, added: 1
>> ofonod[5812]: plugins/dun_gw.c:modem_watch() modem: 0x8e0f140, added: 1
>> ofonod[5812]: examples/emulator.c:modem_watch() modem: 0x8e0f140, added:=
 1
>> ofonod[5812]: plugins/smart-messaging.c:modem_watch() modem: 0x8e0f140,
>> added: 1
>> ofonod[5812]: plugins/push-notification.c:modem_watch() modem:
>> 0x8e0f140, added: 1
>>
>> $ enable-modem /telit_0
>>
>> ofonod[5812]: plugins/telit.c:telit_enable() 0x8e0f140
>> ofonod[5812]: src/modem.c:get_modem_property() modem 0x8e0f140 property
>> Modem
>> ofonod[5812]: plugins/telit.c:open_device() Modem /dev/ttyUSB2
>
>
>
> First, I suggest to try with the auxiliary port /dev/ttyUSB4. Perhaps with
> this revision, the modem port is not supporting SIM access request.

It doesn't seem to be an issue with SIM access over the MDM port. Same
result when using the modem's AUX port...

> If it works, then I presume you would need to change the telit plugin to =
use
> the auxiliary port by default and the modem port only for 'gprs_context'
> purpose.

--===============8443539209639644908==--


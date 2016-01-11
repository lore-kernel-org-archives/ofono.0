Content-Type: multipart/mixed; boundary="===============3832578029092953580=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Mon, 11 Jan 2016 11:18:12 -0600
Message-ID: <5693E3D4.2060804@gmail.com>
In-Reply-To: <CADnUhn0c1g7zu2aORxRZzyRK2tkGvZw0PugFvgV2WUWy4V5NGg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3832578029092953580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On 01/11/2016 09:02 AM, matti kaasinen wrote:
> Denis,
> I noticed from the logs that 'net' should have been probed by
> huawei_cdc_ncm module instead of plain cdc_ncm. I managed getting sysfs
> lines after "net finished" line in ofonod log after changing cdc_ncm to
> huawei_cdc_ncm (below):
> ..plugins/udev.c:udev_event() subsystem net finished
> ..plugins/udevng.c:check_usb_device() huawei_cdc_ncm [12d1:1506]
> ..plugins/udevng.c:add_device()
> /sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb2=
/2-1
> ..plugins/udevng.c:add_device()
> /sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb2=
/2-1/2-1:1.1/net/wwan0
> ..plugins/udevng.c:add_device() wwan0 (huawei) 255/2/22  =3D=3D> (null) (=
null)
>
>
> I also got net record from setup_huawei() printout:
> ..plugins/udevng.c:setup_huawei() mdm=3D/dev/ttyUSB0 pcui=3D/dev/ttyUSB2
> diag=3D/dev/ttyUSB1 qmi=3D(null) net=3Dwwan0
>

So looks like your device is detected properly now.

>
> Now this process proceeded further providing printout from
> provision_get_settings():
> ..plugins/provision.c:provision_get_settings() Provisioning for MCC 244,
> MNC 05, SPN 'elisa'
> ..plugins/provision.c:provision_get_settings() Found 1 APs
> ..plugins/provision.c:provision_get_settings() Name: '(null)'
> ..plugins/provision.c:provision_get_settings() APN: 'internet'
> ..plugins/provision.c:provision_get_settings() Type:
> OFONO_GPRS_CONTEXT_TYPE_INTERNET
> ..plugins/provision.c:provision_get_settings() Username: '(null)'
> ..plugins/provision.c:provision_get_settings() Password: '(null)'
>

And at least reading EFspn from the SIM works. So provisioning succeeds.

>
> After that came some errors:
> ..src/sim.c:ofono_sim_remove_spn_watch() 0x11cf60
> ofonod: PCUI: > AT+CPBS=3D?\r
> ofonod: PCUI: < \r\n+CME ERROR: 14\r\n
> ofonod: PCUI: > AT+CPBS=3D?\r
> ofonod: PCUI: < \r\n+CME ERROR: 14\r\n
> ofonod: PCUI: > AT+CPBS=3D?\r
> ofonod: PCUI: < \r\n+CPBS: ("SM","EN","ON")\r\n\r\nOK\r\n

This is a separate issue.  The phonebook is not ready for reading. =

Shouldn't affect data connections though...

>
> I did not see any progress on connman side.
>
> Modifications in plugins/udevng.c
> vendor_list[]:
>      { "huawei",    "huawei_cdc_ncm",    "12d1"        },
>
> setup_huawei():
>                  g_strcmp0(info->interface, "255/2/22") =3D=3D 0 ||
>                  g_strcmp0(info->interface, "255/1/56") =3D=3D 0) {
>              net =3D info->devnode;
>

Feel free to send a patch for this.

>
> Where should I look next?
> I could provide full log, but I am not sure if attachments/messages with
> attachments pass through.

What does list-contexts show?  Can you do test/online-modem and =

test/activate-context, test/process-context-settings?

The logs should show up fine.

Regards,
-Denis

--===============3832578029092953580==--


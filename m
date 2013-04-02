Content-Type: multipart/mixed; boundary="===============7087328461514234664=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Tue, 02 Apr 2013 17:25:42 +0200
Message-ID: <515AF876.8010500@syscom-instruments.com>
In-Reply-To: <515AF457.2000102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7087328461514234664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 02. 04. 13 17:08, Denis Kenzior wrote:
>
> I doubt provisioning has anything to do with this. That is only for
> activating a context.

Indeed, I tried to remove duplicate entries, provisioning is good but =

SMS fail with GPRS enabled.

I see stange behavior too. When I try to re-enabled a disabled GPRS =

context (Active true --> Active false --> Active true), I've got an error:

----------------------------
ofonod[25358]: Modem: > AT+CGDATA=3D"PPP",1\r
ofonod[25358]: Modem: < \r\nCONNECT 115200\r\n
ofonod[25358]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
ofonod[25358]: drivers/atmodem/gprs-context.c:setup_ppp()
ofonod[25358]: drivers/atmodem/gprs-context.c:ppp_connect()
ofonod[25358]: IP: 10.47.176.26
ofonod[25358]: DNS: 10.74.210.210, 10.74.210.211
ofonod[25358]: src/gprs.c:pri_activate_callback() 0x101a58
ofonod[25358]: plugins/udev.c:udev_event() subsystem net add
ofonod[25358]: plugins/udev.c:udev_event() subsystem net finished
ofonod[25358]: plugins/udevng.c:check_modem_list()
ofonod[25358]: =

drivers/atmodem/gprs-context.c:at_gprs_deactivate_primary() cid 1
ofonod[25358]: plugins/udevng.c:remove_device() =

/sys/devices/virtual/net/ppp0
ofonod[25358]: plugins/udev.c:udev_event() subsystem net remove
ofonod[25358]: plugins/udev.c:remove_modem() /devices/virtual/net/ppp0
ofonod[25358]: plugins/udev.c:udev_event() subsystem net finished
ofonod[25358]: drivers/atmodem/gprs-context.c:ppp_disconnect() Reason: 6
ofonod[25358]: Modem: < \r\nNO CARRIER\r\n
ofonod[25358]: Data: < \r\nNO CARRIER\r\n
ofonod[25358]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary() =

cid 1
ofonod[25358]: src/gprs.c:pri_activate_callback() 0x101a58
ofonod[25358]: src/gprs.c:pri_activate_callback() Activating context =

failed with error: Unknown error type
----------------------------

But it works well on the first activation... I need to investiguate this =

issue to see what happenning in the source code.

>
> This is automatic provisioning. If there are multiple possibilities that
> fit, then this requires user input. Obviously oFono does not support
> user input, so a UI of some sort to finish provisioning is required.
>

Yes of course ! Sorry, I've chocolate instead of brain since few days.

Regards,

--===============7087328461514234664==--


Content-Type: multipart/mixed; boundary="===============1416101343735885245=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: Re: [PATCH 1/1] udev: add serial_info struct to modem
Date: Sat, 09 Sep 2017 10:40:33 -0700
Message-ID: <20170909174033.GC3@computer.craftyguy.net>
In-Reply-To: <20170909090519.20523-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1416101343735885245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

This looks MUCH better!! Just to re-cap, it took the application of
all three of the patches you sent over to get this to finally come up.


ofonod[1800]: plugins/nokia-gpio.c:phonet_status_cb() Link phonet0 (2) is d=
own
ofonod[1800]: plugins/nokia-gpio.c:gpio_power_state_machine() (POWER_EVENT_=
PHONET_LINK_DOWN) @ state POWER_STATE_NONE
ofonod[1800]: plugins/nokia-gpio.c:gpio_power_set_state() (POWER_STATE_OFF)=
 at (POWER_STATE_NONE)
ofonod[1800]: plugins/nokia-gpio.c:gpio_finish_modem_power_off()
ofonod[1800]: plugins/nokia-gpio.c:gpio_write() ("cmt_apeslpx", "inactive")
ofonod[1800]: plugins/nokia-gpio.c:gpio_write() ("cmt_rst_rq", "inactive")
ofonod[1800]: plugins/nokia-gpio.c:gpio_write() ("cmt_en", "inactive")
ofonod[1800]: plugins/nokia-gpio.c:gpio_write() ("cmt_rst", "inactive")
ofonod[1800]: plugins/nokia-gpio.c:gpio_write() ("cmt_rst", "active")
ofonod[1800]: plugins/n900.c:n900_power_cb() power state POWER_STATE_OFF
ofonod[1800]: plugins/n900.c:n900_enable() modem=3D0x617ad0 with 0x617cd0



localhost:/home/user/ofono# python2 test/list-modems
[ /n900_2 ]
    Features =3D sim
    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.SimManager org.ofono.VoiceCallManager org.ofon=
o.AudioSettings
    Online =3D 0
    Model =3D Nokia N900
    Revision =3D V ICPR82_10w08
25-02-10
RX-51
(c) Nokia
    Type =3D hardware
    Serial =3D 356938037199412
    Manufacturer =3D Nokia
    [ org.ofono.SimManager ]
        Present =3D 0
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 08 000 999 110 112 911 118 119
    [ org.ofono.AudioSettings ]
        Active =3D 0

Going to test some of the more 'advanced' features now :)

-Clayton


On Sat, Sep 09, 2017 at 11:05:19AM +0200, Jonas Bonn wrote:
>---
>Hi Clayton,
>
>Sorry, I messed up the earlier patch.  It should be like this, I think.
>
>/Jonas
>
> plugins/udevng.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/plugins/udevng.c b/plugins/udevng.c
>index 5767259..a4b99aa 100644
>--- a/plugins/udevng.c
>+++ b/plugins/udevng.c
>@@ -1355,7 +1355,7 @@ static void add_serial_device(struct udev_device *de=
v)
> 	info->subsystem =3D g_strdup(subsystem);
> 	info->dev =3D udev_device_ref(dev);
>
>-	modem->devices =3D g_slist_append(modem->devices, info);
>+	modem->serial =3D info;
> }
>
> static void add_device(const char *syspath, const char *devname,
>-- =

>2.9.3
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>https://lists.ofono.org/mailman/listinfo/ofono


--===============1416101343735885245==--


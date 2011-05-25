Content-Type: multipart/mixed; boundary="===============3186962243794568220=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 1/2] Add basic Telit UC864-G support:
Date: Wed, 25 May 2011 09:12:37 -0700
Message-ID: <1306339957.2681.22.camel@aeonflux>
In-Reply-To: <4DDCFDBE.3050905@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3186962243794568220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernhard,

> >> +	 * +CFUN=3D1: mobile full functionality with power saving disabled (=
factory default).
> >> +	 * +CFUN=3D5: mobile full functionality with power saving enabled.
> >> +	 */
> >> +	g_at_chat_send(chat, "AT+CFUN=3D1", none_prefix, cfun_enable_cb, mod=
em, NULL);
> > If you are supporting online mode, then this is wrong. You need to start
> > in offline mode. So most likely CFUN=3D4.
> >
> =

> Ok, I switched it. The only problem about being in state 4 is that #QSS =

> returns "sim not inserted". But after test/online-modem everything wakes =

> up properly. I was not sure about attaching a full log or not. I can =

> upload it to pastebin if you like.
> =

> ...
> ofonod[5796]: src/sim.c:ofono_sim_add_state_watch() 0x9488ad0
> ofonod[5796]: Modem: > AT#QSS=3D1\r
> ofonod[5796]: Modem: < \r\nOK\r\n
> ofonod[5796]: Modem: > AT#QSS?\r
> ofonod[5796]: Modem: < \r\n#QSS: 1,0\r\n\r\nOK\r\n
> ofonod[5796]: plugins/telit.c:telit_qss_cb() SIM not inserted
> ofonod[5796]: Modem: > AT+CGMI\r
> ofonod[5796]: Modem: < \r\nTelit\r\n\r\nOK\r\n
> ofonod[5796]: Modem: > AT+CLCC\r
> ofonod[5796]: Modem: < \r\n+CME ERROR: 10\r\n
> ofonod[5796]: Modem: > AT+CGMM\r
> ofonod[5796]: Modem: < \r\nUC864-G\r\n\r\nOK\r\n
> ofonod[5796]: Modem: > AT+CGMR\r
> ofonod[5796]: Modem: < \r\n08.01.107\r\n\r\nOK\r\n
> ofonod[5796]: Modem: > AT+CGSN\r
> ofonod[5796]: Modem: < \r\n356265021006068\r\n\r\nOK\r\n
> ofonod[5796]: plugins/telit.c:telit_set_online() modem 0x9488438 online
> ofonod[5796]: Modem: > AT+CFUN=3D1\r
> ofonod[5796]: Modem: < \r\nOK\r\n
> ofonod[5796]: src/modem.c:common_online_cb() Online in PRE SIM state
> ofonod[5796]: Modem: < \r\n#QSS: 1\r\n
> ofonod[5796]: plugins/telit.c:telit_qss_notify() SIM inserted
> ofonod[5796]: Modem: > AT+CRSM=3D192,28599\r
> ...

you need to handle SIM hotswap if the modem does support and report it.
Check how other modem plugins do it.

> >> +		/* enable sim state notification */
> >> +		g_at_chat_send(chat, "AT#QSS=3D1", NULL, NULL, NULL, NULL);
> >> +		g_at_chat_register(chat, "#QSS:", telit_qss_notify, FALSE, sim, NUL=
L);
> >> +		/* query current sim state */
> >> +		g_at_chat_send(chat, "AT#QSS?", NULL, telit_qss_cb, sim, NULL);
> > Using NULL for prefix is most likely wrong here. Can you show us some
> > examples logs with OFONO_AT_DEBUG=3D1 for this?
> >
> =

> ofonod[30582]: drivers/atmodem/voicecall.c:at_voicecall_initialized() =

> voicecall_init: registering to notifications
> ofonod[30582]: src/sim.c:ofono_sim_add_state_watch() 0x18cb6b0
> ofonod[30582]: > AT#QSS=3D1\r
> ofonod[30582]: < \r\nOK\r\n
> ofonod[30582]: > AT#QSS?\r
> ofonod[30582]: < \r\n#QSS: 1,1\r\n\r\nOK\r\n
> ofonod[30582]: plugins/telit.c:telit_qss_cb() SIM inserted
> ofonod[30582]: > AT+CGMI\r
> ofonod[30582]: < \r\nTelit\r\n\r\nOK\r\n
> ofonod[30582]: > AT+CLCC\r
> ofonod[30582]: < \r\nOK\r\n
> =

> But I followed your adwise and added a prefix for #QSS for the new patch =

> (see output above)

For AT#QSS=3D1 you do want to use none_prefix. And for AT#QSS? you want to
use a special qss_prefix.

In case you are using NULL as prefix it would consume all events and
that means that any other unsolicited notification will be missed.

> >> +	if (gps)
> >> +		g_at_chat_send(chat, "AT$GPSP=3D1", NULL, NULL, NULL, NULL);
> > So in general the post_online, pre_sim and post_sim states should only
> > be used to add atoms and not to send commands.
> >
> > If you wanna support GPS, then please create a proper atom driver
> > specific for the Telit modem.
> >
> =

> Ok, I will remove the GPS attempts of the patch and try to support it =

> later.
> =

> As far as I read the doc a correct implemented GPS atom is opening the =

> GPS tty line, so I cannot longer use it with gypsy?

It does not need to be. You can have multiple TTY and also the location
reporting atoms return a file descriptor via D-Bus. So that would be
easy to use from Gypsy as well. However the TTY is actually owned by
oFono in the end.

> >> +static void add_telit(struct ofono_modem *modem,
> >> +					struct udev_device *udev_device)
> >> +{
> >> +	struct udev_list_entry *entry;
> >> +	const char *devnode;
> >> +	gboolean found =3D FALSE;
> >> +	gboolean gps =3D FALSE;
> >> +
> >> +	DBG("modem %p", modem);
> >> +
> >> +	entry =3D udev_device_get_properties_list_entry(udev_device);
> >> +	while (entry) {
> >> +		const char *name =3D udev_list_entry_get_name(entry);
> >> +		const char *value =3D udev_list_entry_get_value(entry);
> >> +
> >> +		if (g_str_equal(name, "OFONO_TELIT_TYPE") =3D=3D TRUE&&
> >> +					g_str_equal(value, "modem") =3D=3D TRUE) {
> >> +			found =3D TRUE;
> >> +		}
> >> +		if (g_str_equal(name, "OFONO_TELIT_MODEL") =3D=3D TRUE&&
> >> +					g_str_equal(value, "UC864-G") =3D=3D TRUE) {
> >> +			gps =3D TRUE;
> >> +		}
> >> +		entry =3D udev_list_entry_get_next(entry);
> >> +	}
> >> +
> >> +	if (found =3D=3D FALSE)
> >> +		return;
> >> +
> >> +	devnode =3D udev_device_get_devnode(udev_device);
> >> +	ofono_modem_set_string(modem, "Device", devnode);
> >> +
> >> +	if(gps)
> >> +		ofono_modem_set_integer(modem, "GPS", 1);
> >> +
> >> +	ofono_modem_register(modem);
> >> +}
> >> +
> >
> > Do you happen to have the output of /proc/bus/usb/devices for this
> > device?
> >
> =

> #uname -a
> Linux entw48 2.6.32-28-generic #55-Ubuntu SMP Mon Jan 10 23:42:43 UTC =

> 2011 x86_64 GNU/Linux
> =

> # ls -lah /proc/bus/
> total 0
> dr-xr-xr-x   4 root root 0 2011-05-25 14:32 .
> dr-xr-xr-x 237 root root 0 2011-05-24 10:53 ..
> dr-xr-xr-x   2 root root 0 2011-05-25 14:32 input
> dr-xr-xr-x   3 root root 0 2011-05-25 14:32 pci
> =

> =

> root(a)entw48:~# ls -lah /sys/bus/usb-serial/devices/
> total 0
> drwxr-xr-x 2 root root 0 2011-05-25 14:33 .
> drwxr-xr-x 4 root root 0 2011-05-25 14:32 ..
> lrwxrwxrwx 1 root root 0 2011-05-25 14:33 ttyUSB0 -> =

> ../../../devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.0/ttyUSB0
> lrwxrwxrwx 1 root root 0 2011-05-25 14:33 ttyUSB1 -> =

> ../../../devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.1/ttyUSB1
> lrwxrwxrwx 1 root root 0 2011-05-25 14:33 ttyUSB2 -> =

> ../../../devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.2/ttyUSB2
> lrwxrwxrwx 1 root root 0 2011-05-25 14:33 ttyUSB3 -> =

> ../../../devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.3/ttyUSB3

There is a script usbdevices.sh if you do not have usbfs mounted
anymore.

Regards

Marcel



--===============3186962243794568220==--


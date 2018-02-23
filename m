Content-Type: multipart/mixed; boundary="===============6981641354619181824=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Issue with service reporting on a 4G modem
Date: Fri, 23 Feb 2018 19:19:46 +0100
Message-ID: <8105e020-dd73-5c87-2cad-0ae32da1c827@monom.org>
In-Reply-To: <AM4PR01MB18736B32DD3AC54D61D117B19CCF0@AM4PR01MB1873.eurprd01.prod.exchangelabs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6981641354619181824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bassem,

On 02/20/2018 10:44 AM, Bassem BOUBAKER wrote:
> Hello Daniel,
> =

> Exactly, my modem is creating an additional ethernet interface, and I don=
't know why.
> =

> Please find in the link below the full log of connman.
> =

> https://ufile.io/dmgbw

Feb 20 08:52:21 pcm kernel: cdc_acm 1-1:1.4: ttyACM2: USB ACM device
Feb 20 08:52:21 pcm kernel: cdc_acm 1-1:1.6: ttyACM3: USB ACM device
Feb 20 08:52:21 pcm kernel: cdc_acm 1-1:1.8: This device cannot do calls on=
 its own. It is not a modem.
Feb 20 08:52:21 pcm kernel: cdc_acm 1-1:1.8: ttyACM4: USB ACM device
Feb 20 08:52:21 pcm kernel: usbcore: registered new interface driver cdc_acm
Feb 20 08:52:21 pcm kernel: cdc_acm: USB Abstract Control Model driver for =
USB modems and ISDN adapters
Feb 20 08:52:21 pcm kernel[657]: cdc_acm 1-1:1.0: ttyACM0: USB ACM device
Feb 20 08:52:21 pcm kerncdc_ether 1-1:1.10 usb0: CDC: unexpected notificati=
on 01!
el[657]: cdc_acm 1-1:1.2: ttyACM1: USB ACM device
Feb 20 08:52:21 pcm kernel[657]: cdc_acm 1-1:1.4: ttyACM2: USB ACM device
Feb 20 08:52:21 pcm kernel[657]: cdc_acm 1-1:1.6: ttyACM3: USB ACM device
Feb 20 08:52:21 pcm kernel[657]: cdc_acm 1-1:1.8: This device cannot do cal=
ls on its own. It is not a modem.
Feb 20 08:52:21 pcm kernel[657]: cdc_acm 1-1:1.8: ttyACM4: USB ACM device
Feb 20 08:52:21 pcm kernel[657]: usbcore: registered new interface driver c=
dc_acm
Feb 20 08:52:21 pcm kernel[657]: cdc_acm: USB Abstract Control Model driver=
 for USB modems and ISDN adapters
Feb 20 08:52:21 pcm connmand[700]: src/rtnl.c:rtnl_message() buf 0x7eeffbf8=
 len 1076
Feb 20 08:52:21 pcm connmand[cdc_ether 1-1:1.12 usb1: CDC: unexpected notif=
ication 01!
700]: src/rtnl.c:rtnl_message() NEWLINK len 1076 type 16 flags 0x0000 seq 0=
 pid 0
Feb 20 08:52:21 pcm connmand[700]: src/ipconfig.c:__connman_ipconfig_newlin=
k() index 7
Feb 20 08:52:21 pcm connmand[700]: usb0 {create} index 7 type 1 <ETHER>
Feb 20 08:52:21 pcm connmand[700]: usb0 {update} flags 4098 <DOWN>
Feb 20 08:52:21 pcm connmand[700]: usb0 {newlink} index 7 address XX:XX:XX:=
XX:00:00 mtu 1500
Feb 20 08:52:21 pcm connmand[700]: usb0 {newlink} index 7 operstate 2 <DOWN>


Check if the DEVTYPE is set correctly on the modem. If it is not
wwan ConnMan wont ignore it src/rntl.c:

static void read_uevent(struct interface_data *interface)
{
	[...]

	found_devtype =3D false;
	while (fgets(line, sizeof(line), f)) {
		char *pos;

		pos =3D strchr(line, '\n');
		if (!pos)
			continue;
		pos[0] =3D '\0';

		if (strncmp(line, "DEVTYPE=3D", 8) !=3D 0)
			continue;

		found_devtype =3D true;

		if (strcmp(line + 8, "wlan") =3D=3D 0) {
			interface->service_type =3D CONNMAN_SERVICE_TYPE_WIFI;
			interface->device_type =3D CONNMAN_DEVICE_TYPE_WIFI;
		} else if (strcmp(line + 8, "wwan") =3D=3D 0) {
			interface->service_type =3D CONNMAN_SERVICE_TYPE_CELLULAR;
			interface->device_type =3D CONNMAN_DEVICE_TYPE_CELLULAR;
		} else if (strcmp(line + 8, "bluetooth") =3D=3D 0) {
			interface->service_type =3D CONNMAN_SERVICE_TYPE_BLUETOOTH;
			interface->device_type =3D CONNMAN_DEVICE_TYPE_BLUETOOTH;
		} else if (strcmp(line + 8, "gadget") =3D=3D 0) {
			interface->service_type =3D CONNMAN_SERVICE_TYPE_GADGET;
			interface->device_type =3D CONNMAN_DEVICE_TYPE_GADGET;
		} else if (strcmp(line + 8, "vlan") =3D=3D 0) {
			interface->service_type =3D CONNMAN_SERVICE_TYPE_ETHERNET;
			interface->device_type =3D CONNMAN_DEVICE_TYPE_ETHERNET;
		} else if (strcmp(line + 8, "bond") =3D=3D 0) {
			interface->service_type =3D CONNMAN_SERVICE_TYPE_ETHERNET;
			interface->device_type =3D CONNMAN_DEVICE_TYPE_ETHERNET;
		} else {
			interface->service_type =3D CONNMAN_SERVICE_TYPE_UNKNOWN;
			interface->device_type =3D CONNMAN_DEVICE_TYPE_UNKNOWN;
		}
	}

	[...]
}

DEVTYPE=3Dwwan in /sys/class/net/<device>/uevent.

HTH!

Thanks,
Daniel

--===============6981641354619181824==--


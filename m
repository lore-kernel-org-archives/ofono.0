Content-Type: multipart/mixed; boundary="===============3545489693637037676=="
MIME-Version: 1.0
From: Bassem BOUBAKER <bassem.boubaker@actia.fr>
Subject: RE: Issue with service reporting on a 4G modem
Date: Mon, 26 Feb 2018 12:16:04 +0000
Message-ID: <AM4PR01MB1873371B219961C9D091856A9CC10@AM4PR01MB1873.eurprd01.prod.exchangelabs.com>
In-Reply-To: <8105e020-dd73-5c87-2cad-0ae32da1c827@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3545489693637037676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Issue is fixed. Thank you for your help.

I used to have this:
# cat /sys/class/net/usb0/uevent =

INTERFACE=3Dusb0
IFINDEX=3D7

I changed my driver in the kernel to probe it as a wwan info device based o=
n vid and pid . =


Now I have the DEVTYPE correct:
# cat /sys/class/net/wwan0/uevent =

DEVTYPE=3Dwwan
INTERFACE=3Dwwan0
IFINDEX=3D7


Below my kernel patch in case of anyone having the same issue.

PS: I'm using a Cinterion PLS8 modem.

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index b1897c7..b1c29c2 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -480,7 +480,7 @@ static const struct driver_info wwan_info =3D {
 #define ZTE_VENDOR_ID	0x19D2
 #define DELL_VENDOR_ID	0x413C
 #define REALTEK_VENDOR_ID	0x0bda
-
+#define GEMALTO_VENDOR_ID	0x1e2d
 static const struct usb_device_id	products [] =3D {
 /*
  * BLACKLIST !!
@@ -709,6 +709,17 @@ static const struct usb_device_id	products [] =3D {
     .bInterfaceProtocol	=3D USB_CDC_PROTO_NONE,
     .driver_info =3D (unsigned long)&wwan_info,
 }, {
+	/* Cinterion pls8 by GEMALTO */
+	.match_flags =3D USB_DEVICE_ID_MATCH_VENDOR
+	| USB_DEVICE_ID_MATCH_PRODUCT
+	| USB_DEVICE_ID_MATCH_INT_INFO,
+	.idVendor =3D GEMALTO_VENDOR_ID,
+	.idProduct	=3D 0x0061,
+	.bInterfaceClass	=3D USB_CLASS_COMM,
+	.bInterfaceSubClass	=3D USB_CDC_SUBCLASS_ETHERNET,
+	.bInterfaceProtocol	=3D USB_CDC_PROTO_NONE,
+	.driver_info =3D (unsigned long)&wwan_info,
+},{
     /* Telit modules */
     USB_VENDOR_AND_INTERFACE_INFO(0x1bc7, USB_CLASS_COMM,
             USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),

Thanks,
Bassem.


>Hi Bassem,
>
>On 02/20/2018 10:44 AM, Bassem BOUBAKER wrote:
>> Hello Daniel,
>> =

>> Exactly, my modem is creating an additional ethernet interface, and I do=
n't know why.
>> =

>> Please find in the link below the full log of connman.
>> =

>> https://ufile.io/dmgbw
>
>Feb 20 08:52:21 pcm kernel: cdc_acm 1-1:1.4: ttyACM2: USB ACM device
>Feb 20 08:52:21 pcm kernel: cdc_acm 1-1:1.6: ttyACM3: USB ACM device
>Feb 20 08:52:21 pcm kernel: cdc_acm 1-1:1.8: This device cannot do calls o=
n its own. It is not a modem.
>Feb 20 08:52:21 pcm kernel: cdc_acm 1-1:1.8: ttyACM4: USB ACM device
>Feb 20 08:52:21 pcm kernel: usbcore: registered new interface driver cdc_a=
cm
>Feb 20 08:52:21 pcm kernel: cdc_acm: USB Abstract Control Model driver for=
 USB modems and ISDN adapters
>Feb 20 08:52:21 pcm kernel[657]: cdc_acm 1-1:1.0: ttyACM0: USB ACM device
>Feb 20 08:52:21 pcm kerncdc_ether 1-1:1.10 usb0: CDC: unexpected notificat=
ion 01!
>el[657]: cdc_acm 1-1:1.2: ttyACM1: USB ACM device
>Feb 20 08:52:21 pcm kernel[657]: cdc_acm 1-1:1.4: ttyACM2: USB ACM device
>Feb 20 08:52:21 pcm kernel[657]: cdc_acm 1-1:1.6: ttyACM3: USB ACM device
>Feb 20 08:52:21 pcm kernel[657]: cdc_acm 1-1:1.8: This device cannot do ca=
lls on its own. It is not a modem.
>Feb 20 08:52:21 pcm kernel[657]: cdc_acm 1-1:1.8: ttyACM4: USB ACM device
>Feb 20 08:52:21 pcm kernel[657]: usbcore: registered new interface driver =
cdc_acm
>Feb 20 08:52:21 pcm kernel[657]: cdc_acm: USB Abstract Control Model drive=
r for USB modems and ISDN adapters
>Feb 20 08:52:21 pcm connmand[700]: src/rtnl.c:rtnl_message() buf 0x7eeffbf=
8 len 1076
>Feb 20 08:52:21 pcm connmand[cdc_ether 1-1:1.12 usb1: CDC: unexpected noti=
fication 01!
>700]: src/rtnl.c:rtnl_message() NEWLINK len 1076 type 16 flags 0x0000 seq =
0 pid 0
>Feb 20 08:52:21 pcm connmand[700]: src/ipconfig.c:__connman_ipconfig_newli=
nk() index 7
>Feb 20 08:52:21 pcm connmand[700]: usb0 {create} index 7 type 1 <ETHER>
>Feb 20 08:52:21 pcm connmand[700]: usb0 {update} flags 4098 <DOWN>
>Feb 20 08:52:21 pcm connmand[700]: usb0 {newlink} index 7 address XX:XX:XX=
:XX:00:00 mtu 1500
>Feb 20 08:52:21 pcm connmand[700]: usb0 {newlink} index 7 operstate 2 <DOW=
N>
>
>
>Check if the DEVTYPE is set correctly on the modem. If it is not
>wwan ConnMan wont ignore it src/rntl.c:
>
>static void read_uevent(struct interface_data *interface)
>{
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [...]
>
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_devtype =3D false;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (fgets(line, sizeof(line)=
, f)) {
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 char *pos;
>
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pos =3D strchr(line, '\n');
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (!pos)
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pos[0] =3D '\0';
>
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (strncmp(line, "DEVTYPE=3D", 8) !=3D 0)
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 found_devtype =3D true;
>
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (strcmp(line + 8, "wlan") =3D=3D 0) {
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->service_type =3D CONNMAN_SERVICE_TYPE_WIFI;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->device_type =3D CONNMAN_DEVICE_TYPE_WIFI;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else if (strcmp(line + 8, "wwan") =3D=3D 0) {
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->service_type =3D CONNMAN_SERVICE_TYPE_CELLULAR;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->device_type =3D CONNMAN_DEVICE_TYPE_CELLULAR;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else if (strcmp(line + 8, "bluetooth") =3D=3D 0) {
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->service_type =3D CONNMAN_SERVICE_TYPE_BLUETOOTH;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interface->device_ty=
pe =3D CONNMAN_DEVICE_TYPE_BLUETOOTH;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else if (strcmp(line + 8, "gadget") =3D=3D 0) {
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->service_type =3D CONNMAN_SERVICE_TYPE_GADGET;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->device_type =3D CONNMAN_DEVICE_TYPE_GADGET;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else if (strcmp(line + 8, "vlan") =3D=3D 0) {
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->service_type =3D CONNMAN_SERVICE_TYPE_ETHERNET;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->device_type =3D CONNMAN_DEVICE_TYPE_ETHERNET;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else if (strcmp(line + 8, "bond") =3D=3D 0) {
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->service_type =3D CONNMAN_SERVICE_TYPE_ETHERNET;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->device_type =3D CONNMAN_DEVICE_TYPE_ETHERNET;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else {
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->service_type =3D CONNMAN_SERVICE_TYPE_UNKNOWN;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfac=
e->device_type =3D CONNMAN_DEVICE_TYPE_UNKNOWN;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [...]
>}
>
>DEVTYPE=3Dwwan in /sys/class/net/<device>/uevent.
>
>HTH!
>
>Thanks,
>Daniel
   =20
--===============3545489693637037676==--


Content-Type: multipart/mixed; boundary="===============1437469559625163285=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: How to test ofono for MediaTek Modem and Qualcomm Modem
Date: Mon, 10 Apr 2017 09:19:41 +0100
Message-ID: <40bb2105-84c9-9c3f-b348-56a77b6d02a2@gmail.com>
In-Reply-To: <CAOLU1cRL7pYDMbi-QOFM4D3_Lw-SV8Z75uYR2jgfBc7vEYPy1g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1437469559625163285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rohit,

On 07/04/17 21:16, Rohit Agrawal wrote:
> Hi Folks,
> =

> I am new to ofono. Can you please list down the steps to test ofono on Me=
diaTek and Qualcomm Modem.
> I have got MediaTek and Qualcomm boards with me. What are the necessary a=
rrangements I need to do in order
> to test ofono on these boards. MediaTek board comes with vendor-ril.so an=
d as per ofono documentation it talks to RILD
> over unix socket interface.  How exactly the flow happens. Can any one ex=
plain to me ?
> =

> How about Qualcomm modem ? Ofono talks through qmi, is this through qmi_w=
wan driver ? If yes so can someone
> please throw the light on the flow for Qualcomm modem too ?

I can try to explain the process, which I went through myself a short while=
 ago with a Telit/Qualcomm QMI modem.

1. You need to look at plugins/udevng.c
- the first important structure is: struct vendor_list[] - it assigns ofono=
 driver name to udev devices, based on linux driver name, and vendor/produc=
t IDs
- the second one is: struct driver_list[] - it matches ofono driver name to=
 a setup function
- then you go to a setup function - for my modem, I had to create setup_tel=
itqmi() - my modem creates several devices: qmi_wwan, cdc-wdm, and a bunch =
of usb-serial "option" adapters. You have to filter the ones which are requ=
ired, based on device/subsystem IDs - for QMI, you need the qmi_wwan and cd=
c ones.


2. Plugin file
- Most QMI modems should behave quite similarly to each other. A generic pl=
ugin for them is plugins/gobi.c
- I selected it in udevng.c:setup_telitqmi() by doing this: ofono_modem_set=
_driver(modem->modem, "gobi");
- Additionally, my modem required setting two optional flags, to go through=
 slightly different code paths:
	ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
	ofono_modem_set_boolean(modem->modem, "AlwaysOnline", TRUE);
Other QMI modems may or may not need those.

3. Driver
- The gobi plugin will instantiate the main driver code in: drivers/qmimode=
m.c


If you are lucky, and your modem is not too different to other QMI ones, yo=
u will only need to add your vendor/product/device IDs to udevng.c

Hope this helps.
Lukasz


> =

> -Best Regards,
> Rohit Agrawal
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>=20

--===============1437469559625163285==--


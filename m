Content-Type: multipart/mixed; boundary="===============9219891429115834883=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: ublox TOBY-R200
Date: Thu, 13 Sep 2018 20:48:17 +0200
Message-ID: <CAKSBH7HGo9kVrd5Si3gDo6tjr4ZMPmobhJEUD-LFFHM824FigQ@mail.gmail.com>
In-Reply-To: <CAFJydPX1vqmbE160ESS-BFnes8gfK-Y6rX9x90uHJMKmOVfFBA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9219891429115834883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi Frank,

your modem doesn't seem to be supported.
There are these models:
SARA_G270 =3D 1102,
TOBYL2_COMPATIBLE_MODE =3D 1141,
TOBYL2_MEDIUM_THROUGHPUT_MODE =3D 1143,
TOBYL2_HIGH_THROUGHPUT_MODE =3D 1146,
If your model is compatible with any of them, I can add  the 1107 for you
for a test.

from the PID, I would say it should be intermediate between the SARA_G260
and the TOBYL2_COMPATIBLE_MODE.
Most likely it will work this latter, but maybe not all features...

Are you willing to test?

Best regards,
Giacinto



On Thu, Sep 13, 2018 at 7:48 PM Frank Vasquez <frankv@helium.com> wrote:

> Hi Giacinto,
>
> > can you send the result of "lsusb" and "lsusb -t"?
>
> The usbutils version of lsusb is somewhat better.
>
> # lsusb
> Bus 002 Device 001: ID 1d6b:0003
> Bus 001 Device 002: ID 1546:1107
> Bus 001 Device 001: ID 1d6b:0002
> # lsusb -t
> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dcdc_acm, 480M
>     |__ Port 1: Dev 2, If 1, Class=3D, Driver=3Dcdc_acm, 480M
>     |__ Port 1: Dev 2, If 2, Class=3D, Driver=3Dcdc_acm, 480M
>     |__ Port 1: Dev 2, If 3, Class=3D, Driver=3Dcdc_acm, 480M
>     |__ Port 1: Dev 2, If 4, Class=3D, Driver=3Dcdc_acm, 480M
>     |__ Port 1: Dev 2, If 5, Class=3D, Driver=3Dcdc_acm, 480M
>     |__ Port 1: Dev 2, If 6, Class=3D, Driver=3Dcdc_acm, 480M
>     |__ Port 1: Dev 2, If 7, Class=3D, Driver=3Dcdc_acm, 480M
>     |__ Port 1: Dev 2, If 8, Class=3D, Driver=3Dcdc_acm, 480M
>     |__ Port 1: Dev 2, If 9, Class=3D, Driver=3Dcdc_acm, 480M
>     |__ Port 1: Dev 2, If 10, Class=3D, Driver=3Dcdc_acm, 480M
>     |__ Port 1: Dev 2, If 11, Class=3D, Driver=3Dcdc_acm, 480M
>
> And here is a relevant excerpt from lsusb -v.
>
> Bus 001 Device 002: ID 1546:1107
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239
>   bDeviceSubClass         2
>   bDeviceProtocol         1
>   bMaxPacketSize0        64
>   idVendor           0x1546
>   idProduct          0x1107
>   bcdDevice           17.29
>   iManufacturer           1 u-blox
>   iProduct                2 u-blox Cellular Module
>   iSerial                 3 352848080392646
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          405
>     bNumInterfaces         12
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xe0
>       Self Powered
>       Remote Wakeup
>     MaxPower              100mA
>     Interface Association:
>       bLength                 8
>       bDescriptorType        11
>       bFirstInterface         0
>       bInterfaceCount         2
>       bFunctionClass          2
>       bFunctionSubClass       2
>       bFunctionProtocol       1
>       iFunction               4 CDC ACM
> ...
>
> Cheers,
> Frank
>
>
> On Thu, Sep 13, 2018 at 10:21 AM Frank Vasquez <frankv@helium.com> wrot=
e:
>
>> Hi Giacinto,
>>
>> > can you send the result of "lsusb" and "lsusb -t"?
>>
>> # lsusb -t
>> Bus 001 Device 001: ID 1d6b:0002
>> Bus 001 Device 002: ID 1546:1107
>> Bus 002 Device 001: ID 1d6b:0003
>>
>> I am running BusyBox's stripped down version of lsusb that's why
>> information is so lacking.
>> I'll install usbutils on my device's Buildroot image and rerun the
>> commands.
>>
>> Cheers,
>> Frank
>>
>> On Thu, Sep 13, 2018 at 3:49 AM Giacinto Cifelli <gciofono@gmail.com>
>> wrote:
>>
>>> hi Frank,
>>>
>>> can you send the result of "lsusb" and "lsusb -t"?
>>>
>>> Giacinto
>>>
>>> On Thu, 13 Sep 2018, 00:41 Frank Vasquez, <frankv@helium.com> wrote:
>>>
>>>> Greetings,
>>>>
>>>> I have an embedded device with a ublox TOBY-R200 on it.  I want to use
>>>> connman to manage any cellular connection on that modem since connman =
is
>>>> already managing ethernet and wifi connectivity.  oFono seems like the=
 best
>>>> option.  I see that there is already a ublox plugin for oFono but I do=
n't
>>>> think the TOBY-R200 is supported.  The cell module is soldered onto the
>>>> board and appears as a USB device.
>>>>
>>>> [    6.519190] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,
>>>> SerialNumber=3D3
>>>> [    6.519197] usb 1-1: Product: u-blox Cellular Module
>>>> [    6.519204] usb 1-1: Manufacturer: u-blox
>>>> [    6.519211] usb 1-1: SerialNumber: 352848080392646
>>>>
>>>> I can send AT commands to the modem over /dev/ttyACM0.
>>>>
>>>> Cheers,
>>>> Frank
>>>> _______________________________________________
>>>> ofono mailing list
>>>> ofono(a)ofono.org
>>>> https://lists.ofono.org/mailman/listinfo/ofono
>>>>
>>>

--===============9219891429115834883==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9
Imx0ciI+aGkgRnJhbmssPGRpdj48YnI+PC9kaXY+PGRpdj55b3VyIG1vZGVtIGRvZXNuJiMzOTt0
IHNlZW0gdG8gYmUgc3VwcG9ydGVkLjwvZGl2PjxkaXY+VGhlcmUgYXJlIHRoZXNlIG1vZGVsczo8
L2Rpdj48ZGl2PjxkaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PlNBUkFfRzI3MDxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJCTwvc3Bhbj49IDExMDIs
PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlRPQllMMl9D
T01QQVRJQkxFX01PREU8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj49IDEx
NDEsPGJyPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5U
T0JZTDJfTUVESVVNX1RIUk9VR0hQVVRfTU9ERTxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PSAxMTQzLDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5UT0JZTDJfSElHSF9USFJPVUdIUFVUX01PREU8c3BhbiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPj0gMTE0Niw8L2Rpdj48L2Rpdj48ZGl2PklmIHlvdXIgbW9kZWwgaXMg
Y29tcGF0aWJsZSB3aXRoIGFueSBvZiB0aGVtLCBJIGNhbiBhZGTCoCB0aGUgMTEwNyBmb3IgeW91
IGZvciBhIHRlc3QuPGJyPjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+ZnJvbSB0aGUg
UElELCBJIHdvdWxkIHNheSBpdCBzaG91bGQgYmUgaW50ZXJtZWRpYXRlIGJldHdlZW4gdGhlIFNB
UkFfRzI2MCBhbmQgdGhlIFRPQllMMl9DT01QQVRJQkxFX01PREUuPC9kaXY+PGRpdj5Nb3N0IGxp
a2VseSBpdCB3aWxsIHdvcmsgdGhpcyBsYXR0ZXIsIGJ1dCBtYXliZSBub3QgYWxsIGZlYXR1cmVz
Li4uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BcmUgeW91IHdpbGxpbmcgdG8gdGVzdD88L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJlc3QgcmVnYXJkcyw8L2Rpdj48ZGl2PkdpYWNpbnRvPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+
PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2
IGRpcj0ibHRyIj5PbiBUaHUsIFNlcCAxMywgMjAxOCBhdCA3OjQ4IFBNIEZyYW5rIFZhc3F1ZXog
Jmx0OzxhIGhyZWY9Im1haWx0bzpmcmFua3ZAaGVsaXVtLmNvbSI+ZnJhbmt2QGhlbGl1bS5jb208
L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+
PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgR2lhY2ludG8sPC9kaXY+PGRpdiBkaXI9
Imx0ciI+PGJyPjwvZGl2PjxkaXYgZGlyPSJsdHIiPiZndDvCoDxzcGFuIHN0eWxlPSJjb2xvcjpy
Z2IoODAsMCw4MCkiPmNhbiB5b3Ugc2VuZCB0aGUgcmVzdWx0IG9mICZxdW90O2xzdXNiJnF1b3Q7
IGFuZCAmcXVvdDtsc3VzYiAtdCZxdW90Oz88L3NwYW4+PC9kaXY+PGRpdiBkaXI9Imx0ciI+PGJy
PjwvZGl2PjxkaXYgZGlyPSJsdHIiPlRoZSB1c2J1dGlscyB2ZXJzaW9uIG9mIGxzdXNiIGlzIHNv
bWV3aGF0IGJldHRlci48L2Rpdj48ZGl2IGRpcj0ibHRyIj48YnI+PGRpdj48ZGl2PiMgbHN1c2I8
L2Rpdj48ZGl2PkJ1cyAwMDIgRGV2aWNlIDAwMTogSUQgMWQ2YjowMDAzwqDCoDwvZGl2PjxkaXY+
QnVzIDAwMSBEZXZpY2UgMDAyOiBJRCAxNTQ2OjExMDfCoMKgPC9kaXY+PGRpdj5CdXMgMDAxIERl
dmljZSAwMDE6IElEIDFkNmI6MDAwMsKgwqA8L2Rpdj48ZGl2PiMgbHN1c2IgLXQ8L2Rpdj48ZGl2
Pi86wqAgQnVzIDAyLlBvcnQgMTogRGV2IDEsIENsYXNzPXJvb3RfaHViLCBEcml2ZXI9eGhjaS1o
Y2QvMXAsIDUwMDBNPC9kaXY+PGRpdj4vOsKgIEJ1cyAwMS5Qb3J0IDE6IERldiAxLCBDbGFzcz1y
b290X2h1YiwgRHJpdmVyPXhoY2ktaGNkLzFwLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9y
dCAxOiBEZXYgMiwgSWYgMCwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+
wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDEsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4
ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiAyLCBDbGFzcz0sIERyaXZl
cj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgMywg
Q2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTog
RGV2IDIsIElmIDQsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKg
IHxfXyBQb3J0IDE6IERldiAyLCBJZiA1LCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9k
aXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgNiwgQ2xhc3M9LCBEcml2ZXI9Y2Rj
X2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDcsIENsYXNz
PSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAy
LCBJZiA4LCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18g
UG9ydCAxOiBEZXYgMiwgSWYgOSwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2Pjxk
aXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDEwLCBDbGFzcz0sIERyaXZlcj1jZGNfYWNt
LCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgMTEsIENsYXNzPSwg
RHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFuZCBo
ZXJlIGlzIGEgcmVsZXZhbnQgZXhjZXJwdCBmcm9tIGxzdXNiIC12LjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+PGRpdj5CdXMgMDAxIERldmljZSAwMDI6IElEIDE1NDY6MTEwNzwvZGl2PjxkaXY+
RGV2aWNlIERlc2NyaXB0b3I6PC9kaXY+PGRpdj7CoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgMTg8L2Rpdj48ZGl2PsKgIGJEZXNjcmlwdG9yVHlwZcKgIMKgIMKgIMKgIMKgMTwvZGl2
PjxkaXY+wqAgYmNkVVNCwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAyLjAwPC9kaXY+PGRpdj7CoCBi
RGV2aWNlQ2xhc3PCoCDCoCDCoCDCoCDCoCAyMzk8L2Rpdj48ZGl2PsKgIGJEZXZpY2VTdWJDbGFz
c8KgIMKgIMKgIMKgIMKgMjwvZGl2PjxkaXY+wqAgYkRldmljZVByb3RvY29swqAgwqAgwqAgwqAg
wqAxPC9kaXY+PGRpdj7CoCBiTWF4UGFja2V0U2l6ZTDCoCDCoCDCoCDCoCA2NDwvZGl2PjxkaXY+
wqAgaWRWZW5kb3LCoCDCoCDCoCDCoCDCoCDCoDB4MTU0NjwvZGl2PjxkaXY+wqAgaWRQcm9kdWN0
wqAgwqAgwqAgwqAgwqAgMHgxMTA3PC9kaXY+PGRpdj7CoCBiY2REZXZpY2XCoCDCoCDCoCDCoCDC
oCDCoDE3LjI5PC9kaXY+PGRpdj7CoCBpTWFudWZhY3R1cmVywqAgwqAgwqAgwqAgwqAgwqAxIHUt
YmxveDwvZGl2PjxkaXY+wqAgaVByb2R1Y3TCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAyIHUtYmxv
eCBDZWxsdWxhciBNb2R1bGU8L2Rpdj48ZGl2PsKgIGlTZXJpYWzCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDMgMzUyODQ4MDgwMzkyNjQ2PC9kaXY+PGRpdj7CoCBiTnVtQ29uZmlndXJhdGlvbnPC
oCDCoCDCoCAxPC9kaXY+PGRpdj7CoCBDb25maWd1cmF0aW9uIERlc2NyaXB0b3I6PC9kaXY+PGRp
dj7CoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA5PC9kaXY+PGRpdj7CoCDC
oCBiRGVzY3JpcHRvclR5cGXCoCDCoCDCoCDCoCDCoDI8L2Rpdj48ZGl2PsKgIMKgIHdUb3RhbExl
bmd0aMKgIMKgIMKgIMKgIMKgIDQwNTwvZGl2PjxkaXY+wqAgwqAgYk51bUludGVyZmFjZXPCoCDC
oCDCoCDCoCDCoDEyPC9kaXY+PGRpdj7CoCDCoCBiQ29uZmlndXJhdGlvblZhbHVlwqAgwqAgwqAx
PC9kaXY+PGRpdj7CoCDCoCBpQ29uZmlndXJhdGlvbsKgIMKgIMKgIMKgIMKgIDA8L2Rpdj48ZGl2
PsKgIMKgIGJtQXR0cmlidXRlc8KgIMKgIMKgIMKgIMKgMHhlMDwvZGl2PjxkaXY+wqAgwqAgwqAg
U2VsZiBQb3dlcmVkPC9kaXY+PGRpdj7CoCDCoCDCoCBSZW1vdGUgV2FrZXVwPC9kaXY+PGRpdj7C
oCDCoCBNYXhQb3dlcsKgIMKgIMKgIMKgIMKgIMKgIMKgIDEwMG1BPC9kaXY+PGRpdj7CoCDCoCBJ
bnRlcmZhY2UgQXNzb2NpYXRpb246PC9kaXY+PGRpdj7CoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA4PC9kaXY+PGRpdj7CoCDCoCDCoCBiRGVzY3JpcHRvclR5cGXCoCDC
oCDCoCDCoCAxMTwvZGl2PjxkaXY+wqAgwqAgwqAgYkZpcnN0SW50ZXJmYWNlwqAgwqAgwqAgwqAg
wqAwPC9kaXY+PGRpdj7CoCDCoCDCoCBiSW50ZXJmYWNlQ291bnTCoCDCoCDCoCDCoCDCoDI8L2Rp
dj48ZGl2PsKgIMKgIMKgIGJGdW5jdGlvbkNsYXNzwqAgwqAgwqAgwqAgwqAgMjwvZGl2PjxkaXY+
wqAgwqAgwqAgYkZ1bmN0aW9uU3ViQ2xhc3PCoCDCoCDCoCDCoDI8L2Rpdj48ZGl2PsKgIMKgIMKg
IGJGdW5jdGlvblByb3RvY29swqAgwqAgwqAgwqAxPC9kaXY+PGRpdj7CoCDCoCDCoCBpRnVuY3Rp
b27CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDQgQ0RDIEFDTTwvZGl2PjxkaXY+Li4uPC9kaXY+PC9k
aXY+PGRpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9kaXY+
PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxk
aXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBUaHUsIFNlcCAxMywgMjAx
OCBhdCAxMDoyMSBBTSBGcmFuayBWYXNxdWV6ICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhl
bGl1bS5jb20iIHRhcmdldD0iX2JsYW5rIj5mcmFua3ZAaGVsaXVtLmNvbTwvYT4mZ3Q7IHdyb3Rl
Ojxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48
ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj5IaSBHaWFjaW50byw8ZGl2Pjxicj48L2Rpdj48
ZGl2PiZndDsgY2FuIHlvdSBzZW5kIHRoZSByZXN1bHQgb2YgJnF1b3Q7bHN1c2ImcXVvdDsgYW5k
ICZxdW90O2xzdXNiIC10JnF1b3Q7PzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj4jIGxz
dXNiIC10PC9kaXY+PGRpdj5CdXMgMDAxIERldmljZSAwMDE6IElEIDFkNmI6MDAwMjwvZGl2Pjxk
aXY+QnVzIDAwMSBEZXZpY2UgMDAyOiBJRCAxNTQ2OjExMDc8L2Rpdj48ZGl2PkJ1cyAwMDIgRGV2
aWNlIDAwMTogSUQgMWQ2YjowMDAzPC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFt
IHJ1bm5pbmcgQnVzeUJveCYjMzk7cyBzdHJpcHBlZCBkb3duIHZlcnNpb24gb2YgbHN1c2IgdGhh
dCYjMzk7cyB3aHkgaW5mb3JtYXRpb24gaXMgc28gbGFja2luZy48L2Rpdj48ZGl2PkkmIzM5O2xs
IGluc3RhbGwgdXNidXRpbHMgb24gbXkgZGV2aWNlJiMzOTtzIEJ1aWxkcm9vdCBpbWFnZSBhbmQg
cmVydW4gdGhlIGNvbW1hbmRzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Q2hlZXJzLDwvZGl2
PjxkaXY+RnJhbms8L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUi
PjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgU2VwIDEzLCAyMDE4IGF0IDM6NDkgQU0gR2lhY2ludG8g
Q2lmZWxsaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmdjaW9mb25vQGdtYWlsLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPmdjaW9mb25vQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXIt
bGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0iYXV0byI+aGkg
RnJhbmssPGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+Y2FuIHlvdSBz
ZW5kIHRoZSByZXN1bHQgb2YgJnF1b3Q7bHN1c2ImcXVvdDsgYW5kICZxdW90O2xzdXNiIC10JnF1
b3Q7PzwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPkdpYWNp
bnRvPC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRy
Ij5PbiBUaHUsIDEzIFNlcCAyMDE4LCAwMDo0MSBGcmFuayBWYXNxdWV6LCAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmZyYW5rdkBoZWxpdW0uY29tIiB0YXJnZXQ9Il9ibGFuayI+ZnJhbmt2QGhlbGl1bS5j
b208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+R3JlZXRpbmdzLDxk
aXY+PGJyPjwvZGl2PjxkaXY+SSBoYXZlIGFuIGVtYmVkZGVkIGRldmljZSB3aXRoIGEgdWJsb3gg
VE9CWS1SMjAwIG9uIGl0LsKgIEkgd2FudCB0byB1c2UgY29ubm1hbiB0byBtYW5hZ2UgYW55IGNl
bGx1bGFyIGNvbm5lY3Rpb24gb24gdGhhdCBtb2RlbSBzaW5jZSBjb25ubWFuIGlzIGFscmVhZHkg
bWFuYWdpbmcgZXRoZXJuZXQgYW5kIHdpZmkgY29ubmVjdGl2aXR5LsKgIG9Gb25vIHNlZW1zIGxp
a2UgdGhlIGJlc3Qgb3B0aW9uLsKgIEkgc2VlIHRoYXQgdGhlcmUgaXMgYWxyZWFkeSBhIHVibG94
IHBsdWdpbiBmb3Igb0Zvbm8gYnV0IEkgZG9uJiMzOTt0IHRoaW5rIHRoZSBUT0JZLVIyMDAgaXMg
c3VwcG9ydGVkLsKgIFRoZSBjZWxsIG1vZHVsZSBpcyBzb2xkZXJlZCBvbnRvIHRoZSBib2FyZCBh
bmQgYXBwZWFycyBhcyBhIFVTQiBkZXZpY2UuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2
PlvCoCDCoCA2LjUxOTE5MF0gdXNiIDEtMTogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEs
IFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTM8L2Rpdj48ZGl2PlvCoCDCoCA2LjUxOTE5N10gdXNi
IDEtMTogUHJvZHVjdDogdS1ibG94IENlbGx1bGFyIE1vZHVsZTwvZGl2PjxkaXY+W8KgIMKgIDYu
NTE5MjA0XSB1c2IgMS0xOiBNYW51ZmFjdHVyZXI6IHUtYmxveDwvZGl2PjxkaXY+W8KgIMKgIDYu
NTE5MjExXSB1c2IgMS0xOiBTZXJpYWxOdW1iZXI6IDM1Mjg0ODA4MDM5MjY0NjwvZGl2PjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBjYW4gc2VuZCBBVCBjb21tYW5kcyB0byB0aGUgbW9kZW0g
b3ZlciAvZGV2L3R0eUFDTTAuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+
PGRpdj5GcmFuazwvZGl2PjwvZGl2PjwvZGl2PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJt
YWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5v
Zm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL29mb25vIiByZWw9Im5vcmVmZXJyZXIgbm9yZWZlcnJlciIgdGFyZ2V0
PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm88
L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1
b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============9219891429115834883==--


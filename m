Content-Type: multipart/mixed; boundary="===============4735853945983898978=="
MIME-Version: 1.0
From: Frank Vasquez <frankv@helium.com>
Subject: Re: ublox TOBY-R200
Date: Thu, 13 Sep 2018 10:48:32 -0700
Message-ID: <CAFJydPX1vqmbE160ESS-BFnes8gfK-Y6rX9x90uHJMKmOVfFBA@mail.gmail.com>
In-Reply-To: <CAFJydPUVNVhBcmDcYAmx1=ggEXCxvZz=7EYXHdgjmhMspGny2Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4735853945983898978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> can you send the result of "lsusb" and "lsusb -t"?

The usbutils version of lsusb is somewhat better.

# lsusb
Bus 002 Device 001: ID 1d6b:0003
Bus 001 Device 002: ID 1546:1107
Bus 001 Device 001: ID 1d6b:0002
# lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
/:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dcdc_acm, 480M
    |__ Port 1: Dev 2, If 1, Class=3D, Driver=3Dcdc_acm, 480M
    |__ Port 1: Dev 2, If 2, Class=3D, Driver=3Dcdc_acm, 480M
    |__ Port 1: Dev 2, If 3, Class=3D, Driver=3Dcdc_acm, 480M
    |__ Port 1: Dev 2, If 4, Class=3D, Driver=3Dcdc_acm, 480M
    |__ Port 1: Dev 2, If 5, Class=3D, Driver=3Dcdc_acm, 480M
    |__ Port 1: Dev 2, If 6, Class=3D, Driver=3Dcdc_acm, 480M
    |__ Port 1: Dev 2, If 7, Class=3D, Driver=3Dcdc_acm, 480M
    |__ Port 1: Dev 2, If 8, Class=3D, Driver=3Dcdc_acm, 480M
    |__ Port 1: Dev 2, If 9, Class=3D, Driver=3Dcdc_acm, 480M
    |__ Port 1: Dev 2, If 10, Class=3D, Driver=3Dcdc_acm, 480M
    |__ Port 1: Dev 2, If 11, Class=3D, Driver=3Dcdc_acm, 480M

And here is a relevant excerpt from lsusb -v.

Bus 001 Device 002: ID 1546:1107
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239
  bDeviceSubClass         2
  bDeviceProtocol         1
  bMaxPacketSize0        64
  idVendor           0x1546
  idProduct          0x1107
  bcdDevice           17.29
  iManufacturer           1 u-blox
  iProduct                2 u-blox Cellular Module
  iSerial                 3 352848080392646
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          405
    bNumInterfaces         12
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          2
      bFunctionSubClass       2
      bFunctionProtocol       1
      iFunction               4 CDC ACM
...

Cheers,
Frank


On Thu, Sep 13, 2018 at 10:21 AM Frank Vasquez <frankv@helium.com> wrote:

> Hi Giacinto,
>
> > can you send the result of "lsusb" and "lsusb -t"?
>
> # lsusb -t
> Bus 001 Device 001: ID 1d6b:0002
> Bus 001 Device 002: ID 1546:1107
> Bus 002 Device 001: ID 1d6b:0003
>
> I am running BusyBox's stripped down version of lsusb that's why
> information is so lacking.
> I'll install usbutils on my device's Buildroot image and rerun the
> commands.
>
> Cheers,
> Frank
>
> On Thu, Sep 13, 2018 at 3:49 AM Giacinto Cifelli <gciofono@gmail.com>
> wrote:
>
>> hi Frank,
>>
>> can you send the result of "lsusb" and "lsusb -t"?
>>
>> Giacinto
>>
>> On Thu, 13 Sep 2018, 00:41 Frank Vasquez, <frankv@helium.com> wrote:
>>
>>> Greetings,
>>>
>>> I have an embedded device with a ublox TOBY-R200 on it.  I want to use
>>> connman to manage any cellular connection on that modem since connman is
>>> already managing ethernet and wifi connectivity.  oFono seems like the =
best
>>> option.  I see that there is already a ublox plugin for oFono but I don=
't
>>> think the TOBY-R200 is supported.  The cell module is soldered onto the
>>> board and appears as a USB device.
>>>
>>> [    6.519190] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,
>>> SerialNumber=3D3
>>> [    6.519197] usb 1-1: Product: u-blox Cellular Module
>>> [    6.519204] usb 1-1: Manufacturer: u-blox
>>> [    6.519211] usb 1-1: SerialNumber: 352848080392646
>>>
>>> I can send AT commands to the modem over /dev/ttyACM0.
>>>
>>> Cheers,
>>> Frank
>>> _______________________________________________
>>> ofono mailing list
>>> ofono(a)ofono.org
>>> https://lists.ofono.org/mailman/listinfo/ofono
>>>
>>

--===============4735853945983898978==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+PGRpdiBkaXI9Imx0ciI+SGkgR2lhY2ludG8sPC9kaXY+PGRpdiBkaXI9Imx0ciI+PGJyPjwv
ZGl2PjxkaXYgZGlyPSJsdHIiPiZndDvCoDxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCki
PmNhbiB5b3Ugc2VuZCB0aGUgcmVzdWx0IG9mICZxdW90O2xzdXNiJnF1b3Q7IGFuZCAmcXVvdDts
c3VzYiAtdCZxdW90Oz88L3NwYW4+PC9kaXY+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2PjxkaXYg
ZGlyPSJsdHIiPlRoZSB1c2J1dGlscyB2ZXJzaW9uIG9mIGxzdXNiIGlzIHNvbWV3aGF0IGJldHRl
ci48L2Rpdj48ZGl2IGRpcj0ibHRyIj48YnI+PGRpdj48ZGl2PiMgbHN1c2I8L2Rpdj48ZGl2PkJ1
cyAwMDIgRGV2aWNlIDAwMTogSUQgMWQ2YjowMDAzwqDCoDwvZGl2PjxkaXY+QnVzIDAwMSBEZXZp
Y2UgMDAyOiBJRCAxNTQ2OjExMDfCoMKgPC9kaXY+PGRpdj5CdXMgMDAxIERldmljZSAwMDE6IElE
IDFkNmI6MDAwMsKgwqA8L2Rpdj48ZGl2PiMgbHN1c2IgLXQ8L2Rpdj48ZGl2Pi86wqAgQnVzIDAy
LlBvcnQgMTogRGV2IDEsIENsYXNzPXJvb3RfaHViLCBEcml2ZXI9eGhjaS1oY2QvMXAsIDUwMDBN
PC9kaXY+PGRpdj4vOsKgIEJ1cyAwMS5Qb3J0IDE6IERldiAxLCBDbGFzcz1yb290X2h1YiwgRHJp
dmVyPXhoY2ktaGNkLzFwLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwg
SWYgMCwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBv
cnQgMTogRGV2IDIsIElmIDEsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2
PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiAyLCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0
ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgMywgQ2xhc3M9LCBEcml2
ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDQs
IENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6
IERldiAyLCBJZiA1LCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDC
oCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgNiwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwv
ZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDcsIENsYXNzPSwgRHJpdmVyPWNk
Y19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiA4LCBDbGFz
cz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYg
MiwgSWYgOSwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9f
IFBvcnQgMTogRGV2IDIsIElmIDEwLCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+
PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgMTEsIENsYXNzPSwgRHJpdmVyPWNkY19h
Y20sIDQ4ME08L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFuZCBoZXJlIGlzIGEgcmVs
ZXZhbnQgZXhjZXJwdCBmcm9tIGxzdXNiIC12LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRp
dj5CdXMgMDAxIERldmljZSAwMDI6IElEIDE1NDY6MTEwNzwvZGl2PjxkaXY+RGV2aWNlIERlc2Ny
aXB0b3I6PC9kaXY+PGRpdj7CoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTg8L2Rp
dj48ZGl2PsKgIGJEZXNjcmlwdG9yVHlwZcKgIMKgIMKgIMKgIMKgMTwvZGl2PjxkaXY+wqAgYmNk
VVNCwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAyLjAwPC9kaXY+PGRpdj7CoCBiRGV2aWNlQ2xhc3PC
oCDCoCDCoCDCoCDCoCAyMzk8L2Rpdj48ZGl2PsKgIGJEZXZpY2VTdWJDbGFzc8KgIMKgIMKgIMKg
IMKgMjwvZGl2PjxkaXY+wqAgYkRldmljZVByb3RvY29swqAgwqAgwqAgwqAgwqAxPC9kaXY+PGRp
dj7CoCBiTWF4UGFja2V0U2l6ZTDCoCDCoCDCoCDCoCA2NDwvZGl2PjxkaXY+wqAgaWRWZW5kb3LC
oCDCoCDCoCDCoCDCoCDCoDB4MTU0NjwvZGl2PjxkaXY+wqAgaWRQcm9kdWN0wqAgwqAgwqAgwqAg
wqAgMHgxMTA3PC9kaXY+PGRpdj7CoCBiY2REZXZpY2XCoCDCoCDCoCDCoCDCoCDCoDE3LjI5PC9k
aXY+PGRpdj7CoCBpTWFudWZhY3R1cmVywqAgwqAgwqAgwqAgwqAgwqAxIHUtYmxveDwvZGl2Pjxk
aXY+wqAgaVByb2R1Y3TCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAyIHUtYmxveCBDZWxsdWxhciBN
b2R1bGU8L2Rpdj48ZGl2PsKgIGlTZXJpYWzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDMgMzUy
ODQ4MDgwMzkyNjQ2PC9kaXY+PGRpdj7CoCBiTnVtQ29uZmlndXJhdGlvbnPCoCDCoCDCoCAxPC9k
aXY+PGRpdj7CoCBDb25maWd1cmF0aW9uIERlc2NyaXB0b3I6PC9kaXY+PGRpdj7CoCDCoCBiTGVu
Z3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA5PC9kaXY+PGRpdj7CoCDCoCBiRGVzY3JpcHRv
clR5cGXCoCDCoCDCoCDCoCDCoDI8L2Rpdj48ZGl2PsKgIMKgIHdUb3RhbExlbmd0aMKgIMKgIMKg
IMKgIMKgIDQwNTwvZGl2PjxkaXY+wqAgwqAgYk51bUludGVyZmFjZXPCoCDCoCDCoCDCoCDCoDEy
PC9kaXY+PGRpdj7CoCDCoCBiQ29uZmlndXJhdGlvblZhbHVlwqAgwqAgwqAxPC9kaXY+PGRpdj7C
oCDCoCBpQ29uZmlndXJhdGlvbsKgIMKgIMKgIMKgIMKgIDA8L2Rpdj48ZGl2PsKgIMKgIGJtQXR0
cmlidXRlc8KgIMKgIMKgIMKgIMKgMHhlMDwvZGl2PjxkaXY+wqAgwqAgwqAgU2VsZiBQb3dlcmVk
PC9kaXY+PGRpdj7CoCDCoCDCoCBSZW1vdGUgV2FrZXVwPC9kaXY+PGRpdj7CoCDCoCBNYXhQb3dl
csKgIMKgIMKgIMKgIMKgIMKgIMKgIDEwMG1BPC9kaXY+PGRpdj7CoCDCoCBJbnRlcmZhY2UgQXNz
b2NpYXRpb246PC9kaXY+PGRpdj7CoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqA4PC9kaXY+PGRpdj7CoCDCoCDCoCBiRGVzY3JpcHRvclR5cGXCoCDCoCDCoCDCoCAxMTwv
ZGl2PjxkaXY+wqAgwqAgwqAgYkZpcnN0SW50ZXJmYWNlwqAgwqAgwqAgwqAgwqAwPC9kaXY+PGRp
dj7CoCDCoCDCoCBiSW50ZXJmYWNlQ291bnTCoCDCoCDCoCDCoCDCoDI8L2Rpdj48ZGl2PsKgIMKg
IMKgIGJGdW5jdGlvbkNsYXNzwqAgwqAgwqAgwqAgwqAgMjwvZGl2PjxkaXY+wqAgwqAgwqAgYkZ1
bmN0aW9uU3ViQ2xhc3PCoCDCoCDCoCDCoDI8L2Rpdj48ZGl2PsKgIMKgIMKgIGJGdW5jdGlvblBy
b3RvY29swqAgwqAgwqAgwqAxPC9kaXY+PGRpdj7CoCDCoCDCoCBpRnVuY3Rpb27CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDQgQ0RDIEFDTTwvZGl2PjxkaXY+Li4uPC9kaXY+PC9kaXY+PGRpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9kaXY+PGRpdj48YnI+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9Imdt
YWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBUaHUsIFNlcCAxMywgMjAxOCBhdCAxMDoyMSBB
TSBGcmFuayBWYXNxdWV6ICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhlbGl1bS5jb20iPmZy
YW5rdkBoZWxpdW0uY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIi
PkhpIEdpYWNpbnRvLDxkaXY+PGJyPjwvZGl2PjxkaXY+Jmd0OyBjYW4geW91IHNlbmQgdGhlIHJl
c3VsdCBvZiAmcXVvdDtsc3VzYiZxdW90OyBhbmQgJnF1b3Q7bHN1c2IgLXQmcXVvdDs/PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PiMgbHN1c2IgLXQ8L2Rpdj48ZGl2PkJ1cyAwMDEgRGV2
aWNlIDAwMTogSUQgMWQ2YjowMDAyPC9kaXY+PGRpdj5CdXMgMDAxIERldmljZSAwMDI6IElEIDE1
NDY6MTEwNzwvZGl2PjxkaXY+QnVzIDAwMiBEZXZpY2UgMDAxOiBJRCAxZDZiOjAwMDM8L2Rpdj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYW0gcnVubmluZyBCdXN5Qm94JiMzOTtzIHN0cmlw
cGVkIGRvd24gdmVyc2lvbiBvZiBsc3VzYiB0aGF0JiMzOTtzIHdoeSBpbmZvcm1hdGlvbiBpcyBz
byBsYWNraW5nLjwvZGl2PjxkaXY+SSYjMzk7bGwgaW5zdGFsbCB1c2J1dGlscyBvbiBteSBkZXZp
Y2UmIzM5O3MgQnVpbGRyb290IGltYWdlIGFuZCByZXJ1biB0aGUgY29tbWFuZHMuPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2PjwvZGl2PjwvZGl2
Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBTZXAg
MTMsIDIwMTggYXQgMzo0OSBBTSBHaWFjaW50byBDaWZlbGxpICZsdDs8YSBocmVmPSJtYWlsdG86
Z2Npb2Zvbm9AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+Z2Npb2Zvbm9AZ21haWwuY29tPC9h
PiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmct
bGVmdDoxZXgiPjxkaXYgZGlyPSJhdXRvIj5oaSBGcmFuayw8ZGl2IGRpcj0iYXV0byI+PGJyPjwv
ZGl2PjxkaXYgZGlyPSJhdXRvIj5jYW4geW91IHNlbmQgdGhlIHJlc3VsdCBvZiAmcXVvdDtsc3Vz
YiZxdW90OyBhbmQgJnF1b3Q7bHN1c2IgLXQmcXVvdDs/PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxi
cj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+R2lhY2ludG88L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgMTMgU2VwIDIwMTgsIDAwOjQx
IEZyYW5rIFZhc3F1ZXosICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhlbGl1bS5jb20iIHRh
cmdldD0iX2JsYW5rIj5mcmFua3ZAaGVsaXVtLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRy
Ij48ZGl2IGRpcj0ibHRyIj5HcmVldGluZ3MsPGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUgYW4g
ZW1iZWRkZWQgZGV2aWNlIHdpdGggYSB1YmxveCBUT0JZLVIyMDAgb24gaXQuwqAgSSB3YW50IHRv
IHVzZSBjb25ubWFuIHRvIG1hbmFnZSBhbnkgY2VsbHVsYXIgY29ubmVjdGlvbiBvbiB0aGF0IG1v
ZGVtIHNpbmNlIGNvbm5tYW4gaXMgYWxyZWFkeSBtYW5hZ2luZyBldGhlcm5ldCBhbmQgd2lmaSBj
b25uZWN0aXZpdHkuwqAgb0Zvbm8gc2VlbXMgbGlrZSB0aGUgYmVzdCBvcHRpb24uwqAgSSBzZWUg
dGhhdCB0aGVyZSBpcyBhbHJlYWR5IGEgdWJsb3ggcGx1Z2luIGZvciBvRm9ubyBidXQgSSBkb24m
IzM5O3QgdGhpbmsgdGhlIFRPQlktUjIwMCBpcyBzdXBwb3J0ZWQuwqAgVGhlIGNlbGwgbW9kdWxl
IGlzIHNvbGRlcmVkIG9udG8gdGhlIGJvYXJkIGFuZCBhcHBlYXJzIGFzIGEgVVNCIGRldmljZS48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+W8KgIMKgIDYuNTE5MTkwXSB1c2IgMS0xOiBO
ZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MSwgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9Mzwv
ZGl2PjxkaXY+W8KgIMKgIDYuNTE5MTk3XSB1c2IgMS0xOiBQcm9kdWN0OiB1LWJsb3ggQ2VsbHVs
YXIgTW9kdWxlPC9kaXY+PGRpdj5bwqAgwqAgNi41MTkyMDRdIHVzYiAxLTE6IE1hbnVmYWN0dXJl
cjogdS1ibG94PC9kaXY+PGRpdj5bwqAgwqAgNi41MTkyMTFdIHVzYiAxLTE6IFNlcmlhbE51bWJl
cjogMzUyODQ4MDgwMzkyNjQ2PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGNhbiBz
ZW5kIEFUIGNvbW1hbmRzIHRvIHRoZSBtb2RlbSBvdmVyIC9kZXYvdHR5QUNNMC48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9kaXY+PC9kaXY+PC9kaXY+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9u
byBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHJlbD0i
bm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9mb25vLm9yZzwvYT48YnI+CjxhIGhy
ZWY9Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm8iIHJlbD0i
bm9yZWZlcnJlciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy5vZm9u
by5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvYmxvY2txdW90ZT48L2Rpdj4K
PC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============4735853945983898978==--


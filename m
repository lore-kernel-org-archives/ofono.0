Content-Type: multipart/mixed; boundary="===============5652306209804191972=="
MIME-Version: 1.0
From: Leonardo Luiz Padovani da Mata <leonardol@syst.com.br>
Subject: Re: Add support to huawei e173
Date: Tue, 31 May 2011 16:11:56 -0300
Message-ID: <BANLkTi=LbZcb_m=G6qWF106Lc8D6j+Cxpg@mail.gmail.com>
In-Reply-To: <BANLkTi=2-=4MwfsFcO8S-H4-T-yh9Hi3wA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5652306209804191972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,
after installing the usb-modeswitch packages, and adding information about
this modem, i'm getting this output on dmesg:

[  211.821126] usb 1-1: new high speed USB device using ehci_hcd and address
5
[  212.159596] usb 1-1: New USB device found, idVendor=3D12d1, idProduct=3D=
1c0b
[  212.159613] usb 1-1: New USB device strings: Mfr=3D2, Product=3D1,
SerialNumber=3D0
[  212.159626] usb 1-1: Product: HUAWEI Mobile
[  212.159636] usb 1-1: Manufacturer: HUAWEI
[  212.164491] scsi4 : usb-storage 1-1:1.0
[  212.168298] scsi5 : usb-storage 1-1:1.1
[  214.196257] usb 1-1: usbfs: USBDEVFS_CONTROL failed cmd usb_modeswitch
rqt 128 rq 6 len 255 ret -110
[  215.196274] usb 1-1: usbfs: USBDEVFS_CONTROL failed cmd usb_modeswitch
rqt 128 rq 6 len 255 ret -110
[  223.169124] scsi 4:0:0:0: CD-ROM            HUAWEI   Mass Storage
2.31 PQ: 0 ANSI: 2
[  223.169196] scsi 5:0:0:0: Direct-Access     HUAWEI   SD Storage
2.31 PQ: 0 ANSI: 2
[  223.179683] sr0: scsi-1 drive
[  223.179702] cdrom: Uniform CD-ROM driver Revision: 3.20
[  223.181383] sr 4:0:0:0: Attached scsi CD-ROM sr0
[  223.182586] sr 4:0:0:0: Attached scsi generic sg1 type 5
[  223.190693] sd 5:0:0:0: Attached scsi generic sg1 type 0
[  223.195132] sd 5:0:0:0: [sdb] Attached SCSI removable disk
[  223.239512] usb 1-1: USB disconnect, address 5
[  225.452183] usb 1-1: new high speed USB device using ehci_hcd and address
6
[  225.568519] usb 1-1: New USB device found, idVendor=3D12d1, idProduct=3D=
1c05
[  225.568536] usb 1-1: New USB device strings: Mfr=3D2, Product=3D1,
SerialNumber=3D0
[  225.568548] usb 1-1: Product: HUAWEI Mobile


I think that usb_modeswitch cannot be done in this device.  Maybe you are
more familiar with this type of debugging and you can help me.

rule added on 40-usb_modeswitch.rules:
ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1c0b", RUN+=3D"usb_mode=
switch
'%b/%k'"

file with modem information on /etc/usb_modeswitch.d :
########################################################
# Huawei E173s

DefaultVendor=3D 0x12d1
DefaultProduct=3D 0x1c0b

TargetVendor=3D 0x12d1
TargetProduct=3D 0x1c05

CheckSuccess=3D20

MessageContent=3D"555342431234567800000000000000110600000000000000000000000=
00000"


On interesting information is that this modem has a driver inside the
"cd-rom" that must be compiled to worl, at least  this is the information on
readme file. I'm not sure it this is really needed or not.



On Tue, May 31, 2011 at 3:05 PM, Leonardo Luiz Padovani da Mata <
leonardol@syst.com.br> wrote:

>
>
> On Tue, May 31, 2011 at 2:52 PM, Denis Kenzior <denkenz@gmail.com> wrot=
e:
>
>> Hi Leonardo,
>>
>> On 05/31/2011 12:45 PM, Leonardo Luiz Padovani da Mata wrote:
>> > Hello Denis, how are you?
>> >
>> > On Tue, May 31, 2011 at 1:47 PM, Denis Kenzior <denkenz@gmail.com
>> > <mailto:denkenz@gmail.com>> wrote:
>> >
>> >     Hi Leonardo,
>> >
>> >     On 05/30/2011 04:11 PM, Leonardo Luiz Padovani da Mata wrote:
>> >     > hello dudes, what i need to do to check if the implemented drive=
rs
>> are
>> >     > enough to support a modem? Do i just need to add the rules for
>> >     udev? how
>> >     > do i do that?
>> >     >
>> >     > The id of the modem is  12d1:1c0b huawei e173
>> >     >
>> >
>> >     Check plugins/ofono.rules in git.  It looks like a rule is not
>> present
>> >     for this particular device id.
>> >
>> >     You will have to do some minor poking around to figure out what tty
>> >     corresponds to what function (e.g. Pcui, Modem, see other Huawei
>> rules
>> >     for examples), add a new entry to ofono.rules and try to see if it
>> >     works.
>> >
>> >
>> > Ok, i've found another possible soluttion using usb_modeswitch, but it
>> > didn't work yet:
>> > http://www.draisberghof.de/usb_modeswitch/bb/viewtopic.php?t=3D552
>> >
>> > Do you think that the usb_modeswitch approach is better/worse?
>>
>> This depends a little bit on how your modem is being recognized.  If it
>> is recognized as a storage device, then yes, usb_modeswitch will
>> probably be required.
>>
>> If it is already recognized as a modem and the rules are not present in
>> ofono.rules, then you will need to perform the steps I mentioned in my
>> previous mail.
>>
>
> I think it's beeing reconize as a storage device:
>
> [69834.725138] usb 1-1: new high speed USB device using ehci_hcd and
> address 8
> [69835.059643] usb 1-1: New USB device found, idVendor=3D12d1, idProduct=
=3D1c0b
> [69835.059659] usb 1-1: New USB device strings: Mfr=3D2, Product=3D1,
> SerialNumber=3D0
> [69835.059672] usb 1-1: Product: HUAWEI Mobile
> [69835.059681] usb 1-1: Manufacturer: HUAWEI
> [69835.065356] scsi10 : usb-storage 1-1:1.0
> [69835.069655] scsi11 : usb-storage 1-1:1.1
> [69837.899663] scsi 10:0:0:0: CD-ROM            HUAWEI   Mass Storage
> 2.31 PQ: 0 ANSI: 2
> [69837.899734] scsi 11:0:0:0: Direct-Access     HUAWEI   SD Storage
> 2.31 PQ: 0 ANSI: 2
> [69837.911391] sr0: scsi-1 drive
> [69837.913325] sr 10:0:0:0: Attached scsi CD-ROM sr0
> [69837.914408] sr 10:0:0:0: Attached scsi generic sg1 type 5
> [69837.923960] sd 11:0:0:0: Attached scsi generic sg2 type 0
> [69837.933196] sd 11:0:0:0: [sdb] Attached SCSI removable disk
>
>
>
>
>>
>> Regards,
>> -Denis
>>
>
>
>
> --
> Leonardo Luiz Padovani da Mata
>
> International Syst S/A
> Metasys Tecnologia
> Software Engineer Metasys MeeGo Team
>
> leonardol(a)metasys.com.br
> +55-31-3503-9040
>
> "May the force be with you, always"
> "Nerd Pride... eu tenho. Voce tem?"
>



-- =

Leonardo Luiz Padovani da Mata

International Syst S/A
Metasys Tecnologia
Software Engineer Metasys MeeGo Team

leonardol(a)metasys.com.br
+55-31-3503-9040

"May the force be with you, always"
"Nerd Pride... eu tenho. Voce tem?"

--===============5652306209804191972==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGVsbG8sIDxicj5hZnRlciBpbnN0YWxsaW5nIHRoZSB1c2ItbW9kZXN3aXRjaCBwYWNrYWdlcywg
YW5kIGFkZGluZyBpbmZvcm1hdGlvbiBhYm91dCB0aGlzIG1vZGVtLCBpJiMzOTttIGdldHRpbmcg
dGhpcyBvdXRwdXQgb24gZG1lc2c6PGJyPjxicj5boCAyMTEuODIxMTI2XSB1c2IgMS0xOiBuZXcg
aGlnaCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRyZXNzIDU8YnI+Clug
IDIxMi4xNTk1OTZdIHVzYiAxLTE6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xMmQx
LCBpZFByb2R1Y3Q9MWMwYjxicj5boCAyMTIuMTU5NjEzXSB1c2IgMS0xOiBOZXcgVVNCIGRldmlj
ZSBzdHJpbmdzOiBNZnI9MiwgUHJvZHVjdD0xLCBTZXJpYWxOdW1iZXI9MDxicj5boCAyMTIuMTU5
NjI2XSB1c2IgMS0xOiBQcm9kdWN0OiBIVUFXRUkgTW9iaWxlPGJyPlugIDIxMi4xNTk2MzZdIHVz
YiAxLTE6IE1hbnVmYWN0dXJlcjogSFVBV0VJPGJyPgpboCAyMTIuMTY0NDkxXSBzY3NpNCA6IHVz
Yi1zdG9yYWdlIDEtMToxLjA8YnI+W6AgMjEyLjE2ODI5OF0gc2NzaTUgOiB1c2Itc3RvcmFnZSAx
LTE6MS4xPGJyPlugIDIxNC4xOTYyNTddIHVzYiAxLTE6IHVzYmZzOiBVU0JERVZGU19DT05UUk9M
IGZhaWxlZCBjbWQgdXNiX21vZGVzd2l0Y2ggcnF0IDEyOCBycSA2IGxlbiAyNTUgcmV0IC0xMTA8
YnI+W6AgMjE1LjE5NjI3NF0gdXNiIDEtMTogdXNiZnM6IFVTQkRFVkZTX0NPTlRST0wgZmFpbGVk
IGNtZCB1c2JfbW9kZXN3aXRjaCBycXQgMTI4IHJxIDYgbGVuIDI1NSByZXQgLTExMDxicj4KW6Ag
MjIzLjE2OTEyNF0gc2NzaSA0OjA6MDowOiBDRC1ST02goKCgoKCgoKCgoCBIVUFXRUmgoCBNYXNz
IFN0b3JhZ2WgoKCgIDIuMzEgUFE6IDAgQU5TSTogMjxicj5boCAyMjMuMTY5MTk2XSBzY3NpIDU6
MDowOjA6IERpcmVjdC1BY2Nlc3OgoKCgIEhVQVdFSaCgIFNEIFN0b3JhZ2WgoKCgoKAgMi4zMSBQ
UTogMCBBTlNJOiAyPGJyPlugIDIyMy4xNzk2ODNdIHNyMDogc2NzaS0xIGRyaXZlPGJyPgpboCAy
MjMuMTc5NzAyXSBjZHJvbTogVW5pZm9ybSBDRC1ST00gZHJpdmVyIFJldmlzaW9uOiAzLjIwPGJy
PlugIDIyMy4xODEzODNdIHNyIDQ6MDowOjA6IEF0dGFjaGVkIHNjc2kgQ0QtUk9NIHNyMDxicj5b
oCAyMjMuMTgyNTg2XSBzciA0OjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2cxIHR5cGUg
NTxicj5boCAyMjMuMTkwNjkzXSBzZCA1OjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2cx
IHR5cGUgMDxicj4KW6AgMjIzLjE5NTEzMl0gc2QgNTowOjA6MDogW3NkYl0gQXR0YWNoZWQgU0NT
SSByZW1vdmFibGUgZGlzazxicj5boCAyMjMuMjM5NTEyXSB1c2IgMS0xOiBVU0IgZGlzY29ubmVj
dCwgYWRkcmVzcyA1PGJyPlugIDIyNS40NTIxODNdIHVzYiAxLTE6IG5ldyBoaWdoIHNwZWVkIFVT
QiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgNjxicj5boCAyMjUuNTY4NTE5XSB1
c2IgMS0xOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MTJkMSwgaWRQcm9kdWN0PTFj
MDU8YnI+ClugIDIyNS41Njg1MzZdIHVzYiAxLTE6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1m
cj0yLCBQcm9kdWN0PTEsIFNlcmlhbE51bWJlcj0wPGJyPlugIDIyNS41Njg1NDhdIHVzYiAxLTE6
IFByb2R1Y3Q6IEhVQVdFSSBNb2JpbGU8YnI+PGJyPjxicj5JIHRoaW5rIHRoYXQgdXNiX21vZGVz
d2l0Y2ggY2Fubm90IGJlIGRvbmUgaW4gdGhpcyBkZXZpY2UuoCBNYXliZSB5b3UgYXJlIG1vcmUg
ZmFtaWxpYXIgd2l0aCB0aGlzIHR5cGUgb2YgZGVidWdnaW5nIGFuZCB5b3UgY2FuIGhlbHAgbWUu
IDxicj4KPGJyPnJ1bGUgYWRkZWQgb24gNDAtdXNiX21vZGVzd2l0Y2gucnVsZXM6PGJyPkFUVFJT
e2lkVmVuZG9yfT09JnF1b3Q7MTJkMSZxdW90OywgQVRUUlN7aWRQcm9kdWN0fT09JnF1b3Q7MWMw
YiZxdW90OywgUlVOKz0mcXVvdDt1c2JfbW9kZXN3aXRjaCAmIzM5OyViLyVrJiMzOTsmcXVvdDs8
YnI+PGJyPmZpbGUgd2l0aCBtb2RlbSBpbmZvcm1hdGlvbiBvbiAvZXRjL3VzYl9tb2Rlc3dpdGNo
LmQgOjxicj4KIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyM8YnI+IyBIdWF3ZWkgRTE3M3M8YnI+PGJyPkRlZmF1bHRWZW5kb3I9IDB4MTJkMTxi
cj5EZWZhdWx0UHJvZHVjdD0gMHgxYzBiPGJyPjxicj5UYXJnZXRWZW5kb3I9IDB4MTJkMTxicj5U
YXJnZXRQcm9kdWN0PSAweDFjMDU8YnI+PGJyPkNoZWNrU3VjY2Vzcz0yMDxicj48YnI+TWVzc2Fn
ZUNvbnRlbnQ9JnF1b3Q7NTU1MzQyNDMxMjM0NTY3ODAwMDAwMDAwMDAwMDAwMTEwNjAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAmcXVvdDs8YnI+Cjxicj48YnI+T24gaW50ZXJlc3RpbmcgaW5m
b3JtYXRpb24gaXMgdGhhdCB0aGlzIG1vZGVtIGhhcyBhIGRyaXZlciBpbnNpZGUgdGhlICZxdW90
O2NkLXJvbSZxdW90OyB0aGF0IG11c3QgYmUgY29tcGlsZWQgdG8gd29ybCwgYXQgbGVhc3SgIHRo
aXMgaXMgdGhlIGluZm9ybWF0aW9uIG9uIHJlYWRtZSBmaWxlLiBJJiMzOTttIG5vdCBzdXJlIGl0
IHRoaXMgaXMgcmVhbGx5IG5lZWRlZCBvciBub3QuPGJyPgo8YnI+PGJyPjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+T24gVHVlLCBNYXkgMzEsIDIwMTEgYXQgMzowNSBQTSwgTGVvbmFyZG8g
THVpeiBQYWRvdmFuaSBkYSBNYXRhIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRv
Omxlb25hcmRvbEBzeXN0LmNvbS5iciI+bGVvbmFyZG9sQHN5c3QuY29tLmJyPC9hPiZndDs8L3Nw
YW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
OyI+Cjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXY+PGRpdj48L2Rpdj48ZGl2
IGNsYXNzPSJoNSI+T24gVHVlLCBNYXkgMzEsIDIwMTEgYXQgMjo1MiBQTSwgRGVuaXMgS2Vuemlv
ciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIg
dGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxi
cj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CkhpIExlb25h
cmRvLDxicj4KPGRpdj48YnI+Ck9uIDA1LzMxLzIwMTEgMTI6NDUgUE0sIExlb25hcmRvIEx1aXog
UGFkb3ZhbmkgZGEgTWF0YSB3cm90ZTo8YnI+CiZndDsgSGVsbG8gRGVuaXMsIGhvdyBhcmUgeW91
Pzxicj4KJmd0Ozxicj4KJmd0OyBPbiBUdWUsIE1heSAzMSwgMjAxMSBhdCAxOjQ3IFBNLCBEZW5p
cyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iIHRhcmdldD0i
X2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT48YnI+CjwvZGl2PjxkaXY+Jmd0OyAmbHQ7bWFp
bHRvOjxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRl
bmtlbnpAZ21haWwuY29tPC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4KJmd0Ozxicj4KJmd0OyCgIKAg
SGkgTGVvbmFyZG8sPGJyPgomZ3Q7PGJyPgomZ3Q7IKAgoCBPbiAwNS8zMC8yMDExIDA0OjExIFBN
LCBMZW9uYXJkbyBMdWl6IFBhZG92YW5pIGRhIE1hdGEgd3JvdGU6PGJyPgomZ3Q7IKAgoCAmZ3Q7
IGhlbGxvIGR1ZGVzLCB3aGF0IGkgbmVlZCB0byBkbyB0byBjaGVjayBpZiB0aGUgaW1wbGVtZW50
ZWQgZHJpdmVycyBhcmU8YnI+CiZndDsgoCCgICZndDsgZW5vdWdoIHRvIHN1cHBvcnQgYSBtb2Rl
bT8gRG8gaSBqdXN0IG5lZWQgdG8gYWRkIHRoZSBydWxlcyBmb3I8YnI+CiZndDsgoCCgIHVkZXY/
IGhvdzxicj4KJmd0OyCgIKAgJmd0OyBkbyBpIGRvIHRoYXQ/PGJyPgomZ3Q7IKAgoCAmZ3Q7PGJy
PgomZ3Q7IKAgoCAmZ3Q7IFRoZSBpZCBvZiB0aGUgbW9kZW0gaXMgoDEyZDE6MWMwYiBodWF3ZWkg
ZTE3Mzxicj4KJmd0OyCgIKAgJmd0Ozxicj4KJmd0Ozxicj4KJmd0OyCgIKAgQ2hlY2sgcGx1Z2lu
cy9vZm9uby5ydWxlcyBpbiBnaXQuIKBJdCBsb29rcyBsaWtlIGEgcnVsZSBpcyBub3QgcHJlc2Vu
dDxicj4KJmd0OyCgIKAgZm9yIHRoaXMgcGFydGljdWxhciBkZXZpY2UgaWQuPGJyPgomZ3Q7PGJy
PgomZ3Q7IKAgoCBZb3Ugd2lsbCBoYXZlIHRvIGRvIHNvbWUgbWlub3IgcG9raW5nIGFyb3VuZCB0
byBmaWd1cmUgb3V0IHdoYXQgdHR5PGJyPgomZ3Q7IKAgoCBjb3JyZXNwb25kcyB0byB3aGF0IGZ1
bmN0aW9uIChlLmcuIFBjdWksIE1vZGVtLCBzZWUgb3RoZXIgSHVhd2VpIHJ1bGVzPGJyPgomZ3Q7
IKAgoCBmb3IgZXhhbXBsZXMpLCBhZGQgYSBuZXcgZW50cnkgdG8gb2Zvbm8ucnVsZXMgYW5kIHRy
eSB0byBzZWUgaWYgaXQ8YnI+CiZndDsgoCCgIHdvcmtzLjxicj4KJmd0Ozxicj4KJmd0Ozxicj4K
Jmd0OyBPaywgaSYjMzk7dmUgZm91bmQgYW5vdGhlciBwb3NzaWJsZSBzb2x1dHRpb24gdXNpbmcg
dXNiX21vZGVzd2l0Y2gsIGJ1dCBpdDxicj4KJmd0OyBkaWRuJiMzOTt0IHdvcmsgeWV0Ojxicj4K
Jmd0OyA8YSBocmVmPSJodHRwOi8vd3d3LmRyYWlzYmVyZ2hvZi5kZS91c2JfbW9kZXN3aXRjaC9i
Yi92aWV3dG9waWMucGhwP3Q9NTUyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL3d3dy5kcmFpc2Jl
cmdob2YuZGUvdXNiX21vZGVzd2l0Y2gvYmIvdmlld3RvcGljLnBocD90PTU1MjwvYT48YnI+CiZn
dDs8YnI+CiZndDsgRG8geW91IHRoaW5rIHRoYXQgdGhlIHVzYl9tb2Rlc3dpdGNoIGFwcHJvYWNo
IGlzIGJldHRlci93b3JzZT88YnI+Cjxicj4KPC9kaXY+VGhpcyBkZXBlbmRzIGEgbGl0dGxlIGJp
dCBvbiBob3cgeW91ciBtb2RlbSBpcyBiZWluZyByZWNvZ25pemVkLiCgSWYgaXQ8YnI+CmlzIHJl
Y29nbml6ZWQgYXMgYSBzdG9yYWdlIGRldmljZSwgdGhlbiB5ZXMsIHVzYl9tb2Rlc3dpdGNoIHdp
bGw8YnI+CnByb2JhYmx5IGJlIHJlcXVpcmVkLjxicj4KPGJyPgpJZiBpdCBpcyBhbHJlYWR5IHJl
Y29nbml6ZWQgYXMgYSBtb2RlbSBhbmQgdGhlIHJ1bGVzIGFyZSBub3QgcHJlc2VudCBpbjxicj4K
b2Zvbm8ucnVsZXMsIHRoZW4geW91IHdpbGwgbmVlZCB0byBwZXJmb3JtIHRoZSBzdGVwcyBJIG1l
bnRpb25lZCBpbiBteTxicj4KcHJldmlvdXMgbWFpbC48YnI+PC9ibG9ja3F1b3RlPjwvZGl2Pjwv
ZGl2PjxkaXY+PGJyPkkgdGhpbmsgaXQmIzM5O3MgYmVlaW5nIHJlY29uaXplIGFzIGEgc3RvcmFn
ZSBkZXZpY2U6PGJyPjxicj5bNjk4MzQuNzI1MTM4XSB1c2IgMS0xOiBuZXcgaGlnaCBzcGVlZCBV
U0IgZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRyZXNzIDg8YnI+WzY5ODM1LjA1OTY0M10g
dXNiIDEtMTogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTEyZDEsIGlkUHJvZHVjdD0x
YzBiPGJyPgoKWzY5ODM1LjA1OTY1OV0gdXNiIDEtMTogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczog
TWZyPTIsIFByb2R1Y3Q9MSwgU2VyaWFsTnVtYmVyPTA8YnI+WzY5ODM1LjA1OTY3Ml0gdXNiIDEt
MTogUHJvZHVjdDogSFVBV0VJIE1vYmlsZTxicj5bNjk4MzUuMDU5NjgxXSB1c2IgMS0xOiBNYW51
ZmFjdHVyZXI6IEhVQVdFSTxicj5bNjk4MzUuMDY1MzU2XSBzY3NpMTAgOiB1c2Itc3RvcmFnZSAx
LTE6MS4wPGJyPgoKWzY5ODM1LjA2OTY1NV0gc2NzaTExIDogdXNiLXN0b3JhZ2UgMS0xOjEuMTxi
cj5bNjk4MzcuODk5NjYzXSBzY3NpIDEwOjA6MDowOiBDRC1ST02goKCgoKCgoKCgoCBIVUFXRUmg
oCBNYXNzIFN0b3JhZ2WgoKCgIDIuMzEgUFE6IDAgQU5TSTogMjxicj5bNjk4MzcuODk5NzM0XSBz
Y3NpIDExOjA6MDowOiBEaXJlY3QtQWNjZXNzoKCgoCBIVUFXRUmgoCBTRCBTdG9yYWdloKCgoKCg
IDIuMzEgUFE6IDAgQU5TSTogMjxicj4KCls2OTgzNy45MTEzOTFdIHNyMDogc2NzaS0xIGRyaXZl
PGJyPls2OTgzNy45MTMzMjVdIHNyIDEwOjA6MDowOiBBdHRhY2hlZCBzY3NpIENELVJPTSBzcjA8
YnI+WzY5ODM3LjkxNDQwOF0gc3IgMTA6MDowOjA6IEF0dGFjaGVkIHNjc2kgZ2VuZXJpYyBzZzEg
dHlwZSA1PGJyPls2OTgzNy45MjM5NjBdIHNkIDExOjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVy
aWMgc2cyIHR5cGUgMDxicj4KWzY5ODM3LjkzMzE5Nl0gc2QgMTE6MDowOjA6IFtzZGJdIEF0dGFj
aGVkIFNDU0kgcmVtb3ZhYmxlIGRpc2s8YnI+Cjxicj48YnI+oDwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHQgMHB0IDBwdCAwLjhleDtib3JkZXIt
bGVmdDoxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+
ClJlZ2FyZHMsPGJyPgo8Zm9udCBjb2xvcj0iIzg4ODg4OCI+LURlbmlzPGJyPgo8L2ZvbnQ+PC9i
bG9ja3F1b3RlPjwvZGl2Pjxicj48YnIgY2xlYXI9ImFsbCI+PGJyPi0tIDxicj48ZGl2IGNsYXNz
PSJpbSI+TGVvbmFyZG8gTHVpeiBQYWRvdmFuaSBkYSBNYXRhPGJyPjxicj48L2Rpdj48ZGl2Pjxk
aXY+PC9kaXY+PGRpdiBjbGFzcz0iaDUiPkludGVybmF0aW9uYWwgU3lzdCBTL0E8YnI+TWV0YXN5
cyBUZWNub2xvZ2lhPGJyPlNvZnR3YXJlIEVuZ2luZWVyIE1ldGFzeXMgTWVlR28gVGVhbTxicj4K
PGJyPjxhIGhyZWY9Im1haWx0bzpsZW9uYXJkb2xAbWV0YXN5cy5jb20uYnIiIHRhcmdldD0iX2Js
YW5rIj5sZW9uYXJkb2xAbWV0YXN5cy5jb20uYnI8L2E+PGJyPgorNTUtMzEtMzUwMy05MDQwPGJy
Pjxicj4mcXVvdDtNYXkgdGhlIGZvcmNlIGJlIHdpdGggeW91LCBhbHdheXMmcXVvdDs8YnI+JnF1
b3Q7TmVyZCBQcmlkZS4uLiBldSB0ZW5oby4gVm9jZSB0ZW0/JnF1b3Q7PGJyPgo8L2Rpdj48L2Rp
dj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjxiciBjbGVhcj0iYWxsIj48YnI+LS0gPGJyPkxlb25h
cmRvIEx1aXogUGFkb3ZhbmkgZGEgTWF0YTxicj48YnI+SW50ZXJuYXRpb25hbCBTeXN0IFMvQTxi
cj5NZXRhc3lzIFRlY25vbG9naWE8YnI+U29mdHdhcmUgRW5naW5lZXIgTWV0YXN5cyBNZWVHbyBU
ZWFtPGJyPjxicj48YSBocmVmPSJtYWlsdG86bGVvbmFyZG9sQG1ldGFzeXMuY29tLmJyIiB0YXJn
ZXQ9Il9ibGFuayI+bGVvbmFyZG9sQG1ldGFzeXMuY29tLmJyPC9hPjxicj4KKzU1LTMxLTM1MDMt
OTA0MDxicj48YnI+JnF1b3Q7TWF5IHRoZSBmb3JjZSBiZSB3aXRoIHlvdSwgYWx3YXlzJnF1b3Q7
PGJyPiZxdW90O05lcmQgUHJpZGUuLi4gZXUgdGVuaG8uIFZvY2UgdGVtPyZxdW90Ozxicj4K

--===============5652306209804191972==--


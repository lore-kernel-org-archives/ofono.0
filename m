Content-Type: multipart/mixed; boundary="===============8590118348827833072=="
MIME-Version: 1.0
From: Leonardo Luiz Padovani da Mata <leonardol@syst.com.br>
Subject: Re: Problem with Huawei E5832
Date: Thu, 09 Jun 2011 18:16:28 -0300
Message-ID: <BANLkTinzTube+mg9K2vQ5_7SX2m+bOexNg@mail.gmail.com>
In-Reply-To: <CE59C043D0EC3349B2BF41C0EC72229B4D80D079@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8590118348827833072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I think i'm having the same behavior as yours, with a different modem. They
asked me to change the file ofono.rules (find / -name ofono.rules) and
change add your  modem id:
idVendor=3D12d1, idProduct=3D142d

For me it didn't work.

There is also usbmodeswitch that must be called for some modems, google for
it.

Hope that this may help you.


On Wed, Jun 8, 2011 at 11:07 PM, Deng, Ying An <ying.an.deng@intel.com>wr=
ote:

> Hi,
>
> When using Huawei E5832 with ofono 0.48, the 3G modem cannot be initializ=
ed
> by ofono.
>
> Here's the ofono log:
>
> ofonod[2763]: src/modem.c:ofono_modem_create() name: 1234567890ABCDEF,
> type: huawei
> ofonod[2763]: src/modem.c:set_modem_property() modem 0x86791e0 property
> Path
> ofonod[2763]: src/modem.c:set_modem_property() modem 0x86791e0 property
> Registered
> ofonod[2763]: plugins/udev.c:add_modem()
> /devices/pci0000:00/0000:00:1d.7/usb1/1-5/1-5:1.2/ttyUSB1/tty/ttyUSB1
> (huawei)
> ofonod[2763]: plugins/udev.c:add_huawei() modem 0x86791e0
> ofonod[2763]: src/modem.c:get_modem_property() modem 0x86791e0 property
> ModemRegistered
> ofonod[2763]: src/modem.c:get_modem_property() modem 0x86791e0 property
> PcuiRegistered
> ofonod[2763]: src/modem.c:get_modem_property() modem 0x86791e0 property
> Path
> ofonod[2763]: plugins/udev.c:add_modem()
> /devices/pci0000:00/0000:00:1d.7/usb1/1-5/1-5:1.0/ttyUSB0/tty/ttyUSB0
> (huawei)
> ofonod[2763]: plugins/udev.c:add_huawei() modem 0x86791e0
> ofonod[2763]: src/modem.c:get_modem_property() modem 0x86791e0 property
> ModemRegistered
> ofonod[2763]: src/modem.c:get_modem_property() modem 0x86791e0 property
> PcuiRegistered
>
>
> Here's the dmesg log:
>
> [ 5916.054519] usb 1-5: new high speed USB device using ehci_hcd and
> address 21
> [ 5916.182355] usb 1-5: New USB device found, idVendor=3D12d1, idProduct=
=3D142d
> [ 5916.182374] usb 1-5: New USB device strings: Mfr=3D3, Product=3D2,
> SerialNumber=3D1
> [ 5916.182390] usb 1-5: Product: HUAWEI Mobile Connect
> [ 5916.182403] usb 1-5: Manufacturer: Huawei Incorporated
> [ 5916.182415] usb 1-5: SerialNumber: 1234567890ABCDEF
> [ 5916.195359] option 1-5:1.0: GSM modem (1-port) converter detected
> [ 5916.197114] usb 1-5: GSM modem (1-port) converter now attached to
> ttyUSB0
> [ 5916.199431] scsi32 : usb-storage 1-5:1.1
> [ 5916.202722] option 1-5:1.2: GSM modem (1-port) converter detected
> [ 5916.204631] usb 1-5: GSM modem (1-port) converter now attached to
> ttyUSB1
> [ 5917.205700] scsi 32:0:0:0: CD-ROM            HUAWEI   Mass storage
> ffff PQ: 0 ANSI: 2
> [ 5917.207737] scsi 32:0:0:1: Direct-Access     HUAWEI   Mass storage
> ffff PQ: 0 ANSI: 2
> [ 5917.221393] sr0: scsi-1 drive
> [ 5917.226228] sr 32:0:0:0: Attached scsi CD-ROM sr0
> [ 5917.227684] sr 32:0:0:0: Attached scsi generic sg1 type 5
> [ 5917.231320] sd 32:0:0:1: Attached scsi generic sg2 type 0
> [ 5917.241071] sd 32:0:0:1: [sdb] Attached SCSI removable disk
>
>
> Can anybody give some advice?
>
> Thanks
> Best regards,
>
> Ying.An
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
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

--===============8590118348827833072==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SSB0aGluayBpJiMzOTttIGhhdmluZyB0aGUgc2FtZSBiZWhhdmlvciBhcyB5b3Vycywgd2l0aCBh
IGRpZmZlcmVudCBtb2RlbS4gVGhleSBhc2tlZCBtZSB0byBjaGFuZ2UgdGhlIGZpbGUgb2Zvbm8u
cnVsZXMgKGZpbmQgLyAtbmFtZSBvZm9uby5ydWxlcykgYW5kIGNoYW5nZSBhZGQgeW91cqAgbW9k
ZW0gaWQ6PGJyPiBpZFZlbmRvcj0xMmQxLCBpZFByb2R1Y3Q9MTQyZDxicj48YnI+Rm9yIG1lIGl0
IGRpZG4mIzM5O3Qgd29yay48YnI+Cjxicj5UaGVyZSBpcyBhbHNvIHVzYm1vZGVzd2l0Y2ggdGhh
dCBtdXN0IGJlIGNhbGxlZCBmb3Igc29tZSBtb2RlbXMsIGdvb2dsZSBmb3IgaXQuPGJyPjxicj5I
b3BlIHRoYXQgdGhpcyBtYXkgaGVscCB5b3UuPGJyPjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPk9uIFdlZCwgSnVuIDgsIDIwMTEgYXQgMTE6MDcgUE0sIERlbmcsIFlpbmcgQW4gPHNw
YW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86eWluZy5hbi5kZW5nQGludGVsLmNvbSI+
eWluZy5hbi5kZW5nQGludGVsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+CjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1s
ZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXg7Ij5IaSw8YnI+Cjxicj4KV2hlbiB1
c2luZyBIdWF3ZWkgRTU4MzIgd2l0aCBvZm9ubyAwLjQ4LCB0aGUgM0cgbW9kZW0gY2Fubm90IGJl
IGluaXRpYWxpemVkIGJ5IG9mb25vLjxicj4KPGJyPgpIZXJlJiMzOTtzIHRoZSBvZm9ubyBsb2c6
PGJyPgo8YnI+Cm9mb25vZFsyNzYzXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fY3JlYXRlKCkg
bmFtZTogMTIzNDU2Nzg5MEFCQ0RFRiwgdHlwZTogaHVhd2VpPGJyPgpvZm9ub2RbMjc2M106IHNy
Yy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4ODY3OTFlMCBwcm9wZXJ0eSBQ
YXRoPGJyPgpvZm9ub2RbMjc2M106IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1v
ZGVtIDB4ODY3OTFlMCBwcm9wZXJ0eSBSZWdpc3RlcmVkPGJyPgpvZm9ub2RbMjc2M106IHBsdWdp
bnMvdWRldi5jOmFkZF9tb2RlbSgpIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC43L3Vz
YjEvMS01LzEtNToxLjIvdHR5VVNCMS90dHkvdHR5VVNCMSAoaHVhd2VpKTxicj4Kb2Zvbm9kWzI3
NjNdOiBwbHVnaW5zL3VkZXYuYzphZGRfaHVhd2VpKCkgbW9kZW0gMHg4Njc5MWUwPGJyPgpvZm9u
b2RbMjc2M106IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4ODY3OTFl
MCBwcm9wZXJ0eSBNb2RlbVJlZ2lzdGVyZWQ8YnI+Cm9mb25vZFsyNzYzXTogc3JjL21vZGVtLmM6
Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4Njc5MWUwIHByb3BlcnR5IFBjdWlSZWdpc3Rl
cmVkPGJyPgpvZm9ub2RbMjc2M106IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1v
ZGVtIDB4ODY3OTFlMCBwcm9wZXJ0eSBQYXRoPGJyPgpvZm9ub2RbMjc2M106IHBsdWdpbnMvdWRl
di5jOmFkZF9tb2RlbSgpIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC43L3VzYjEvMS01
LzEtNToxLjAvdHR5VVNCMC90dHkvdHR5VVNCMCAoaHVhd2VpKTxicj4Kb2Zvbm9kWzI3NjNdOiBw
bHVnaW5zL3VkZXYuYzphZGRfaHVhd2VpKCkgbW9kZW0gMHg4Njc5MWUwPGJyPgpvZm9ub2RbMjc2
M106IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4ODY3OTFlMCBwcm9w
ZXJ0eSBNb2RlbVJlZ2lzdGVyZWQ8YnI+Cm9mb25vZFsyNzYzXTogc3JjL21vZGVtLmM6Z2V0X21v
ZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4Njc5MWUwIHByb3BlcnR5IFBjdWlSZWdpc3RlcmVkPGJy
Pgo8YnI+Cjxicj4KSGVyZSYjMzk7cyB0aGUgZG1lc2cgbG9nOjxicj4KPGJyPgpbIDU5MTYuMDU0
NTE5XSB1c2IgMS01OiBuZXcgaGlnaCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFu
ZCBhZGRyZXNzIDIxPGJyPgpbIDU5MTYuMTgyMzU1XSB1c2IgMS01OiBOZXcgVVNCIGRldmljZSBm
b3VuZCwgaWRWZW5kb3I9MTJkMSwgaWRQcm9kdWN0PTE0MmQ8YnI+ClsgNTkxNi4xODIzNzRdIHVz
YiAxLTU6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0zLCBQcm9kdWN0PTIsIFNlcmlhbE51
bWJlcj0xPGJyPgpbIDU5MTYuMTgyMzkwXSB1c2IgMS01OiBQcm9kdWN0OiBIVUFXRUkgTW9iaWxl
IENvbm5lY3Q8YnI+ClsgNTkxNi4xODI0MDNdIHVzYiAxLTU6IE1hbnVmYWN0dXJlcjogSHVhd2Vp
IEluY29ycG9yYXRlZDxicj4KWyA1OTE2LjE4MjQxNV0gdXNiIDEtNTogU2VyaWFsTnVtYmVyOiAx
MjM0NTY3ODkwQUJDREVGPGJyPgpbIDU5MTYuMTk1MzU5XSBvcHRpb24gMS01OjEuMDogR1NNIG1v
ZGVtICgxLXBvcnQpIGNvbnZlcnRlciBkZXRlY3RlZDxicj4KWyA1OTE2LjE5NzExNF0gdXNiIDEt
NTogR1NNIG1vZGVtICgxLXBvcnQpIGNvbnZlcnRlciBub3cgYXR0YWNoZWQgdG8gdHR5VVNCMDxi
cj4KWyA1OTE2LjE5OTQzMV0gc2NzaTMyIDogdXNiLXN0b3JhZ2UgMS01OjEuMTxicj4KWyA1OTE2
LjIwMjcyMl0gb3B0aW9uIDEtNToxLjI6IEdTTSBtb2RlbSAoMS1wb3J0KSBjb252ZXJ0ZXIgZGV0
ZWN0ZWQ8YnI+ClsgNTkxNi4yMDQ2MzFdIHVzYiAxLTU6IEdTTSBtb2RlbSAoMS1wb3J0KSBjb252
ZXJ0ZXIgbm93IGF0dGFjaGVkIHRvIHR0eVVTQjE8YnI+ClsgNTkxNy4yMDU3MDBdIHNjc2kgMzI6
MDowOjA6IENELVJPTSCgIKAgoCCgIKAgoEhVQVdFSSCgIE1hc3Mgc3RvcmFnZSCgIKAgZmZmZiBQ
UTogMCBBTlNJOiAyPGJyPgpbIDU5MTcuMjA3NzM3XSBzY3NpIDMyOjA6MDoxOiBEaXJlY3QtQWNj
ZXNzIKAgoCBIVUFXRUkgoCBNYXNzIHN0b3JhZ2UgoCCgIGZmZmYgUFE6IDAgQU5TSTogMjxicj4K
WyA1OTE3LjIyMTM5M10gc3IwOiBzY3NpLTEgZHJpdmU8YnI+ClsgNTkxNy4yMjYyMjhdIHNyIDMy
OjA6MDowOiBBdHRhY2hlZCBzY3NpIENELVJPTSBzcjA8YnI+ClsgNTkxNy4yMjc2ODRdIHNyIDMy
OjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2cxIHR5cGUgNTxicj4KWyA1OTE3LjIzMTMy
MF0gc2QgMzI6MDowOjE6IEF0dGFjaGVkIHNjc2kgZ2VuZXJpYyBzZzIgdHlwZSAwPGJyPgpbIDU5
MTcuMjQxMDcxXSBzZCAzMjowOjA6MTogW3NkYl0gQXR0YWNoZWQgU0NTSSByZW1vdmFibGUgZGlz
azxicj4KPGJyPgo8YnI+CkNhbiBhbnlib2R5IGdpdmUgc29tZSBhZHZpY2U/PGJyPgo8YnI+ClRo
YW5rczxicj4KQmVzdCByZWdhcmRzLDxicj4KPGJyPgpZaW5nLkFuPGJyPgo8YnI+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5n
IGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9y
ZzwvYT48YnI+CjxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8i
IHRhcmdldD0iX2JsYW5rIj5odHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vPC9h
Pjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48YnIgY2xlYXI9ImFsbCI+PGJyPi0tIDxicj5M
ZW9uYXJkbyBMdWl6IFBhZG92YW5pIGRhIE1hdGE8YnI+PGJyPkludGVybmF0aW9uYWwgU3lzdCBT
L0E8YnI+TWV0YXN5cyBUZWNub2xvZ2lhPGJyPlNvZnR3YXJlIEVuZ2luZWVyIE1ldGFzeXMgTWVl
R28gVGVhbTxicj48YnI+PGEgaHJlZj0ibWFpbHRvOmxlb25hcmRvbEBtZXRhc3lzLmNvbS5iciIg
dGFyZ2V0PSJfYmxhbmsiPmxlb25hcmRvbEBtZXRhc3lzLmNvbS5icjwvYT48YnI+Cis1NS0zMS0z
NTAzLTkwNDA8YnI+PGJyPiZxdW90O01heSB0aGUgZm9yY2UgYmUgd2l0aCB5b3UsIGFsd2F5cyZx
dW90Ozxicj4mcXVvdDtOZXJkIFByaWRlLi4uIGV1IHRlbmhvLiBWb2NlIHRlbT8mcXVvdDs8YnI+
Cg==

--===============8590118348827833072==--


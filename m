Content-Type: multipart/mixed; boundary="===============0660236095656721926=="
MIME-Version: 1.0
From: Leonardo Luiz Padovani da Mata <leonardol@syst.com.br>
Subject: Re: Add support to huawei e173
Date: Tue, 31 May 2011 15:05:07 -0300
Message-ID: <BANLkTi=2-=4MwfsFcO8S-H4-T-yh9Hi3wA@mail.gmail.com>
In-Reply-To: <4DE52AF1.8030607@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0660236095656721926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2011 at 2:52 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Leonardo,
>
> On 05/31/2011 12:45 PM, Leonardo Luiz Padovani da Mata wrote:
> > Hello Denis, how are you?
> >
> > On Tue, May 31, 2011 at 1:47 PM, Denis Kenzior <denkenz@gmail.com
> > <mailto:denkenz@gmail.com>> wrote:
> >
> >     Hi Leonardo,
> >
> >     On 05/30/2011 04:11 PM, Leonardo Luiz Padovani da Mata wrote:
> >     > hello dudes, what i need to do to check if the implemented drivers
> are
> >     > enough to support a modem? Do i just need to add the rules for
> >     udev? how
> >     > do i do that?
> >     >
> >     > The id of the modem is  12d1:1c0b huawei e173
> >     >
> >
> >     Check plugins/ofono.rules in git.  It looks like a rule is not
> present
> >     for this particular device id.
> >
> >     You will have to do some minor poking around to figure out what tty
> >     corresponds to what function (e.g. Pcui, Modem, see other Huawei
> rules
> >     for examples), add a new entry to ofono.rules and try to see if it
> >     works.
> >
> >
> > Ok, i've found another possible soluttion using usb_modeswitch, but it
> > didn't work yet:
> > http://www.draisberghof.de/usb_modeswitch/bb/viewtopic.php?t=3D552
> >
> > Do you think that the usb_modeswitch approach is better/worse?
>
> This depends a little bit on how your modem is being recognized.  If it
> is recognized as a storage device, then yes, usb_modeswitch will
> probably be required.
>
> If it is already recognized as a modem and the rules are not present in
> ofono.rules, then you will need to perform the steps I mentioned in my
> previous mail.
>

I think it's beeing reconize as a storage device:

[69834.725138] usb 1-1: new high speed USB device using ehci_hcd and address
8
[69835.059643] usb 1-1: New USB device found, idVendor=3D12d1, idProduct=3D=
1c0b
[69835.059659] usb 1-1: New USB device strings: Mfr=3D2, Product=3D1,
SerialNumber=3D0
[69835.059672] usb 1-1: Product: HUAWEI Mobile
[69835.059681] usb 1-1: Manufacturer: HUAWEI
[69835.065356] scsi10 : usb-storage 1-1:1.0
[69835.069655] scsi11 : usb-storage 1-1:1.1
[69837.899663] scsi 10:0:0:0: CD-ROM            HUAWEI   Mass Storage
2.31 PQ: 0 ANSI: 2
[69837.899734] scsi 11:0:0:0: Direct-Access     HUAWEI   SD Storage
2.31 PQ: 0 ANSI: 2
[69837.911391] sr0: scsi-1 drive
[69837.913325] sr 10:0:0:0: Attached scsi CD-ROM sr0
[69837.914408] sr 10:0:0:0: Attached scsi generic sg1 type 5
[69837.923960] sd 11:0:0:0: Attached scsi generic sg2 type 0
[69837.933196] sd 11:0:0:0: [sdb] Attached SCSI removable disk




>
> Regards,
> -Denis
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

--===============0660236095656721926==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVHVlLCBNYXkgMzEsIDIwMTEgYXQg
Mjo1MiBQTSwgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0
bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3Jv
dGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAg
MCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXg7Ij4KSGkg
TGVvbmFyZG8sPGJyPgo8ZGl2IGNsYXNzPSJpbSI+PGJyPgpPbiAwNS8zMS8yMDExIDEyOjQ1IFBN
LCBMZW9uYXJkbyBMdWl6IFBhZG92YW5pIGRhIE1hdGEgd3JvdGU6PGJyPgomZ3Q7IEhlbGxvIERl
bmlzLCBob3cgYXJlIHlvdT88YnI+CiZndDs8YnI+CiZndDsgT24gVHVlLCBNYXkgMzEsIDIwMTEg
YXQgMTo0NyBQTSwgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21h
aWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT48YnI+CjwvZGl2PjxkaXYgY2xhc3M9ImltIj4m
Z3Q7ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56
QGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0OyB3cm90ZTo8YnI+CiZndDs8YnI+CiZndDsgoCCgIEhpIExl
b25hcmRvLDxicj4KJmd0Ozxicj4KJmd0OyCgIKAgT24gMDUvMzAvMjAxMSAwNDoxMSBQTSwgTGVv
bmFyZG8gTHVpeiBQYWRvdmFuaSBkYSBNYXRhIHdyb3RlOjxicj4KJmd0OyCgIKAgJmd0OyBoZWxs
byBkdWRlcywgd2hhdCBpIG5lZWQgdG8gZG8gdG8gY2hlY2sgaWYgdGhlIGltcGxlbWVudGVkIGRy
aXZlcnMgYXJlPGJyPgomZ3Q7IKAgoCAmZ3Q7IGVub3VnaCB0byBzdXBwb3J0IGEgbW9kZW0/IERv
IGkganVzdCBuZWVkIHRvIGFkZCB0aGUgcnVsZXMgZm9yPGJyPgomZ3Q7IKAgoCB1ZGV2PyBob3c8
YnI+CiZndDsgoCCgICZndDsgZG8gaSBkbyB0aGF0Pzxicj4KJmd0OyCgIKAgJmd0Ozxicj4KJmd0
OyCgIKAgJmd0OyBUaGUgaWQgb2YgdGhlIG1vZGVtIGlzIKAxMmQxOjFjMGIgaHVhd2VpIGUxNzM8
YnI+CiZndDsgoCCgICZndDs8YnI+CiZndDs8YnI+CiZndDsgoCCgIENoZWNrIHBsdWdpbnMvb2Zv
bm8ucnVsZXMgaW4gZ2l0LiCgSXQgbG9va3MgbGlrZSBhIHJ1bGUgaXMgbm90IHByZXNlbnQ8YnI+
CiZndDsgoCCgIGZvciB0aGlzIHBhcnRpY3VsYXIgZGV2aWNlIGlkLjxicj4KJmd0Ozxicj4KJmd0
OyCgIKAgWW91IHdpbGwgaGF2ZSB0byBkbyBzb21lIG1pbm9yIHBva2luZyBhcm91bmQgdG8gZmln
dXJlIG91dCB3aGF0IHR0eTxicj4KJmd0OyCgIKAgY29ycmVzcG9uZHMgdG8gd2hhdCBmdW5jdGlv
biAoZS5nLiBQY3VpLCBNb2RlbSwgc2VlIG90aGVyIEh1YXdlaSBydWxlczxicj4KJmd0OyCgIKAg
Zm9yIGV4YW1wbGVzKSwgYWRkIGEgbmV3IGVudHJ5IHRvIG9mb25vLnJ1bGVzIGFuZCB0cnkgdG8g
c2VlIGlmIGl0PGJyPgomZ3Q7IKAgoCB3b3Jrcy48YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDsg
T2ssIGkmIzM5O3ZlIGZvdW5kIGFub3RoZXIgcG9zc2libGUgc29sdXR0aW9uIHVzaW5nIHVzYl9t
b2Rlc3dpdGNoLCBidXQgaXQ8YnI+CiZndDsgZGlkbiYjMzk7dCB3b3JrIHlldDo8YnI+CiZndDsg
PGEgaHJlZj0iaHR0cDovL3d3dy5kcmFpc2Jlcmdob2YuZGUvdXNiX21vZGVzd2l0Y2gvYmIvdmll
d3RvcGljLnBocD90PTU1MiIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cuZHJhaXNiZXJnaG9m
LmRlL3VzYl9tb2Rlc3dpdGNoL2JiL3ZpZXd0b3BpYy5waHA/dD01NTI8L2E+PGJyPgomZ3Q7PGJy
PgomZ3Q7IERvIHlvdSB0aGluayB0aGF0IHRoZSB1c2JfbW9kZXN3aXRjaCBhcHByb2FjaCBpcyBi
ZXR0ZXIvd29yc2U/PGJyPgo8YnI+CjwvZGl2PlRoaXMgZGVwZW5kcyBhIGxpdHRsZSBiaXQgb24g
aG93IHlvdXIgbW9kZW0gaXMgYmVpbmcgcmVjb2duaXplZC4goElmIGl0PGJyPgppcyByZWNvZ25p
emVkIGFzIGEgc3RvcmFnZSBkZXZpY2UsIHRoZW4geWVzLCB1c2JfbW9kZXN3aXRjaCB3aWxsPGJy
Pgpwcm9iYWJseSBiZSByZXF1aXJlZC48YnI+Cjxicj4KSWYgaXQgaXMgYWxyZWFkeSByZWNvZ25p
emVkIGFzIGEgbW9kZW0gYW5kIHRoZSBydWxlcyBhcmUgbm90IHByZXNlbnQgaW48YnI+Cm9mb25v
LnJ1bGVzLCB0aGVuIHlvdSB3aWxsIG5lZWQgdG8gcGVyZm9ybSB0aGUgc3RlcHMgSSBtZW50aW9u
ZWQgaW4gbXk8YnI+CnByZXZpb3VzIG1haWwuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj5JIHRo
aW5rIGl0JiMzOTtzIGJlZWluZyByZWNvbml6ZSBhcyBhIHN0b3JhZ2UgZGV2aWNlOjxicj48YnI+
WzY5ODM0LjcyNTEzOF0gdXNiIDEtMTogbmV3IGhpZ2ggc3BlZWQgVVNCIGRldmljZSB1c2luZyBl
aGNpX2hjZCBhbmQgYWRkcmVzcyA4PGJyPls2OTgzNS4wNTk2NDNdIHVzYiAxLTE6IE5ldyBVU0Ig
ZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xMmQxLCBpZFByb2R1Y3Q9MWMwYjxicj4KWzY5ODM1LjA1
OTY1OV0gdXNiIDEtMTogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTIsIFByb2R1Y3Q9MSwg
U2VyaWFsTnVtYmVyPTA8YnI+WzY5ODM1LjA1OTY3Ml0gdXNiIDEtMTogUHJvZHVjdDogSFVBV0VJ
IE1vYmlsZTxicj5bNjk4MzUuMDU5NjgxXSB1c2IgMS0xOiBNYW51ZmFjdHVyZXI6IEhVQVdFSTxi
cj5bNjk4MzUuMDY1MzU2XSBzY3NpMTAgOiB1c2Itc3RvcmFnZSAxLTE6MS4wPGJyPgpbNjk4MzUu
MDY5NjU1XSBzY3NpMTEgOiB1c2Itc3RvcmFnZSAxLTE6MS4xPGJyPls2OTgzNy44OTk2NjNdIHNj
c2kgMTA6MDowOjA6IENELVJPTaCgoKCgoKCgoKCgIEhVQVdFSaCgIE1hc3MgU3RvcmFnZaCgoKAg
Mi4zMSBQUTogMCBBTlNJOiAyPGJyPls2OTgzNy44OTk3MzRdIHNjc2kgMTE6MDowOjA6IERpcmVj
dC1BY2Nlc3OgoKCgIEhVQVdFSaCgIFNEIFN0b3JhZ2WgoKCgoKAgMi4zMSBQUTogMCBBTlNJOiAy
PGJyPgpbNjk4MzcuOTExMzkxXSBzcjA6IHNjc2ktMSBkcml2ZTxicj5bNjk4MzcuOTEzMzI1XSBz
ciAxMDowOjA6MDogQXR0YWNoZWQgc2NzaSBDRC1ST00gc3IwPGJyPls2OTgzNy45MTQ0MDhdIHNy
IDEwOjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2cxIHR5cGUgNTxicj5bNjk4MzcuOTIz
OTYwXSBzZCAxMTowOjA6MDogQXR0YWNoZWQgc2NzaSBnZW5lcmljIHNnMiB0eXBlIDA8YnI+WzY5
ODM3LjkzMzE5Nl0gc2QgMTE6MDowOjA6IFtzZGJdIEF0dGFjaGVkIFNDU0kgcmVtb3ZhYmxlIGRp
c2s8YnI+Cjxicj48YnI+oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IGJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdi
KDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxlZnQ6IDFleDsiPgo8YnI+ClJlZ2FyZHMsPGJyPgo8
Zm9udCBjb2xvcj0iIzg4ODg4OCI+LURlbmlzPGJyPgo8L2ZvbnQ+PC9ibG9ja3F1b3RlPjwvZGl2
Pjxicj48YnIgY2xlYXI9ImFsbCI+PGJyPi0tIDxicj5MZW9uYXJkbyBMdWl6IFBhZG92YW5pIGRh
IE1hdGE8YnI+PGJyPkludGVybmF0aW9uYWwgU3lzdCBTL0E8YnI+TWV0YXN5cyBUZWNub2xvZ2lh
PGJyPlNvZnR3YXJlIEVuZ2luZWVyIE1ldGFzeXMgTWVlR28gVGVhbTxicj48YnI+PGEgaHJlZj0i
bWFpbHRvOmxlb25hcmRvbEBtZXRhc3lzLmNvbS5iciIgdGFyZ2V0PSJfYmxhbmsiPmxlb25hcmRv
bEBtZXRhc3lzLmNvbS5icjwvYT48YnI+Cis1NS0zMS0zNTAzLTkwNDA8YnI+PGJyPiZxdW90O01h
eSB0aGUgZm9yY2UgYmUgd2l0aCB5b3UsIGFsd2F5cyZxdW90Ozxicj4mcXVvdDtOZXJkIFByaWRl
Li4uIGV1IHRlbmhvLiBWb2NlIHRlbT8mcXVvdDs8YnI+Cg==

--===============0660236095656721926==--


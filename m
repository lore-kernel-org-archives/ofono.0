Content-Type: multipart/mixed; boundary="===============8172055448228352560=="
MIME-Version: 1.0
From: Leonardo Luiz Padovani da Mata <leonardol@syst.com.br>
Subject: Re: Add support to huawei e173
Date: Tue, 31 May 2011 14:45:20 -0300
Message-ID: <BANLkTi=po+QnDZeDJWvVCnCx2kUfbVJSbg@mail.gmail.com>
In-Reply-To: <4DE51B8B.6010504@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8172055448228352560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis, how are you?

On Tue, May 31, 2011 at 1:47 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Leonardo,
>
> On 05/30/2011 04:11 PM, Leonardo Luiz Padovani da Mata wrote:
> > hello dudes, what i need to do to check if the implemented drivers are
> > enough to support a modem? Do i just need to add the rules for udev? how
> > do i do that?
> >
> > The id of the modem is  12d1:1c0b huawei e173
> >
>
> Check plugins/ofono.rules in git.  It looks like a rule is not present
> for this particular device id.
>
> You will have to do some minor poking around to figure out what tty
> corresponds to what function (e.g. Pcui, Modem, see other Huawei rules
> for examples), add a new entry to ofono.rules and try to see if it works.
>
>
Ok, i've found another possible soluttion using usb_modeswitch, but it
didn't work yet:
http://www.draisberghof.de/usb_modeswitch/bb/viewtopic.php?t=3D552

Do you think that the usb_modeswitch approach is better/worse?


> Regards,
> -Denis
>

Thanks



-- =

Leonardo Luiz Padovani da Mata

International Syst S/A
Metasys Tecnologia
Software Engineer Metasys MeeGo Team

leonardol(a)metasys.com.br
+55-31-3503-9040

"May the force be with you, always"
"Nerd Pride... eu tenho. Voce tem?"

--===============8172055448228352560==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGVsbG8gRGVuaXMsIGhvdyBhcmUgeW91Pzxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUi
Pk9uIFR1ZSwgTWF5IDMxLCAyMDExIGF0IDE6NDcgUE0sIERlbmlzIEtlbnppb3IgPHNwYW4gZGly
PSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21h
aWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4OyI+CkhpIExlb25hcmRvLDxicj4KPGRpdiBjbGFzcz0iaW0iPjxi
cj4KT24gMDUvMzAvMjAxMSAwNDoxMSBQTSwgTGVvbmFyZG8gTHVpeiBQYWRvdmFuaSBkYSBNYXRh
IHdyb3RlOjxicj4KJmd0OyBoZWxsbyBkdWRlcywgd2hhdCBpIG5lZWQgdG8gZG8gdG8gY2hlY2sg
aWYgdGhlIGltcGxlbWVudGVkIGRyaXZlcnMgYXJlPGJyPgomZ3Q7IGVub3VnaCB0byBzdXBwb3J0
IGEgbW9kZW0/IERvIGkganVzdCBuZWVkIHRvIGFkZCB0aGUgcnVsZXMgZm9yIHVkZXY/IGhvdzxi
cj4KJmd0OyBkbyBpIGRvIHRoYXQ/PGJyPgomZ3Q7PGJyPgomZ3Q7IFRoZSBpZCBvZiB0aGUgbW9k
ZW0gaXMgoDEyZDE6MWMwYiBodWF3ZWkgZTE3Mzxicj4KJmd0Ozxicj4KPGJyPgo8L2Rpdj5DaGVj
ayBwbHVnaW5zL29mb25vLnJ1bGVzIGluIGdpdC4goEl0IGxvb2tzIGxpa2UgYSBydWxlIGlzIG5v
dCBwcmVzZW50PGJyPgpmb3IgdGhpcyBwYXJ0aWN1bGFyIGRldmljZSBpZC48YnI+Cjxicj4KWW91
IHdpbGwgaGF2ZSB0byBkbyBzb21lIG1pbm9yIHBva2luZyBhcm91bmQgdG8gZmlndXJlIG91dCB3
aGF0IHR0eTxicj4KY29ycmVzcG9uZHMgdG8gd2hhdCBmdW5jdGlvbiAoZS5nLiBQY3VpLCBNb2Rl
bSwgc2VlIG90aGVyIEh1YXdlaSBydWxlczxicj4KZm9yIGV4YW1wbGVzKSwgYWRkIGEgbmV3IGVu
dHJ5IHRvIG9mb25vLnJ1bGVzIGFuZCB0cnkgdG8gc2VlIGlmIGl0IHdvcmtzLjxicj4KPGJyPjwv
YmxvY2txdW90ZT48ZGl2Pjxicj5PaywgaSYjMzk7dmUgZm91bmQgYW5vdGhlciBwb3NzaWJsZSBz
b2x1dHRpb24gdXNpbmcgdXNiX21vZGVzd2l0Y2gsIGJ1dCBpdCBkaWRuJiMzOTt0IHdvcmsgeWV0
Ojxicj48YSBocmVmPSJodHRwOi8vd3d3LmRyYWlzYmVyZ2hvZi5kZS91c2JfbW9kZXN3aXRjaC9i
Yi92aWV3dG9waWMucGhwP3Q9NTUyIj5odHRwOi8vd3d3LmRyYWlzYmVyZ2hvZi5kZS91c2JfbW9k
ZXN3aXRjaC9iYi92aWV3dG9waWMucGhwP3Q9NTUyPC9hPjxicj4KPGJyPkRvIHlvdSB0aGluayB0
aGF0IHRoZSB1c2JfbW9kZXN3aXRjaCBhcHByb2FjaCBpcyBiZXR0ZXIvd29yc2U/PGJyPqA8YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQg
MHB0IDBwdCAwLjhleDsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7
IHBhZGRpbmctbGVmdDogMWV4OyI+ClJlZ2FyZHMsPGJyPgo8Zm9udCBjb2xvcj0iIzg4ODg4OCI+
LURlbmlzPGJyPgo8L2ZvbnQ+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj5UaGFua3M8YnI+PGJyPjxi
ciBjbGVhcj0iYWxsIj48YnI+LS0gPGJyPkxlb25hcmRvIEx1aXogUGFkb3ZhbmkgZGEgTWF0YTxi
cj48YnI+SW50ZXJuYXRpb25hbCBTeXN0IFMvQTxicj5NZXRhc3lzIFRlY25vbG9naWE8YnI+U29m
dHdhcmUgRW5naW5lZXIgTWV0YXN5cyBNZWVHbyBUZWFtPGJyPjxicj48YSBocmVmPSJtYWlsdG86
bGVvbmFyZG9sQG1ldGFzeXMuY29tLmJyIiB0YXJnZXQ9Il9ibGFuayI+bGVvbmFyZG9sQG1ldGFz
eXMuY29tLmJyPC9hPjxicj4KKzU1LTMxLTM1MDMtOTA0MDxicj48YnI+JnF1b3Q7TWF5IHRoZSBm
b3JjZSBiZSB3aXRoIHlvdSwgYWx3YXlzJnF1b3Q7PGJyPiZxdW90O05lcmQgUHJpZGUuLi4gZXUg
dGVuaG8uIFZvY2UgdGVtPyZxdW90Ozxicj4K

--===============8172055448228352560==--


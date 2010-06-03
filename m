Content-Type: multipart/mixed; boundary="===============7499156844268115278=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: Re: E63 as generic At Modem?
Date: Thu, 03 Jun 2010 12:41:02 +0300
Message-ID: <AANLkTinjJ5-WP_hhMQR1XXVssW0W6LMCap8y1MB43U-D@mail.gmail.com>
In-Reply-To: <AANLkTimnluwt-HJVMtup0VMRUyYRcpxoPgsV7QIKLgn9@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7499156844268115278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I managed to make E63 work as a generic modem.

This can be done by disabling isi modem in configure

*./configure --disable-isimodem*

I could make voice calls, but sms is still not possible may be because
AT+CRSM command is failing from the E63.

But why is the isimodem not configurable through modem.conf file? To disable
isimodem, we need to be build ofono.

Regards
Arun




On Tue, Jun 1, 2010 at 9:52 AM, Arun Ravindran <arunlee@gmail.com> wrote:

> Hi,
>
>
> On Mon, May 31, 2010 at 4:54 PM, Aki Niemi <aki@protocolpolice.com> wro=
te:
>
>> Hi Arun,
>>
>> 2010/5/31 Arun Ravindran <arunlee@gmail.com>:
>> > Hello All,
>> >
>> > I am running the latest ofono in my ubuntu 9.10, under virtual box.
>> >
>> > I have connected my E63 through USB and I can see that the isimodem up
>> and
>> > working.
>>
>> > Good, are you able to make calls with it?
>>
>> Yes i am able to make calls.
>
>
>> > I tried to use E63 as a generic modem by adding the following to the
>> > modem.conf
>>
>> > Don't do that. The AT command interface on most Nokia modems is not
>> > very good. Just use the isimodem driver. We don't expect everything to
>> > work flawlessly over USB, but if you experience problems, just 'export
>> > OFONO_ISI_DEBUG=3Dall' and post the debug logs, and we can see if the
>> > problem can be fixed.
>>
>> > However, we are currently using N900 as a reference phone; via USB
>> > while developing and on-device obviously for MeeGo purposes. Other
>> > models may or may not work.
>>
>> > Cheers,
>> > Aki
>> __
>
>
> I shall post the debug logs.
>
> Regards
> Arun
>
>
>> _____________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> http://lists.ofono.org/listinfo/ofono
>>
>
>

--===============7499156844268115278==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgYWxsLDxicj48YnI+SSBtYW5hZ2VkIHRvIG1ha2UgRTYzIHdvcmsgYXMgYSBnZW5lcmljIG1v
ZGVtLiA8YnI+PGJyPlRoaXMgY2FuIGJlIGRvbmUgYnkgZGlzYWJsaW5nIGlzaSBtb2RlbSBpbiBj
b25maWd1cmU8YnI+PGJyPjxiPi4vY29uZmlndXJlIC0tZGlzYWJsZS1pc2ltb2RlbTwvYj48YnI+
PGJyPkkgY291bGQgbWFrZSB2b2ljZSBjYWxscywgYnV0IHNtcyBpcyBzdGlsbCBub3QgcG9zc2li
bGUgbWF5IGJlIGJlY2F1c2UgQVQrQ1JTTSBjb21tYW5kIGlzIGZhaWxpbmcgZnJvbSB0aGUgRTYz
Ljxicj4KPGJyPkJ1dCB3aHkgaXMgdGhlIGlzaW1vZGVtIG5vdCBjb25maWd1cmFibGUgdGhyb3Vn
aCBtb2RlbS5jb25mIGZpbGU/IFRvIGRpc2FibGUgaXNpbW9kZW0sIHdlIG5lZWQgdG8gYmUgYnVp
bGQgb2Zvbm8uPGJyPjxicj5SZWdhcmRzPGJyPkFydW48YnI+PGJyPjxicj48YnI+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUdWUsIEp1biAxLCAyMDEwIGF0IDk6NTIgQU0sIEFydW4g
UmF2aW5kcmFuIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmFydW5sZWVAZ21h
aWwuY29tIj5hcnVubGVlQGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+CjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQg
cmdiKDIwNCwgMjA0LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxl
ZnQ6IDFleDsiPkhpLDxicj48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGNs
YXNzPSJpbSI+T24gTW9uLCBNYXkgMzEsIDIwMTAgYXQgNDo1NCBQTSwgQWtpIE5pZW1pIDxzcGFu
IGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmFraUBwcm90b2NvbHBvbGljZS5jb20iIHRh
cmdldD0iX2JsYW5rIj5ha2lAcHJvdG9jb2xwb2xpY2UuY29tPC9hPiZndDs8L3NwYW4+IHdyb3Rl
Ojxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6
IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7
IHBhZGRpbmctbGVmdDogMWV4OyI+CkhpIEFydW4sPGJyPgo8YnI+CjIwMTAvNS8zMSBBcnVuIFJh
dmluZHJhbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFydW5sZWVAZ21haWwuY29tIiB0YXJnZXQ9Il9i
bGFuayI+YXJ1bmxlZUBnbWFpbC5jb208L2E+Jmd0Ozo8YnI+CjxkaXY+Jmd0OyBIZWxsbyBBbGws
PGJyPgomZ3Q7PGJyPgomZ3Q7IEkgYW0gcnVubmluZyB0aGUgbGF0ZXN0IG9mb25vIGluIG15IHVi
dW50dSA5LjEwLCB1bmRlciB2aXJ0dWFsIGJveC48YnI+CiZndDs8YnI+CiZndDsgSSBoYXZlIGNv
bm5lY3RlZCBteSBFNjMgdGhyb3VnaCBVU0IgYW5kIEkgY2FuIHNlZSB0aGF0IHRoZSBpc2ltb2Rl
bSB1cCBhbmQ8YnI+CiZndDsgd29ya2luZy48YnI+Cjxicj4KPC9kaXY+Jmd0OyBHb29kLCBhcmUg
eW91IGFibGUgdG8gbWFrZSBjYWxscyB3aXRoIGl0Pzxicj4KPGRpdj48YnI+PC9kaXY+PC9ibG9j
a3F1b3RlPjwvZGl2PjxkaXY+WWVzIGkgYW0gYWJsZSB0byBtYWtlIGNhbGxzLjxicj6gPGJyPjwv
ZGl2PjxkaXYgY2xhc3M9ImltIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2luOiAwcHQg
MHB0IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KPGRpdj4KCiZndDsgSSB0cmllZCB0
byB1c2UgRTYzIGFzIGEgZ2VuZXJpYyBtb2RlbSBieSBhZGRpbmcgdGhlIGZvbGxvd2luZyB0byB0
aGU8YnI+CiZndDsgbW9kZW0uY29uZjxicj4KPGJyPgo8L2Rpdj4mZ3Q7IERvbiYjMzk7dCBkbyB0
aGF0LiBUaGUgQVQgY29tbWFuZCBpbnRlcmZhY2Ugb24gbW9zdCBOb2tpYSBtb2RlbXMgaXMgbm90
PGJyPgomZ3Q7IHZlcnkgZ29vZC4gSnVzdCB1c2UgdGhlIGlzaW1vZGVtIGRyaXZlci4gV2UgZG9u
JiMzOTt0IGV4cGVjdCBldmVyeXRoaW5nIHRvPGJyPgomZ3Q7IHdvcmsgZmxhd2xlc3NseSBvdmVy
IFVTQiwgYnV0IGlmIHlvdSBleHBlcmllbmNlIHByb2JsZW1zLCBqdXN0ICYjMzk7ZXhwb3J0PGJy
PgomZ3Q7IE9GT05PX0lTSV9ERUJVRz1hbGwmIzM5OyBhbmQgcG9zdCB0aGUgZGVidWcgbG9ncywg
YW5kIHdlIGNhbiBzZWUgaWYgdGhlPGJyPgomZ3Q7IHByb2JsZW0gY2FuIGJlIGZpeGVkLjxicj4K
PGJyPgomZ3Q7IEhvd2V2ZXIsIHdlIGFyZSBjdXJyZW50bHkgdXNpbmcgTjkwMCBhcyBhIHJlZmVy
ZW5jZSBwaG9uZTsgdmlhIFVTQjxicj4KJmd0OyB3aGlsZSBkZXZlbG9waW5nIGFuZCBvbi1kZXZp
Y2Ugb2J2aW91c2x5IGZvciBNZWVHbyBwdXJwb3Nlcy4gT3RoZXI8YnI+Jmd0OyBtb2RlbHMgbWF5
IG9yIG1heSBub3Qgd29yay48YnI+Cjxicj4KJmd0OyBDaGVlcnMsPGJyPgomZ3Q7IEFraTxicj4K
X188L2Jsb2NrcXVvdGU+PC9kaXY+PGRpdj48YnI+SSBzaGFsbCBwb3N0IHRoZSBkZWJ1ZyBsb2dz
Ljxicj48YnI+UmVnYXJkczxicj48Zm9udCBjb2xvcj0iIzg4ODg4OCI+QXJ1bjxicj6gPGJyPjwv
Zm9udD48L2Rpdj48ZGl2IGNsYXNzPSJpbSI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdp
bjogMHB0IDBwdCAwcHQgMC44ZXg7IHBhZGRpbmctbGVmdDogMWV4OyI+Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4KCm9mb25vIG1haWxpbmcgbGlzdDxi
cj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25v
QG9mb25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGlu
Zm8vb2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZv
L29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pjxicj4KPC9ibG9ja3F1b3Rl
PjwvZGl2Pjxicj4K

--===============7499156844268115278==--


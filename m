Content-Type: multipart/mixed; boundary="===============7132633456325213650=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: Re: E63 as generic At Modem?
Date: Tue, 01 Jun 2010 09:52:56 +0300
Message-ID: <AANLkTimnluwt-HJVMtup0VMRUyYRcpxoPgsV7QIKLgn9@mail.gmail.com>
In-Reply-To: <AANLkTilIKHwLy6hCo9l1-szjaageHlMD_MJ-lSxbLEiD@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7132633456325213650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,


On Mon, May 31, 2010 at 4:54 PM, Aki Niemi <aki@protocolpolice.com> wrote:

> Hi Arun,
>
> 2010/5/31 Arun Ravindran <arunlee@gmail.com>:
> > Hello All,
> >
> > I am running the latest ofono in my ubuntu 9.10, under virtual box.
> >
> > I have connected my E63 through USB and I can see that the isimodem up
> and
> > working.
>
> > Good, are you able to make calls with it?
>
> Yes i am able to make calls.


> > I tried to use E63 as a generic modem by adding the following to the
> > modem.conf
>
> > Don't do that. The AT command interface on most Nokia modems is not
> > very good. Just use the isimodem driver. We don't expect everything to
> > work flawlessly over USB, but if you experience problems, just 'export
> > OFONO_ISI_DEBUG=3Dall' and post the debug logs, and we can see if the
> > problem can be fixed.
>
> > However, we are currently using N900 as a reference phone; via USB
> > while developing and on-device obviously for MeeGo purposes. Other
> > models may or may not work.
>
> > Cheers,
> > Aki
> __


I shall post the debug logs.

Regards
Arun


> _____________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============7132633456325213650==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgTWF5IDMxLCAy
MDEwIGF0IDQ6NTQgUE0sIEFraSBOaWVtaSA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1h
aWx0bzpha2lAcHJvdG9jb2xwb2xpY2UuY29tIj5ha2lAcHJvdG9jb2xwb2xpY2UuY29tPC9hPiZn
dDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2luOiAwcHQg
MHB0IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KSGkgQXJ1biw8YnI+Cjxicj4KMjAx
MC81LzMxIEFydW4gUmF2aW5kcmFuICZsdDs8YSBocmVmPSJtYWlsdG86YXJ1bmxlZUBnbWFpbC5j
b20iPmFydW5sZWVAZ21haWwuY29tPC9hPiZndDs6PGJyPgo8ZGl2IGNsYXNzPSJpbSI+Jmd0OyBI
ZWxsbyBBbGwsPGJyPgomZ3Q7PGJyPgomZ3Q7IEkgYW0gcnVubmluZyB0aGUgbGF0ZXN0IG9mb25v
IGluIG15IHVidW50dSA5LjEwLCB1bmRlciB2aXJ0dWFsIGJveC48YnI+CiZndDs8YnI+CiZndDsg
SSBoYXZlIGNvbm5lY3RlZCBteSBFNjMgdGhyb3VnaCBVU0IgYW5kIEkgY2FuIHNlZSB0aGF0IHRo
ZSBpc2ltb2RlbSB1cCBhbmQ8YnI+CiZndDsgd29ya2luZy48YnI+Cjxicj4KPC9kaXY+Jmd0OyBH
b29kLCBhcmUgeW91IGFibGUgdG8gbWFrZSBjYWxscyB3aXRoIGl0Pzxicj4KPGRpdiBjbGFzcz0i
aW0iPjxicj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj5ZZXMgaSBhbSBhYmxlIHRvIG1ha2UgY2Fs
bHMuPGJyPqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
Ym9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdpbjogMHB0IDBw
dCAwcHQgMC44ZXg7IHBhZGRpbmctbGVmdDogMWV4OyI+PGRpdiBjbGFzcz0iaW0iPgoKJmd0OyBJ
IHRyaWVkIHRvIHVzZSBFNjMgYXMgYSBnZW5lcmljIG1vZGVtIGJ5IGFkZGluZyB0aGUgZm9sbG93
aW5nIHRvIHRoZTxicj4KJmd0OyBtb2RlbS5jb25mPGJyPgo8YnI+CjwvZGl2PiZndDsgRG9uJiMz
OTt0IGRvIHRoYXQuIFRoZSBBVCBjb21tYW5kIGludGVyZmFjZSBvbiBtb3N0IE5va2lhIG1vZGVt
cyBpcyBub3Q8YnI+CiZndDsgdmVyeSBnb29kLiBKdXN0IHVzZSB0aGUgaXNpbW9kZW0gZHJpdmVy
LiBXZSBkb24mIzM5O3QgZXhwZWN0IGV2ZXJ5dGhpbmcgdG88YnI+CiZndDsgd29yayBmbGF3bGVz
c2x5IG92ZXIgVVNCLCBidXQgaWYgeW91IGV4cGVyaWVuY2UgcHJvYmxlbXMsIGp1c3QgJiMzOTtl
eHBvcnQ8YnI+CiZndDsgT0ZPTk9fSVNJX0RFQlVHPWFsbCYjMzk7IGFuZCBwb3N0IHRoZSBkZWJ1
ZyBsb2dzLCBhbmQgd2UgY2FuIHNlZSBpZiB0aGU8YnI+CiZndDsgcHJvYmxlbSBjYW4gYmUgZml4
ZWQuPGJyPgo8YnI+CiZndDsgSG93ZXZlciwgd2UgYXJlIGN1cnJlbnRseSB1c2luZyBOOTAwIGFz
IGEgcmVmZXJlbmNlIHBob25lOyB2aWEgVVNCPGJyPgomZ3Q7IHdoaWxlIGRldmVsb3BpbmcgYW5k
IG9uLWRldmljZSBvYnZpb3VzbHkgZm9yIE1lZUdvIHB1cnBvc2VzLiBPdGhlcjxicj4mZ3Q7IG1v
ZGVscyBtYXkgb3IgbWF5IG5vdCB3b3JrLjxicj4KPGJyPgomZ3Q7IENoZWVycyw8YnI+CiZndDsg
QWtpPGJyPgpfXzwvYmxvY2txdW90ZT48ZGl2Pjxicj5JIHNoYWxsIHBvc3QgdGhlIGRlYnVnIGxv
Z3MuPGJyPjxicj5SZWdhcmRzPGJyPkFydW48YnI+oDxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIw
NCwgMjA0KTsgbWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij5f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+CgpvZm9ubyBt
YWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9m
b25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8v
b2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29m
b25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============7132633456325213650==--


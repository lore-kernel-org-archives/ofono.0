Content-Type: multipart/mixed; boundary="===============4309423934862174511=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Wed, 20 Jan 2016 19:20:36 +0200
Message-ID: <CADnUhn0dGRuwjF59+SWHbW-zm5ttb+7BZp7jNWrgC+4GfOE1Qg@mail.gmail.com>
In-Reply-To: <87oacgff3b.fsf@nemi.mork.no>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4309423934862174511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B8rn!

2016-01-20 17:25 GMT+02:00 Bj=C3=B8rn Mork <bjorn@mork.no>:

> > Bj=C3=B8rn, is there something missing in initialization?
>
> I don't think so. It all looks OK to me.  It's just the AT^DHCP?
> response which is a bit unexpected.  IIUC, the modem LEDs indicate a
> connection?  What about "AT^NDISDUP?" ?
>
Initial LED led operation was "blinking green". It changed to "slow
blinking blue"  after online-modem command. There was no change after
activate-context (that produced "AT^NDISUP..."). I did not try manual
"AT^NDISDUP?" command, though. I'll try it tomorrow.

>
> Did you try a DHCP client?  Maybe this firmware doesn't implement the
> AT^DHCP command but has a DHCP server?
>
I did not try. I'll try it tomorrow.

>
> > Is there something wrong with firmware?
>
> That would depend on the definition of "right" :)
>
> Huawei can do pretty much what they want since the functions are vendor
> specific.  They are probably happy as long as the firmware matches the
> Windows driver+application.  But usually they are pretty good at making
> consistent interfaces across different firmware code bases, so the
> unusual AT^DHCP? response is unexpected and might be considered a bug.
>
> > Is there any chance switching modem to HiLink mode (=3D using cdc_ether)
> like
> > the older versions did?
> > Would it be possible by downgrading firmware or by usb_modeswitch?
>
> I am guessing the answers are "yes" to all those questions.  But I don't
> know how...
>
I guess, it's not a good idea, but I could try removing huawei_cdc_ncm
set-up from udevng.c. Anyhow, just inserting udev rule for using cdc_acm
with this particular e3131 did not work.

>
> > If all the answers are no, I suppose I need to switch to for instance to
> > ModemManager or ppp without any managers.
>
> If MM can connect, then oFono should be able to as well.  I see that you
> didn't find any AT^NDISDUP command in the MM log.  Did it by any chance
> use PPP?  Or was there something else going on?

I don't think there bacome any PPP interfaces in ifconfig listing if I
recall it correctly.

Thanks,
Matti

--===============4309423934862174511==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPkhpIEJqw7hybiE8YnI+PGJy
PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
MjAxNi0wMS0yMCAxNzoyNSBHTVQrMDI6MDAgQmrDuHJuIE1vcmsgPHNwYW4gZGlyPSJsdHIiPiZs
dDs8YSBocmVmPSJtYWlsdG86Ympvcm5AbW9yay5ubyIgdGFyZ2V0PSJfYmxhbmsiPmJqb3JuQG1v
cmsubm88L2E+Jmd0Ozwvc3Bhbj46PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdi
KDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48c3BhbiBjbGFzcz0iIj4mZ3Q7IEJqw7hy
biwgaXMgdGhlcmUgc29tZXRoaW5nIG1pc3NpbmcgaW4gaW5pdGlhbGl6YXRpb24/PGJyPgo8YnI+
Cjwvc3Bhbj5JIGRvbiYjMzk7dCB0aGluayBzby4gSXQgYWxsIGxvb2tzIE9LIHRvIG1lLsKgIEl0
JiMzOTtzIGp1c3QgdGhlIEFUXkRIQ1A/PGJyPgpyZXNwb25zZSB3aGljaCBpcyBhIGJpdCB1bmV4
cGVjdGVkLsKgIElJVUMsIHRoZSBtb2RlbSBMRURzIGluZGljYXRlIGE8YnI+CmNvbm5lY3Rpb24/
wqAgV2hhdCBhYm91dCAmcXVvdDtBVF5ORElTRFVQPyZxdW90OyA/PGJyPjwvYmxvY2txdW90ZT48
ZGl2PkluaXRpYWwgTEVEIGxlZCBvcGVyYXRpb24gd2FzICZxdW90O2JsaW5raW5nIGdyZWVuJnF1
b3Q7LiBJdCBjaGFuZ2VkIHRvICZxdW90O3Nsb3cgYmxpbmtpbmcgYmx1ZSZxdW90O8KgIGFmdGVy
IG9ubGluZS1tb2RlbSBjb21tYW5kLiBUaGVyZSB3YXMgbm8gY2hhbmdlIGFmdGVyIGFjdGl2YXRl
LWNvbnRleHQgKHRoYXQgcHJvZHVjZWQgJnF1b3Q7QVReTkRJU1VQLi4uJnF1b3Q7KS4gSSBkaWQg
bm90IHRyeSBtYW51YWwgJnF1b3Q7QVReTkRJU0RVUD8mcXVvdDsgY29tbWFuZCwgdGhvdWdoLiBJ
JiMzOTtsbCB0cnkgaXQgdG9tb3Jyb3cuIDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29s
aWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgpEaWQgeW91IHRyeSBh
IERIQ1AgY2xpZW50P8KgIE1heWJlIHRoaXMgZmlybXdhcmUgZG9lc24mIzM5O3QgaW1wbGVtZW50
IHRoZTxicj4KQVReREhDUCBjb21tYW5kIGJ1dCBoYXMgYSBESENQIHNlcnZlcj88YnI+PC9ibG9j
a3F1b3RlPjxkaXY+SSBkaWQgbm90IHRyeS4gSSYjMzk7bGwgdHJ5IGl0IHRvbW9ycm93LiA8YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPgo8c3BhbiBjbGFzcz0iIj48YnI+CiZndDsgSXMgdGhlcmUgc29tZXRoaW5n
IHdyb25nIHdpdGggZmlybXdhcmU/PGJyPgo8YnI+Cjwvc3Bhbj5UaGF0IHdvdWxkIGRlcGVuZCBv
biB0aGUgZGVmaW5pdGlvbiBvZiAmcXVvdDtyaWdodCZxdW90OyA6KTxicj4KPGJyPgpIdWF3ZWkg
Y2FuIGRvIHByZXR0eSBtdWNoIHdoYXQgdGhleSB3YW50IHNpbmNlIHRoZSBmdW5jdGlvbnMgYXJl
IHZlbmRvcjxicj4Kc3BlY2lmaWMuwqAgVGhleSBhcmUgcHJvYmFibHkgaGFwcHkgYXMgbG9uZyBh
cyB0aGUgZmlybXdhcmUgbWF0Y2hlcyB0aGU8YnI+CldpbmRvd3MgZHJpdmVyK2FwcGxpY2F0aW9u
LsKgIEJ1dCB1c3VhbGx5IHRoZXkgYXJlIHByZXR0eSBnb29kIGF0IG1ha2luZzxicj4KY29uc2lz
dGVudCBpbnRlcmZhY2VzIGFjcm9zcyBkaWZmZXJlbnQgZmlybXdhcmUgY29kZSBiYXNlcywgc28g
dGhlPGJyPgp1bnVzdWFsIEFUXkRIQ1A/IHJlc3BvbnNlIGlzIHVuZXhwZWN0ZWQgYW5kIG1pZ2h0
IGJlIGNvbnNpZGVyZWQgYSBidWcuPGJyPgo8c3BhbiBjbGFzcz0iIj48YnI+CiZndDsgSXMgdGhl
cmUgYW55IGNoYW5jZSBzd2l0Y2hpbmcgbW9kZW0gdG8gSGlMaW5rIG1vZGUgKD0gdXNpbmcgY2Rj
X2V0aGVyKSBsaWtlPGJyPgomZ3Q7IHRoZSBvbGRlciB2ZXJzaW9ucyBkaWQ/PGJyPgomZ3Q7IFdv
dWxkIGl0IGJlIHBvc3NpYmxlIGJ5IGRvd25ncmFkaW5nIGZpcm13YXJlIG9yIGJ5IHVzYl9tb2Rl
c3dpdGNoPzxicj4KPGJyPgo8L3NwYW4+SSBhbSBndWVzc2luZyB0aGUgYW5zd2VycyBhcmUgJnF1
b3Q7eWVzJnF1b3Q7IHRvIGFsbCB0aG9zZSBxdWVzdGlvbnMuwqAgQnV0IEkgZG9uJiMzOTt0PGJy
Pgprbm93IGhvdy4uLjxicj48L2Jsb2NrcXVvdGU+PGRpdj5JIGd1ZXNzLCBpdCYjMzk7cyBub3Qg
YSBnb29kIGlkZWEsIGJ1dCBJIGNvdWxkIHRyeSByZW1vdmluZyBodWF3ZWlfY2RjX25jbSBzZXQt
dXAgZnJvbSB1ZGV2bmcuYy4gQW55aG93LCBqdXN0IGluc2VydGluZyB1ZGV2IHJ1bGUgZm9yIHVz
aW5nIGNkY19hY20gd2l0aCB0aGlzIHBhcnRpY3VsYXIgZTMxMzEgZGlkIG5vdCB3b3JrLsKgIDxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFk
ZGluZy1sZWZ0OjFleCI+CjxzcGFuIGNsYXNzPSIiPjxicj4KJmd0OyBJZiBhbGwgdGhlIGFuc3dl
cnMgYXJlIG5vLCBJIHN1cHBvc2UgSSBuZWVkIHRvIHN3aXRjaCB0byBmb3IgaW5zdGFuY2UgdG88
YnI+CiZndDsgTW9kZW1NYW5hZ2VyIG9yIHBwcCB3aXRob3V0IGFueSBtYW5hZ2Vycy48YnI+Cjxi
cj4KPC9zcGFuPklmIE1NIGNhbiBjb25uZWN0LCB0aGVuIG9Gb25vIHNob3VsZCBiZSBhYmxlIHRv
IGFzIHdlbGwuwqAgSSBzZWUgdGhhdCB5b3U8YnI+CmRpZG4mIzM5O3QgZmluZCBhbnkgQVReTkRJ
U0RVUCBjb21tYW5kIGluIHRoZSBNTSBsb2cuwqAgRGlkIGl0IGJ5IGFueSBjaGFuY2U8YnI+CnVz
ZSBQUFA/wqAgT3Igd2FzIHRoZXJlIHNvbWV0aGluZyBlbHNlIGdvaW5nIG9uPzwvYmxvY2txdW90
ZT48ZGl2PkkgZG9uJiMzOTt0IHRoaW5rIHRoZXJlIGJhY29tZSBhbnkgUFBQIGludGVyZmFjZXMg
aW4gaWZjb25maWcgbGlzdGluZyBpZiBJIHJlY2FsbCBpdCBjb3JyZWN0bHkuPGJyPjxicj48L2Rp
dj48ZGl2PlRoYW5rcyw8YnI+PC9kaXY+PGRpdj5NYXR0aSA8YnI+PC9kaXY+PC9kaXY+PGJyPjxi
cj48L2Rpdj48L2Rpdj4K

--===============4309423934862174511==--


Content-Type: multipart/mixed; boundary="===============0562302997863160549=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jer=C3=B4nimo?= Lopes <lopesjeronimo@gmail.com>
Subject: Re: Particular APN and Ofono+Connman+BBB+Buildroot
Date: Fri, 28 Mar 2014 14:20:37 -0300
Message-ID: <CAM5ihG98aTffbTnX2OVo7kA2nDSFkJqJgjhQK9MRZ4hfLkzhvg@mail.gmail.com>
In-Reply-To: <53358AAD.5030302@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0562302997863160549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again Denis


2014-03-28 11:43 GMT-03:00 Denis Kenzior <denkenz@gmail.com>:

> Hi Jer=C3=B4nimo,
>
> > Ok, if I write my own how can I include it to my application? Do I need
> > to include this source file in ofono compilation or is there another wa=
y?
> >
>
> The easiest is to include it into oFono source.  We do support external
> plugins but I can't point you to an example off the top of my head.
> There were a couple of external plugins in the past.  See src/plugin.c
> and Makefile* to see how to do this.
>

Ok, I'll try the easiest first. But even to do that I'm a little lost, can
I just add the "foo.c" file at "plugins" folder and compile? Do I need to
add it to the "Makefile.am"?

Is there a easy way to test it with Eclipse? By test, I mean configure
Eclipse to cross-compile it, launch and debug at the target, this case the
Beaglebone Black board.


> > Another question, make both work at the same time? I mean, make ofono
> > look first at 'my own provider', if doesn't have a specific APN, look at
> > the Mobile Broadband Provider.
>
> This can be done by setting the plugin priority appropriately. Plugins
> with higher priorities are queried first.
>
> > That's nice, but I need Python to achieve that. I would like to keep the
> > system (an embedded one) as simple as possible, and for now I don't have
> > Python, I don't think it's a good idea to include it just for that.
> >
> > Can I do that with C?
>
> Sure.  Python just gives you an example of what D-Bus properties to set.
>
> >
> > If so, what is the difference between first method and this one?
>
> No difference in the end.  For an embedded system which has no user
> input, the provisioning approach will likely be easier.
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============0562302997863160549==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OmNvdXJpZXIgbmV3LG1vbm9zcGFjZSI+SGkgYWdhaW4gRGVuaXM8L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9leHRyYSI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxNC0wMy0y
OCAxMTo0MyBHTVQtMDM6MDAgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhy
ZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21h
aWwuY29tPC9hPiZndDs8L3NwYW4+Ojxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+SGkgSmVy9G5pbW8sPGJyPgo8ZGl2IGNsYXNzPSIiPjxicj4KJmd0OyBP
aywgaWYgSSB3cml0ZSBteSBvd24gaG93IGNhbiBJIGluY2x1ZGUgaXQgdG8gbXkgYXBwbGljYXRp
b24/IERvIEkgbmVlZDxicj4KJmd0OyB0byBpbmNsdWRlIHRoaXMgc291cmNlIGZpbGUgaW4gb2Zv
bm8gY29tcGlsYXRpb24gb3IgaXMgdGhlcmUgYW5vdGhlciB3YXk/PGJyPgomZ3Q7PGJyPgo8YnI+
CjwvZGl2PlRoZSBlYXNpZXN0IGlzIHRvIGluY2x1ZGUgaXQgaW50byBvRm9ubyBzb3VyY2UuIKBX
ZSBkbyBzdXBwb3J0IGV4dGVybmFsPGJyPgpwbHVnaW5zIGJ1dCBJIGNhbiYjMzk7dCBwb2ludCB5
b3UgdG8gYW4gZXhhbXBsZSBvZmYgdGhlIHRvcCBvZiBteSBoZWFkLjxicj4KVGhlcmUgd2VyZSBh
IGNvdXBsZSBvZiBleHRlcm5hbCBwbHVnaW5zIGluIHRoZSBwYXN0LiCgU2VlIHNyYy9wbHVnaW4u
Yzxicj4KYW5kIE1ha2VmaWxlKiB0byBzZWUgaG93IHRvIGRvIHRoaXMuPGJyPjwvYmxvY2txdW90
ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJm
b250LWZhbWlseTomIzM5O2NvdXJpZXIgbmV3JiMzOTssbW9ub3NwYWNlIj5PaywgSSYjMzk7bGwg
dHJ5IHRoZSBlYXNpZXN0IGZpcnN0LiBCdXQgZXZlbiB0byBkbyB0aGF0IEkmIzM5O20gYSBsaXR0
bGUgbG9zdCwgY2FuIEkganVzdCBhZGQgdGhlICZxdW90O2Zvby5jJnF1b3Q7IGZpbGUgYXQgJnF1
b3Q7cGx1Z2lucyZxdW90OyBmb2xkZXIgYW5kIGNvbXBpbGU/IERvIEkgbmVlZCB0byBhZGQgaXQg
dG8gdGhlICZxdW90O01ha2VmaWxlLmFtJnF1b3Q7PzwvZGl2Pgo8L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6JiMzOTtjb3VyaWVyIG5ldyYjMzk7LG1v
bm9zcGFjZSI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250
LWZhbWlseTomIzM5O2NvdXJpZXIgbmV3JiMzOTssbW9ub3NwYWNlIj5JcyB0aGVyZSBhIGVhc3kg
d2F5IHRvIHRlc3QgaXQgd2l0aCBFY2xpcHNlPyBCeSB0ZXN0LCBJIG1lYW4gY29uZmlndXJlIEVj
bGlwc2UgdG8gY3Jvc3MtY29tcGlsZSBpdCwgbGF1bmNoIGFuZCBkZWJ1ZyBhdCB0aGUgdGFyZ2V0
LCB0aGlzIGNhc2UgdGhlIEJlYWdsZWJvbmUgQmxhY2sgYm9hcmQuPC9kaXY+CjxkaXY+PGJyPjwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAu
OGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgo8ZGl2IGNs
YXNzPSIiPjxicj4KJmd0OyBBbm90aGVyIHF1ZXN0aW9uLCBtYWtlIGJvdGggd29yayBhdCB0aGUg
c2FtZSB0aW1lPyBJIG1lYW4sIG1ha2Ugb2Zvbm88YnI+CiZndDsgbG9vayBmaXJzdCBhdCAmIzM5
O215IG93biBwcm92aWRlciYjMzk7LCBpZiBkb2VzbiYjMzk7dCBoYXZlIGEgc3BlY2lmaWMgQVBO
LCBsb29rIGF0PGJyPgomZ3Q7IHRoZSBNb2JpbGUgQnJvYWRiYW5kIFByb3ZpZGVyLjxicj4KPGJy
Pgo8L2Rpdj5UaGlzIGNhbiBiZSBkb25lIGJ5IHNldHRpbmcgdGhlIHBsdWdpbiBwcmlvcml0eSBh
cHByb3ByaWF0ZWx5LiBQbHVnaW5zPGJyPgp3aXRoIGhpZ2hlciBwcmlvcml0aWVzIGFyZSBxdWVy
aWVkIGZpcnN0Ljxicj4KPGRpdiBjbGFzcz0iIj48YnI+CiZndDsgVGhhdCYjMzk7cyBuaWNlLCBi
dXQgSSBuZWVkIFB5dGhvbiB0byBhY2hpZXZlIHRoYXQuIEkgd291bGQgbGlrZSB0byBrZWVwIHRo
ZTxicj4KJmd0OyBzeXN0ZW0gKGFuIGVtYmVkZGVkIG9uZSkgYXMgc2ltcGxlIGFzIHBvc3NpYmxl
LCBhbmQgZm9yIG5vdyBJIGRvbiYjMzk7dCBoYXZlPGJyPgomZ3Q7IFB5dGhvbiwgSSBkb24mIzM5
O3QgdGhpbmsgaXQmIzM5O3MgYSBnb29kIGlkZWEgdG8gaW5jbHVkZSBpdCBqdXN0IGZvciB0aGF0
Ljxicj4KJmd0Ozxicj4KJmd0OyBDYW4gSSBkbyB0aGF0IHdpdGggQz88YnI+Cjxicj4KPC9kaXY+
U3VyZS4goFB5dGhvbiBqdXN0IGdpdmVzIHlvdSBhbiBleGFtcGxlIG9mIHdoYXQgRC1CdXMgcHJv
cGVydGllcyB0byBzZXQuPGJyPgo8ZGl2IGNsYXNzPSIiPjxicj4KJmd0Ozxicj4KJmd0OyBJZiBz
bywgd2hhdCBpcyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIGZpcnN0IG1ldGhvZCBhbmQgdGhpcyBv
bmU/PGJyPgo8YnI+CjwvZGl2Pk5vIGRpZmZlcmVuY2UgaW4gdGhlIGVuZC4goEZvciBhbiBlbWJl
ZGRlZCBzeXN0ZW0gd2hpY2ggaGFzIG5vIHVzZXI8YnI+CmlucHV0LCB0aGUgcHJvdmlzaW9uaW5n
IGFwcHJvYWNoIHdpbGwgbGlrZWx5IGJlIGVhc2llci48YnI+CjxkaXYgY2xhc3M9IkhPRW5aYiI+
PGRpdiBjbGFzcz0iaDUiPjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlz
dDxicj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9h
Pjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9v
Zm9ubyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlz
dGluZm8vb2Zvbm88L2E+PGJyPgo8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwv
ZGl2PjwvZGl2Pgo=

--===============0562302997863160549==--


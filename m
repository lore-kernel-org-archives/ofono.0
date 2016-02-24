Content-Type: multipart/mixed; boundary="===============5871212550098612037=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Wed, 24 Feb 2016 16:49:56 +0200
Message-ID: <CADnUhn31UetFJtm6re4jmjKBFUAGod9XWhms7MfTeUxE5VKcOA@mail.gmail.com>
In-Reply-To: <47184AF1-26FD-4A4A-9E09-1D756E18B878@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5871212550098612037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,
and thank you for your feedback.
I managed grabbing time to patching this CDC_NCM_FLAG_NDP_TO_END feature in
linux-ti-staging 4.1 kernel.  I found a patch (
https://dev.openwrt.org/browser/trunk/target/linux/generic/patches-4.1/190-=
cdc_ncm_add_support_for_moving_ndp_to_end_of_ncm_frame.patch?rev=3D46493)
doing this on mainline 4.1 kernel. Unfortunately linux-ti-staging has one
more kernel symbol exported in the files patched in this patch. Therefore,
I could not use it directly. However, even though I think I got the feature
patched properly, there was no change in operation (in spite of the kernel
module load messages). In fact, it was told in the patch comment that:
"This change has been tested and working with a Huawei E3131 device (which
works regardless of NDP position)". So, result was not too big surprise to
me. Unfortunately problem is still active if anyone has more fresh thoughts.
Thanks,
Matti

2016-01-23 22:32 GMT+02:00 CedrIc Jehasse <cedric.jehasse@gmail.com>:

> Hi,
>
> > Executing ifconfig wwan0 up;dhclient wwan0 can't get lease from wwan0
> interface.
> >
> I=E2=80=99ve had issues with an E3372 that didn=E2=80=99t accept cdc ncm =
frames from the
> linux cdc_ncm driver. Maybe there=E2=80=99s the same issue on the E3131, =
causing
> dhcp to fail. I see it=E2=80=99s been worked around since linux kernel v4=
.2 by
> adding the flag CDC_NCM_FLAG_NDP_TO_END to the cdc_ncm driver.
>
> Cedric
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============5871212550098612037==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+SGkgQ2VkcmljLCA8YnI+YW5kIHRoYW5rIHlv
dSBmb3IgeW91ciBmZWVkYmFjay48YnI+PC9kaXY+SSBtYW5hZ2VkIGdyYWJiaW5nIHRpbWUgdG8g
cGF0Y2hpbmcgdGhpcyBDRENfTkNNX0ZMQUdfTkRQX1RPX0VORCBmZWF0dXJlIGluIGxpbnV4LXRp
LXN0YWdpbmcgNC4xIGtlcm5lbC7CoCBJIGZvdW5kIGEgcGF0Y2ggKDxhIGhyZWY9Imh0dHBzOi8v
ZGV2Lm9wZW53cnQub3JnL2Jyb3dzZXIvdHJ1bmsvdGFyZ2V0L2xpbnV4L2dlbmVyaWMvcGF0Y2hl
cy00LjEvMTkwLWNkY19uY21fYWRkX3N1cHBvcnRfZm9yX21vdmluZ19uZHBfdG9fZW5kX29mX25j
bV9mcmFtZS5wYXRjaD9yZXY9NDY0OTMiPmh0dHBzOi8vZGV2Lm9wZW53cnQub3JnL2Jyb3dzZXIv
dHJ1bmsvdGFyZ2V0L2xpbnV4L2dlbmVyaWMvcGF0Y2hlcy00LjEvMTkwLWNkY19uY21fYWRkX3N1
cHBvcnRfZm9yX21vdmluZ19uZHBfdG9fZW5kX29mX25jbV9mcmFtZS5wYXRjaD9yZXY9NDY0OTM8
L2E+KSBkb2luZyB0aGlzIG9uIG1haW5saW5lIDQuMSBrZXJuZWwuIFVuZm9ydHVuYXRlbHkgbGlu
dXgtdGktc3RhZ2luZyBoYXMgb25lIG1vcmUga2VybmVsIHN5bWJvbCBleHBvcnRlZCBpbiB0aGUg
ZmlsZXMgcGF0Y2hlZCBpbiB0aGlzIHBhdGNoLiBUaGVyZWZvcmUsIEkgY291bGQgbm90IHVzZSBp
dCBkaXJlY3RseS4gSG93ZXZlciwgZXZlbiB0aG91Z2ggSSB0aGluayBJIGdvdCB0aGUgZmVhdHVy
ZSBwYXRjaGVkIHByb3Blcmx5LCB0aGVyZSB3YXMgbm8gY2hhbmdlIGluIG9wZXJhdGlvbiAoaW4g
c3BpdGUgb2YgdGhlIGtlcm5lbCBtb2R1bGUgbG9hZCBtZXNzYWdlcykuIEluIGZhY3QsIGl0IHdh
cyB0b2xkIGluIHRoZSBwYXRjaCBjb21tZW50IHRoYXQ6ICZxdW90O1RoaXMgY2hhbmdlIGhhcyBi
ZWVuIHRlc3RlZCBhbmQgd29ya2luZyB3aXRoIGEgSHVhd2VpIEUzMTMxIGRldmljZSAod2hpY2gg
d29ya3MgcmVnYXJkbGVzcyBvZiBORFAgcG9zaXRpb24pJnF1b3Q7LiBTbywgcmVzdWx0IHdhcyBu
b3QgdG9vIGJpZyBzdXJwcmlzZSB0byBtZS4gVW5mb3J0dW5hdGVseSBwcm9ibGVtIGlzIHN0aWxs
IGFjdGl2ZSBpZiBhbnlvbmUgaGFzIG1vcmUgZnJlc2ggdGhvdWdodHMuPGJyPjwvZGl2PlRoYW5r
cyw8YnI+PC9kaXY+TWF0dGk8YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48
ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxNi0wMS0yMyAyMjozMiBHTVQrMDI6MDAgQ2Vkcklj
IEplaGFzc2UgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86Y2VkcmljLmplaGFz
c2VAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+Y2VkcmljLmplaGFzc2VAZ21haWwuY29tPC9h
PiZndDs8L3NwYW4+Ojxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij5IaSw8YnI+CjxzcGFuIGNsYXNzPSIiPjxicj4KJmd0OyBFeGVjdXRpbmcgaWZjb25maWcg
d3dhbjAgdXA7ZGhjbGllbnQgd3dhbjAgY2FuJiMzOTt0IGdldCBsZWFzZSBmcm9tIHd3YW4wIGlu
dGVyZmFjZS48YnI+CiZndDs8YnI+Cjwvc3Bhbj5J4oCZdmUgaGFkIGlzc3VlcyB3aXRoIGFuIEUz
MzcyIHRoYXQgZGlkbuKAmXQgYWNjZXB0IGNkYyBuY20gZnJhbWVzIGZyb20gdGhlIGxpbnV4IGNk
Y19uY20gZHJpdmVyLiBNYXliZSB0aGVyZeKAmXMgdGhlIHNhbWUgaXNzdWUgb24gdGhlIEUzMTMx
LCBjYXVzaW5nIGRoY3AgdG8gZmFpbC4gSSBzZWUgaXTigJlzIGJlZW4gd29ya2VkIGFyb3VuZCBz
aW5jZSBsaW51eCBrZXJuZWwgdjQuMiBieSBhZGRpbmcgdGhlIGZsYWcgQ0RDX05DTV9GTEFHX05E
UF9UT19FTkQgdG8gdGhlIGNkY19uY20gZHJpdmVyLjxicj4KPGJyPgpDZWRyaWM8YnI+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWls
aW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25v
Lm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlz
dGluZm8vb2Zvbm8iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbGlz
dHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8L2Jsb2NrcXVvdGU+
PC9kaXY+PGJyPjwvZGl2Pgo=

--===============5871212550098612037==--


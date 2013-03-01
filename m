Content-Type: multipart/mixed; boundary="===============2732780093600674913=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: Re: [PATCH v2] bluez5: Add role parameter to bt_register_profile
Date: Fri, 01 Mar 2013 17:02:16 -0300
Message-ID: <CAG7KCRGGGHOtapszi3YLXvmpPpnF=YEwYNWK72_O4KBgUmjPvg@mail.gmail.com>
In-Reply-To: <513104C2.2090500@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2732780093600674913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Which profiles actually need this?  If this is an extreme minority, then
> I'd rather see a dedicated function for this.  e.g.
>
> bt_register_profile_with_role(**)
>
> Regards,
> -Denis
>

Hi,

In oFono, only the DUN profile use it.

I'll create the new function, as specified.

--===============2732780093600674913==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij4KV2hpY2ggcHJvZmlsZXMgYWN0dWFsbHkgbmVlZCB0aGlzPyCgSWYg
dGhpcyBpcyBhbiBleHRyZW1lIG1pbm9yaXR5LCB0aGVuIEkmIzM5O2QgcmF0aGVyIHNlZSBhIGRl
ZGljYXRlZCBmdW5jdGlvbiBmb3IgdGhpcy4goGUuZy48YnI+Cjxicj4KYnRfcmVnaXN0ZXJfcHJv
ZmlsZV93aXRoX3JvbGUoPHU+PC91Pik8YnI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4K
PC9ibG9ja3F1b3RlPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SGksPC9kaXY+PGJyPjxkaXY+
PHNwYW4gc3R5bGU9ImNvbG9yOnJnYigzNCwzNCwzNCk7Zm9udC1mYW1pbHk6YXJpYWwsc2Fucy1z
ZXJpZjtmb250LXNpemU6MTNweDtiYWNrZ3JvdW5kLWNvbG9yOnJnYigyNTUsMjU1LDI1NSkiPklu
IG9Gb25vLCBvbmx5IHRoZSBEVU4gcHJvZmlsZSB1c2UgaXQuPC9zcGFuPjxkaXYgc3R5bGU9ImNv
bG9yOnJnYigzNCwzNCwzNCk7Zm9udC1mYW1pbHk6YXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6
MTNweDtiYWNrZ3JvdW5kLWNvbG9yOnJnYigyNTUsMjU1LDI1NSkiPgo8YnI+PC9kaXY+PGRpdiBz
dHlsZT0iY29sb3I6cmdiKDM0LDM0LDM0KTtmb250LWZhbWlseTphcmlhbCxzYW5zLXNlcmlmO2Zv
bnQtc2l6ZToxM3B4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+SSYjMzk7bGwg
Y3JlYXRlIHRoZSBuZXcgZnVuY3Rpb24sIGFzIHNwZWNpZmllZC48L2Rpdj48L2Rpdj4K

--===============2732780093600674913==--


Content-Type: multipart/mixed; boundary="===============1234511350569419214=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: Vendor product extension thoughts
Date: Fri, 05 Jan 2018 09:59:26 +0100
Message-ID: <CAH4ZQwsbkTFOSTo6BuZ-WMBDpE82CuJt7rgvy3fw8_6-7pni8Q@mail.gmail.com>
In-Reply-To: <fea86f8c-9f44-cbbe-74e1-5bee3b4a9633@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1234511350569419214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>
> - add a product parameter to the function prototype
>>
>
> This would be too invasive.  Are you using the telit gprs-context driver?
> If so, you'd be better off changing that one to accept a custom data
> structure instead of a GAtChat.  See drivers/hfpmodem for an example.  Or
> write a custom driver for your needs...
>
> - change the vendor parameter with a structure of two variables
>>
>
> See abov
> =E2=80=8Be
>

=E2=80=8BThis is probably the most suitable solution for me.
Thank you.

Enrico=E2=80=8B

--===============1234511350569419214==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PHNwYW4gY2xhc3M9IiI+PC9zcGFuPjxzcGFuIGNsYXNzPSIiPjwvc3Bh
bj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij48c3BhbiBjbGFzcz0iIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij4tIGFkZCBhIHByb2R1Y3QgcGFyYW1ldGVyIHRvIHRoZSBmdW5jdGlvbiBwcm90b3R5cGU8
YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvc3Bhbj4KVGhpcyB3b3VsZCBiZSB0b28gaW52YXNpdmUu
wqAgQXJlIHlvdSB1c2luZyB0aGUgdGVsaXQgZ3Bycy1jb250ZXh0IGRyaXZlcj/CoCBJZiBzbywg
eW91JiMzOTtkIGJlIGJldHRlciBvZmYgY2hhbmdpbmcgdGhhdCBvbmUgdG8gYWNjZXB0IGEgY3Vz
dG9tIGRhdGEgc3RydWN0dXJlIGluc3RlYWQgb2YgYSBHQXRDaGF0LsKgIFNlZSBkcml2ZXJzL2hm
cG1vZGVtIGZvciBhbiBleGFtcGxlLsKgIE9yIHdyaXRlIGEgY3VzdG9tIGRyaXZlciBmb3IgeW91
ciBuZWVkcy4uLjxzcGFuIGNsYXNzPSIiPjxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBz
b2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KLSBjaGFuZ2UgdGhlIHZlbmRvciBwYXJhbWV0ZXIgd2l0
aCBhIHN0cnVjdHVyZSBvZiB0d28gdmFyaWFibGVzPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L3Nw
YW4+ClNlZSBhYm92PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmO2Rp
c3BsYXk6aW5saW5lIiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+4oCLZTwvZGl2PjwvYmxvY2txdW90
ZT48ZGl2Pjxicj48L2Rpdj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNh
bnMtc2VyaWYiIGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij7igItUaGlzIGlzIHByb2JhYmx5IHRoZSBt
b3N0IHN1aXRhYmxlIHNvbHV0aW9uIGZvciBtZS48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWls
eTp2ZXJkYW5hLHNhbnMtc2VyaWYiIGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5UaGFuayB5b3UuPC9k
aXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fu
cy1zZXJpZiIgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPkVucmljb+KAizwvZGl2Pjxicj48L2Rpdj48
L2Rpdj4K

--===============1234511350569419214==--


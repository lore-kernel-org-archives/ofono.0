Content-Type: multipart/mixed; boundary="===============0642616302318094922=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Vendor product extension thoughts
Date: Thu, 04 Jan 2018 14:01:33 +0100
Message-ID: <CAH4ZQwuKXyE1wi47d1eO-Jcqcht47OkoV_WO3KUOuCymhQ31Yg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0642616302318094922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

=E2=80=8BHello everyone,

I'm facing what seems to be a limit in ofono implementation.
I'm working with some Telit modems and some of them have reserved contexts
which can't be used for data connection.

Currently, from telit plugin, I can only send the "vendor" parameter to the
interface create function and there is no way to specify the product.

What you think?
Did anyone ever have to set different behaviors for different products of
the same vendor?

I'm thinking about different solutions:
- extend the vendors enum in order to be a vendor/product enum.
- add a product parameter to the function prototype
- change the vendor parameter with a structure of two variables

Do you think it would be an improvement?

P.S. happy new year!

Enrico

--===============0642616302318094922==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlm
IiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+4oCLSGVsbG8gZXZlcnlvbmUsPGJyPjxicj5JJiMzOTtt
IGZhY2luZyB3aGF0IHNlZW1zIHRvIGJlIGEgbGltaXQgaW4gb2Zvbm8gaW1wbGVtZW50YXRpb24u
PGJyPkkmIzM5O20gd29ya2luZyB3aXRoIHNvbWUgVGVsaXQgbW9kZW1zIGFuZCBzb21lIG9mIHRo
ZW0gaGF2ZSByZXNlcnZlZCBjb250ZXh0cyB3aGljaCBjYW4mIzM5O3QgYmUgdXNlZCBmb3IgZGF0
YSBjb25uZWN0aW9uLjxicj48YnI+Q3VycmVudGx5LCBmcm9tIHRlbGl0IHBsdWdpbiwgSSBjYW4g
b25seSBzZW5kIHRoZSAmcXVvdDt2ZW5kb3ImcXVvdDsgcGFyYW1ldGVyIHRvIHRoZSBpbnRlcmZh
Y2UgY3JlYXRlIGZ1bmN0aW9uIGFuZCB0aGVyZSBpcyBubyB3YXkgdG8gc3BlY2lmeSB0aGUgcHJv
ZHVjdC48YnI+PGJyPldoYXQgeW91IHRoaW5rPzxicj5EaWQgYW55b25lIGV2ZXIgaGF2ZSB0byBz
ZXQgZGlmZmVyZW50IGJlaGF2aW9ycyBmb3IgZGlmZmVyZW50IHByb2R1Y3RzIG9mIHRoZSBzYW1l
IHZlbmRvcj88YnI+PGJyPkkmIzM5O20gdGhpbmtpbmcgYWJvdXQgZGlmZmVyZW50IHNvbHV0aW9u
czo8YnI+LSBleHRlbmQgdGhlIHZlbmRvcnMgZW51bSBpbiBvcmRlciB0byBiZSBhIHZlbmRvci9w
cm9kdWN0IGVudW0uPGJyPi0gYWRkIGEgcHJvZHVjdCBwYXJhbWV0ZXIgdG8gdGhlIGZ1bmN0aW9u
IHByb3RvdHlwZTxicj4tIGNoYW5nZSB0aGUgdmVuZG9yIHBhcmFtZXRlciB3aXRoIGEgc3RydWN0
dXJlIG9mIHR3byB2YXJpYWJsZXM8YnI+PGJyPkRvIHlvdSB0aGluayBpdCB3b3VsZCBiZSBhbiBp
bXByb3ZlbWVudD88YnI+PGJyPlAuUy4gaGFwcHkgbmV3IHllYXIhPGJyPjxicj5FbnJpY288L2Rp
dj48L2Rpdj4K

--===============0642616302318094922==--


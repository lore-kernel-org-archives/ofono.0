Content-Type: multipart/mixed; boundary="===============2199092809895867682=="
MIME-Version: 1.0
From: Tonny Tzeng <tonny.tzeng@gmail.com>
Subject: Re: [PATCH] Specify vendor ID for Huawei modem while creating GPRS
 context
Date: Sun, 12 Dec 2010 00:37:24 +0800
Message-ID: <AANLkTikBCc8+4BpCu7=Dmi8BBDgDn9_ThvDzfKa5JTbo@mail.gmail.com>
In-Reply-To: <4D0390C4.4010908@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2199092809895867682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

No, you don't.  You are confusing gprs atom and the gprs-context atom.
> Grep for VENDOR in drivers/atmodem/gprs-context.c if you do not believe
> me.  There is no vendor specific code in the atmodem gprs-context driver.
>

Yes, my bad, I misunderstood the program flow...
So, is huawei_post_online() in plugins/huawei.c the right place to pass the
vendor ID while calling to ofono_gprs_create()?

Together with the patch to fix parsing of unquoted CGREG, now I can get the
CGREG status correctly from the Huawei modem.  :)  Thanks!

Best Regards,
Tonny

--===============2199092809895867682==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPjxkaXYgY2xhc3M9ImltIj5ObywgeW91IGRv
biYjMzk7dC4goFlvdSBhcmUgY29uZnVzaW5nIGdwcnMgYXRvbSBhbmQgdGhlIGdwcnMtY29udGV4
dCBhdG9tLjwvZGl2PgoKR3JlcCBmb3IgVkVORE9SIGluIGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNv
bnRleHQuYyBpZiB5b3UgZG8gbm90IGJlbGlldmU8YnI+Cm1lLiCgVGhlcmUgaXMgbm8gdmVuZG9y
IHNwZWNpZmljIGNvZGUgaW4gdGhlIGF0bW9kZW0gZ3Bycy1jb250ZXh0IGRyaXZlci48YnI+PC9i
bG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+WWVzLCBteSBiYWQsIEkgbWlzdW5kZXJzdG9v
ZCB0aGUgcHJvZ3JhbSBmbG93Li4uPC9kaXY+PGRpdj5TbywgaXMgaHVhd2VpX3Bvc3Rfb25saW5l
KCkgaW4gcGx1Z2lucy9odWF3ZWkuYyB0aGUgcmlnaHQgcGxhY2UgdG8gcGFzcyB0aGUgdmVuZG9y
IElEIHdoaWxlIGNhbGxpbmcgdG8gb2Zvbm9fZ3Byc19jcmVhdGUoKT88L2Rpdj4KPGRpdj48YnI+
PC9kaXY+PGRpdj5Ub2dldGhlciB3aXRoIHRoZSBwYXRjaCB0byBmaXggcGFyc2luZyBvZiB1bnF1
b3RlZCBDR1JFRywgbm93IEkgY2FuIGdldCB0aGUgQ0dSRUcgc3RhdHVzIGNvcnJlY3RseSBmcm9t
IHRoZSBIdWF3ZWkgbW9kZW0uIKA6KSCgVGhhbmtzITwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
QmVzdCBSZWdhcmRzLDwvZGl2PjxkaXY+VG9ubnk8L2Rpdj48L2Rpdj4K

--===============2199092809895867682==--


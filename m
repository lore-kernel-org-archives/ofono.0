Content-Type: multipart/mixed; boundary="===============8396210835102045254=="
MIME-Version: 1.0
From: Jerry Casette <gjerryboi@gmail.com>
Subject: buildroot
Date: Wed, 23 Mar 2011 17:01:18 +0100
Message-ID: <AANLkTi=MRsBechiLLBeG9pcKQ+dG5ViZY04x5QwOmZrW@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8396210835102045254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello List,

first mail, please be gentle. I wish to create a new rootfs for my ARM920T
microcontroller based device using BUILDROOT. The device has a serial port
attached huawei 3G modem that could theoretically be used with stock
chap/ppp. I do vividly remember though my aggreviance with this before
finding wvdial, a simple, easy-to-use package to configure, initialize,
start, and monitor the pppd. Unfortunately, wvdial just can not be added to
my buidroot created rootFS. My question to the listmembers is twofold:
1) am I right to assume that ofono is more than capable replacing my old
friend vwdial as shown here:
http://ofono.org/wiki/how-work-newly-bought-3g-key
2) if so, is there a makefile I could use to add ofono to my otherwise
functional buildroot conf?

Any help would be much appreciated.

TIA,
Jerry O_O

--===============8396210835102045254==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGVsbG8gTGlzdCw8YnI+PGJyPmZpcnN0IG1haWwsIHBsZWFzZSBiZSBnZW50bGUuIEkgd2lzaCB0
byBjcmVhdGUgYSBuZXcgcm9vdGZzIGZvciBteSBBUk05MjBUIG1pY3JvY29udHJvbGxlciBiYXNl
ZCBkZXZpY2UgdXNpbmcgQlVJTERST09ULiBUaGUgZGV2aWNlIGhhcyBhIHNlcmlhbCBwb3J0IGF0
dGFjaGVkIGh1YXdlaSAzRyBtb2RlbSB0aGF0IGNvdWxkIHRoZW9yZXRpY2FsbHkgYmUgdXNlZCB3
aXRoIHN0b2NrIGNoYXAvcHBwLiBJIGRvIHZpdmlkbHkgcmVtZW1iZXIgdGhvdWdoIG15IGFnZ3Jl
dmlhbmNlIHdpdGggdGhpcyBiZWZvcmUgZmluZGluZyB3dmRpYWwsIGEgc2ltcGxlLCBlYXN5LXRv
LXVzZSBwYWNrYWdlIHRvIGNvbmZpZ3VyZSwgaW5pdGlhbGl6ZSwgc3RhcnQsIGFuZCBtb25pdG9y
IHRoZSBwcHBkLiBVbmZvcnR1bmF0ZWx5LCB3dmRpYWwganVzdCBjYW4gbm90IGJlIGFkZGVkIHRv
IG15IGJ1aWRyb290IGNyZWF0ZWQgcm9vdEZTLiBNeSBxdWVzdGlvbiB0byB0aGUgbGlzdG1lbWJl
cnMgaXMgdHdvZm9sZDo8YnI+CjEpIGFtIEkgcmlnaHQgdG8gYXNzdW1lIHRoYXQgb2Zvbm8gaXMg
bW9yZSB0aGFuIGNhcGFibGUgcmVwbGFjaW5nIG15IG9sZCBmcmllbmQgdndkaWFsIGFzIHNob3du
IGhlcmU6IDxhIGhyZWY9Imh0dHA6Ly9vZm9uby5vcmcvd2lraS9ob3ctd29yay1uZXdseS1ib3Vn
aHQtM2cta2V5Ij5odHRwOi8vb2Zvbm8ub3JnL3dpa2kvaG93LXdvcmstbmV3bHktYm91Z2h0LTNn
LWtleTwvYT48YnI+CjIpIGlmIHNvLCBpcyB0aGVyZSBhIG1ha2VmaWxlIEkgY291bGQgdXNlIHRv
IGFkZCBvZm9ubyB0byBteSBvdGhlcndpc2UgZnVuY3Rpb25hbCBidWlsZHJvb3QgY29uZj88YnI+
PGJyPkFueSBoZWxwIHdvdWxkIGJlIG11Y2ggYXBwcmVjaWF0ZWQuIDxicj48YnI+VElBLCA8YnI+
SmVycnkgT19PPGJyPgo=

--===============8396210835102045254==--


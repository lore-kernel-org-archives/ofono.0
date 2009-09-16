Content-Type: multipart/mixed; boundary="===============0596586693408121953=="
MIME-Version: 1.0
From: Dennis.Yxun <dennis.yxun@gmail.com>
Subject: Re: Bug in sms
Date: Wed, 16 Sep 2009 09:22:08 +0000
Message-ID: <7b09df4c0909160222l5fd50ca0w30ff4ae72defec62@mail.gmail.com>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001AB9212FC@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0596586693408121953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI Yang:
    Mind I ask you a question? maybe off-topic.
Which hardware(the GSM modem?) are you testing?
Is that possible for a developer to get an open hardware,
So they can put their hands in
   Thanks.

Dennis

On Wed, Sep 16, 2009 at 8:22 AM, Gu, Yang <yang.gu@intel.com> wrote:

> Hi,
>        Today I tried oFono with my cell phone, but it crashed when starti=
ng
> up. The problem happens in function at_cmgl_notify() of file
> drivers/atmodem/sms.c. In my case, strlen(hexpdu) =3D=3D 338, but the buf=
fer
> "pdu" has maximum size of 164. So after decode_hex_own_buf(), some memory
> was written unexpectedly. Call for a fix, please.
>
>
> Regards,
> -Yang
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============0596586693408121953==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SEkgWWFuZzo8YnI+oKCgIE1pbmQgSSBhc2sgeW91IGEgcXVlc3Rpb24/IG1heWJlIG9mZi10b3Bp
Yy48YnI+V2hpY2ggaGFyZHdhcmUodGhlIEdTTSBtb2RlbT8pIGFyZSB5b3UgdGVzdGluZz88YnI+
SXMgdGhhdCBwb3NzaWJsZSBmb3IgYSBkZXZlbG9wZXIgdG8gZ2V0IGFuIG9wZW4gaGFyZHdhcmUs
PGJyPlNvIHRoZXkgY2FuIHB1dCB0aGVpciBoYW5kcyBpbjxicj6goCBUaGFua3MuPGJyPgo8YnI+
RGVubmlzPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gV2VkLCBTZXAgMTYsIDIw
MDkgYXQgODoyMiBBTSwgR3UsIFlhbmcgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJodHRw
Oi8veWFuZy5ndSI+eWFuZy5ndTwvYT5APGEgaHJlZj0iaHR0cDovL2ludGVsLmNvbSI+aW50ZWwu
Y29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFy
Z2luOiAwcHQgMHB0IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KSGksPGJyPgogoCCg
IKAgoFRvZGF5IEkgdHJpZWQgb0Zvbm8gd2l0aCBteSBjZWxsIHBob25lLCBidXQgaXQgY3Jhc2hl
ZCB3aGVuIHN0YXJ0aW5nIHVwLiBUaGUgcHJvYmxlbSBoYXBwZW5zIGluIGZ1bmN0aW9uIGF0X2Nt
Z2xfbm90aWZ5KCkgb2YgZmlsZSBkcml2ZXJzL2F0bW9kZW0vc21zLmMuIEluIG15IGNhc2UsIHN0
cmxlbihoZXhwZHUpID09IDMzOCwgYnV0IHRoZSBidWZmZXIgJnF1b3Q7cGR1JnF1b3Q7IGhhcyBt
YXhpbXVtIHNpemUgb2YgMTY0LiBTbyBhZnRlciBkZWNvZGVfaGV4X293bl9idWYoKSwgc29tZSBt
ZW1vcnkgd2FzIHdyaXR0ZW4gdW5leHBlY3RlZGx5LiBDYWxsIGZvciBhIGZpeCwgcGxlYXNlLjxi
cj4KCjxicj4KPGJyPgpSZWdhcmRzLDxicj4KLVlhbmc8YnI+Cjxicj4KPGJyPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBs
aXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8
L2E+PGJyPgo8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIiB0
YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubzwvYT48
YnI+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+Cg==

--===============0596586693408121953==--


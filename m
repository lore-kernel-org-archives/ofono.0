Content-Type: multipart/mixed; boundary="===============7843030422334627501=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH 1/2] gprs: Ignore activated contexts during init,
 list them later
Date: Mon, 12 Aug 2019 20:43:07 +0200
Message-ID: <CAHB-PjkDp4Lh+PuCLNDAR1dZUQnQHeLiELaP+s45ORs1z-5Hjg@mail.gmail.com>
In-Reply-To: <486556da-b3c7-8c6a-e7a8-58097dd449be@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7843030422334627501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den m=C3=A5n 12 aug. 2019 kl 19:28 skrev Denis Kenzior <denkenz@gmail.com=
>:

> Hi Richard,
>
> >> +    void (*get_active_auto_context)(struct ofono_gprs *gprs,
> >> +                    ofono_gprs_active_context_cb_t cb,
> >> +                    void *data);
> >
> > list_active_contexts?  Also, since there can in theory be multiple ones
> > of these, I'd do something like:
> >
> > typedef void (*ofono_gprs_active_context_cb_t)(int cid, const char *apn,
> >                          void *data);
> >
> > void (*list_active_contexts)(struct ofono_gprs *gprs,
> >              ofono_gprs_active_context_cb_t active_cb,
> >              ofono_gprs_cb_t finished_cb);
> >
>
> As an alternative to the above you can simply do:
>
> void (*list_active_contexts)(struct ofono_gprs *gprs,
>                                 ofono_gprs_cb_t cb);
>
> And direct the driver to issue N ofono_gprs_context_activated calls
> followed by cb.  Where N is the number of active contexts.
>

Makes more sense, then there is no need for a "strange" call with -1 and
NULL.


>
> Regards,
> -Denis
>

--Richard

--===============7843030422334627501==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gbcOlbiAxMiBhdWcu
IDIwMTkga2wgMTk6Mjggc2tyZXYgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRl
bmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7Ojxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+SGkgUmljaGFyZCw8YnI+Cjxicj4KJmd0OyZndDsgK8KgwqDCoCB2b2lkICgqZ2V0X2FjdGl2
ZV9hdXRvX2NvbnRleHQpKHN0cnVjdCBvZm9ub19ncHJzICpncHJzLDxicj4KJmd0OyZndDsgK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mb25vX2dwcnNfYWN0aXZlX2Nv
bnRleHRfY2JfdCBjYiw8YnI+CiZndDsmZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB2b2lkICpkYXRhKTs8YnI+CiZndDsgPGJyPgomZ3Q7IGxpc3RfYWN0aXZlX2Nv
bnRleHRzP8KgIEFsc28sIHNpbmNlIHRoZXJlIGNhbiBpbiB0aGVvcnkgYmUgbXVsdGlwbGUgb25l
cyA8YnI+CiZndDsgb2YgdGhlc2UsIEkmIzM5O2QgZG8gc29tZXRoaW5nIGxpa2U6PGJyPgomZ3Q7
IDxicj4KJmd0OyB0eXBlZGVmIHZvaWQgKCpvZm9ub19ncHJzX2FjdGl2ZV9jb250ZXh0X2NiX3Qp
KGludCBjaWQsIGNvbnN0IGNoYXIgKmFwbiw8YnI+CiZndDvCoCDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKmRhdGEpOzxicj4KJmd0OyA8YnI+CiZn
dDsgdm9pZCAoKmxpc3RfYWN0aXZlX2NvbnRleHRzKShzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Bycyw8
YnI+CiZndDvCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mb25vX2dwcnNfYWN0aXZlX2NvbnRl
eHRfY2JfdCBhY3RpdmVfY2IsPGJyPgomZ3Q7wqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZm9u
b19ncHJzX2NiX3QgZmluaXNoZWRfY2IpOzxicj4KJmd0OyA8YnI+Cjxicj4KQXMgYW4gYWx0ZXJu
YXRpdmUgdG8gdGhlIGFib3ZlIHlvdSBjYW4gc2ltcGx5IGRvOjxicj4KPGJyPgp2b2lkICgqbGlz
dF9hY3RpdmVfY29udGV4dHMpKHN0cnVjdCBvZm9ub19ncHJzICpncHJzLDxicj4KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgb2Zvbm9fZ3Byc19jYl90IGNi
KTs8YnI+Cjxicj4KQW5kIGRpcmVjdCB0aGUgZHJpdmVyIHRvIGlzc3VlIE4gb2Zvbm9fZ3Byc19j
b250ZXh0X2FjdGl2YXRlZCBjYWxscyA8YnI+CmZvbGxvd2VkIGJ5IGNiLsKgIFdoZXJlIE4gaXMg
dGhlIG51bWJlciBvZiBhY3RpdmUgY29udGV4dHMuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48
L2Rpdj48ZGl2Pk1ha2VzIG1vcmUgc2Vuc2UsIHRoZW4gdGhlcmUgaXMgbm8gbmVlZCBmb3IgYSAm
cXVvdDtzdHJhbmdlJnF1b3Q7IGNhbGwgd2l0aCAtMSBhbmQgTlVMTC48L2Rpdj48ZGl2PsKgPC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPgo8YnI+ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+PC9ibG9ja3F1b3RlPjxkaXY+
PGJyPjwvZGl2PjxkaXY+LS1SaWNoYXJkwqA8L2Rpdj48L2Rpdj48L2Rpdj4K

--===============7843030422334627501==--


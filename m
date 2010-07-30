Content-Type: multipart/mixed; boundary="===============2406460815929632202=="
MIME-Version: 1.0
From: s s <sk53901@gmail.com>
Subject: Re: USSD support in ofono-0.25
Date: Fri, 30 Jul 2010 12:58:43 +0530
Message-ID: <AANLkTimeWdbweQ40WpH-NRjq4LD0pfJtCd=HWbXRHw7Q@mail.gmail.com>
In-Reply-To: <1280474440.21857.1.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2406460815929632202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi ,
             supplementaryservices-api.txt is not available in doc folder in
ofono-0.25.tar.gz ,is there any other location to find it?

thanks
ss.
On Fri, Jul 30, 2010 at 12:50 PM, Marcel Holtmann <marcel@holtmann.org>wr=
ote:

> Hi,
>
> > Is USSD support is available and functional in ofono latest version?
>
> yes it is.
>
> > I found the support in SupplementaryServices interface and I am able
> > to read the properties from this interface, but I am getting error
> > when try to call "Initiate" method,
> > from the definition of "Initiate" method in ussd.c found that out
> > arguments are "sv". below is the test code.
> >
> > gchar *str=3DNULL;
> > GValue val=3D{0,};
> > g_value_init(&val,G_TYPE_STRING);
> > dbus_g_proxy_call (proxy,
> >
> "Initiate",&error,G_TYPE_STRING,"*#43#",G_TYPE_INVALID,G_TYPE_STRING,&str=
,G_TYPE_VALUE,&val,
> G_TYPE_INVALID);
> >
> > if above code is executed  , the error is
> > " GLib-GObject-WARNING **: gvalue.c:185: cannot initialize GValue with
> > type `GValueArray_gchararray+GHashTable_gchararray+GValue__', the
> > value has already been initialized as `gchararray'
> >
> > Couldn't convert argument, expected "GValue" "
> >
> >
> > and in generate_cw_ss_query_reply callback , message signature is
> > "(sa{sv})"
> > so tried with
> >
> > GArray *list;
> > GHashTable *OUT_arg0=3DNULL;
> > dbus_g_proxy_call (proxy,
> > "Initiate",&error,G_TYPE_STRING,"*#43#",G_TYPE_INVALID,
> >                                 dbus_g_type_get_struct ("GValueArray",
> > G_TYPE_STRING,
> >                                 dbus_g_type_get_map ("GHashTable",
> > G_TYPE_STRING, G_TYPE_VALUE),G_TYPE_INVALID),
> >                                 &OUT_arg0, G_TYPE_INVALID);
> >
> > but it is returning error " Expected D-BUS struct, got type code 's'"
> >
> > can any body please tell me the correct return types.
> >
> > in both cases ofono is getting response from phonesim.
> >
> > and no proper documentation is available for USSD support .
>
> Look at doc/supplementaryservices-api.txt for a detailed description of
> the API. And test/test-ussd is an example in Python on how to use it.
>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============2406460815929632202==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgLDxicj6goKCgoKCgoKCgoKAgc3VwcGxlbWVudGFyeXNlcnZpY2VzLWFwaS50eHQgaXMgbm90
IGF2YWlsYWJsZSBpbiBkb2MgZm9sZGVyIGluIG9mb25vLTAuMjUudGFyLmd6ICxpcyB0aGVyZSBh
bnkgb3RoZXIgbG9jYXRpb24gdG8gZmluZCBpdD88YnI+PGJyPnRoYW5rcyA8YnI+c3MuPGJyPjxk
aXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBGcmksIEp1bCAzMCwgMjAxMCBhdCAxMjo1MCBQTSwg
TWFyY2VsIEhvbHRtYW5uIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOm1hcmNl
bEBob2x0bWFubi5vcmciPm1hcmNlbEBob2x0bWFubi5vcmc8L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6
PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJib3JkZXItbGVmdDog
MXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsg
cGFkZGluZy1sZWZ0OiAxZXg7Ij5IaSw8YnI+CjxkaXYgY2xhc3M9ImltIj48YnI+CiZndDsgSXMg
VVNTRCBzdXBwb3J0IGlzIGF2YWlsYWJsZSBhbmQgZnVuY3Rpb25hbCBpbiBvZm9ubyBsYXRlc3Qg
dmVyc2lvbj88YnI+Cjxicj4KPC9kaXY+eWVzIGl0IGlzLjxicj4KPGRpdj48ZGl2PjwvZGl2Pjxk
aXYgY2xhc3M9Img1Ij48YnI+CiZndDsgSSBmb3VuZCB0aGUgc3VwcG9ydCBpbiBTdXBwbGVtZW50
YXJ5U2VydmljZXMgaW50ZXJmYWNlIGFuZCBJIGFtIGFibGU8YnI+CiZndDsgdG8gcmVhZCB0aGUg
cHJvcGVydGllcyBmcm9tIHRoaXMgaW50ZXJmYWNlLCBidXQgSSBhbSBnZXR0aW5nIGVycm9yPGJy
PgomZ3Q7IHdoZW4gdHJ5IHRvIGNhbGwgJnF1b3Q7SW5pdGlhdGUmcXVvdDsgbWV0aG9kLDxicj4K
Jmd0OyBmcm9tIHRoZSBkZWZpbml0aW9uIG9mICZxdW90O0luaXRpYXRlJnF1b3Q7IG1ldGhvZCBp
biB1c3NkLmMgZm91bmQgdGhhdCBvdXQ8YnI+CiZndDsgYXJndW1lbnRzIGFyZSAmcXVvdDtzdiZx
dW90Oy4gYmVsb3cgaXMgdGhlIHRlc3QgY29kZS48YnI+CiZndDs8YnI+CiZndDsgZ2NoYXIgKnN0
cj1OVUxMOzxicj4KJmd0OyBHVmFsdWUgdmFsPXswLH07PGJyPgomZ3Q7IGdfdmFsdWVfaW5pdCgm
YW1wO3ZhbCxHX1RZUEVfU1RSSU5HKTs8YnI+CiZndDsgZGJ1c19nX3Byb3h5X2NhbGwgKHByb3h5
LDxicj4KJmd0OyAmcXVvdDtJbml0aWF0ZSZxdW90OywmYW1wO2Vycm9yLEdfVFlQRV9TVFJJTkcs
JnF1b3Q7KiM0MyMmcXVvdDssR19UWVBFX0lOVkFMSUQsR19UWVBFX1NUUklORywmYW1wO3N0cixH
X1RZUEVfVkFMVUUsJmFtcDt2YWwsIEdfVFlQRV9JTlZBTElEKTs8YnI+CiZndDs8YnI+CiZndDsg
aWYgYWJvdmUgY29kZSBpcyBleGVjdXRlZCCgLCB0aGUgZXJyb3IgaXM8YnI+CiZndDsgJnF1b3Q7
IEdMaWItR09iamVjdC1XQVJOSU5HICoqOiBndmFsdWUuYzoxODU6IGNhbm5vdCBpbml0aWFsaXpl
IEdWYWx1ZSB3aXRoPGJyPgomZ3Q7IHR5cGUgYEdWYWx1ZUFycmF5X2djaGFyYXJyYXkrR0hhc2hU
YWJsZV9nY2hhcmFycmF5K0dWYWx1ZV9fJiMzOTssIHRoZTxicj4KJmd0OyB2YWx1ZSBoYXMgYWxy
ZWFkeSBiZWVuIGluaXRpYWxpemVkIGFzIGBnY2hhcmFycmF5JiMzOTs8YnI+CiZndDs8YnI+CiZn
dDsgQ291bGRuJiMzOTt0IGNvbnZlcnQgYXJndW1lbnQsIGV4cGVjdGVkICZxdW90O0dWYWx1ZSZx
dW90OyAmcXVvdDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDsgYW5kIGluIGdlbmVyYXRlX2N3
X3NzX3F1ZXJ5X3JlcGx5IGNhbGxiYWNrICwgbWVzc2FnZSBzaWduYXR1cmUgaXM8YnI+CiZndDsg
JnF1b3Q7KHNhe3N2fSkmcXVvdDs8YnI+CiZndDsgc28gdHJpZWQgd2l0aDxicj4KJmd0Ozxicj4K
Jmd0OyBHQXJyYXkgKmxpc3Q7PGJyPgomZ3Q7IEdIYXNoVGFibGUgKk9VVF9hcmcwPU5VTEw7PGJy
PgomZ3Q7IGRidXNfZ19wcm94eV9jYWxsIChwcm94eSw8YnI+CiZndDsgJnF1b3Q7SW5pdGlhdGUm
cXVvdDssJmFtcDtlcnJvcixHX1RZUEVfU1RSSU5HLCZxdW90OyojNDMjJnF1b3Q7LEdfVFlQRV9J
TlZBTElELDxicj4KJmd0OyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGRidXNfZ190
eXBlX2dldF9zdHJ1Y3QgKCZxdW90O0dWYWx1ZUFycmF5JnF1b3Q7LDxicj4KJmd0OyBHX1RZUEVf
U1RSSU5HLDxicj4KJmd0OyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGRidXNfZ190
eXBlX2dldF9tYXAgKCZxdW90O0dIYXNoVGFibGUmcXVvdDssPGJyPgomZ3Q7IEdfVFlQRV9TVFJJ
TkcsIEdfVFlQRV9WQUxVRSksR19UWVBFX0lOVkFMSUQpLDxicj4KJmd0OyCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgICZhbXA7T1VUX2FyZzAsIEdfVFlQRV9JTlZBTElEKTs8YnI+CiZn
dDs8YnI+CiZndDsgYnV0IGl0IGlzIHJldHVybmluZyBlcnJvciAmcXVvdDsgRXhwZWN0ZWQgRC1C
VVMgc3RydWN0LCBnb3QgdHlwZSBjb2RlICYjMzk7cyYjMzk7JnF1b3Q7PGJyPgomZ3Q7PGJyPgom
Z3Q7IGNhbiBhbnkgYm9keSBwbGVhc2UgdGVsbCBtZSB0aGUgY29ycmVjdCByZXR1cm4gdHlwZXMu
PGJyPgomZ3Q7PGJyPgomZ3Q7IGluIGJvdGggY2FzZXMgb2Zvbm8gaXMgZ2V0dGluZyByZXNwb25z
ZSBmcm9tIHBob25lc2ltLjxicj4KJmd0Ozxicj4KJmd0OyBhbmQgbm8gcHJvcGVyIGRvY3VtZW50
YXRpb24gaXMgYXZhaWxhYmxlIGZvciBVU1NEIHN1cHBvcnQgLjxicj4KPGJyPgo8L2Rpdj48L2Rp
dj5Mb29rIGF0IGRvYy9zdXBwbGVtZW50YXJ5c2VydmljZXMtYXBpLnR4dCBmb3IgYSBkZXRhaWxl
ZCBkZXNjcmlwdGlvbiBvZjxicj4KdGhlIEFQSS4gQW5kIHRlc3QvdGVzdC11c3NkIGlzIGFuIGV4
YW1wbGUgaW4gUHl0aG9uIG9uIGhvdyB0byB1c2UgaXQuPGJyPgo8YnI+ClJlZ2FyZHM8YnI+Cjxm
b250IGNvbG9yPSIjODg4ODg4Ij48YnI+Ck1hcmNlbDxicj4KPC9mb250PjxkaXY+PGRpdj48L2Rp
dj48ZGl2IGNsYXNzPSJoNSI+PGJyPgo8YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1h
aWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0
dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5odHRw
Oi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9kaXY+PC9kaXY+PC9i
bG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============2406460815929632202==--


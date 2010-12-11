Content-Type: multipart/mixed; boundary="===============1527638474475764338=="
MIME-Version: 1.0
From: Tonny Tzeng <tonny.tzeng@gmail.com>
Subject: Re: [PATCH] Specify vendor ID for Huawei modem while creating GPRS
 context
Date: Sat, 11 Dec 2010 22:48:29 +0800
Message-ID: <AANLkTikX7KpnQfPKv88NSG3Yt0LXAzYkPr=eE6S2k40X@mail.gmail.com>
In-Reply-To: <4CFDA832.9090309@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1527638474475764338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Dec 7, 2010 at 11:21 AM, Denis Kenzior <denkenz@gmail.com> wrote:
>
> > diff --git a/plugins/huawei.c b/plugins/huawei.c
> > index 25dfaca..32cf70d 100644
> > --- a/plugins/huawei.c
> > +++ b/plugins/huawei.c
> > @@ -454,7 +454,7 @@ static void huawei_disconnect(gpointer user_data)
> >                       data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_C=
S) {
> >               ofono_info("Reopened GPRS context channel");
> >
> > -             data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem=
",
> > +             data->gc =3D ofono_gprs_context_create(modem,
> OFONO_VENDOR_HUAWEI,
> > "atmodem",
> >
> data->modem);
>
> There's no need to pass the vendor flag here.  The atmodem gprs_context
> driver does not have any vendor handling code inside it.
>

But it seems to me the gprs context will be pass to modem plugins, so we
need to set the vendor code for Huawei modems, because it sends unquoted
strings.

For example, please correct me if wrong, when the network registration
status changed, ofono will invoke modem's set_attached() to handle the modem
attach/detach.  Then, in gprs_attach_callback() in src/gprs.c, it will
invokes modem's attached_status() to check the modem state, which has vendor
dependent code in it.  Most importantly, after ofono sending AT+CGREG? to
query the solicited response, the at_cgreg_cb() requires the correct vendor
 ID so that at_util_parse_reg() knows whether the lac and ci are quoted
strings or not?  Did I misunderstand?  Thanks.

Best Regards,
Tonny

--===============1527638474475764338==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVHVlLCBEZWMgNywg
MjAxMCBhdCAxMToyMSBBTSwgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhy
ZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwv
c3Bhbj4gd3JvdGU6PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsi
Pgo8ZGl2IGNsYXNzPSJpbSI+CiZndDsgZGlmZiAtLWdpdCBhL3BsdWdpbnMvaHVhd2VpLmMgYi9w
bHVnaW5zL2h1YXdlaS5jPGJyPgomZ3Q7IGluZGV4IDI1ZGZhY2EuLjMyY2Y3MGQgMTAwNjQ0PGJy
PgomZ3Q7IC0tLSBhL3BsdWdpbnMvaHVhd2VpLmM8YnI+CiZndDsgKysrIGIvcGx1Z2lucy9odWF3
ZWkuYzxicj4KJmd0OyBAQCAtNDU0LDcgKzQ1NCw3IEBAIHN0YXRpYyB2b2lkIGh1YXdlaV9kaXNj
b25uZWN0KGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+CiZndDsgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IGRhdGEtJmd0O3NpbV9zdGF0ZSA9PSBIVUFXRUlfU0lNX1NUQVRFX0lOVkFMSURfQ1MpIHs8YnI+
CiZndDsgoCCgIKAgoCCgIKAgoCBvZm9ub19pbmZvKCZxdW90O1Jlb3BlbmVkIEdQUlMgY29udGV4
dCBjaGFubmVsJnF1b3Q7KTs8YnI+CiZndDs8YnI+CiZndDsgLSCgIKAgoCCgIKAgoCBkYXRhLSZn
dDtnYyA9IG9mb25vX2dwcnNfY29udGV4dF9jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9kZW0m
cXVvdDssPGJyPgomZ3Q7ICsgoCCgIKAgoCCgIKAgZGF0YS0mZ3Q7Z2MgPSBvZm9ub19ncHJzX2Nv
bnRleHRfY3JlYXRlKG1vZGVtLCBPRk9OT19WRU5ET1JfSFVBV0VJLDxicj4KJmd0OyAmcXVvdDth
dG1vZGVtJnF1b3Q7LDxicj4KJmd0OyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGRhdGEtJmd0O21vZGVtKTs8YnI+Cjxicj4KPC9k
aXY+VGhlcmUmIzM5O3Mgbm8gbmVlZCB0byBwYXNzIHRoZSB2ZW5kb3IgZmxhZyBoZXJlLiCgVGhl
IGF0bW9kZW0gZ3Byc19jb250ZXh0PGJyPgpkcml2ZXIgZG9lcyBub3QgaGF2ZSBhbnkgdmVuZG9y
IGhhbmRsaW5nIGNvZGUgaW5zaWRlIGl0Ljxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+
PGRpdj5CdXQgaXQgc2VlbXMgdG8gbWUgdGhlIGdwcnMgY29udGV4dCB3aWxsIGJlIHBhc3MgdG8g
bW9kZW0gcGx1Z2lucywgc28gd2UgbmVlZCB0byBzZXQgdGhlIHZlbmRvciBjb2RlIGZvciBIdWF3
ZWkgbW9kZW1zLCBiZWNhdXNlIGl0IHNlbmRzIHVucXVvdGVkIHN0cmluZ3MuPC9kaXY+CjxkaXY+
PGJyPjwvZGl2PjxkaXY+Rm9yIGV4YW1wbGUsIHBsZWFzZSBjb3JyZWN0IG1lIGlmIHdyb25nLCB3
aGVuIHRoZSBuZXR3b3JrIHJlZ2lzdHJhdGlvbiBzdGF0dXMgY2hhbmdlZCwgb2Zvbm8gd2lsbCBp
bnZva2UgbW9kZW0mIzM5O3Mgc2V0X2F0dGFjaGVkKCkgdG8gaGFuZGxlIHRoZSBtb2RlbSBhdHRh
Y2gvZGV0YWNoLiCgVGhlbiwgaW4gZ3Byc19hdHRhY2hfY2FsbGJhY2soKSBpbiBzcmMvZ3Bycy5j
LCBpdCB3aWxsIGludm9rZXMgbW9kZW0mIzM5O3MgYXR0YWNoZWRfc3RhdHVzKCkgdG8gY2hlY2sg
dGhlIG1vZGVtIHN0YXRlLCB3aGljaCBoYXMgdmVuZG9yIGRlcGVuZGVudCBjb2RlIGluIGl0LiCg
TW9zdCBpbXBvcnRhbnRseSwgYWZ0ZXIgb2Zvbm8gc2VuZGluZyBBVCtDR1JFRz8gdG8gcXVlcnkg
dGhlIHNvbGljaXRlZCByZXNwb25zZSwgdGhlIGF0X2NncmVnX2NiKCkgcmVxdWlyZXMgdGhlIGNv
cnJlY3QgdmVuZG9yIKBJRCBzbyB0aGF0IGF0X3V0aWxfcGFyc2VfcmVnKCkga25vd3Mgd2hldGhl
ciB0aGUgbGFjIGFuZCBjaSBhcmUgcXVvdGVkIHN0cmluZ3Mgb3Igbm90PyCgRGlkIEkgbWlzdW5k
ZXJzdGFuZD8goFRoYW5rcy48L2Rpdj4KPGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IFJlZ2FyZHMs
PC9kaXY+PGRpdj5Ub25ueTwvZGl2PjwvZGl2Pgo=

--===============1527638474475764338==--


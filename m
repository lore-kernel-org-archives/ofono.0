Content-Type: multipart/mixed; boundary="===============8176321695428640636=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Re: [PATCH 1/3] gprs: Add DBus method to reset contexts
Date: Mon, 18 May 2015 19:08:39 +0200
Message-ID: <CACM4vuBtPd+1rBCoj2qaFR76V8bd6mV9k8XjeeJrjB_x5W-AMQ@mail.gmail.com>
In-Reply-To: <5559F292.4000604@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8176321695428640636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2015 at 4:09 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> On 05/18/2015 01:53 AM, Alfonso Sanchez-Beato wrote:
>
>> Hi Denis,
>>
>>
> <snip>
>
>
>          +
>>         +       for (l =3D gprs->contexts; l; l =3D l->next) {
>>         +               struct pri_context *ctx =3D l->data;
>>         +
>>         +               if (ctx->pending)
>>         +                       return __ofono_error_busy(msg);
>>         +       }
>>         +
>>         +       if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
>>         +               return __ofono_error_invalid_args(msg);
>>         +
>>         +       if (gprs->powered)
>>         +               return __ofono_error_not_allowed(msg);
>>         +
>>         +       for (l =3D gprs->contexts; l; l =3D l->next) {
>>         +               struct pri_context *ctx =3D l->data;
>>         +
>>         +               if (ctx->active)
>>         +                       return __ofono_error_not_allowed(msg);
>>
>>
>>     Is there a particular reason you're running through the list of
>>     contexts again here?  Why not check for ctx->active at the same time
>>     as ctx->pending?
>>
>>
>> I wanted to make sure that __ofono_error_busy was returned before
>> __ofono_error_not_allowed if one context was busy and another one was
>> active, for instance. Not that I feel is really important and I can
>> change this if the other way is preferred.
>>
>>
> Makes sense.  However, since this is not obvious, we probably should add a
> comment as to why this is being done.  Want to submit a patch or do you
> want me to do this?
>

Submitted.

Br,
Alfonso


>
> Regards,
> -Denis
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============8176321695428640636==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgTWF5IDE4LCAyMDE1IGF0IDQ6MDkgUE0sIERlbmlzIEtl
bnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5j
b20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90
ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAw
IC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+T24gMDUv
MTgvMjAxNSAwMTo1MyBBTSwgQWxmb25zbyBTYW5jaGV6LUJlYXRvIHdyb3RlOjxicj4KPGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CkhpIERlbmlzLDxicj4KPGJy
Pgo8L2Jsb2NrcXVvdGU+Cjxicj4KJmx0O3NuaXAmZ3Q7PGRpdj48ZGl2IGNsYXNzPSJoNSI+PGJy
Pgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAg
MCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgrCoCDC
oCDCoCDCoCArPGJyPgrCoCDCoCDCoCDCoCArwqAgwqAgwqAgwqBmb3IgKGwgPSBncHJzLSZndDtj
b250ZXh0czsgbDsgbCA9IGwtJmd0O25leHQpIHs8YnI+CsKgIMKgIMKgIMKgICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHN0cnVjdCBwcmlfY29udGV4dCAqY3R4ID0gbC0mZ3Q7ZGF0YTs8YnI+CsKg
IMKgIMKgIMKgICs8YnI+CsKgIMKgIMKgIMKgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChj
dHgtJmd0O3BlbmRpbmcpPGJyPgrCoCDCoCDCoCDCoCArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gX19vZm9ub19lcnJvcl9idXN5KG1zZyk7PGJyPgrCoCDCoCDCoCDC
oCArwqAgwqAgwqAgwqB9PGJyPgrCoCDCoCDCoCDCoCArPGJyPgrCoCDCoCDCoCDCoCArwqAgwqAg
wqAgwqBpZiAoIWRidXNfbWVzc2FnZV9nZXRfYXJncyhtc2csIE5VTEwsIERCVVNfVFlQRV9JTlZB
TElEKSk8YnI+CsKgIMKgIMKgIMKgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBfX29m
b25vX2Vycm9yX2ludmFsaWRfYXJncyhtc2cpOzxicj4KwqAgwqAgwqAgwqAgKzxicj4KwqAgwqAg
wqAgwqAgK8KgIMKgIMKgIMKgaWYgKGdwcnMtJmd0O3Bvd2VyZWQpPGJyPgrCoCDCoCDCoCDCoCAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gX19vZm9ub19lcnJvcl9ub3RfYWxsb3dlZCht
c2cpOzxicj4KwqAgwqAgwqAgwqAgKzxicj4KwqAgwqAgwqAgwqAgK8KgIMKgIMKgIMKgZm9yIChs
ID0gZ3Bycy0mZ3Q7Y29udGV4dHM7IGw7IGwgPSBsLSZndDtuZXh0KSB7PGJyPgrCoCDCoCDCoCDC
oCArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgcHJpX2NvbnRleHQgKmN0eCA9IGwtJmd0
O2RhdGE7PGJyPgrCoCDCoCDCoCDCoCArPGJyPgrCoCDCoCDCoCDCoCArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAoY3R4LSZndDthY3RpdmUpPGJyPgrCoCDCoCDCoCDCoCArwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gX19vZm9ub19lcnJvcl9ub3RfYWxsb3dlZCht
c2cpOzxicj4KPGJyPgo8YnI+CsKgIMKgIElzIHRoZXJlIGEgcGFydGljdWxhciByZWFzb24geW91
JiMzOTtyZSBydW5uaW5nIHRocm91Z2ggdGhlIGxpc3Qgb2Y8YnI+CsKgIMKgIGNvbnRleHRzIGFn
YWluIGhlcmU/wqAgV2h5IG5vdCBjaGVjayBmb3IgY3R4LSZndDthY3RpdmUgYXQgdGhlIHNhbWUg
dGltZTxicj4KwqAgwqAgYXMgY3R4LSZndDtwZW5kaW5nPzxicj4KPGJyPgo8YnI+Ckkgd2FudGVk
IHRvIG1ha2Ugc3VyZSB0aGF0IF9fb2Zvbm9fZXJyb3JfYnVzeSB3YXMgcmV0dXJuZWQgYmVmb3Jl
PGJyPgpfX29mb25vX2Vycm9yX25vdF9hbGxvd2VkIGlmIG9uZSBjb250ZXh0IHdhcyBidXN5IGFu
ZCBhbm90aGVyIG9uZSB3YXM8YnI+CmFjdGl2ZSwgZm9yIGluc3RhbmNlLiBOb3QgdGhhdCBJIGZl
ZWwgaXMgcmVhbGx5IGltcG9ydGFudCBhbmQgSSBjYW48YnI+CmNoYW5nZSB0aGlzIGlmIHRoZSBv
dGhlciB3YXkgaXMgcHJlZmVycmVkLjxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L2Rpdj48
L2Rpdj4KTWFrZXMgc2Vuc2UuwqAgSG93ZXZlciwgc2luY2UgdGhpcyBpcyBub3Qgb2J2aW91cywg
d2UgcHJvYmFibHkgc2hvdWxkIGFkZCBhIGNvbW1lbnQgYXMgdG8gd2h5IHRoaXMgaXMgYmVpbmcg
ZG9uZS7CoCBXYW50IHRvIHN1Ym1pdCBhIHBhdGNoIG9yIGRvIHlvdSB3YW50IG1lIHRvIGRvIHRo
aXM/PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlN1Ym1pdHRlZC48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PkJyLDwvZGl2PjxkaXY+QWxmb25zbzwvZGl2PjxkaXY+wqA8L2Rp
dj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhl
eDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgpSZWdh
cmRzLDxicj4KLURlbmlzPGRpdiBjbGFzcz0iSE9FblpiIj48ZGl2IGNsYXNzPSJoNSI+PGJyPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8g
bWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9
Il9ibGFuayI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5v
Zm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8v
bGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8L2Rpdj48L2Rp
dj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2PjwvZGl2Pgo=

--===============8176321695428640636==--


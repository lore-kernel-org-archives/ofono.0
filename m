Content-Type: multipart/mixed; boundary="===============7986350335704188301=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: Telit ME910C1-WW not detected
Date: Wed, 02 Oct 2019 15:31:48 +0100
Message-ID: <CABPh3UOGOtswXp-mY_2wPW0OgirGq9Td9V3HyU1WWvC-AXdpkw@mail.gmail.com>
In-Reply-To: <CAPS-YPDsAJJYr_awqBOp=BBPcJ-Z-zW5g2Zcxp3yMe8n3X=Wqg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7986350335704188301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks

do you think that you can submit it to ofono mailing list?

in particular I don;t know if

if (data->model =3D=3D ME910C1)
ofono_netreg_create(modem, OFONO_VENDOR_TELIT_ME910C1, "atmodem",
data->chat);
else
ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);

is acceptable

Cheers
Nicola Lunghi


On Wed, 2 Oct 2019 at 15:29, Anibal Lim=C3=B3n <limon.anibal@gmail.com> w=
rote:

>
>
> On Wed, Oct 2, 2019 at 9:00 AM nick83ola <nick83ola@gmail.com> wrote:
>
>> Hi Anibal,
>> I'm interested as well in the patch
>>
>> I saw that there you have two branches (me910 and v1.30+me910) can you
>> tell me what branch have you tested?
>> the diff is this
>>
>
> Yeah the latest one is me910, I was making a mistake to enable GPRS
> instead of disable it, that's the change.
>
> Anibal
>
>
>>
>> git diff me910
>> diff --git a/plugins/telit.c b/plugins/telit.c
>> index f36995dc..50344281 100644
>> --- a/plugins/telit.c
>> +++ b/plugins/telit.c
>> @@ -239,16 +239,19 @@ static void cfun_enable_cb(gboolean ok, GAtResult
>> *result, gpointer user_data)
>>
>>         ofono_modem_set_powered(modem, TRUE);
>>
>> -       /*
>> -        * Tell the modem not to automatically initiate auto-attach
>> -        * proceedures on its own.
>> -        */
>> -       if (data->model =3D=3D ME910C1)
>> -               g_at_chat_send(data->chat, "AT+CGATT=3D0", NULL, NULL,
>> NULL, NULL);
>> -       else
>> -
>> +       if (data->model =3D=3D ME910C1) {
>> +               /*
>> +                * Telit ME910C1 needs to activate the GPRS to
>> auto-attach the network.
>> +                */
>> +               g_at_chat_send(data->chat, "AT+CGATT=3D1", NULL, NULL,
>> NULL, NULL);
>> +       } else {
>> +               /*
>> +                * Tell the modem not to automatically initiate
>> auto-attach
>> +                * proceedures on its own.
>> +                */
>>                 g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
>>                                         NULL, NULL, NULL);
>> +       }
>>
>>         /* Follow sim state */
>>         g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
>>
>>
>> Thanks
>> Nicola Lunghi
>>
>>
>> On Tue, 1 Oct 2019 at 22:54, <limon.anibal@gmail.com> wrote:
>>
>>> Hi Dresdo,
>>>
>>> I have a patch that adds support for Telit ME910 but it is upon Ofono
>>> 1.30, i plan to send for review.
>>>
>>>
>>> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec8ac=
1deeda5c
>>>
>>> Regards!,
>>> Anibal
>>> _______________________________________________
>>> ofono mailing list -- ofono(a)ofono.org
>>> To unsubscribe send an email to ofono-leave(a)ofono.org
>>>
>>

--===============7986350335704188301==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5UaGFua3M8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmRvIHlv
dSB0aGluayB0aGF0IHlvdSBjYW4gc3VibWl0IGl0IHRvIG9mb25vIG1haWxpbmcgbGlzdD88L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PmluIHBhcnRpY3VsYXIgSSBkb247dCBrbm93IGlmPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5pZiAoZGF0YS0mZ3Q7bW9kZWwgPT0gTUU5MTBDMSk8YnI+CQlv
Zm9ub19uZXRyZWdfY3JlYXRlKG1vZGVtLCBPRk9OT19WRU5ET1JfVEVMSVRfTUU5MTBDMSwgJnF1
b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7Y2hhdCk7PGJyPgllbHNlPGJyPgkJb2Zvbm9fbmV0
cmVnX2NyZWF0ZShtb2RlbSwgT0ZPTk9fVkVORE9SX1RFTElULCAmcXVvdDthdG1vZGVtJnF1b3Q7
LCBkYXRhLSZndDtjaGF0KTs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmlzIGFjY2VwdGFibGU8
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkNoZWVyczwvZGl2PjxkaXY+Tmljb2xhIEx1bmdoaTwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRp
diBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwgMiBPY3QgMjAxOSBhdCAxNToy
OSwgQW5pYmFsIExpbcOzbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmxpbW9uLmFuaWJhbEBnbWFpbC5j
b20iPmxpbW9uLmFuaWJhbEBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4
O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgi
PjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxicj48L2Rpdj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBXZWQsIE9j
dCAyLCAyMDE5IGF0IDk6MDAgQU0gbmljazgzb2xhICZsdDs8YSBocmVmPSJtYWlsdG86bmljazgz
b2xhQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm5pY2s4M29sYUBnbWFpbC5jb208L2E+Jmd0
OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIw
NCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXY+SGkgQW5pYmFsLDwv
ZGl2PjxkaXY+SSYjMzk7bSBpbnRlcmVzdGVkIGFzIHdlbGwgaW4gdGhlIHBhdGNoPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5JIHNhdyB0aGF0IHRoZXJlIHlvdSBoYXZlIHR3byBicmFuY2hlcyAo
bWU5MTAgYW5kIHYxLjMwK21lOTEwKSBjYW4geW91IHRlbGwgbWUgd2hhdCBicmFuY2ggaGF2ZSB5
b3UgdGVzdGVkPzwvZGl2PjxkaXY+dGhlIGRpZmYgaXMgdGhpczwvZGl2PjwvZGl2PjwvYmxvY2tx
dW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlllYWggdGhlIGxhdGVzdCBvbmUgaXMgbWU5MTAsIEkg
d2FzIG1ha2luZyBhIG1pc3Rha2UgdG8gZW5hYmxlIEdQUlMgaW5zdGVhZCBvZiBkaXNhYmxlIGl0
LCB0aGF0JiMzOTtzIHRoZSBjaGFuZ2UuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbmliYWw8
L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIw
NCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXY+PGJyPjwvZGl2Pjxk
aXY+Z2l0IGRpZmYgbWU5MTA8YnI+ZGlmZiAtLWdpdCBhL3BsdWdpbnMvdGVsaXQuYyBiL3BsdWdp
bnMvdGVsaXQuYzxicj5pbmRleCBmMzY5OTVkYy4uNTAzNDQyODEgMTAwNjQ0PGJyPi0tLSBhL3Bs
dWdpbnMvdGVsaXQuYzxicj4rKysgYi9wbHVnaW5zL3RlbGl0LmM8YnI+QEAgLTIzOSwxNiArMjM5
LDE5IEBAIHN0YXRpYyB2b2lkIGNmdW5fZW5hYmxlX2NiKGdib29sZWFuIG9rLCBHQXRSZXN1bHQg
KnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKTxicj7CoDxicj7CoCDCoCDCoCDCoCBvZm9ub19t
b2RlbV9zZXRfcG93ZXJlZChtb2RlbSwgVFJVRSk7PGJyPsKgPGJyPi0gwqAgwqAgwqAgLyo8YnI+
LSDCoCDCoCDCoCDCoCogVGVsbCB0aGUgbW9kZW0gbm90IHRvIGF1dG9tYXRpY2FsbHkgaW5pdGlh
dGUgYXV0by1hdHRhY2g8YnI+LSDCoCDCoCDCoCDCoCogcHJvY2VlZHVyZXMgb24gaXRzIG93bi48
YnI+LSDCoCDCoCDCoCDCoCovPGJyPi0gwqAgwqAgwqAgaWYgKGRhdGEtJmd0O21vZGVsID09IE1F
OTEwQzEpPGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7
Y2hhdCwgJnF1b3Q7QVQrQ0dBVFQ9MCZxdW90OywgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCk7PGJy
Pi0gwqAgwqAgwqAgZWxzZTxicj4tPGJyPisgwqAgwqAgwqAgaWYgKGRhdGEtJmd0O21vZGVsID09
IE1FOTEwQzEpIHs8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKjxicj4rIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgKiBUZWxpdCBNRTkxMEMxIG5lZWRzIHRvIGFjdGl2YXRlIHRoZSBHUFJTIHRv
IGF1dG8tYXR0YWNoIHRoZSBuZXR3b3JrLjxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKi88
YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDtjaGF0LCAm
cXVvdDtBVCtDR0FUVD0xJnF1b3Q7LCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMKTs8YnI+KyDCoCDC
oCDCoCB9IGVsc2Ugezxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qPGJyPisgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAqIFRlbGwgdGhlIG1vZGVtIG5vdCB0byBhdXRvbWF0aWNhbGx5IGluaXRp
YXRlIGF1dG8tYXR0YWNoPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIHByb2NlZWR1cmVz
IG9uIGl0cyBvd24uPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqLzxicj7CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDtjaGF0LCAmcXVvdDtBVCNBVVRP
QVRUPTAmcXVvdDssIG5vbmVfcHJlZml4LDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBOVUxMLCBOVUxMKTs8YnI+KyDC
oCDCoCDCoCB9PGJyPsKgPGJyPsKgIMKgIMKgIMKgIC8qIEZvbGxvdyBzaW0gc3RhdGUgKi88YnI+
wqAgwqAgwqAgwqAgZ19hdF9jaGF0X3JlZ2lzdGVyKGRhdGEtJmd0O2NoYXQsICZxdW90OyNRU1M6
JnF1b3Q7LCB0ZWxpdF9xc3Nfbm90aWZ5LDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+VGhhbmtzPC9kaXY+PGRpdj5OaWNvbGEgTHVuZ2hpPGJyPjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIg
Y2xhc3M9ImdtYWlsX2F0dHIiPk9uIFR1ZSwgMSBPY3QgMjAxOSBhdCAyMjo1NCwgJmx0OzxhIGhy
ZWY9Im1haWx0bzpsaW1vbi5hbmliYWxAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bGltb24u
YW5pYmFsQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxl
ZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+SGkgRHJlc2Rv
LDxicj4KPGJyPgpJIGhhdmUgYSBwYXRjaCB0aGF0IGFkZHMgc3VwcG9ydCBmb3IgVGVsaXQgTUU5
MTAgYnV0IGl0IGlzIHVwb24gT2Zvbm8gMS4zMCwgaSBwbGFuIHRvIHNlbmQgZm9yIHJldmlldy48
YnI+Cjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL2FsaW1vbi9vZm9uby9jb21taXQv
OTIwNzEyZTE4NGZmYWYxMTQzZTljZTEzYzNiZWM4YWMxZGVlZGE1YyIgcmVsPSJub3JlZmVycmVy
IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL2FsaW1vbi9vZm9uby9jb21taXQv
OTIwNzEyZTE4NGZmYWYxMTQzZTljZTEzYzNiZWM4YWMxZGVlZGE1YzwvYT48YnI+Cjxicj4KUmVn
YXJkcyEsPGJyPgpBbmliYWw8YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3QgLS0gPGEgaHJlZj0ibWFpbHRvOm9m
b25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9mb25vLm9yZzwvYT48YnI+ClRv
IHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gPGEgaHJlZj0ibWFpbHRvOm9mb25vLWxlYXZl
QG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vLWxlYXZlQG9mb25vLm9yZzwvYT48YnI+
CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pgo8L2Jsb2NrcXVv
dGU+PC9kaXY+Cg==

--===============7986350335704188301==--


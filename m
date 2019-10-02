Content-Type: multipart/mixed; boundary="===============2675363064084303184=="
MIME-Version: 1.0
From: Anibal =?unknown-8bit?q?Lim=C3=B3n?= <limon.anibal@gmail.com>
Subject: Re: Telit ME910C1-WW not detected
Date: Wed, 02 Oct 2019 09:32:25 -0500
Message-ID: <CAPS-YPDsAJJYr_awqBOp=BBPcJ-Z-zW5g2Zcxp3yMe8n3X=Wqg@mail.gmail.com>
In-Reply-To: <CABPh3UMAoOOy6f9zdBNmnaus5BFgtJBGc3v9R-q=QWFdnm00pw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2675363064084303184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2019 at 9:00 AM nick83ola <nick83ola@gmail.com> wrote:

> Hi Anibal,
> I'm interested as well in the patch
>
> I saw that there you have two branches (me910 and v1.30+me910) can you
> tell me what branch have you tested?
> the diff is this
>

Yeah the latest one is me910, I was making a mistake to enable GPRS instead
of disable it, that's the change.

Anibal


>
> git diff me910
> diff --git a/plugins/telit.c b/plugins/telit.c
> index f36995dc..50344281 100644
> --- a/plugins/telit.c
> +++ b/plugins/telit.c
> @@ -239,16 +239,19 @@ static void cfun_enable_cb(gboolean ok, GAtResult
> *result, gpointer user_data)
>
>         ofono_modem_set_powered(modem, TRUE);
>
> -       /*
> -        * Tell the modem not to automatically initiate auto-attach
> -        * proceedures on its own.
> -        */
> -       if (data->model =3D=3D ME910C1)
> -               g_at_chat_send(data->chat, "AT+CGATT=3D0", NULL, NULL, NU=
LL,
> NULL);
> -       else
> -
> +       if (data->model =3D=3D ME910C1) {
> +               /*
> +                * Telit ME910C1 needs to activate the GPRS to auto-attach
> the network.
> +                */
> +               g_at_chat_send(data->chat, "AT+CGATT=3D1", NULL, NULL, NU=
LL,
> NULL);
> +       } else {
> +               /*
> +                * Tell the modem not to automatically initiate auto-atta=
ch
> +                * proceedures on its own.
> +                */
>                 g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
>                                         NULL, NULL, NULL);
> +       }
>
>         /* Follow sim state */
>         g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
>
>
> Thanks
> Nicola Lunghi
>
>
> On Tue, 1 Oct 2019 at 22:54, <limon.anibal@gmail.com> wrote:
>
>> Hi Dresdo,
>>
>> I have a patch that adds support for Telit ME910 but it is upon Ofono
>> 1.30, i plan to send for review.
>>
>>
>> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec8ac1=
deeda5c
>>
>> Regards!,
>> Anibal
>> _______________________________________________
>> ofono mailing list -- ofono(a)ofono.org
>> To unsubscribe send an email to ofono-leave(a)ofono.org
>>
>

--===============2675363064084303184==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwgT2N0
IDIsIDIwMTkgYXQgOTowMCBBTSBuaWNrODNvbGEgJmx0OzxhIGhyZWY9Im1haWx0bzpuaWNrODNv
bGFAZ21haWwuY29tIj5uaWNrODNvbGFAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBw
eCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxl
ZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2PkhpIEFuaWJhbCw8L2Rpdj48ZGl2PkkmIzM5O20g
aW50ZXJlc3RlZCBhcyB3ZWxsIGluIHRoZSBwYXRjaDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
SSBzYXcgdGhhdCB0aGVyZSB5b3UgaGF2ZSB0d28gYnJhbmNoZXMgKG1lOTEwIGFuZCB2MS4zMCtt
ZTkxMCkgY2FuIHlvdSB0ZWxsIG1lIHdoYXQgYnJhbmNoIGhhdmUgeW91IHRlc3RlZD88L2Rpdj48
ZGl2PnRoZSBkaWZmIGlzIHRoaXM8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9k
aXY+PGRpdj5ZZWFoIHRoZSBsYXRlc3Qgb25lIGlzIG1lOTEwLCBJIHdhcyBtYWtpbmcgYSBtaXN0
YWtlIHRvIGVuYWJsZSBHUFJTIGluc3RlYWQgb2YgZGlzYWJsZSBpdCwgdGhhdCYjMzk7cyB0aGUg
Y2hhbmdlLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QW5pYmFsPC9kaXY+PGRpdj7CoDwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBw
eCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxl
ZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2Pjxicj48L2Rpdj48ZGl2PmdpdCBkaWZmIG1lOTEw
PGJyPmRpZmYgLS1naXQgYS9wbHVnaW5zL3RlbGl0LmMgYi9wbHVnaW5zL3RlbGl0LmM8YnI+aW5k
ZXggZjM2OTk1ZGMuLjUwMzQ0MjgxIDEwMDY0NDxicj4tLS0gYS9wbHVnaW5zL3RlbGl0LmM8YnI+
KysrIGIvcGx1Z2lucy90ZWxpdC5jPGJyPkBAIC0yMzksMTYgKzIzOSwxOSBAQCBzdGF0aWMgdm9p
ZCBjZnVuX2VuYWJsZV9jYihnYm9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVy
IHVzZXJfZGF0YSk8YnI+wqA8YnI+wqAgwqAgwqAgwqAgb2Zvbm9fbW9kZW1fc2V0X3Bvd2VyZWQo
bW9kZW0sIFRSVUUpOzxicj7CoDxicj4tIMKgIMKgIMKgIC8qPGJyPi0gwqAgwqAgwqAgwqAqIFRl
bGwgdGhlIG1vZGVtIG5vdCB0byBhdXRvbWF0aWNhbGx5IGluaXRpYXRlIGF1dG8tYXR0YWNoPGJy
Pi0gwqAgwqAgwqAgwqAqIHByb2NlZWR1cmVzIG9uIGl0cyBvd24uPGJyPi0gwqAgwqAgwqAgwqAq
Lzxicj4tIMKgIMKgIMKgIGlmIChkYXRhLSZndDttb2RlbCA9PSBNRTkxMEMxKTxicj4tIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2NoYXQsICZxdW90O0FUK0NH
QVRUPTAmcXVvdDssIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwpOzxicj4tIMKgIMKgIMKgIGVsc2U8
YnI+LTxicj4rIMKgIMKgIMKgIGlmIChkYXRhLSZndDttb2RlbCA9PSBNRTkxMEMxKSB7PGJyPisg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgLyo8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogVGVs
aXQgTUU5MTBDMSBuZWVkcyB0byBhY3RpdmF0ZSB0aGUgR1BSUyB0byBhdXRvLWF0dGFjaCB0aGUg
bmV0d29yay48YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCovPGJyPisgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7QVQrQ0dBVFQ9MSZx
dW90OywgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCk7PGJyPisgwqAgwqAgwqAgfSBlbHNlIHs8YnI+
KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKjxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBU
ZWxsIHRoZSBtb2RlbSBub3QgdG8gYXV0b21hdGljYWxseSBpbml0aWF0ZSBhdXRvLWF0dGFjaDxi
cj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBwcm9jZWVkdXJlcyBvbiBpdHMgb3duLjxicj4r
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKi88YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ19h
dF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7QVQjQVVUT0FUVD0wJnF1b3Q7LCBub25l
X3ByZWZpeCw8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgTlVMTCwgTlVMTCwgTlVMTCk7PGJyPisgwqAgwqAgwqAgfTxicj7CoDxi
cj7CoCDCoCDCoCDCoCAvKiBGb2xsb3cgc2ltIHN0YXRlICovPGJyPsKgIMKgIMKgIMKgIGdfYXRf
Y2hhdF9yZWdpc3RlcihkYXRhLSZndDtjaGF0LCAmcXVvdDsjUVNTOiZxdW90OywgdGVsaXRfcXNz
X25vdGlmeSw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rczwv
ZGl2PjxkaXY+Tmljb2xhIEx1bmdoaTxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48YnI+
PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRy
Ij5PbiBUdWUsIDEgT2N0IDIwMTkgYXQgMjI6NTQsICZsdDs8YSBocmVmPSJtYWlsdG86bGltb24u
YW5pYmFsQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmxpbW9uLmFuaWJhbEBnbWFpbC5jb208
L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkhpIERyZXNkbyw8YnI+Cjxicj4KSSBoYXZl
IGEgcGF0Y2ggdGhhdCBhZGRzIHN1cHBvcnQgZm9yIFRlbGl0IE1FOTEwIGJ1dCBpdCBpcyB1cG9u
IE9mb25vIDEuMzAsIGkgcGxhbiB0byBzZW5kIGZvciByZXZpZXcuPGJyPgo8YnI+CjxhIGhyZWY9
Imh0dHBzOi8vZ2l0aHViLmNvbS9hbGltb24vb2Zvbm8vY29tbWl0LzkyMDcxMmUxODRmZmFmMTE0
M2U5Y2UxM2MzYmVjOGFjMWRlZWRhNWMiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsi
Pmh0dHBzOi8vZ2l0aHViLmNvbS9hbGltb24vb2Zvbm8vY29tbWl0LzkyMDcxMmUxODRmZmFmMTE0
M2U5Y2UxM2MzYmVjOGFjMWRlZWRhNWM8L2E+PGJyPgo8YnI+ClJlZ2FyZHMhLDxicj4KQW5pYmFs
PGJyPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4K
b2Zvbm8gbWFpbGluZyBsaXN0IC0tIDxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHRh
cmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgpUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIDxhIGhyZWY9Im1haWx0bzpvZm9uby1sZWF2ZUBvZm9uby5vcmciIHRhcmdl
dD0iX2JsYW5rIj5vZm9uby1sZWF2ZUBvZm9uby5vcmc8L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9k
aXY+CjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4K

--===============2675363064084303184==--


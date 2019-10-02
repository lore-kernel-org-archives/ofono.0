Content-Type: multipart/mixed; boundary="===============5500774066077125158=="
MIME-Version: 1.0
From: Anibal =?unknown-8bit?q?Lim=C3=B3n?= <limon.anibal@gmail.com>
Subject: Re: Telit ME910C1-WW not detected
Date: Wed, 02 Oct 2019 09:39:27 -0500
Message-ID: <CAPS-YPASaqxw0aD7LBmwmqfASyq4nQhc6B7dsgKLF-L1cf571w@mail.gmail.com>
In-Reply-To: <CABPh3UOGOtswXp-mY_2wPW0OgirGq9Td9V3HyU1WWvC-AXdpkw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5500774066077125158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2019 at 9:32 AM nick83ola <nick83ola@gmail.com> wrote:

> Thanks
>
> do you think that you can submit it to ofono mailing list?
>
> in particular I don;t know if
>
> if (data->model =3D=3D ME910C1)
> ofono_netreg_create(modem, OFONO_VENDOR_TELIT_ME910C1, "atmodem",
> data->chat);
> else
> ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
>

That's because this specific model dosen't support  signal strength
reporting via CIND.

https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec8ac1dee=
da5c#diff-2bbda16023120e26f58cfa7335520fb4

Anibal


>
> is acceptable
>
> Cheers
> Nicola Lunghi
>
>
> On Wed, 2 Oct 2019 at 15:29, Anibal Lim=C3=B3n <limon.anibal@gmail.com>=
 wrote:
>
>>
>>
>> On Wed, Oct 2, 2019 at 9:00 AM nick83ola <nick83ola@gmail.com> wrote:
>>
>>> Hi Anibal,
>>> I'm interested as well in the patch
>>>
>>> I saw that there you have two branches (me910 and v1.30+me910) can you
>>> tell me what branch have you tested?
>>> the diff is this
>>>
>>
>> Yeah the latest one is me910, I was making a mistake to enable GPRS
>> instead of disable it, that's the change.
>>
>> Anibal
>>
>>
>>>
>>> git diff me910
>>> diff --git a/plugins/telit.c b/plugins/telit.c
>>> index f36995dc..50344281 100644
>>> --- a/plugins/telit.c
>>> +++ b/plugins/telit.c
>>> @@ -239,16 +239,19 @@ static void cfun_enable_cb(gboolean ok, GAtResult
>>> *result, gpointer user_data)
>>>
>>>         ofono_modem_set_powered(modem, TRUE);
>>>
>>> -       /*
>>> -        * Tell the modem not to automatically initiate auto-attach
>>> -        * proceedures on its own.
>>> -        */
>>> -       if (data->model =3D=3D ME910C1)
>>> -               g_at_chat_send(data->chat, "AT+CGATT=3D0", NULL, NULL,
>>> NULL, NULL);
>>> -       else
>>> -
>>> +       if (data->model =3D=3D ME910C1) {
>>> +               /*
>>> +                * Telit ME910C1 needs to activate the GPRS to
>>> auto-attach the network.
>>> +                */
>>> +               g_at_chat_send(data->chat, "AT+CGATT=3D1", NULL, NULL,
>>> NULL, NULL);
>>> +       } else {
>>> +               /*
>>> +                * Tell the modem not to automatically initiate
>>> auto-attach
>>> +                * proceedures on its own.
>>> +                */
>>>                 g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefi=
x,
>>>                                         NULL, NULL, NULL);
>>> +       }
>>>
>>>         /* Follow sim state */
>>>         g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
>>>
>>>
>>> Thanks
>>> Nicola Lunghi
>>>
>>>
>>> On Tue, 1 Oct 2019 at 22:54, <limon.anibal@gmail.com> wrote:
>>>
>>>> Hi Dresdo,
>>>>
>>>> I have a patch that adds support for Telit ME910 but it is upon Ofono
>>>> 1.30, i plan to send for review.
>>>>
>>>>
>>>> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec8a=
c1deeda5c
>>>>
>>>> Regards!,
>>>> Anibal
>>>> _______________________________________________
>>>> ofono mailing list -- ofono(a)ofono.org
>>>> To unsubscribe send an email to ofono-leave(a)ofono.org
>>>>
>>>

--===============5500774066077125158==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwgT2N0
IDIsIDIwMTkgYXQgOTozMiBBTSBuaWNrODNvbGEgJmx0OzxhIGhyZWY9Im1haWx0bzpuaWNrODNv
bGFAZ21haWwuY29tIj5uaWNrODNvbGFAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBw
eCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxl
ZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2PlRoYW5rczwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+ZG8geW91IHRoaW5rIHRoYXQgeW91IGNhbiBzdWJtaXQgaXQgdG8gb2Zvbm8gbWFpbGluZyBs
aXN0PzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+aW4gcGFydGljdWxhciBJIGRvbjt0IGtub3cg
aWY8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmlmIChkYXRhLSZndDttb2RlbCA9PSBNRTkxMEMx
KTxicj4JCW9mb25vX25ldHJlZ19jcmVhdGUobW9kZW0sIE9GT05PX1ZFTkRPUl9URUxJVF9NRTkx
MEMxLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtjaGF0KTs8YnI+CWVsc2U8YnI+CQlv
Zm9ub19uZXRyZWdfY3JlYXRlKG1vZGVtLCBPRk9OT19WRU5ET1JfVEVMSVQsICZxdW90O2F0bW9k
ZW0mcXVvdDssIGRhdGEtJmd0O2NoYXQpOzwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2PlRoYXQmIzM5O3MgYmVjYXVzZSB0aGlzIHNwZWNpZmljIG1vZGVsIGRvc2Vu
JiMzOTt0IHN1cHBvcnTCoCBzaWduYWwgc3RyZW5ndGggcmVwb3J0aW5nIHZpYSBDSU5ELjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+PC9kaXY+PGRpdj48YSBocmVmPSJodHRwczovL2dpdGh1Yi5j
b20vYWxpbW9uL29mb25vL2NvbW1pdC85MjA3MTJlMTg0ZmZhZjExNDNlOWNlMTNjM2JlYzhhYzFk
ZWVkYTVjI2RpZmYtMmJiZGExNjAyMzEyMGUyNmY1OGNmYTczMzU1MjBmYjQiPmh0dHBzOi8vZ2l0
aHViLmNvbS9hbGltb24vb2Zvbm8vY29tbWl0LzkyMDcxMmUxODRmZmFmMTE0M2U5Y2UxM2MzYmVj
OGFjMWRlZWRhNWMjZGlmZi0yYmJkYTE2MDIzMTIwZTI2ZjU4Y2ZhNzMzNTUyMGZiNDwvYT48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFuaWJhbDwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRp
diBkaXI9Imx0ciI+PGRpdj48YnI+PC9kaXY+PGRpdj5pcyBhY2NlcHRhYmxlPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5DaGVlcnM8L2Rpdj48ZGl2Pk5pY29sYSBMdW5naGk8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIi
IGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBXZWQsIDIgT2N0IDIwMTkgYXQgMTU6MjksIEFuaWJhbCBM
aW3Ds24gJmx0OzxhIGhyZWY9Im1haWx0bzpsaW1vbi5hbmliYWxAZ21haWwuY29tIiB0YXJnZXQ9
Il9ibGFuayI+bGltb24uYW5pYmFsQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHgg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0
OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNs
YXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdl
ZCwgT2N0IDIsIDIwMTkgYXQgOTowMCBBTSBuaWNrODNvbGEgJmx0OzxhIGhyZWY9Im1haWx0bzpu
aWNrODNvbGFAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bmljazgzb2xhQGdtYWlsLmNvbTwv
YT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigy
MDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBBbmli
YWwsPC9kaXY+PGRpdj5JJiMzOTttIGludGVyZXN0ZWQgYXMgd2VsbCBpbiB0aGUgcGF0Y2g8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgc2F3IHRoYXQgdGhlcmUgeW91IGhhdmUgdHdvIGJyYW5j
aGVzIChtZTkxMCBhbmQgdjEuMzArbWU5MTApIGNhbiB5b3UgdGVsbCBtZSB3aGF0IGJyYW5jaCBo
YXZlIHlvdSB0ZXN0ZWQ/PC9kaXY+PGRpdj50aGUgZGlmZiBpcyB0aGlzPC9kaXY+PC9kaXY+PC9i
bG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+WWVhaCB0aGUgbGF0ZXN0IG9uZSBpcyBtZTkx
MCwgSSB3YXMgbWFraW5nIGEgbWlzdGFrZSB0byBlbmFibGUgR1BSUyBpbnN0ZWFkIG9mIGRpc2Fi
bGUgaXQsIHRoYXQmIzM5O3MgdGhlIGNoYW5nZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFu
aWJhbDwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigy
MDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj48YnI+PC9k
aXY+PGRpdj5naXQgZGlmZiBtZTkxMDxicj5kaWZmIC0tZ2l0IGEvcGx1Z2lucy90ZWxpdC5jIGIv
cGx1Z2lucy90ZWxpdC5jPGJyPmluZGV4IGYzNjk5NWRjLi41MDM0NDI4MSAxMDA2NDQ8YnI+LS0t
IGEvcGx1Z2lucy90ZWxpdC5jPGJyPisrKyBiL3BsdWdpbnMvdGVsaXQuYzxicj5AQCAtMjM5LDE2
ICsyMzksMTkgQEAgc3RhdGljIHZvaWQgY2Z1bl9lbmFibGVfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJl
c3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2RhdGEpPGJyPsKgPGJyPsKgIMKgIMKgIMKgIG9m
b25vX21vZGVtX3NldF9wb3dlcmVkKG1vZGVtLCBUUlVFKTs8YnI+wqA8YnI+LSDCoCDCoCDCoCAv
Kjxicj4tIMKgIMKgIMKgIMKgKiBUZWxsIHRoZSBtb2RlbSBub3QgdG8gYXV0b21hdGljYWxseSBp
bml0aWF0ZSBhdXRvLWF0dGFjaDxicj4tIMKgIMKgIMKgIMKgKiBwcm9jZWVkdXJlcyBvbiBpdHMg
b3duLjxicj4tIMKgIMKgIMKgIMKgKi88YnI+LSDCoCDCoCDCoCBpZiAoZGF0YS0mZ3Q7bW9kZWwg
PT0gTUU5MTBDMSk8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnX2F0X2NoYXRfc2VuZChkYXRh
LSZndDtjaGF0LCAmcXVvdDtBVCtDR0FUVD0wJnF1b3Q7LCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxM
KTs8YnI+LSDCoCDCoCDCoCBlbHNlPGJyPi08YnI+KyDCoCDCoCDCoCBpZiAoZGF0YS0mZ3Q7bW9k
ZWwgPT0gTUU5MTBDMSkgezxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qPGJyPisgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAqIFRlbGl0IE1FOTEwQzEgbmVlZHMgdG8gYWN0aXZhdGUgdGhlIEdQ
UlMgdG8gYXV0by1hdHRhY2ggdGhlIG5ldHdvcmsuPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAqLzxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2No
YXQsICZxdW90O0FUK0NHQVRUPTEmcXVvdDssIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwpOzxicj4r
IMKgIMKgIMKgIH0gZWxzZSB7PGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyo8YnI+KyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCogVGVsbCB0aGUgbW9kZW0gbm90IHRvIGF1dG9tYXRpY2FsbHkg
aW5pdGlhdGUgYXV0by1hdHRhY2g8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogcHJvY2Vl
ZHVyZXMgb24gaXRzIG93bi48YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCovPGJyPsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2NoYXQsICZxdW90O0FU
I0FVVE9BVFQ9MCZxdW90Oywgbm9uZV9wcmVmaXgsPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5VTEwsIE5VTEwsIE5VTEwpOzxi
cj4rIMKgIMKgIMKgIH08YnI+wqA8YnI+wqAgwqAgwqAgwqAgLyogRm9sbG93IHNpbSBzdGF0ZSAq
Lzxicj7CoCDCoCDCoCDCoCBnX2F0X2NoYXRfcmVnaXN0ZXIoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7
I1FTUzomcXVvdDssIHRlbGl0X3Fzc19ub3RpZnksPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5UaGFua3M8L2Rpdj48ZGl2Pk5pY29sYSBMdW5naGk8YnI+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0i
bHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gVHVlLCAxIE9jdCAyMDE5IGF0IDIyOjU0LCAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmxpbW9uLmFuaWJhbEBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5s
aW1vbi5hbmliYWxAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBE
cmVzZG8sPGJyPgo8YnI+CkkgaGF2ZSBhIHBhdGNoIHRoYXQgYWRkcyBzdXBwb3J0IGZvciBUZWxp
dCBNRTkxMCBidXQgaXQgaXMgdXBvbiBPZm9ubyAxLjMwLCBpIHBsYW4gdG8gc2VuZCBmb3IgcmV2
aWV3Ljxicj4KPGJyPgo8YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vYWxpbW9uL29mb25vL2Nv
bW1pdC85MjA3MTJlMTg0ZmZhZjExNDNlOWNlMTNjM2JlYzhhYzFkZWVkYTVjIiByZWw9Im5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdGh1Yi5jb20vYWxpbW9uL29mb25vL2Nv
bW1pdC85MjA3MTJlMTg0ZmZhZjExNDNlOWNlMTNjM2JlYzhhYzFkZWVkYTVjPC9hPjxicj4KPGJy
PgpSZWdhcmRzISw8YnI+CkFuaWJhbDxicj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdCAtLSA8YSBocmVmPSJtYWls
dG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxi
cj4KVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byA8YSBocmVmPSJtYWlsdG86b2Zvbm8t
bGVhdmVAb2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+b2Zvbm8tbGVhdmVAb2Zvbm8ub3JnPC9h
Pjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+CjwvYmxv
Y2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pgo=

--===============5500774066077125158==--


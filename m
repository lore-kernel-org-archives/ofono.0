Content-Type: multipart/mixed; boundary="===============2536068216303616621=="
MIME-Version: 1.0
From: Anibal =?unknown-8bit?q?Lim=C3=B3n?= <limon.anibal@gmail.com>
Subject: Re: Telit ME910C1-WW not detected
Date: Thu, 03 Oct 2019 17:11:40 -0500
Message-ID: <CAPS-YPCc_b5DV8_+uuY9U3GFLiZexiH9vyJpNzJQ64HosN8ACQ@mail.gmail.com>
In-Reply-To: <CAPS-YPASaqxw0aD7LBmwmqfASyq4nQhc6B7dsgKLF-L1cf571w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2536068216303616621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I fix a bug in the code due to auto-attach, see [1] and the specific change
[2].
Please test and let me know before send the patch.

Cheers.
Anibal

[1] htt <https://github.com/alimon/ofono/tree/me910_fix_v2>
ps://github.com/alimon/ofono/tree/me910_fix_v2
<https://github.com/alimon/ofono/tree/me910_fix_v2>
[2]
https://github.com/alimon/ofono/commit/682fd656afaf637b915d5d6b78a4211dd6e0=
884d

On Wed, Oct 2, 2019 at 9:39 AM Anibal Lim=C3=B3n <limon.anibal@gmail.com>=
 wrote:

>
>
> On Wed, Oct 2, 2019 at 9:32 AM nick83ola <nick83ola@gmail.com> wrote:
>
>> Thanks
>>
>> do you think that you can submit it to ofono mailing list?
>>
>> in particular I don;t know if
>>
>> if (data->model =3D=3D ME910C1)
>> ofono_netreg_create(modem, OFONO_VENDOR_TELIT_ME910C1, "atmodem",
>> data->chat);
>> else
>> ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
>>
>
> That's because this specific model dosen't support  signal strength
> reporting via CIND.
>
>
> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec8ac1d=
eeda5c#diff-2bbda16023120e26f58cfa7335520fb4
>
> Anibal
>
>
>>
>> is acceptable
>>
>> Cheers
>> Nicola Lunghi
>>
>>
>> On Wed, 2 Oct 2019 at 15:29, Anibal Lim=C3=B3n <limon.anibal@gmail.com=
> wrote:
>>
>>>
>>>
>>> On Wed, Oct 2, 2019 at 9:00 AM nick83ola <nick83ola@gmail.com> wrote:
>>>
>>>> Hi Anibal,
>>>> I'm interested as well in the patch
>>>>
>>>> I saw that there you have two branches (me910 and v1.30+me910) can you
>>>> tell me what branch have you tested?
>>>> the diff is this
>>>>
>>>
>>> Yeah the latest one is me910, I was making a mistake to enable GPRS
>>> instead of disable it, that's the change.
>>>
>>> Anibal
>>>
>>>
>>>>
>>>> git diff me910
>>>> diff --git a/plugins/telit.c b/plugins/telit.c
>>>> index f36995dc..50344281 100644
>>>> --- a/plugins/telit.c
>>>> +++ b/plugins/telit.c
>>>> @@ -239,16 +239,19 @@ static void cfun_enable_cb(gboolean ok, GAtResult
>>>> *result, gpointer user_data)
>>>>
>>>>         ofono_modem_set_powered(modem, TRUE);
>>>>
>>>> -       /*
>>>> -        * Tell the modem not to automatically initiate auto-attach
>>>> -        * proceedures on its own.
>>>> -        */
>>>> -       if (data->model =3D=3D ME910C1)
>>>> -               g_at_chat_send(data->chat, "AT+CGATT=3D0", NULL, NULL,
>>>> NULL, NULL);
>>>> -       else
>>>> -
>>>> +       if (data->model =3D=3D ME910C1) {
>>>> +               /*
>>>> +                * Telit ME910C1 needs to activate the GPRS to
>>>> auto-attach the network.
>>>> +                */
>>>> +               g_at_chat_send(data->chat, "AT+CGATT=3D1", NULL, NULL,
>>>> NULL, NULL);
>>>> +       } else {
>>>> +               /*
>>>> +                * Tell the modem not to automatically initiate
>>>> auto-attach
>>>> +                * proceedures on its own.
>>>> +                */
>>>>                 g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_pref=
ix,
>>>>                                         NULL, NULL, NULL);
>>>> +       }
>>>>
>>>>         /* Follow sim state */
>>>>         g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
>>>>
>>>>
>>>> Thanks
>>>> Nicola Lunghi
>>>>
>>>>
>>>> On Tue, 1 Oct 2019 at 22:54, <limon.anibal@gmail.com> wrote:
>>>>
>>>>> Hi Dresdo,
>>>>>
>>>>> I have a patch that adds support for Telit ME910 but it is upon Ofono
>>>>> 1.30, i plan to send for review.
>>>>>
>>>>>
>>>>> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec8=
ac1deeda5c
>>>>>
>>>>> Regards!,
>>>>> Anibal
>>>>> _______________________________________________
>>>>> ofono mailing list -- ofono(a)ofono.org
>>>>> To unsubscribe send an email to ofono-leave(a)ofono.org
>>>>>
>>>>

--===============2536068216303616621==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5JIGZpeCBhIGJ1ZyBpbiB0aGUg
Y29kZSBkdWUgdG8gYXV0by1hdHRhY2gsIHNlZSBbMV0gYW5kIHRoZSBzcGVjaWZpYyBjaGFuZ2Ug
WzJdLjwvZGl2PjxkaXY+UGxlYXNlIHRlc3QgYW5kIGxldCBtZSBrbm93IGJlZm9yZSBzZW5kIHRo
ZSBwYXRjaC48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5DaGVlcnMuPC9kaXY+PGRpdj5B
bmliYWw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlsxXcKgPGEgaHJlZj0iaHR0cHM6Ly9naXRo
dWIuY29tL2FsaW1vbi9vZm9uby90cmVlL21lOTEwX2ZpeF92MiI+aHR0PC9hPjxhIGhyZWY9Imh0
dHBzOi8vZ2l0aHViLmNvbS9hbGltb24vb2Zvbm8vdHJlZS9tZTkxMF9maXhfdjIiPnBzOi8vZ2l0
aHViLmNvbS9hbGltb24vb2Zvbm8vdHJlZS9tZTkxMF9maXhfdjI8L2E+PC9kaXY+PGRpdj5bMl3C
oDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9hbGltb24vb2Zvbm8vY29tbWl0LzY4MmZkNjU2
YWZhZjYzN2I5MTVkNWQ2Yjc4YTQyMTFkZDZlMDg4NGQiPmh0dHBzOi8vZ2l0aHViLmNvbS9hbGlt
b24vb2Zvbm8vY29tbWl0LzY4MmZkNjU2YWZhZjYzN2I5MTVkNWQ2Yjc4YTQyMTFkZDZlMDg4NGQ8
L2E+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRy
IiBjbGFzcz0iZ21haWxfYXR0ciI+T24gV2VkLCBPY3QgMiwgMjAxOSBhdCA5OjM5IEFNIEFuaWJh
bCBMaW3Ds24gJmx0OzxhIGhyZWY9Im1haWx0bzpsaW1vbi5hbmliYWxAZ21haWwuY29tIj5saW1v
bi5hbmliYWxAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXIt
bGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRp
cj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48YnI+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1
b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gV2VkLCBPY3QgMiwgMjAx
OSBhdCA5OjMyIEFNIG5pY2s4M29sYSAmbHQ7PGEgaHJlZj0ibWFpbHRvOm5pY2s4M29sYUBnbWFp
bC5jb20iIHRhcmdldD0iX2JsYW5rIj5uaWNrODNvbGFAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6
PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtw
YWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2PlRoYW5rczwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+ZG8geW91IHRoaW5rIHRoYXQgeW91IGNhbiBzdWJtaXQgaXQgdG8gb2Zvbm8g
bWFpbGluZyBsaXN0PzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+aW4gcGFydGljdWxhciBJIGRv
bjt0IGtub3cgaWY8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmlmIChkYXRhLSZndDttb2RlbCA9
PSBNRTkxMEMxKTxicj4JCW9mb25vX25ldHJlZ19jcmVhdGUobW9kZW0sIE9GT05PX1ZFTkRPUl9U
RUxJVF9NRTkxMEMxLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtjaGF0KTs8YnI+CWVs
c2U8YnI+CQlvZm9ub19uZXRyZWdfY3JlYXRlKG1vZGVtLCBPRk9OT19WRU5ET1JfVEVMSVQsICZx
dW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0O2NoYXQpOzwvZGl2PjwvZGl2PjwvYmxvY2txdW90
ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYXQmIzM5O3MgYmVjYXVzZSB0aGlzIHNwZWNpZmljIG1v
ZGVsIGRvc2VuJiMzOTt0IHN1cHBvcnTCoCBzaWduYWwgc3RyZW5ndGggcmVwb3J0aW5nIHZpYSBD
SU5ELjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PC9kaXY+PGRpdj48YSBocmVmPSJodHRwczov
L2dpdGh1Yi5jb20vYWxpbW9uL29mb25vL2NvbW1pdC85MjA3MTJlMTg0ZmZhZjExNDNlOWNlMTNj
M2JlYzhhYzFkZWVkYTVjI2RpZmYtMmJiZGExNjAyMzEyMGUyNmY1OGNmYTczMzU1MjBmYjQiIHRh
cmdldD0iX2JsYW5rIj5odHRwczovL2dpdGh1Yi5jb20vYWxpbW9uL29mb25vL2NvbW1pdC85MjA3
MTJlMTg0ZmZhZjExNDNlOWNlMTNjM2JlYzhhYzFkZWVkYTVjI2RpZmYtMmJiZGExNjAyMzEyMGUy
NmY1OGNmYTczMzU1MjBmYjQ8L2E+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbmliYWw8L2Rp
dj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwy
MDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXY+PGJyPjwvZGl2PjxkaXY+
aXMgYWNjZXB0YWJsZTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Q2hlZXJzPC9kaXY+PGRpdj5O
aWNvbGEgTHVuZ2hpPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9Imdt
YWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gV2VkLCAyIE9j
dCAyMDE5IGF0IDE1OjI5LCBBbmliYWwgTGltw7NuICZsdDs8YSBocmVmPSJtYWlsdG86bGltb24u
YW5pYmFsQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmxpbW9uLmFuaWJhbEBnbWFpbC5jb208
L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJs
dHIiPjxicj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIi
IGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBXZWQsIE9jdCAyLCAyMDE5IGF0IDk6MDAgQU0gbmljazgz
b2xhICZsdDs8YSBocmVmPSJtYWlsdG86bmljazgzb2xhQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPm5pY2s4M29sYUBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2Jv
cmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxk
aXYgZGlyPSJsdHIiPjxkaXY+SGkgQW5pYmFsLDwvZGl2PjxkaXY+SSYjMzk7bSBpbnRlcmVzdGVk
IGFzIHdlbGwgaW4gdGhlIHBhdGNoPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIHNhdyB0aGF0
IHRoZXJlIHlvdSBoYXZlIHR3byBicmFuY2hlcyAobWU5MTAgYW5kIHYxLjMwK21lOTEwKSBjYW4g
eW91IHRlbGwgbWUgd2hhdCBicmFuY2ggaGF2ZSB5b3UgdGVzdGVkPzwvZGl2PjxkaXY+dGhlIGRp
ZmYgaXMgdGhpczwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Plll
YWggdGhlIGxhdGVzdCBvbmUgaXMgbWU5MTAsIEkgd2FzIG1ha2luZyBhIG1pc3Rha2UgdG8gZW5h
YmxlIEdQUlMgaW5zdGVhZCBvZiBkaXNhYmxlIGl0LCB0aGF0JiMzOTtzIHRoZSBjaGFuZ2UuPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbmliYWw8L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2Jv
cmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxk
aXYgZGlyPSJsdHIiPjxkaXY+PGJyPjwvZGl2PjxkaXY+Z2l0IGRpZmYgbWU5MTA8YnI+ZGlmZiAt
LWdpdCBhL3BsdWdpbnMvdGVsaXQuYyBiL3BsdWdpbnMvdGVsaXQuYzxicj5pbmRleCBmMzY5OTVk
Yy4uNTAzNDQyODEgMTAwNjQ0PGJyPi0tLSBhL3BsdWdpbnMvdGVsaXQuYzxicj4rKysgYi9wbHVn
aW5zL3RlbGl0LmM8YnI+QEAgLTIzOSwxNiArMjM5LDE5IEBAIHN0YXRpYyB2b2lkIGNmdW5fZW5h
YmxlX2NiKGdib29sZWFuIG9rLCBHQXRSZXN1bHQgKnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRh
KTxicj7CoDxicj7CoCDCoCDCoCDCoCBvZm9ub19tb2RlbV9zZXRfcG93ZXJlZChtb2RlbSwgVFJV
RSk7PGJyPsKgPGJyPi0gwqAgwqAgwqAgLyo8YnI+LSDCoCDCoCDCoCDCoCogVGVsbCB0aGUgbW9k
ZW0gbm90IHRvIGF1dG9tYXRpY2FsbHkgaW5pdGlhdGUgYXV0by1hdHRhY2g8YnI+LSDCoCDCoCDC
oCDCoCogcHJvY2VlZHVyZXMgb24gaXRzIG93bi48YnI+LSDCoCDCoCDCoCDCoCovPGJyPi0gwqAg
wqAgwqAgaWYgKGRhdGEtJmd0O21vZGVsID09IE1FOTEwQzEpPGJyPi0gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7QVQrQ0dBVFQ9MCZxdW90
OywgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCk7PGJyPi0gwqAgwqAgwqAgZWxzZTxicj4tPGJyPisg
wqAgwqAgwqAgaWYgKGRhdGEtJmd0O21vZGVsID09IE1FOTEwQzEpIHs8YnI+KyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAvKjxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBUZWxpdCBNRTkxMEMx
IG5lZWRzIHRvIGFjdGl2YXRlIHRoZSBHUFJTIHRvIGF1dG8tYXR0YWNoIHRoZSBuZXR3b3JrLjxi
cj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKi88YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBn
X2F0X2NoYXRfc2VuZChkYXRhLSZndDtjaGF0LCAmcXVvdDtBVCtDR0FUVD0xJnF1b3Q7LCBOVUxM
LCBOVUxMLCBOVUxMLCBOVUxMKTs8YnI+KyDCoCDCoCDCoCB9IGVsc2Ugezxicj4rIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIC8qPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIFRlbGwgdGhlIG1v
ZGVtIG5vdCB0byBhdXRvbWF0aWNhbGx5IGluaXRpYXRlIGF1dG8tYXR0YWNoPGJyPisgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAqIHByb2NlZWR1cmVzIG9uIGl0cyBvd24uPGJyPisgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAqLzxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnX2F0X2NoYXRfc2Vu
ZChkYXRhLSZndDtjaGF0LCAmcXVvdDtBVCNBVVRPQVRUPTAmcXVvdDssIG5vbmVfcHJlZml4LDxi
cj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBOVUxMLCBOVUxMLCBOVUxMKTs8YnI+KyDCoCDCoCDCoCB9PGJyPsKgPGJyPsKgIMKgIMKg
IMKgIC8qIEZvbGxvdyBzaW0gc3RhdGUgKi88YnI+wqAgwqAgwqAgwqAgZ19hdF9jaGF0X3JlZ2lz
dGVyKGRhdGEtJmd0O2NoYXQsICZxdW90OyNRU1M6JnF1b3Q7LCB0ZWxpdF9xc3Nfbm90aWZ5LDwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzPC9kaXY+PGRpdj5O
aWNvbGEgTHVuZ2hpPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFR1ZSwg
MSBPY3QgMjAxOSBhdCAyMjo1NCwgJmx0OzxhIGhyZWY9Im1haWx0bzpsaW1vbi5hbmliYWxAZ21h
aWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bGltb24uYW5pYmFsQGdtYWlsLmNvbTwvYT4mZ3Q7IHdy
b3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIw
NCk7cGFkZGluZy1sZWZ0OjFleCI+SGkgRHJlc2RvLDxicj4KPGJyPgpJIGhhdmUgYSBwYXRjaCB0
aGF0IGFkZHMgc3VwcG9ydCBmb3IgVGVsaXQgTUU5MTAgYnV0IGl0IGlzIHVwb24gT2Zvbm8gMS4z
MCwgaSBwbGFuIHRvIHNlbmQgZm9yIHJldmlldy48YnI+Cjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9n
aXRodWIuY29tL2FsaW1vbi9vZm9uby9jb21taXQvOTIwNzEyZTE4NGZmYWYxMTQzZTljZTEzYzNi
ZWM4YWMxZGVlZGE1YyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9n
aXRodWIuY29tL2FsaW1vbi9vZm9uby9jb21taXQvOTIwNzEyZTE4NGZmYWYxMTQzZTljZTEzYzNi
ZWM4YWMxZGVlZGE1YzwvYT48YnI+Cjxicj4KUmVnYXJkcyEsPGJyPgpBbmliYWw8YnI+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWls
aW5nIGxpc3QgLS0gPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxh
bmsiPm9mb25vQG9mb25vLm9yZzwvYT48YnI+ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwg
dG8gPGEgaHJlZj0ibWFpbHRvOm9mb25vLWxlYXZlQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsi
Pm9mb25vLWxlYXZlQG9mb25vLm9yZzwvYT48YnI+CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9ibG9j
a3F1b3RlPjwvZGl2PjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rp
dj48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============2536068216303616621==--


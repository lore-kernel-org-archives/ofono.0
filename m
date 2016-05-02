Content-Type: multipart/mixed; boundary="===============5326944931729375935=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: Re: [PATCH 2/3] Gobi: Enable SIM driver "manual" config
Date: Mon, 02 May 2016 17:27:56 +0200
Message-ID: <572771FC.5030201@kerlink.fr>
In-Reply-To: <57276EA4.1070306@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5326944931729375935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02/05/2016 17:13, Denis Kenzior wrote:
>
>>
>> diff --git a/plugins/gobi.c b/plugins/gobi.c
>> index 4daa459..09c9d95 100644
>> --- a/plugins/gobi.c
>> +++ b/plugins/gobi.c
>> @@ -413,12 +413,16 @@ error:
>>   static void gobi_pre_sim(struct ofono_modem *modem)
>>   {
>>       struct gobi_data *data =3D ofono_modem_get_data(modem);
>> +    const char * simdriver;
>>
>>       DBG("%p", modem);
>>
>>       ofono_devinfo_create(modem, 0, "qmimodem", data->device);
>>
>> -    if (data->features & GOBI_UIM)
>> +    simdriver =3D ofono_modem_get_string(modem,"Simdriver");
>
> Can we name this ForceSimLegacy and make it a boolean?
>

Yes of course. Actually, it was my first implementation ... and then, I
thought this type of "overload" can be interested for other modem drivers.
So I tried to make it generic through a string.
But I agree using a boolean is simplier and more reliable (avoid the use
of an unregistered driver).

>
> Regards,
> -Denis
>

Thanks,

Martin

--===============5326944931729375935==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMTA2ZjljIj4KICAgIEhpIERlbmlzLDxicj4K
ICAgIDxicj4KICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+T24gMDIvMDUvMjAxNiAx
NzoxMywgRGVuaXMgS2VuemlvcgogICAgICB3cm90ZTo8YnI+CiAgICA8L2Rpdj4KICAgIDxibG9j
a3F1b3RlIGNpdGU9Im1pZDo1NzI3NkVBNC4xMDcwMzA2QGdtYWlsLmNvbSIgdHlwZT0iY2l0ZSI+
PGJyPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICA8YnI+CiAgICAgICAg
ZGlmZiAtLWdpdCBhL3BsdWdpbnMvZ29iaS5jIGIvcGx1Z2lucy9nb2JpLmMKICAgICAgICA8YnI+
CiAgICAgICAgaW5kZXggNGRhYTQ1OS4uMDljOWQ5NSAxMDA2NDQKICAgICAgICA8YnI+CiAgICAg
ICAgLS0tIGEvcGx1Z2lucy9nb2JpLmMKICAgICAgICA8YnI+CiAgICAgICAgKysrIGIvcGx1Z2lu
cy9nb2JpLmMKICAgICAgICA8YnI+CiAgICAgICAgQEAgLTQxMywxMiArNDEzLDE2IEBAIGVycm9y
OgogICAgICAgIDxicj4KICAgICAgICCgIHN0YXRpYyB2b2lkIGdvYmlfcHJlX3NpbShzdHJ1Y3Qg
b2Zvbm9fbW9kZW0gKm1vZGVtKQogICAgICAgIDxicj4KICAgICAgICCgIHsKICAgICAgICA8YnI+
CiAgICAgICAgoKCgoKAgc3RydWN0IGdvYmlfZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dldF9k
YXRhKG1vZGVtKTsKICAgICAgICA8YnI+CiAgICAgICAgK6CgoCBjb25zdCBjaGFyICogc2ltZHJp
dmVyOwogICAgICAgIDxicj4KICAgICAgICA8YnI+CiAgICAgICAgoKCgoKAgREJHKCIlcCIsIG1v
ZGVtKTsKICAgICAgICA8YnI+CiAgICAgICAgPGJyPgogICAgICAgIKCgoKCgIG9mb25vX2Rldmlu
Zm9fY3JlYXRlKG1vZGVtLCAwLCAicW1pbW9kZW0iLAogICAgICAgIGRhdGEtJmd0O2RldmljZSk7
CiAgICAgICAgPGJyPgogICAgICAgIDxicj4KICAgICAgICAtoKCgIGlmIChkYXRhLSZndDtmZWF0
dXJlcyAmYW1wOyBHT0JJX1VJTSkKICAgICAgICA8YnI+CiAgICAgICAgK6CgoCBzaW1kcml2ZXIg
PSBvZm9ub19tb2RlbV9nZXRfc3RyaW5nKG1vZGVtLCJTaW1kcml2ZXIiKTsKICAgICAgICA8YnI+
CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPGJyPgogICAgICBDYW4gd2UgbmFtZSB0aGlzIEZv
cmNlU2ltTGVnYWN5IGFuZCBtYWtlIGl0IGEgYm9vbGVhbj8KICAgICAgPGJyPgogICAgICA8YnI+
CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8YnI+CiAgICBZZXMgb2YgY291cnNlLiBBY3R1YWxseSwg
aXQgd2FzIG15IGZpcnN0IGltcGxlbWVudGF0aW9uIC4uLiBhbmQKICAgIHRoZW4sIEkgdGhvdWdo
dCB0aGlzIHR5cGUgb2YgIm92ZXJsb2FkIiBjYW4gYmUgaW50ZXJlc3RlZCBmb3Igb3RoZXIKICAg
IG1vZGVtIGRyaXZlcnMuPGJyPgogICAgU28gSSB0cmllZCB0byBtYWtlIGl0IGdlbmVyaWMgdGhy
b3VnaCBhIHN0cmluZy48YnI+CiAgICBCdXQgSSBhZ3JlZSB1c2luZyBhIGJvb2xlYW4gaXMgc2lt
cGxpZXIgYW5kIG1vcmUgcmVsaWFibGUgKGF2b2lkIHRoZQogICAgdXNlIG9mIGFuIHVucmVnaXN0
ZXJlZCBkcml2ZXIpLjxicj4KICAgIDxicj4KICAgIDxibG9ja3F1b3RlIGNpdGU9Im1pZDo1NzI3
NkVBNC4xMDcwMzA2QGdtYWlsLmNvbSIgdHlwZT0iY2l0ZSI+CiAgICAgIDxicj4KICAgICAgUmVn
YXJkcywKICAgICAgPGJyPgogICAgICAtRGVuaXMKICAgICAgPGJyPgogICAgICA8YnI+CiAgICA8
L2Jsb2NrcXVvdGU+CiAgICA8YnI+CiAgICBUaGFua3MsPGJyPgogICAgPGJyPgogICAgTWFydGlu
PGJyPgogIDwvYm9keT4KPC9odG1sPgo=

--===============5326944931729375935==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjIuMC4yMiAoR05V
L0xpbnV4KQoKaVFJY0JBRUJBZ0FHQlFKWEozSDhBQW9KRU1KT2oxZU15ZGkvcnNzUC9pU1JRSzF1
Y1lld3FqaGdIa3owRkVmQQpEc1NaN0xkWUJtTFdwdzFsVS9hQVZlVkhrdzdmbFBnYVR6WmdERWZz
YVBOUzR6a0pnZFhqZzVHQ1A5alJoQUpGCmZ2RHBOTzVNQjlBZ1BucmVCRjdBT2d1dWxGdFVUdUps
TTZib3dmbktQdEJPK3VxdUZWakIzbkJiRnpKNUk2cWoKTUFBMVh0MGx6QTBxbUVRVTZKT0xVUWUy
RUtlSHQzV00wU2I4MXVESzg1bEZDeG9JYytQWUFpYldoTWU3UGFOcwo1a2RKK1JhNk1yZ3NxUVJP
MFNuQllEb0RQRjJjUWt6UlBMbnN0VnQydkxSZzhpeTNtV0x1MzI0cnhJWnVROUltCjYvTlU1MDBz
MVdCNUpoQVZhVGdNdXFXZW8zVSs1ZlUyNFpSb0tleEcyVTdWeWFLTzN2OWVKTlViMkk0cWgxdDUK
WllRMk5DS0FtT1JsYmhXWXh6K2kxeFZSVE4rY0gyNUVISk8rL0xzVkhQbVJTWURpamRjdE0wWlJ5
ajBFVEVDNgpUbXFlKy9pM3JlRzYwNVlMTnlTbWxuVzAwRDBaVE5tNXV6a1pTQUxBRUN4K2svdVoz
SHNzTURDc2lTTkRRY0pPClF3NnMyZi93Q1R5YjhjdWw3aW9nV1d2V1lIeHNoVis3TENCNEs3MlZ6
WGlRZzN3NThKWTVtTThUdmFMaXpPaWgKKzloSTJJSTh4dlZObENENkNPYUVtVkdLSjZ1cEpJZGZN
OCthVEpUNHVYaFkzZDNvK1p0eFFnNXpFaXlvV2o3UgpDTHFJRFc2UzFRckt2YlFXbGkvSW1lU3pR
R0xuSFJGMWxCSnZsUWZTaUNtQkNVSkpNWjBOaDVxMkhyTGpWdHpSCmhnd09YWEh5YzBkMzExaXVU
bVNKCj1FbHNRCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============5326944931729375935==--


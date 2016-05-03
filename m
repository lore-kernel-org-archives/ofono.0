Content-Type: multipart/mixed; boundary="===============7753728640164811555=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: Re: [PATCH 2/3] Udevng: Improve modem properties detection
Date: Tue, 03 May 2016 10:40:25 +0200
Message-ID: <572863F9.70701@kerlink.fr>
In-Reply-To: <572819A7.5030407@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7753728640164811555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/05/2016 05:23, Denis Kenzior wrote:
> Hi Martin,
>
> On 05/02/2016 11:33 AM, Martin Chaplet wrote:
>>   * Add driver's subsystem information (net, usb, tty, ...)
>>   * Improve interface number extraction by scanning also device and
>>   parent attributes
>>
>> Signed-off-by: Martin Chaplet <m.chaplet@kerlink.fr>
>
> No signed-off-by please.  See HACKING, 'Submitting Patches' section.
>
>>
>>
>>       devpath =3D udev_device_get_syspath(device);
>>       if (devpath =3D=3D NULL)
>> @@ -1037,7 +1040,19 @@ static void add_device(const char *syspath,
>> const char *devname,
>>       interface =3D udev_device_get_property_value(intf, "INTERFACE");
>>       number =3D udev_device_get_property_value(device,
>> "ID_USB_INTERFACE_NUM");
>>
>> +    /* If environment variable is not set, get value from attributes
>> (or parent's ones) */
>> +    if(number =3D=3D NULL)
>> +    {
>
> Not our style.  oFono uses the Linux Kernel coding style, so the '{'
> should be on the same line as the if.
>
>> +        number =3D udev_device_get_sysattr_value(device,
>> "bInterfaceNumber");
>> +        if(number =3D=3D NULL)
>> +        {
>
> as above
>

OK, sorry for those mistakes and thanks for your review.
I will re-send cleaner patches.

Regards,

Martin

--===============7753728640164811555==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMTA2ZjljIj4KICAgIEhpIERlbmlzLDxicj4K
ICAgIDxicj4KICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+T24gMDMvMDUvMjAxNiAw
NToyMywgRGVuaXMgS2VuemlvcgogICAgICB3cm90ZTo8YnI+CiAgICA8L2Rpdj4KICAgIDxibG9j
a3F1b3RlIGNpdGU9Im1pZDo1NzI4MTlBNy41MDMwNDA3QGdtYWlsLmNvbSIgdHlwZT0iY2l0ZSI+
SGkKICAgICAgTWFydGluLAogICAgICA8YnI+CiAgICAgIDxicj4KICAgICAgT24gMDUvMDIvMjAx
NiAxMTozMyBBTSwgTWFydGluIENoYXBsZXQgd3JvdGU6CiAgICAgIDxicj4KICAgICAgPGJsb2Nr
cXVvdGUgdHlwZT0iY2l0ZSI+oCAqIEFkZCBkcml2ZXIncyBzdWJzeXN0ZW0gaW5mb3JtYXRpb24K
ICAgICAgICAobmV0LCB1c2IsIHR0eSwgLi4uKQogICAgICAgIDxicj4KICAgICAgICCgICogSW1w
cm92ZSBpbnRlcmZhY2UgbnVtYmVyIGV4dHJhY3Rpb24gYnkgc2Nhbm5pbmcgYWxzbyBkZXZpY2UK
ICAgICAgICBhbmQKICAgICAgICA8YnI+CiAgICAgICAgoCBwYXJlbnQgYXR0cmlidXRlcwogICAg
ICAgIDxicj4KICAgICAgICA8YnI+CiAgICAgICAgU2lnbmVkLW9mZi1ieTogTWFydGluIENoYXBs
ZXQgPGEgY2xhc3M9Im1vei10eHQtbGluay1yZmMyMzk2RSIgaHJlZj0ibWFpbHRvOm0uY2hhcGxl
dEBrZXJsaW5rLmZyIj4mbHQ7bS5jaGFwbGV0QGtlcmxpbmsuZnImZ3Q7PC9hPgogICAgICAgIDxi
cj4KICAgICAgPC9ibG9ja3F1b3RlPgogICAgICA8YnI+CiAgICAgIE5vIHNpZ25lZC1vZmYtYnkg
cGxlYXNlLqAgU2VlIEhBQ0tJTkcsICdTdWJtaXR0aW5nIFBhdGNoZXMnCiAgICAgIHNlY3Rpb24u
CiAgICAgIDxicj4KICAgICAgPGJyPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj48YnI+
CiAgICAgICAgPGJyPgogICAgICAgIKCgoKCgIGRldnBhdGggPSB1ZGV2X2RldmljZV9nZXRfc3lz
cGF0aChkZXZpY2UpOwogICAgICAgIDxicj4KICAgICAgICCgoKCgoCBpZiAoZGV2cGF0aCA9PSBO
VUxMKQogICAgICAgIDxicj4KICAgICAgICBAQCAtMTAzNyw3ICsxMDQwLDE5IEBAIHN0YXRpYyB2
b2lkIGFkZF9kZXZpY2UoY29uc3QgY2hhcgogICAgICAgICpzeXNwYXRoLCBjb25zdCBjaGFyICpk
ZXZuYW1lLAogICAgICAgIDxicj4KICAgICAgICCgoKCgoCBpbnRlcmZhY2UgPSB1ZGV2X2Rldmlj
ZV9nZXRfcHJvcGVydHlfdmFsdWUoaW50ZiwKICAgICAgICAiSU5URVJGQUNFIik7CiAgICAgICAg
PGJyPgogICAgICAgIKCgoKCgIG51bWJlciA9IHVkZXZfZGV2aWNlX2dldF9wcm9wZXJ0eV92YWx1
ZShkZXZpY2UsCiAgICAgICAgIklEX1VTQl9JTlRFUkZBQ0VfTlVNIik7CiAgICAgICAgPGJyPgog
ICAgICAgIDxicj4KICAgICAgICAroKCgIC8qIElmIGVudmlyb25tZW50IHZhcmlhYmxlIGlzIG5v
dCBzZXQsIGdldCB2YWx1ZSBmcm9tCiAgICAgICAgYXR0cmlidXRlcyAob3IgcGFyZW50J3Mgb25l
cykgKi8KICAgICAgICA8YnI+CiAgICAgICAgK6CgoCBpZihudW1iZXIgPT0gTlVMTCkKICAgICAg
ICA8YnI+CiAgICAgICAgK6CgoCB7CiAgICAgICAgPGJyPgogICAgICA8L2Jsb2NrcXVvdGU+CiAg
ICAgIDxicj4KICAgICAgTm90IG91ciBzdHlsZS6gIG9Gb25vIHVzZXMgdGhlIExpbnV4IEtlcm5l
bCBjb2Rpbmcgc3R5bGUsIHNvIHRoZQogICAgICAneycgc2hvdWxkIGJlIG9uIHRoZSBzYW1lIGxp
bmUgYXMgdGhlIGlmLgogICAgICA8YnI+CiAgICAgIDxicj4KICAgICAgPGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSI+K6CgoKCgoKAgbnVtYmVyID0KICAgICAgICB1ZGV2X2RldmljZV9nZXRfc3lzYXR0
cl92YWx1ZShkZXZpY2UsICJiSW50ZXJmYWNlTnVtYmVyIik7CiAgICAgICAgPGJyPgogICAgICAg
ICugoKCgoKCgIGlmKG51bWJlciA9PSBOVUxMKQogICAgICAgIDxicj4KICAgICAgICAroKCgoKCg
oCB7CiAgICAgICAgPGJyPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxicj4KICAgICAgYXMg
YWJvdmUKICAgICAgPGJyPgogICAgICA8YnI+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8YnI+CiAg
ICBPSywgc29ycnkgZm9yIHRob3NlIG1pc3Rha2VzIGFuZCB0aGFua3MgZm9yIHlvdXIgcmV2aWV3
Ljxicj4KICAgIEkgd2lsbCByZS1zZW5kIGNsZWFuZXIgcGF0Y2hlcy48YnI+CiAgICA8YnI+CiAg
ICBSZWdhcmRzLDxicj4KICAgIDxicj4KICAgIE1hcnRpbjxicj4KICA8L2JvZHk+CjwvaHRtbD4K

--===============7753728640164811555==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjIuMC4yMiAoR05V
L0xpbnV4KQoKaVFJY0JBRUJBZ0FHQlFKWEtHUCtBQW9KRU1KT2oxZU15ZGkvNEs4UC9SZk9lWERL
ZlpRbW50Z2picUlxUE05agp2QmVzNHlQTkYrUFlHcU95OGR1WFRITjYwV21tbE5vSkxya2E5dXBt
bkxsNlhTNnFPQmYyUDFxQlRzVUM5Vk4yCml3Z0dvU1JrSytkTDcrd1kzajBtV0djTnhIdlJ1TVli
T2pIem9NR0s3Y2hOcHZEMHlhU2hIYXo3NE93UE96Z0gKbFhIUzNLVzFJNDNoQnFIYjY2UlJrWENT
VkxNRU1vL3A5Wm5SeVdPNXpxUDNkZkNaeFN1Q2h3TmFORVB5S2tuKwpRaDJCeG5zczVocHRTajBP
NmFnTForamlCekFpOUlqNVh4azR3OHZCSUNrbmRhSlJZS21SNTNrbjB1aHJKWERLCmpQb3NTUkZk
cjVuTU9PZ3dWYm9oNDczamJ3OUlQenVHRDY2cGhnbnZFWGkxRTRFNTZUbHNFYm91VWJGYnhFTHcK
ajNlSU1HZnI0d1Jkb2N4S29yOUZVaVFMYzkzNzQvTzQ4eFBOaFljTFlIcU9hcU1PaXdYNWVzbDJR
S0hLSnhleAp3bmZYZlJobjBmd2FTejE2N0E2U0NaaFB6aUtOcmxlSHhITC9GR0hRNS96VTI2dlVw
MEZVTDZ0UFVGa2xLbHpTClhlYURxRjVDbUpqbjdyQzZ3M2Ivd3N1bGFBRm1YUSt1TVhZZGtqb1lQ
OUFkQjYwZklmWERqRHIwVGkxVmE2eTIKN3R6WUJpTFNid1pBTTJIOXZ6Rmo5M2E1VHVZWEtRSHUy
UkI5Z3hmODM5cWxiTmhSYzdURzAvRW8wTTZWcXVPOQo2WW9OVm16bnp0MXdvVlBGMzhqcDE5OEwy
RCtKaHE5UkpVc0VEeWp2bEEyNGNSWlFXQnF5bFdyTkRaeEpzY0dMClM0UkVYOVNxTVpocFhQZVpx
THVZCj1vdGJsCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============7753728640164811555==--


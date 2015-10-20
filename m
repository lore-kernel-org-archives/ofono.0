Content-Type: multipart/mixed; boundary="===============1394419656937996551=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Re: [PATCH 07/10] ril: Remove asserts
Date: Tue, 20 Oct 2015 09:26:29 +0200
Message-ID: <CACM4vuD4e9bpbaDNbp=vmuRpoKHtcf5VJv=HP1Hf7-A5LQfL7A@mail.gmail.com>
In-Reply-To: <5624F648.9020209@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1394419656937996551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 3:55 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Alfonso,
>
> On 10/15/2015 11:47 AM, Alfonso Sanchez-Beato wrote:
>
>> ---
>>   plugins/ril.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/plugins/ril.c b/plugins/ril.c
>> index e31f24b..2edb0a9 100644
>> --- a/plugins/ril.c
>> +++ b/plugins/ril.c
>> @@ -144,7 +144,9 @@ static void ril_radio_state_changed(struct ril_msg
>> *message, gpointer user_data)
>>                         break;
>>                 default:
>>                         /* Malformed parcel; no radio state =3D=3D broken
>> rild */
>> -                       g_assert(FALSE);
>> +                       ofono_error("%s: Bad radio state (%d), exiting",
>> +                                                       __func__,
>> radio_state);
>> +                       exit(1);
>>
>
> Can we just remove the ril modem in question instead of killing the entire
> daemon?


I think that if we start to do these things we need to add modem watches to
udev/udevng/rildev as they keep lists with the modems and remove them in
shutdown. Maybe we could try a modem reset here, within a limited number of
retries instead?


>
>
>                 }
>>         }
>>   }
>> @@ -213,7 +215,6 @@ void ril_pre_sim(struct ofono_modem *modem)
>>         sim_data.ril_state_watch =3D NULL;
>>
>>         rd->sim =3D ofono_sim_create(modem, rd->vendor, RILMODEM,
>> &sim_data);
>> -       g_assert(rd->sim !=3D NULL);
>>   }
>>
>>   void ril_post_sim(struct ofono_modem *modem)
>>
>>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============1394419656937996551==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgT2N0IDE5LCAyMDE1IGF0IDM6NTUgUE0sIERlbmlzIEtl
bnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5j
b20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90
ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAw
IC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+SGkgQWxm
b25zbyw8c3BhbiBjbGFzcz0iIj48YnI+Cjxicj4KT24gMTAvMTUvMjAxNSAxMTo0NyBBTSwgQWxm
b25zbyBTYW5jaGV6LUJlYXRvIHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7
cGFkZGluZy1sZWZ0OjFleCI+Ci0tLTxicj4KwqAgcGx1Z2lucy9yaWwuYyB8IDUgKysrLS08YnI+
CsKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pPGJyPgo8
YnI+CmRpZmYgLS1naXQgYS9wbHVnaW5zL3JpbC5jIGIvcGx1Z2lucy9yaWwuYzxicj4KaW5kZXgg
ZTMxZjI0Yi4uMmVkYjBhOSAxMDA2NDQ8YnI+Ci0tLSBhL3BsdWdpbnMvcmlsLmM8YnI+CisrKyBi
L3BsdWdpbnMvcmlsLmM8YnI+CkBAIC0xNDQsNyArMTQ0LDkgQEAgc3RhdGljIHZvaWQgcmlsX3Jh
ZGlvX3N0YXRlX2NoYW5nZWQoc3RydWN0IHJpbF9tc2cgKm1lc3NhZ2UsIGdwb2ludGVyIHVzZXJf
ZGF0YSk8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj4K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGVmYXVsdDo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIC8qIE1hbGZvcm1lZCBwYXJjZWw7IG5vIHJhZGlvIHN0YXRlID09IGJy
b2tlbiByaWxkICovPGJyPgotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnX2Fz
c2VydChGQUxTRSk7PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvZm9u
b19lcnJvcigmcXVvdDslczogQmFkIHJhZGlvIHN0YXRlICglZCksIGV4aXRpbmcmcXVvdDssPGJy
PgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX2Z1bmNfXywgcmFkaW9fc3RhdGUpOzxicj4K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXhpdCgxKTs8YnI+CjwvYmxvY2tx
dW90ZT4KPGJyPjwvc3Bhbj4KQ2FuIHdlIGp1c3QgcmVtb3ZlIHRoZSByaWwgbW9kZW0gaW4gcXVl
c3Rpb24gaW5zdGVhZCBvZiBraWxsaW5nIHRoZSBlbnRpcmUgZGFlbW9uPzwvYmxvY2txdW90ZT48
ZGl2Pjxicj48L2Rpdj48ZGl2PkkgdGhpbmsgdGhhdCBpZiB3ZSBzdGFydCB0byBkbyB0aGVzZSB0
aGluZ3Mgd2UgbmVlZCB0byBhZGQgbW9kZW0gd2F0Y2hlcyB0byB1ZGV2L3VkZXZuZy9yaWxkZXYg
YXMgdGhleSBrZWVwIGxpc3RzIHdpdGggdGhlIG1vZGVtcyBhbmQgcmVtb3ZlIHRoZW0gaW4gc2h1
dGRvd24uIE1heWJlIHdlIGNvdWxkIHRyeSBhIG1vZGVtIHJlc2V0IGhlcmUsIHdpdGhpbiBhIGxp
bWl0ZWQgbnVtYmVyIG9mIHJldHJpZXMgaW5zdGVhZD88L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PHNwYW4gY2xhc3M9IiI+PGJy
Pgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAg
MCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPgrCoCDCoCDCoCDCoCB9PGJyPgrCoCB9PGJyPgpAQCAt
MjEzLDcgKzIxNSw2IEBAIHZvaWQgcmlsX3ByZV9zaW0oc3RydWN0IG9mb25vX21vZGVtICptb2Rl
bSk8YnI+CsKgIMKgIMKgIMKgIHNpbV9kYXRhLnJpbF9zdGF0ZV93YXRjaCA9IE5VTEw7PGJyPgo8
YnI+CsKgIMKgIMKgIMKgIHJkLSZndDtzaW0gPSBvZm9ub19zaW1fY3JlYXRlKG1vZGVtLCByZC0m
Z3Q7dmVuZG9yLCBSSUxNT0RFTSwgJmFtcDtzaW1fZGF0YSk7PGJyPgotwqAgwqAgwqAgwqBnX2Fz
c2VydChyZC0mZ3Q7c2ltICE9IE5VTEwpOzxicj4KwqAgfTxicj4KPGJyPgrCoCB2b2lkIHJpbF9w
b3N0X3NpbShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+
Cjxicj48L3NwYW4+ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+Cjxh
IGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9u
by5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL29mb25vIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xp
c3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3Rl
PjwvZGl2Pjxicj48L2Rpdj48L2Rpdj4K

--===============1394419656937996551==--


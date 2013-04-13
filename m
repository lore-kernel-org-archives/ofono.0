Content-Type: multipart/mixed; boundary="===============4918131232998308566=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: Re: [PATCH] handsfree-audio: Fix parsing of Register() CODECs
Date: Fri, 12 Apr 2013 21:06:34 -0300
Message-ID: <CA+A7VXWKR1woyrX8jpP3WE0h6pBt1+iCztrjr4ADs9Y9z-mcoA@mail.gmail.com>
In-Reply-To: <5168964F.5060705@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4918131232998308566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Apr 12, 2013 8:18 PM, "Denis Kenzior" <denkenz@gmail.com> wrote:
>
> Hi Jo=C3=A3o Paulo,
>
>
> On 04/12/2013 05:25 PM, Jo=C3=A3o Paulo Rechi Vita wrote:
>>
>> Without this patch the mSBC CODEC is always enabled, even when the
>> CODECs array in the Register() message from the agent contains only
>> entry for the CVSD (0x01) CODEC.
>> ---
>>   src/handsfree-audio.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
>> index 1a1cbff..3b0814f 100644
>> --- a/src/handsfree-audio.c
>> +++ b/src/handsfree-audio.c
>> @@ -682,9 +682,10 @@ static DBusMessage
*am_agent_register(DBusConnection *conn,
>>                 return __ofono_error_invalid_args(msg);
>>
>>         for (i =3D 0; i<  length; i++) {
>> -               if (codecs[i] =3D=3D HFP_CODEC_CVSD)
>> +               if (codecs[i] =3D=3D HFP_CODEC_CVSD) {
>>                         has_cvsd =3D TRUE;
>> -               else if (codecs[i] !=3D HFP_CODEC_MSBC)
>> +                       continue;
>> +               } else if (codecs[i] !=3D HFP_CODEC_MSBC)
>>                         return __ofono_error_invalid_args(msg);
>>
>>                 if (defer_setup)
>
>
> Good catch.  I'd prefer we fix Patch 7 in Vinicius' series instead of
applying this patch though.
>

The bug fixed by this patch is not related to what patch 7 of Vinicius'
series does and it's present in the upstream master branch. I'm fine if you
prefer it stashed with Vinicius' patch, I'm just bringing up that the
patches do different things.

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita

--===============4918131232998308566==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHAgZGlyPSJsdHIiPjxicj4KT24gQXByIDEyLCAyMDEzIDg6MTggUE0sICZxdW90O0RlbmlzIEtl
bnppb3ImcXVvdDsgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2Vu
ekBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+CiZndDs8YnI+CiZndDsgSGkgSm/Do28gUGF1
bG8sPGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IE9uIDA0LzEyLzIwMTMgMDU6MjUgUE0sIEpv
w6NvIFBhdWxvIFJlY2hpIFZpdGEgd3JvdGU6PGJyPgomZ3Q7Jmd0Ozxicj4KJmd0OyZndDsgV2l0
aG91dCB0aGlzIHBhdGNoIHRoZSBtU0JDIENPREVDIGlzIGFsd2F5cyBlbmFibGVkLCBldmVuIHdo
ZW4gdGhlPGJyPgomZ3Q7Jmd0OyBDT0RFQ3MgYXJyYXkgaW4gdGhlIFJlZ2lzdGVyKCkgbWVzc2Fn
ZSBmcm9tIHRoZSBhZ2VudCBjb250YWlucyBvbmx5PGJyPgomZ3Q7Jmd0OyBlbnRyeSBmb3IgdGhl
IENWU0QgKDB4MDEpIENPREVDLjxicj4KJmd0OyZndDsgLS0tPGJyPgomZ3Q7Jmd0OyDCoCBzcmMv
aGFuZHNmcmVlLWF1ZGlvLmMgfCA1ICsrKy0tPGJyPgomZ3Q7Jmd0OyDCoCAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKTxicj4KJmd0OyZndDs8YnI+CiZndDsm
Z3Q7IGRpZmYgLS1naXQgYS9zcmMvaGFuZHNmcmVlLWF1ZGlvLmMgYi9zcmMvaGFuZHNmcmVlLWF1
ZGlvLmM8YnI+CiZndDsmZ3Q7IGluZGV4IDFhMWNiZmYuLjNiMDgxNGYgMTAwNjQ0PGJyPgomZ3Q7
Jmd0OyAtLS0gYS9zcmMvaGFuZHNmcmVlLWF1ZGlvLmM8YnI+CiZndDsmZ3Q7ICsrKyBiL3NyYy9o
YW5kc2ZyZWUtYXVkaW8uYzxicj4KJmd0OyZndDsgQEAgLTY4Miw5ICs2ODIsMTAgQEAgc3RhdGlj
IERCdXNNZXNzYWdlICphbV9hZ2VudF9yZWdpc3RlcihEQnVzQ29ubmVjdGlvbiAqY29ubiw8YnI+
CiZndDsmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBfX29mb25vX2Vycm9yX2lu
dmFsaWRfYXJncyhtc2cpOzxicj4KJmd0OyZndDs8YnI+CiZndDsmZ3Q7IMKgIMKgIMKgIMKgIGZv
ciAoaSA9IDA7IGkmbHQ7IMKgbGVuZ3RoOyBpKyspIHs8YnI+CiZndDsmZ3Q7IC0gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaWYgKGNvZGVjc1tpXSA9PSBIRlBfQ09ERUNfQ1ZTRCk8YnI+CiZndDsmZ3Q7
ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGNvZGVjc1tpXSA9PSBIRlBfQ09ERUNfQ1ZTRCkg
ezxicj4KJmd0OyZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGFzX2N2
c2QgPSBUUlVFOzxicj4KJmd0OyZndDsgLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlbHNlIGlmIChj
b2RlY3NbaV0gIT0gSEZQX0NPREVDX01TQkMpPGJyPgomZ3Q7Jmd0OyArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVlOzxicj4KJmd0OyZndDsgKyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB9IGVsc2UgaWYgKGNvZGVjc1tpXSAhPSBIRlBfQ09ERUNfTVNCQyk8YnI+CiZndDsm
Z3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBfX29mb25vX2Vy
cm9yX2ludmFsaWRfYXJncyhtc2cpOzxicj4KJmd0OyZndDs8YnI+CiZndDsmZ3Q7IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGlmIChkZWZlcl9zZXR1cCk8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZn
dDsgR29vZCBjYXRjaC4gwqBJJiMzOTtkIHByZWZlciB3ZSBmaXggUGF0Y2ggNyBpbiBWaW5pY2l1
cyYjMzk7IHNlcmllcyBpbnN0ZWFkIG9mIGFwcGx5aW5nIHRoaXMgcGF0Y2ggdGhvdWdoLjxicj4K
Jmd0OzwvcD4KPHAgZGlyPSJsdHIiPlRoZSBidWcgZml4ZWQgYnkgdGhpcyBwYXRjaCBpcyBub3Qg
cmVsYXRlZCB0byB3aGF0IHBhdGNoIDcgb2YgVmluaWNpdXMmIzM5OyBzZXJpZXMgZG9lcyBhbmQg
aXQmIzM5O3MgcHJlc2VudCBpbiB0aGUgdXBzdHJlYW0gbWFzdGVyIGJyYW5jaC4gSSYjMzk7bSBm
aW5lIGlmIHlvdSBwcmVmZXIgaXQgc3Rhc2hlZCB3aXRoIFZpbmljaXVzJiMzOTsgcGF0Y2gsIEkm
IzM5O20ganVzdCBicmluZ2luZyB1cCB0aGF0IHRoZSBwYXRjaGVzIGRvIGRpZmZlcmVudCB0aGlu
Z3MuPC9wPgoKPHAgZGlyPSJsdHIiPi0tPGJyPgpKb8OjbyBQYXVsbyBSZWNoaSBWaXRhPGJyPgo8
YSBocmVmPSJodHRwOi8vYWJvdXQubWUvanBydml0YSI+aHR0cDovL2Fib3V0Lm1lL2pwcnZpdGE8
L2E+PGJyPgo8L3A+Cg==

--===============4918131232998308566==--


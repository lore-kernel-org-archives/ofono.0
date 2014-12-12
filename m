Content-Type: multipart/mixed; boundary="===============0596679951539119989=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Re: [PATCH 0/4] Add AvailableTechnologies property to RadioSettings
Date: Fri, 12 Dec 2014 12:28:16 +0100
Message-ID: <CACM4vuCFupcW844dUhtGTDmiMVPp2wKbGSx2+aJa3mZSPEWKkQ@mail.gmail.com>
In-Reply-To: <54887DE4.6000701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0596679951539119989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 6:07 PM, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Alfonso,
>
>
> On 12/09/2014 06:34 AM, Alfonso Sanchez-Beato wrote:
>
>> This patch series add the AvailableTechnologies property to the
>> RadioSettings interface. Its purpose is to show the list of valid
>> values for the TechnologyPreference property in the same interface.
>> The use case is letting a UI show the possible RATs so the user cannot
>> select an invalid value for a given modem.
>>
>> Alfonso Sanchez-Beato (4):
>>    doc: Add AvailableTechnologies property
>>    include: Add method to list RATs to radio-settings
>>    src: Implement RAT list property
>>    test: Add AvailableTechnologies to list-modems
>>
>>   doc/radio-settings-api.txt |  5 +++++
>>   include/radio-settings.h   | 15 +++++++++++++++
>>   src/radio-settings.c       | 47 ++++++++++++++++++++++++++++++
>> +++++++++++++++-
>>   test/list-modems           |  3 ++-
>>   4 files changed, 68 insertions(+), 2 deletions(-)
>>
>>
> I went ahead and applied all four patches.  However, I did tweak
> include/radio-settings.h and src/radio-settings.c afterwards.
>
> Mostly I changed radio_access_mode into a bit field and future-proofed the
> implementation some.  I think it is quite simpler now.
>
> As a bonus I added a minimalistic radio_settings driver to phonesim and
> caught one or two issues along the way.
>
> If I broke something, please let me know.
>

It worked fine with our driver, thanks. I've submitted a patch for a small
issue I found.

Br,
Alfonso

--===============0596679951539119989==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIFdlZCwgRGVjIDEwLCAyMDE0IGF0IDY6MDcgUE0sIERlbmlzIEtl
bnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5j
b20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90
ZTo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhl
eDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBBbGZvbnNv
LDxkaXY+PGRpdiBjbGFzcz0iaDUiPjxicj4KPGJyPgpPbiAxMi8wOS8yMDE0IDA2OjM0IEFNLCBB
bGZvbnNvIFNhbmNoZXotQmVhdG8gd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KVGhpcyBwYXRjaCBzZXJpZXMgYWRkIHRoZSBBdmFpbGFibGVU
ZWNobm9sb2dpZXMgcHJvcGVydHkgdG8gdGhlPGJyPgpSYWRpb1NldHRpbmdzIGludGVyZmFjZS4g
SXRzIHB1cnBvc2UgaXMgdG8gc2hvdyB0aGUgbGlzdCBvZiB2YWxpZDxicj4KdmFsdWVzIGZvciB0
aGUgVGVjaG5vbG9neVByZWZlcmVuY2UgcHJvcGVydHkgaW4gdGhlIHNhbWUgaW50ZXJmYWNlLjxi
cj4KVGhlIHVzZSBjYXNlIGlzIGxldHRpbmcgYSBVSSBzaG93IHRoZSBwb3NzaWJsZSBSQVRzIHNv
IHRoZSB1c2VyIGNhbm5vdDxicj4Kc2VsZWN0IGFuIGludmFsaWQgdmFsdWUgZm9yIGEgZ2l2ZW4g
bW9kZW0uPGJyPgo8YnI+CkFsZm9uc28gU2FuY2hlei1CZWF0byAoNCk6PGJyPgrCoCDCoGRvYzog
QWRkIEF2YWlsYWJsZVRlY2hub2xvZ2llcyBwcm9wZXJ0eTxicj4KwqAgwqBpbmNsdWRlOiBBZGQg
bWV0aG9kIHRvIGxpc3QgUkFUcyB0byByYWRpby1zZXR0aW5nczxicj4KwqAgwqBzcmM6IEltcGxl
bWVudCBSQVQgbGlzdCBwcm9wZXJ0eTxicj4KwqAgwqB0ZXN0OiBBZGQgQXZhaWxhYmxlVGVjaG5v
bG9naWVzIHRvIGxpc3QtbW9kZW1zPGJyPgo8YnI+CsKgIGRvYy9yYWRpby1zZXR0aW5ncy1hcGku
dHh0IHzCoCA1ICsrKysrPGJyPgrCoCBpbmNsdWRlL3JhZGlvLXNldHRpbmdzLmjCoCDCoHwgMTUg
KysrKysrKysrKysrKysrPGJyPgrCoCBzcmMvcmFkaW8tc2V0dGluZ3MuY8KgIMKgIMKgIMKgfCA0
NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKys8dT48L3U+KysrKysrKysrKysrKysrLTxi
cj4KwqAgdGVzdC9saXN0LW1vZGVtc8KgIMKgIMKgIMKgIMKgIMKgfMKgIDMgKystPGJyPgrCoCA0
IGZpbGVzIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pPGJyPgo8YnI+
CjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2PjwvZGl2PgpJIHdlbnQgYWhlYWQgYW5kIGFwcGxpZWQg
YWxsIGZvdXIgcGF0Y2hlcy7CoCBIb3dldmVyLCBJIGRpZCB0d2VhayBpbmNsdWRlL3JhZGlvLXNl
dHRpbmdzLmggYW5kIHNyYy9yYWRpby1zZXR0aW5ncy5jIGFmdGVyd2FyZHMuPGJyPgo8YnI+Ck1v
c3RseSBJIGNoYW5nZWQgcmFkaW9fYWNjZXNzX21vZGUgaW50byBhIGJpdCBmaWVsZCBhbmQgZnV0
dXJlLXByb29mZWQgdGhlIGltcGxlbWVudGF0aW9uIHNvbWUuwqAgSSB0aGluayBpdCBpcyBxdWl0
ZSBzaW1wbGVyIG5vdy48YnI+Cjxicj4KQXMgYSBib251cyBJIGFkZGVkIGEgbWluaW1hbGlzdGlj
IHJhZGlvX3NldHRpbmdzIGRyaXZlciB0byBwaG9uZXNpbSBhbmQgY2F1Z2h0IG9uZSBvciB0d28g
aXNzdWVzIGFsb25nIHRoZSB3YXkuPGJyPgo8YnI+CklmIEkgYnJva2Ugc29tZXRoaW5nLCBwbGVh
c2UgbGV0IG1lIGtub3cuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pkl0IHdv
cmtlZCBmaW5lIHdpdGggb3VyIGRyaXZlciwgdGhhbmtzLiBJJiMzOTt2ZSBzdWJtaXR0ZWQgYSBw
YXRjaCBmb3IgYSBzbWFsbCBpc3N1ZSBJIGZvdW5kLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
QnIsPC9kaXY+PGRpdj5BbGZvbnNvPC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============0596679951539119989==--


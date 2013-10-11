Content-Type: multipart/mixed; boundary="===============2254679079793092220=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Re: [PATCH] plugins,
 mbpi: make mbpi return only APNs of a given type. When provisioning
 for internect connection,
 only OFONO_GPRS_CONTEXT_TYPE_INTERNET APNs will be returned.
Date: Fri, 11 Oct 2013 18:17:54 +0200
Message-ID: <CACM4vuCbfXX75-tq4mY6JOv1YJ_TXzxOXuPJH+HL6HOfZy2vSQ@mail.gmail.com>
In-Reply-To: <52581E3D.3090202@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2254679079793092220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

No problem with splitting the patch.

The patch is related to the following bug:

https://bugs.launchpad.net/ubuntu/+source/ofono/+bug/1222106

So we were obtaining some times settings for the MMS APN instead of the
internet one. Maybe the change makes it work only for internet connection,
but not for MMS. Would that mean that get_settings() should have a
parameter specifying the context type so the user decides?

Thanks,
Alfonso



On Fri, Oct 11, 2013 at 5:50 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Alfonso,
>
>
> On 10/11/2013 04:24 AM, Alfonso Sanchez-Beato wrote:
>
>> From: Alfonso Sanchez-Beato <alfonsosanchezbeato@yahoo.es>
>>
>> ---
>>   plugins/mbpi.c      | 7 ++++++-
>>   plugins/mbpi.h      | 1 +
>>   plugins/provision.c | 3 ++-
>>   tools/lookup-apn.c  | 3 ++-
>>
>
> Please break this up into three patches, one for mbpi.[ch] changes, one
> for lookup-apn and one for provision.c.  We're not so much concerned with
> breaking git bisect.
>
> Also, please keep the patch title under 72 characters if possible.
> Sentences should be put into the patch description, not the title.
>
>
>    4 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/plugins/mbpi.c b/plugins/mbpi.c
>> index 309e1ed..b3e26fd 100644
>> --- a/plugins/mbpi.c
>> +++ b/plugins/mbpi.c
>> @@ -53,6 +53,7 @@ enum MBPI_ERROR {
>>   struct gsm_data {
>>         const char *match_mcc;
>>         const char *match_mnc;
>> +       enum ofono_gprs_context_type match_type;
>>         GSList *apns;
>>         gboolean match_found;
>>         gboolean allow_duplicates;
>> @@ -370,7 +371,9 @@ static void gsm_end(GMarkupParseContext *context,
>> const gchar *element_name,
>>                 }
>>         }
>>
>> -       gsm->apns =3D g_slist_append(gsm->apns, ap);
>> +       if (gsm->match_type =3D=3D OFONO_GPRS_CONTEXT_TYPE_ANY ||
>> +                       gsm->match_type =3D=3D ap->type)
>> +               gsm->apns =3D g_slist_append(gsm->apns, ap);
>>   }
>>
>>   static const GMarkupParser gsm_parser =3D {
>> @@ -565,6 +568,7 @@ static gboolean mbpi_parse(const GMarkupParser
>> *parser, gpointer userdata,
>>   }
>>
>>   GSList *mbpi_lookup_apn(const char *mcc, const char *mnc,
>> +                       enum ofono_gprs_context_type type,
>>                         gboolean allow_duplicates, GError **error)
>>   {
>>         struct gsm_data gsm;
>> @@ -573,6 +577,7 @@ GSList *mbpi_lookup_apn(const char *mcc, const char
>> *mnc,
>>         memset(&gsm, 0, sizeof(gsm));
>>         gsm.match_mcc =3D mcc;
>>         gsm.match_mnc =3D mnc;
>> +       gsm.match_type =3D type;
>>         gsm.allow_duplicates =3D allow_duplicates;
>>
>>         if (mbpi_parse(&toplevel_gsm_**parser, &gsm, error) =3D=3D FALSE=
) {
>> diff --git a/plugins/mbpi.h b/plugins/mbpi.h
>> index 64b7ea5..36bbed6 100644
>> --- a/plugins/mbpi.h
>> +++ b/plugins/mbpi.h
>> @@ -24,6 +24,7 @@ const char *mbpi_ap_type(enum ofono_gprs_context_type
>> type);
>>   void mbpi_ap_free(struct ofono_gprs_provision_data *data);
>>
>>   GSList *mbpi_lookup_apn(const char *mcc, const char *mnc,
>> +                       enum ofono_gprs_context_type type,
>>                         gboolean allow_duplicates, GError **error);
>>
>>   char *mbpi_lookup_cdma_provider_**name(const char *sid, GError
>> **error);
>>
>
> I'm fine with the above changes, they could be useful I suppose...
>
>
>  diff --git a/plugins/provision.c b/plugins/provision.c
>> index 99c299e..39e037b 100644
>> --- a/plugins/provision.c
>> +++ b/plugins/provision.c
>> @@ -50,7 +50,8 @@ static int provision_get_settings(const char *mcc,
>> const char *mnc,
>>
>>         DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
>>
>> -       apns =3D mbpi_lookup_apn(mcc, mnc, FALSE, &error);
>> +       apns =3D mbpi_lookup_apn(mcc, mnc, OFONO_GPRS_CONTEXT_TYPE_**
>> INTERNET,
>> +                               FALSE, &error);
>>
>
> However, why do you think this is a good idea?  Provisioning should
> provision all context types, not just internet ones.
>
>
>          if (apns =3D=3D NULL) {
>>                 if (error !=3D NULL) {
>>                         ofono_error("%s", error->message);
>> diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
>> index 884b32a..4654b03 100644
>> --- a/tools/lookup-apn.c
>> +++ b/tools/lookup-apn.c
>> @@ -42,7 +42,8 @@ static void lookup_apn(const char *match_mcc, const
>> char *match_mnc,
>>
>>         g_print("Searching for info for network: %s%s\n", match_mcc,
>> match_mnc);
>>
>> -       apns =3D mbpi_lookup_apn(match_mcc, match_mnc, allow_duplicates,
>> &error);
>> +       apns =3D mbpi_lookup_apn(match_mcc, match_mnc,
>> OFONO_GPRS_CONTEXT_TYPE_ANY,
>> +                               allow_duplicates, &error);
>>
>>         if (apns =3D=3D NULL) {
>>                 if (error !=3D NULL) {
>>
>>
> Regards,
> -Denis
>

--===============2254679079793092220==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGRpdj48YnI+PC9kaXY+PGRpdj5ObyBwcm9ibGVtIHdp
dGggc3BsaXR0aW5nIHRoZSBwYXRjaC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBwYXRj
aCBpcyByZWxhdGVkIHRvIHRoZSBmb2xsb3dpbmcgYnVnOjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+PGEgaHJlZj0iaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvdWJ1bnR1Lytzb3VyY2Uvb2Zv
bm8vK2J1Zy8xMjIyMTA2Ij5odHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC91YnVudHUvK3NvdXJj
ZS9vZm9uby8rYnVnLzEyMjIxMDY8L2E+PGJyPgo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlNv
IHdlIHdlcmUgb2J0YWluaW5nIHNvbWUgdGltZXMgc2V0dGluZ3MgZm9yIHRoZSBNTVMgQVBOIGlu
c3RlYWQgb2YgdGhlIGludGVybmV0IG9uZS4gTWF5YmUgdGhlIGNoYW5nZSBtYWtlcyBpdCB3b3Jr
IG9ubHkgZm9yIGludGVybmV0IGNvbm5lY3Rpb24sIGJ1dCBub3QgZm9yIE1NUy4gV291bGQgdGhh
dCBtZWFuIHRoYXQgZ2V0X3NldHRpbmdzKCkgc2hvdWxkIGhhdmUgYSBwYXJhbWV0ZXIgc3BlY2lm
eWluZyB0aGUgY29udGV4dCB0eXBlIHNvIHRoZSB1c2VyIGRlY2lkZXM/PC9kaXY+CjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+QWxmb25zbzwvZGl2PjxkaXY+PGJyPjwvZGl2
PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiBGcmksIE9jdCAxMSwgMjAxMyBhdCA1OjUwIFBNLCBEZW5pcyBLZW56aW9yIDxz
cGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIiB0YXJn
ZXQ9Il9ibGFuayI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPgo8
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBBbGZvbnNvLDxk
aXYgY2xhc3M9ImltIj48YnI+Cjxicj4KT24gMTAvMTEvMjAxMyAwNDoyNCBBTSwgQWxmb25zbyBT
YW5jaGV6LUJlYXRvIHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+CkZyb206IEFsZm9uc28gU2FuY2hlei1CZWF0byAmbHQ7PGEgaHJlZj0ibWFp
bHRvOmFsZm9uc29zYW5jaGV6YmVhdG9AeWFob28uZXMiIHRhcmdldD0iX2JsYW5rIj5hbGZvbnNv
c2FuY2hlemJlYXRvQHlhaG9vLmVzPC9hPiZndDs8YnI+Cjxicj4KLS0tPGJyPgqgIHBsdWdpbnMv
bWJwaS5jIKAgoCCgfCA3ICsrKysrKy08YnI+CqAgcGx1Z2lucy9tYnBpLmggoCCgIKB8IDEgKzxi
cj4KoCBwbHVnaW5zL3Byb3Zpc2lvbi5jIHwgMyArKy08YnI+CqAgdG9vbHMvbG9va3VwLWFwbi5j
IKB8IDMgKystPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L2Rpdj4KUGxlYXNlIGJyZWFrIHRoaXMg
dXAgaW50byB0aHJlZSBwYXRjaGVzLCBvbmUgZm9yIG1icGkuW2NoXSBjaGFuZ2VzLCBvbmUgZm9y
IGxvb2t1cC1hcG4gYW5kIG9uZSBmb3IgcHJvdmlzaW9uLmMuIKBXZSYjMzk7cmUgbm90IHNvIG11
Y2ggY29uY2VybmVkIHdpdGggYnJlYWtpbmcgZ2l0IGJpc2VjdC48YnI+Cjxicj4KQWxzbywgcGxl
YXNlIGtlZXAgdGhlIHBhdGNoIHRpdGxlIHVuZGVyIDcyIGNoYXJhY3RlcnMgaWYgcG9zc2libGUu
IFNlbnRlbmNlcyBzaG91bGQgYmUgcHV0IGludG8gdGhlIHBhdGNoIGRlc2NyaXB0aW9uLCBub3Qg
dGhlIHRpdGxlLjxkaXY+PGRpdiBjbGFzcz0iaDUiPjxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHgg
I2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KoCA0IGZpbGVzIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pPGJyPgo8YnI+CmRpZmYgLS1naXQgYS9wbHVnaW5zL21i
cGkuYyBiL3BsdWdpbnMvbWJwaS5jPGJyPgppbmRleCAzMDllMWVkLi5iM2UyNmZkIDEwMDY0NDxi
cj4KLS0tIGEvcGx1Z2lucy9tYnBpLmM8YnI+CisrKyBiL3BsdWdpbnMvbWJwaS5jPGJyPgpAQCAt
NTMsNiArNTMsNyBAQCBlbnVtIE1CUElfRVJST1Igezxicj4KoCBzdHJ1Y3QgZ3NtX2RhdGEgezxi
cj4KoCCgIKAgoCBjb25zdCBjaGFyICptYXRjaF9tY2M7PGJyPgqgIKAgoCCgIGNvbnN0IGNoYXIg
Km1hdGNoX21uYzs8YnI+CisgoCCgIKAgZW51bSBvZm9ub19ncHJzX2NvbnRleHRfdHlwZSBtYXRj
aF90eXBlOzxicj4KoCCgIKAgoCBHU0xpc3QgKmFwbnM7PGJyPgqgIKAgoCCgIGdib29sZWFuIG1h
dGNoX2ZvdW5kOzxicj4KoCCgIKAgoCBnYm9vbGVhbiBhbGxvd19kdXBsaWNhdGVzOzxicj4KQEAg
LTM3MCw3ICszNzEsOSBAQCBzdGF0aWMgdm9pZCBnc21fZW5kKEdNYXJrdXBQYXJzZUNvbnRleHQg
KmNvbnRleHQsIGNvbnN0IGdjaGFyICplbGVtZW50X25hbWUsPGJyPgqgIKAgoCCgIKAgoCCgIKAg
fTxicj4KoCCgIKAgoCB9PGJyPgo8YnI+Ci0goCCgIKAgZ3NtLSZndDthcG5zID0gZ19zbGlzdF9h
cHBlbmQoZ3NtLSZndDthcG5zLCBhcCk7PGJyPgorIKAgoCCgIGlmIChnc20tJmd0O21hdGNoX3R5
cGUgPT0gT0ZPTk9fR1BSU19DT05URVhUX1RZUEVfQU5ZIHx8PGJyPgorIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCBnc20tJmd0O21hdGNoX3R5cGUgPT0gYXAtJmd0O3R5cGUpPGJyPgorIKAgoCCgIKAg
oCCgIKAgZ3NtLSZndDthcG5zID0gZ19zbGlzdF9hcHBlbmQoZ3NtLSZndDthcG5zLCBhcCk7PGJy
PgqgIH08YnI+Cjxicj4KoCBzdGF0aWMgY29uc3QgR01hcmt1cFBhcnNlciBnc21fcGFyc2VyID0g
ezxicj4KQEAgLTU2NSw2ICs1NjgsNyBAQCBzdGF0aWMgZ2Jvb2xlYW4gbWJwaV9wYXJzZShjb25z
dCBHTWFya3VwUGFyc2VyICpwYXJzZXIsIGdwb2ludGVyIHVzZXJkYXRhLDxicj4KoCB9PGJyPgo8
YnI+CqAgR1NMaXN0ICptYnBpX2xvb2t1cF9hcG4oY29uc3QgY2hhciAqbWNjLCBjb25zdCBjaGFy
ICptbmMsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBlbnVtIG9mb25vX2dwcnNfY29udGV4
dF90eXBlIHR5cGUsPGJyPgqgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBnYm9vbGVhbiBhbGxvd19k
dXBsaWNhdGVzLCBHRXJyb3IgKiplcnJvcik8YnI+CqAgezxicj4KoCCgIKAgoCBzdHJ1Y3QgZ3Nt
X2RhdGEgZ3NtOzxicj4KQEAgLTU3Myw2ICs1NzcsNyBAQCBHU0xpc3QgKm1icGlfbG9va3VwX2Fw
bihjb25zdCBjaGFyICptY2MsIGNvbnN0IGNoYXIgKm1uYyw8YnI+CqAgoCCgIKAgbWVtc2V0KCZh
bXA7Z3NtLCAwLCBzaXplb2YoZ3NtKSk7PGJyPgqgIKAgoCCgIGdzbS5tYXRjaF9tY2MgPSBtY2M7
PGJyPgqgIKAgoCCgIGdzbS5tYXRjaF9tbmMgPSBtbmM7PGJyPgorIKAgoCCgIGdzbS5tYXRjaF90
eXBlID0gdHlwZTs8YnI+CqAgoCCgIKAgZ3NtLmFsbG93X2R1cGxpY2F0ZXMgPSBhbGxvd19kdXBs
aWNhdGVzOzxicj4KPGJyPgqgIKAgoCCgIGlmIChtYnBpX3BhcnNlKCZhbXA7dG9wbGV2ZWxfZ3Nt
Xzx1PjwvdT5wYXJzZXIsICZhbXA7Z3NtLCBlcnJvcikgPT0gRkFMU0UpIHs8YnI+CmRpZmYgLS1n
aXQgYS9wbHVnaW5zL21icGkuaCBiL3BsdWdpbnMvbWJwaS5oPGJyPgppbmRleCA2NGI3ZWE1Li4z
NmJiZWQ2IDEwMDY0NDxicj4KLS0tIGEvcGx1Z2lucy9tYnBpLmg8YnI+CisrKyBiL3BsdWdpbnMv
bWJwaS5oPGJyPgpAQCAtMjQsNiArMjQsNyBAQCBjb25zdCBjaGFyICptYnBpX2FwX3R5cGUoZW51
bSBvZm9ub19ncHJzX2NvbnRleHRfdHlwZSB0eXBlKTs8YnI+CqAgdm9pZCBtYnBpX2FwX2ZyZWUo
c3RydWN0IG9mb25vX2dwcnNfcHJvdmlzaW9uX2RhdGEgKmRhdGEpOzxicj4KPGJyPgqgIEdTTGlz
dCAqbWJwaV9sb29rdXBfYXBuKGNvbnN0IGNoYXIgKm1jYywgY29uc3QgY2hhciAqbW5jLDxicj4K
KyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgZW51bSBvZm9ub19ncHJzX2NvbnRleHRfdHlwZSB0eXBl
LDxicj4KoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgZ2Jvb2xlYW4gYWxsb3dfZHVwbGljYXRlcywg
R0Vycm9yICoqZXJyb3IpOzxicj4KPGJyPgqgIGNoYXIgKm1icGlfbG9va3VwX2NkbWFfcHJvdmlk
ZXJfPHU+PC91Pm5hbWUoY29uc3QgY2hhciAqc2lkLCBHRXJyb3IgKiplcnJvcik7PGJyPgo8L2Js
b2NrcXVvdGU+Cjxicj48L2Rpdj48L2Rpdj4KSSYjMzk7bSBmaW5lIHdpdGggdGhlIGFib3ZlIGNo
YW5nZXMsIHRoZXkgY291bGQgYmUgdXNlZnVsIEkgc3VwcG9zZS4uLjxkaXYgY2xhc3M9ImltIj48
YnI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CmRp
ZmYgLS1naXQgYS9wbHVnaW5zL3Byb3Zpc2lvbi5jIGIvcGx1Z2lucy9wcm92aXNpb24uYzxicj4K
aW5kZXggOTljMjk5ZS4uMzllMDM3YiAxMDA2NDQ8YnI+Ci0tLSBhL3BsdWdpbnMvcHJvdmlzaW9u
LmM8YnI+CisrKyBiL3BsdWdpbnMvcHJvdmlzaW9uLmM8YnI+CkBAIC01MCw3ICs1MCw4IEBAIHN0
YXRpYyBpbnQgcHJvdmlzaW9uX2dldF9zZXR0aW5ncyhjb25zdCBjaGFyICptY2MsIGNvbnN0IGNo
YXIgKm1uYyw8YnI+Cjxicj4KoCCgIKAgoCBEQkcoJnF1b3Q7UHJvdmlzaW9uaW5nIGZvciBNQ0Mg
JXMsIE1OQyAlcywgU1BOICYjMzk7JXMmIzM5OyZxdW90OywgbWNjLCBtbmMsIHNwbik7PGJyPgo8
YnI+Ci0goCCgIKAgYXBucyA9IG1icGlfbG9va3VwX2FwbihtY2MsIG1uYywgRkFMU0UsICZhbXA7
ZXJyb3IpOzxicj4KKyCgIKAgoCBhcG5zID0gbWJwaV9sb29rdXBfYXBuKG1jYywgbW5jLCBPRk9O
T19HUFJTX0NPTlRFWFRfVFlQRV88dT48L3U+SU5URVJORVQsPGJyPgorIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIEZBTFNFLCAmYW1wO2Vycm9yKTs8YnI+CjwvYmxvY2txdW90ZT4KPGJy
PjwvZGl2PgpIb3dldmVyLCB3aHkgZG8geW91IHRoaW5rIHRoaXMgaXMgYSBnb29kIGlkZWE/IKBQ
cm92aXNpb25pbmcgc2hvdWxkIHByb3Zpc2lvbiBhbGwgY29udGV4dCB0eXBlcywgbm90IGp1c3Qg
aW50ZXJuZXQgb25lcy48ZGl2IGNsYXNzPSJpbSI+PGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgqgIKAgoCCgIGlmIChhcG5zID09IE5VTEwpIHs8
YnI+CqAgoCCgIKAgoCCgIKAgoCBpZiAoZXJyb3IgIT0gTlVMTCkgezxicj4KoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgb2Zvbm9fZXJyb3IoJnF1b3Q7JXMmcXVvdDssIGVycm9yLSZndDttZXNzYWdl
KTs8YnI+CmRpZmYgLS1naXQgYS90b29scy9sb29rdXAtYXBuLmMgYi90b29scy9sb29rdXAtYXBu
LmM8YnI+CmluZGV4IDg4NGIzMmEuLjQ2NTRiMDMgMTAwNjQ0PGJyPgotLS0gYS90b29scy9sb29r
dXAtYXBuLmM8YnI+CisrKyBiL3Rvb2xzL2xvb2t1cC1hcG4uYzxicj4KQEAgLTQyLDcgKzQyLDgg
QEAgc3RhdGljIHZvaWQgbG9va3VwX2Fwbihjb25zdCBjaGFyICptYXRjaF9tY2MsIGNvbnN0IGNo
YXIgKm1hdGNoX21uYyw8YnI+Cjxicj4KoCCgIKAgoCBnX3ByaW50KCZxdW90O1NlYXJjaGluZyBm
b3IgaW5mbyBmb3IgbmV0d29yazogJXMlc1xuJnF1b3Q7LCBtYXRjaF9tY2MsIG1hdGNoX21uYyk7
PGJyPgo8YnI+Ci0goCCgIKAgYXBucyA9IG1icGlfbG9va3VwX2FwbihtYXRjaF9tY2MsIG1hdGNo
X21uYywgYWxsb3dfZHVwbGljYXRlcywgJmFtcDtlcnJvcik7PGJyPgorIKAgoCCgIGFwbnMgPSBt
YnBpX2xvb2t1cF9hcG4obWF0Y2hfbWNjLCBtYXRjaF9tbmMsIE9GT05PX0dQUlNfQ09OVEVYVF9U
WVBFX0FOWSw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgYWxsb3dfZHVwbGlj
YXRlcywgJmFtcDtlcnJvcik7PGJyPgo8YnI+CqAgoCCgIKAgaWYgKGFwbnMgPT0gTlVMTCkgezxi
cj4KoCCgIKAgoCCgIKAgoCCgIGlmIChlcnJvciAhPSBOVUxMKSB7PGJyPgo8YnI+CjwvYmxvY2tx
dW90ZT4KPGJyPjwvZGl2PgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Jsb2NrcXVvdGU+PC9k
aXY+PGJyPjwvZGl2Pgo=

--===============2254679079793092220==--


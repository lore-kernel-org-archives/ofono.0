Content-Type: multipart/mixed; boundary="===============0375737891024447174=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: Re: [PATCH v2 09/12] emulator: Add HFP 1.6 AG card driver
Date: Fri, 26 Apr 2013 16:20:49 -0300
Message-ID: <CAG7KCRG898_AprzTwYJnhmThAPFtQYRiGwuymLR3TB5FC+JOPg@mail.gmail.com>
In-Reply-To: <517A756D.2060305@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0375737891024447174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Apr 26, 2013 at 9:39 AM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Paulo,
>
>
> On 04/26/2013 12:53 PM, Paulo Borges wrote:
>
>> Hi Denis,
>>
>> On Thu, Apr 25, 2013 at 2:58 PM, Denis Kenzior <denkenz@gmail.com
>> <mailto:denkenz@gmail.com>> wrote:
>>
>>     Hi Paulo,
>>
>>
>>     On 04/25/2013 02:09 PM, Paulo Borges wrote:
>>
>>         ---
>>            src/emulator.c |   31 ++++++++++++++++++++++++++++++**__-
>>
>>            1 file changed, 30 insertions(+), 1 deletion(-)
>>
>>         diff --git a/src/emulator.c b/src/emulator.c
>>         index 8ac79d5..5027b02 100644
>>         --- a/src/emulator.c
>>         +++ b/src/emulator.c
>>         @@ -45,6 +45,8 @@
>>
>>            #define RING_TIMEOUT 3
>>
>>         +#define HFP_16_AG_DRIVER "hfp16-ag-driver"
>>         +
>>            struct ofono_emulator {
>>                  struct ofono_atom *atom;
>>                  enum ofono_emulator_type type;
>>         @@ -1007,6 +1009,32 @@ struct ofono_emulator
>>         *ofono_emulator_create(struct ofono_modem *modem,
>>                  return em;
>>            }
>>
>>         +static int hfp16_card_probe(struct ofono_handsfree_card *card,
>>         +                                       unsigned int vendor,
>>         void *data)
>>         +{
>>         +       DBG("HFP 1.6 AG card driver probe");
>>         +
>>         +       return 0;
>>         +}
>>         +
>>         +static void hfp16_card_remove(struct ofono_handsfree_card *card)
>>         +{
>>         +       DBG("HFP 1.6 AG card driver remove");
>>         +}
>>         +
>>         +static void hfp16_card_connect(struct ofono_handsfree_card *car=
d,
>>         +                       ofono_handsfree_card_connect__**_cb_t cb,
>>
>>         void *data)
>>         +{
>>         +       DBG("HFP 1.6 AG card driver connect");
>>         +}
>>         +
>>         +static struct ofono_handsfree_card_driver hfp16_ag_driver =3D {
>>         +       .name           =3D HFP_16_AG_DRIVER,
>>         +       .probe          =3D hfp16_card_probe,
>>         +       .remove         =3D hfp16_card_remove,
>>         +       .connect        =3D hfp16_card_connect,
>>         +};
>>         +
>>
>>
>>     So why do we need this exactly?  There is already a default
>>     implementation inside handsfree_audio_card if the driver is NULL.
>>       How is this going to be different from the default implementation?
>>
>>
>>            static int card_set_local_remote(struct ofono_handsfree_card
>>         *card, int fd)
>>            {
>>                  struct sockaddr_rc saddr;
>>         @@ -1338,9 +1366,10 @@ void
>>         __ofono_emulator_set___**indicator_forced(struct ofono_emulator
>> *em,
>>
>>
>>            int __ofono_emulator_init(void)
>>            {
>>         -       return 0;
>>         +       return
>>         ofono_handsfree_card_driver___**register(&hfp16_ag_driver);
>>            }
>>
>>            void __ofono_emulator_cleanup(void)
>>            {
>>         +       ofono_handsfree_card_driver___**
>> unregister(&hfp16_ag_driver);
>>
>>            }
>>
>>
>>     Regards,
>>     -Denis
>>
>>
>> When both roles support codec negotiation feature AG must first send an
>> unsolicited +BCS and only call the default implementation after HF
>> respond with AT+BCS [1].
>>
>> [1] HFP 1.6 spec page 31: 4.11.3 "Codec Connection Setup".
>>
>>
> This is where the spec is a bit fuzzy.  There is some room for
> interpretation on the timing of the codec negotiation exchange.
>
> Can we do the codec negotiation before hand, not as part of the .connect
> implementation?  e.g. can we negotiate the codec right after SLC
> establishment and from then on simply establish the SCO link, or must we
> always perform codec negotiation right before the SCO link establishment?
>
> Regards,
> -Denis
>

Yes, we can negotiate the codec after an incoming AT+BAC command from HF.
This way, we can ensure that the chosen codec is valid and we don't need to
use a card driver.

I'll change this and send a new version.

-- =

Cheers,
Paulo.

--===============0375737891024447174==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiIHN0eWxlPSJmb250LWZhbWls
eTphcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxM3B4Ij5IaSBEZW5pcyw8L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBGcmksIEFw
ciAyNiwgMjAxMyBhdCA5OjM5IEFNLCBEZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7
PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2Vu
ekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQt
d2lkdGg6MXB4O2JvcmRlci1sZWZ0LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7Ym9yZGVyLWxlZnQt
c3R5bGU6c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+SGkgUGF1bG8sPGRpdiBjbGFzcz0iaW0iPjxi
cj4KPGJyPgpPbiAwNC8yNi8yMDEzIDEyOjUzIFBNLCBQYXVsbyBCb3JnZXMgd3JvdGU6PGJyPgo8
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LWNvbG9yOnJnYigy
MDQsMjA0LDIwNCk7Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRp
diBjbGFzcz0iaW0iPgpIaSBEZW5pcyw8YnI+Cjxicj4KT24gVGh1LCBBcHIgMjUsIDIwMTMgYXQg
Mjo1OCBQTSwgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2VuekBnbWFpbC5jb208L2E+PGJyPjwvZGl2PjxkaXYg
Y2xhc3M9ImltIj4KJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20i
IHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0OyB3cm90ZTo8YnI+
Cjxicj4KoCCgIEhpIFBhdWxvLDxicj4KPGJyPgo8YnI+CqAgoCBPbiAwNC8yNS8yMDEzIDAyOjA5
IFBNLCBQYXVsbyBCb3JnZXMgd3JvdGU6PGJyPgo8YnI+CqAgoCCgIKAgLS0tPGJyPjwvZGl2Pgqg
IKAgoCCgIKAgoHNyYy9lbXVsYXRvci5jIHwgoCAzMSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKys8dT48L3U+X18tPGRpdj48ZGl2IGNsYXNzPSJoNSI+PGJyPgqgIKAgoCCgIKAgoDEgZmls
ZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pPGJyPgo8YnI+CqAgoCCg
IKAgZGlmZiAtLWdpdCBhL3NyYy9lbXVsYXRvci5jIGIvc3JjL2VtdWxhdG9yLmM8YnI+CqAgoCCg
IKAgaW5kZXggOGFjNzlkNS4uNTAyN2IwMiAxMDA2NDQ8YnI+CqAgoCCgIKAgLS0tIGEvc3JjL2Vt
dWxhdG9yLmM8YnI+CqAgoCCgIKAgKysrIGIvc3JjL2VtdWxhdG9yLmM8YnI+CqAgoCCgIKAgQEAg
LTQ1LDYgKzQ1LDggQEA8YnI+Cjxicj4KoCCgIKAgoCCgIKAjZGVmaW5lIFJJTkdfVElNRU9VVCAz
PGJyPgo8YnI+CqAgoCCgIKAgKyNkZWZpbmUgSEZQXzE2X0FHX0RSSVZFUiAmcXVvdDtoZnAxNi1h
Zy1kcml2ZXImcXVvdDs8YnI+CqAgoCCgIKAgKzxicj4KoCCgIKAgoCCgIKBzdHJ1Y3Qgb2Zvbm9f
ZW11bGF0b3Igezxicj4KoCCgIKAgoCCgIKAgoCCgIKBzdHJ1Y3Qgb2Zvbm9fYXRvbSAqYXRvbTs8
YnI+CqAgoCCgIKAgoCCgIKAgoCCgZW51bSBvZm9ub19lbXVsYXRvcl90eXBlIHR5cGU7PGJyPgqg
IKAgoCCgIEBAIC0xMDA3LDYgKzEwMDksMzIgQEAgc3RydWN0IG9mb25vX2VtdWxhdG9yPGJyPgqg
IKAgoCCgICpvZm9ub19lbXVsYXRvcl9jcmVhdGUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSw8
YnI+CqAgoCCgIKAgoCCgIKAgoCCgcmV0dXJuIGVtOzxicj4KoCCgIKAgoCCgIKB9PGJyPgo8YnI+
CqAgoCCgIKAgK3N0YXRpYyBpbnQgaGZwMTZfY2FyZF9wcm9iZShzdHJ1Y3Qgb2Zvbm9faGFuZHNm
cmVlX2NhcmQgKmNhcmQsPGJyPgqgIKAgoCCgICsgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCB1bnNpZ25lZCBpbnQgdmVuZG9yLDxicj4KoCCgIKAgoCB2b2lkICpkYXRhKTxi
cj4KoCCgIKAgoCArezxicj4KoCCgIKAgoCArIKAgoCCgIERCRygmcXVvdDtIRlAgMS42IEFHIGNh
cmQgZHJpdmVyIHByb2JlJnF1b3Q7KTs8YnI+CqAgoCCgIKAgKzxicj4KoCCgIKAgoCArIKAgoCCg
IHJldHVybiAwOzxicj4KoCCgIKAgoCArfTxicj4KoCCgIKAgoCArPGJyPgqgIKAgoCCgICtzdGF0
aWMgdm9pZCBoZnAxNl9jYXJkX3JlbW92ZShzdHJ1Y3Qgb2Zvbm9faGFuZHNmcmVlX2NhcmQgKmNh
cmQpPGJyPgqgIKAgoCCgICt7PGJyPgqgIKAgoCCgICsgoCCgIKAgREJHKCZxdW90O0hGUCAxLjYg
QUcgY2FyZCBkcml2ZXIgcmVtb3ZlJnF1b3Q7KTs8YnI+CqAgoCCgIKAgK308YnI+CqAgoCCgIKAg
Kzxicj4KoCCgIKAgoCArc3RhdGljIHZvaWQgaGZwMTZfY2FyZF9jb25uZWN0KHN0cnVjdCBvZm9u
b19oYW5kc2ZyZWVfY2FyZCAqY2FyZCw8YnI+PC9kaXY+PC9kaXY+CqAgoCCgIKAgKyCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgb2Zvbm9faGFuZHNmcmVlX2NhcmRfY29ubmVjdF9fPHU+PC91Pl9jYl90
IGNiLDxkaXYgY2xhc3M9ImltIj48YnI+CqAgoCCgIKAgdm9pZCAqZGF0YSk8YnI+CqAgoCCgIKAg
K3s8YnI+CqAgoCCgIKAgKyCgIKAgoCBEQkcoJnF1b3Q7SEZQIDEuNiBBRyBjYXJkIGRyaXZlciBj
b25uZWN0JnF1b3Q7KTs8YnI+CqAgoCCgIKAgK308YnI+CqAgoCCgIKAgKzxicj4KoCCgIKAgoCAr
c3RhdGljIHN0cnVjdCBvZm9ub19oYW5kc2ZyZWVfY2FyZF9kcml2ZXIgaGZwMTZfYWdfZHJpdmVy
ID0gezxicj4KoCCgIKAgoCArIKAgoCCgIC5uYW1lIKAgoCCgIKAgoCA9IEhGUF8xNl9BR19EUklW
RVIsPGJyPgqgIKAgoCCgICsgoCCgIKAgLnByb2JlIKAgoCCgIKAgoD0gaGZwMTZfY2FyZF9wcm9i
ZSw8YnI+CqAgoCCgIKAgKyCgIKAgoCAucmVtb3ZlIKAgoCCgIKAgPSBoZnAxNl9jYXJkX3JlbW92
ZSw8YnI+CqAgoCCgIKAgKyCgIKAgoCAuY29ubmVjdCCgIKAgoCCgPSBoZnAxNl9jYXJkX2Nvbm5l
Y3QsPGJyPgqgIKAgoCCgICt9Ozxicj4KoCCgIKAgoCArPGJyPgo8YnI+Cjxicj4KoCCgIFNvIHdo
eSBkbyB3ZSBuZWVkIHRoaXMgZXhhY3RseT8goFRoZXJlIGlzIGFscmVhZHkgYSBkZWZhdWx0PGJy
PgqgIKAgaW1wbGVtZW50YXRpb24gaW5zaWRlIGhhbmRzZnJlZV9hdWRpb19jYXJkIGlmIHRoZSBk
cml2ZXIgaXMgTlVMTC48YnI+CqAgoCCgIEhvdyBpcyB0aGlzIGdvaW5nIHRvIGJlIGRpZmZlcmVu
dCBmcm9tIHRoZSBkZWZhdWx0IGltcGxlbWVudGF0aW9uPzxicj4KPGJyPgo8YnI+CqAgoCCgIKAg
oCCgc3RhdGljIGludCBjYXJkX3NldF9sb2NhbF9yZW1vdGUoc3RydWN0IG9mb25vX2hhbmRzZnJl
ZV9jYXJkPGJyPgqgIKAgoCCgICpjYXJkLCBpbnQgZmQpPGJyPgqgIKAgoCCgIKAgoHs8YnI+CqAg
oCCgIKAgoCCgIKAgoCCgc3RydWN0IHNvY2thZGRyX3JjIHNhZGRyOzxicj4KoCCgIKAgoCBAQCAt
MTMzOCw5ICsxMzY2LDEwIEBAIHZvaWQ8YnI+PC9kaXY+CqAgoCCgIKAgX19vZm9ub19lbXVsYXRv
cl9zZXRfX188dT48L3U+aW5kaWNhdG9yX2ZvcmNlZChzdHJ1Y3Qgb2Zvbm9fZW11bGF0b3IgKmVt
LDxkaXYgY2xhc3M9ImltIj48YnI+Cjxicj4KoCCgIKAgoCCgIKBpbnQgX19vZm9ub19lbXVsYXRv
cl9pbml0KHZvaWQpPGJyPgqgIKAgoCCgIKAgoHs8YnI+CqAgoCCgIKAgLSCgIKAgoCByZXR1cm4g
MDs8YnI+CqAgoCCgIKAgKyCgIKAgoCByZXR1cm48YnI+PC9kaXY+CqAgoCCgIKAgb2Zvbm9faGFu
ZHNmcmVlX2NhcmRfZHJpdmVyX19fPHU+PC91PnJlZ2lzdGVyKCZhbXA7aGZwMTZfYWdfZHJpdmVy
KTs8YnI+CqAgoCCgIKAgoCCgfTxicj4KPGJyPgqgIKAgoCCgIKAgoHZvaWQgX19vZm9ub19lbXVs
YXRvcl9jbGVhbnVwKHZvaWQpPGJyPgqgIKAgoCCgIKAgoHs8YnI+CqAgoCCgIKAgKyCgIKAgoCBv
Zm9ub19oYW5kc2ZyZWVfY2FyZF9kcml2ZXJfX188dT48L3U+dW5yZWdpc3RlcigmYW1wO2hmcDE2
X2FnX2RyaXZlcik7PGRpdiBjbGFzcz0iaW0iPjxicj4KoCCgIKAgoCCgIKB9PGJyPgo8YnI+Cjxi
cj4KoCCgIFJlZ2FyZHMsPGJyPgqgIKAgLURlbmlzPGJyPgo8YnI+Cjxicj4KV2hlbiBib3RoIHJv
bGVzIHN1cHBvcnQgY29kZWMgbmVnb3RpYXRpb24gZmVhdHVyZSBBRyBtdXN0IGZpcnN0IHNlbmQg
YW48YnI+CnVuc29saWNpdGVkICtCQ1MgYW5kIG9ubHkgY2FsbCB0aGUgZGVmYXVsdCBpbXBsZW1l
bnRhdGlvbiBhZnRlciBIRjxicj4KcmVzcG9uZCB3aXRoIEFUK0JDUyBbMV0uPGJyPgo8YnI+Clsx
XSBIRlAgMS42IHNwZWMgcGFnZSAzMTogNC4xMS4zICZxdW90O0NvZGVjIENvbm5lY3Rpb24gU2V0
dXAmcXVvdDsuPGJyPgo8YnI+CjwvZGl2PjwvYmxvY2txdW90ZT4KPGJyPgpUaGlzIGlzIHdoZXJl
IHRoZSBzcGVjIGlzIGEgYml0IGZ1enp5LiCgVGhlcmUgaXMgc29tZSByb29tIGZvciBpbnRlcnBy
ZXRhdGlvbiBvbiB0aGUgdGltaW5nIG9mIHRoZSBjb2RlYyBuZWdvdGlhdGlvbiBleGNoYW5nZS48
YnI+Cjxicj4KQ2FuIHdlIGRvIHRoZSBjb2RlYyBuZWdvdGlhdGlvbiBiZWZvcmUgaGFuZCwgbm90
IGFzIHBhcnQgb2YgdGhlIC5jb25uZWN0IGltcGxlbWVudGF0aW9uPyCgZS5nLiBjYW4gd2UgbmVn
b3RpYXRlIHRoZSBjb2RlYyByaWdodCBhZnRlciBTTEMgZXN0YWJsaXNobWVudCBhbmQgZnJvbSB0
aGVuIG9uIHNpbXBseSBlc3RhYmxpc2ggdGhlIFNDTyBsaW5rLCBvciBtdXN0IHdlIGFsd2F5cyBw
ZXJmb3JtIGNvZGVjIG5lZ290aWF0aW9uIHJpZ2h0IGJlZm9yZSB0aGUgU0NPIGxpbmsgZXN0YWJs
aXNobWVudD88YnI+Cgo8YnI+ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+CjwvYmxvY2txdW90ZT48
L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiIHN0eWxlPSJmb250LXNpemU6MTNweDtm
b250LWZhbWlseTphcmlhbCxzYW5zLXNlcmlmIj5ZZXMsIHdlIGNhbiBuZWdvdGlhdGUgdGhlIGNv
ZGVjIGFmdGVyIGFuIGluY29taW5nIEFUK0JBQyBjb21tYW5kIGZyb20gSEYuIFRoaXMgd2F5LCB3
ZSBjYW4gZW5zdXJlIHRoYXQgdGhlIGNob3NlbiBjb2RlYyBpcyB2YWxpZCBhbmQgd2UgZG9uJiMz
OTt0IG5lZWQgdG8gdXNlIGEgY2FyZCBkcml2ZXIuPC9kaXY+CjxkaXYgY2xhc3M9ImdtYWlsX2V4
dHJhIiBzdHlsZT0iZm9udC1zaXplOjEzcHg7Zm9udC1mYW1pbHk6YXJpYWwsc2Fucy1zZXJpZiI+
PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIiBzdHlsZT0iZm9udC1zaXplOjEzcHg7
Zm9udC1mYW1pbHk6YXJpYWwsc2Fucy1zZXJpZiI+SSYjMzk7bGwgY2hhbmdlIHRoaXMgYW5kIHNl
bmQgYSBuZXcgdmVyc2lvbi48L2Rpdj48ZGl2Pjxicj4KPC9kaXY+LS0gPGJyPjxkaXYgZGlyPSJs
dHIiPkNoZWVycyw8ZGl2PlBhdWxvLjwvZGl2PjwvZGl2Pgo8L2Rpdj48L2Rpdj4K

--===============0375737891024447174==--


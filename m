Content-Type: multipart/mixed; boundary="===============2396466989852507252=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH v7 7/7] plugins/gemalto: use Gemalto lte atom
Date: Fri, 19 Oct 2018 08:04:12 +0200
Message-ID: <CAKSBH7GJdVHAwmXV0pK52AbD5twvfrpUZPFmwzLTb8mXjgPpeA@mail.gmail.com>
In-Reply-To: <40602bd7-b3c2-ad03-80ab-e316a59babc1@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2396466989852507252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi,

On Fri, 19 Oct 2018, 07:57 Jonas Bonn, <jonas@norrbonn.se> wrote:

>
>
> On 19/10/18 05:09, Giacinto Cifelli wrote:
> > Hi Jonas,
> >
> > On Thu, Oct 18, 2018 at 9:41 PM Jonas Bonn <jonas@norrbonn.se> wrote:
> >>
> >> Hi Giacinto,
> >>
> >> On 18/10/18 20:49, Giacinto Cifelli wrote:
> >>> Switch from atmodem to gemaltomodem for the lte atom, in order to
> >>> benefit from the correct syntax for the AT commands.
> >>> The current models included in the Gemalto plugin only use one type
> >>> of authentication syntax, despite the atom supporting the syntax for
> >>> all Gemalto modules.
> >>> Therefore for now the variable GemaltoAuthType is set to a fixed valu=
e,
> >>> independent on the model.
> >>> ---
> >>>    plugins/gemalto.c | 16 +++++++++++++---
> >>>    1 file changed, 13 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> >>> index 5d3c77a9..3ca9f2d6 100644
> >>> --- a/plugins/gemalto.c
> >>> +++ b/plugins/gemalto.c
> >>> @@ -63,6 +63,13 @@ static const char *none_prefix[] =3D { NULL };
> >>>    static const char *sctm_prefix[] =3D { "^SCTM:", NULL };
> >>>    static const char *sbv_prefix[] =3D { "^SBV:", NULL };
> >>>
> >>> +enum auth_option {
> >>> +     GEMALTO_AUTH_DEFAULTS           =3D 0x00,
> >>> +     GEMALTO_AUTH_USE_SGAUTH         =3D 0x01,
> >>> +     GEMALTO_AUTH_ORDER_PWD_USR      =3D 0x02,
> >>> +     GEMALTO_AUTH_ALW_ALL_PARAMS     =3D 0x04,
> >>> +};
> >>> +
> >>>    struct gemalto_hardware_monitor {
> >>>        DBusMessage *msg;
> >>>        int32_t temperature;
> >>> @@ -609,9 +616,12 @@ static void gemalto_post_sim(struct ofono_modem
> *modem)
> >>>        ofono_call_meter_create(modem, 0, "atmodem", data->app);
> >>>        ofono_call_barring_create(modem, 0, "atmodem", data->app);
> >>>
> >>> -     if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x))
> >>> -             ofono_lte_create(modem, OFONO_VENDOR_CINTERION,
> >>> -                                             "atmodem", data->app);
> >>> +     if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x)) {
> >>> +             ofono_modem_set_integer(modem, "GemaltoAuthType",
> >>> +                                             GEMALTO_AUTH_USE_SGAUTH=
 |
> >>> +
>  GEMALTO_AUTH_ORDER_PWD_USR);
> >>> +             ofono_lte_create(modem, 0, "gemaltomodem", data->app);
> >>
> >> Why not call ofono_modem_get_string(modem, "Model") directly in the LTE
> >> atom in order to get the flags?
> >
> > Because it is not the atom's job.
> > There are other flags planned, and not all will be determined by model.
> > Beside, remembering to update each atom for each new modem is
> error-prone.
>
> It's difficult to provide patch review when part of the job involves
> reading the author's mind to know whither they are going... :)
>
> As things currently stand, the flags are determined _only_ by model and
> are accessed only by gemaltoutil.c.  There's no reason to go from model
> to flags at such a high level.  Put a model_to_flags() function in
> gemaltoutil and keep everything in one place.
>

I think I will remove these last two patches from the series for today.
I see if I can start submitting the Gemalto plugin over the weekend.
It is planned anyway, and even if several features depend on atom support
not yet there, I can at least give the new structure.

Then I will re-submit the lte gemalto afterwards.


> /Jonas
>

Giacinto

--===============2396466989852507252==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9ImF1dG8iPjxkaXY+aGksPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGRpdiBkaXI9Imx0ciI+T24gRnJpLCAxOSBPY3QgMjAxOCwgMDc6NTcgSm9uYXMgQm9ubiwgJmx0
OzxhIGhyZWY9Im1haWx0bzpqb25hc0Bub3JyYm9ubi5zZSI+am9uYXNAbm9ycmJvbm4uc2U8L2E+
Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+PGJyPgo8YnI+Ck9uIDE5LzEwLzE4IDA1OjA5LCBHaWFjaW50byBDaWZlbGxpIHdy
b3RlOjxicj4KJmd0OyBIaSBKb25hcyw8YnI+CiZndDsgPGJyPgomZ3Q7IE9uIFRodSwgT2N0IDE4
LCAyMDE4IGF0IDk6NDEgUE0gSm9uYXMgQm9ubiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmpvbmFzQG5v
cnJib25uLnNlIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj5qb25hc0Bub3JyYm9u
bi5zZTwvYT4mZ3Q7IHdyb3RlOjxicj4KJmd0OyZndDs8YnI+CiZndDsmZ3Q7IEhpIEdpYWNpbnRv
LDxicj4KJmd0OyZndDs8YnI+CiZndDsmZ3Q7IE9uIDE4LzEwLzE4IDIwOjQ5LCBHaWFjaW50byBD
aWZlbGxpIHdyb3RlOjxicj4KJmd0OyZndDsmZ3Q7IFN3aXRjaCBmcm9tIGF0bW9kZW0gdG8gZ2Vt
YWx0b21vZGVtIGZvciB0aGUgbHRlIGF0b20sIGluIG9yZGVyIHRvPGJyPgomZ3Q7Jmd0OyZndDsg
YmVuZWZpdCBmcm9tIHRoZSBjb3JyZWN0IHN5bnRheCBmb3IgdGhlIEFUIGNvbW1hbmRzLjxicj4K
Jmd0OyZndDsmZ3Q7IFRoZSBjdXJyZW50IG1vZGVscyBpbmNsdWRlZCBpbiB0aGUgR2VtYWx0byBw
bHVnaW4gb25seSB1c2Ugb25lIHR5cGU8YnI+CiZndDsmZ3Q7Jmd0OyBvZiBhdXRoZW50aWNhdGlv
biBzeW50YXgsIGRlc3BpdGUgdGhlIGF0b20gc3VwcG9ydGluZyB0aGUgc3ludGF4IGZvcjxicj4K
Jmd0OyZndDsmZ3Q7IGFsbCBHZW1hbHRvIG1vZHVsZXMuPGJyPgomZ3Q7Jmd0OyZndDsgVGhlcmVm
b3JlIGZvciBub3cgdGhlIHZhcmlhYmxlIEdlbWFsdG9BdXRoVHlwZSBpcyBzZXQgdG8gYSBmaXhl
ZCB2YWx1ZSw8YnI+CiZndDsmZ3Q7Jmd0OyBpbmRlcGVuZGVudCBvbiB0aGUgbW9kZWwuPGJyPgom
Z3Q7Jmd0OyZndDsgLS0tPGJyPgomZ3Q7Jmd0OyZndDvCoCDCoCBwbHVnaW5zL2dlbWFsdG8uYyB8
IDE2ICsrKysrKysrKysrKystLS08YnI+CiZndDsmZ3Q7Jmd0O8KgIMKgIDEgZmlsZSBjaGFuZ2Vk
LCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKTxicj4KJmd0OyZndDsmZ3Q7PGJyPgom
Z3Q7Jmd0OyZndDsgZGlmZiAtLWdpdCBhL3BsdWdpbnMvZ2VtYWx0by5jIGIvcGx1Z2lucy9nZW1h
bHRvLmM8YnI+CiZndDsmZ3Q7Jmd0OyBpbmRleCA1ZDNjNzdhOS4uM2NhOWYyZDYgMTAwNjQ0PGJy
PgomZ3Q7Jmd0OyZndDsgLS0tIGEvcGx1Z2lucy9nZW1hbHRvLmM8YnI+CiZndDsmZ3Q7Jmd0OyAr
KysgYi9wbHVnaW5zL2dlbWFsdG8uYzxicj4KJmd0OyZndDsmZ3Q7IEBAIC02Myw2ICs2MywxMyBA
QCBzdGF0aWMgY29uc3QgY2hhciAqbm9uZV9wcmVmaXhbXSA9IHsgTlVMTCB9Ozxicj4KJmd0OyZn
dDsmZ3Q7wqAgwqAgc3RhdGljIGNvbnN0IGNoYXIgKnNjdG1fcHJlZml4W10gPSB7ICZxdW90O15T
Q1RNOiZxdW90OywgTlVMTCB9Ozxicj4KJmd0OyZndDsmZ3Q7wqAgwqAgc3RhdGljIGNvbnN0IGNo
YXIgKnNidl9wcmVmaXhbXSA9IHsgJnF1b3Q7XlNCVjomcXVvdDssIE5VTEwgfTs8YnI+CiZndDsm
Z3Q7Jmd0Ozxicj4KJmd0OyZndDsmZ3Q7ICtlbnVtIGF1dGhfb3B0aW9uIHs8YnI+CiZndDsmZ3Q7
Jmd0OyArwqAgwqAgwqBHRU1BTFRPX0FVVEhfREVGQVVMVFPCoCDCoCDCoCDCoCDCoCDCoD0gMHgw
MCw8YnI+CiZndDsmZ3Q7Jmd0OyArwqAgwqAgwqBHRU1BTFRPX0FVVEhfVVNFX1NHQVVUSMKgIMKg
IMKgIMKgIMKgPSAweDAxLDxicj4KJmd0OyZndDsmZ3Q7ICvCoCDCoCDCoEdFTUFMVE9fQVVUSF9P
UkRFUl9QV0RfVVNSwqAgwqAgwqAgPSAweDAyLDxicj4KJmd0OyZndDsmZ3Q7ICvCoCDCoCDCoEdF
TUFMVE9fQVVUSF9BTFdfQUxMX1BBUkFNU8KgIMKgIMKgPSAweDA0LDxicj4KJmd0OyZndDsmZ3Q7
ICt9Ozxicj4KJmd0OyZndDsmZ3Q7ICs8YnI+CiZndDsmZ3Q7Jmd0O8KgIMKgIHN0cnVjdCBnZW1h
bHRvX2hhcmR3YXJlX21vbml0b3Igezxicj4KJmd0OyZndDsmZ3Q7wqAgwqAgwqAgwqAgREJ1c01l
c3NhZ2UgKm1zZzs8YnI+CiZndDsmZ3Q7Jmd0O8KgIMKgIMKgIMKgIGludDMyX3QgdGVtcGVyYXR1
cmU7PGJyPgomZ3Q7Jmd0OyZndDsgQEAgLTYwOSw5ICs2MTYsMTIgQEAgc3RhdGljIHZvaWQgZ2Vt
YWx0b19wb3N0X3NpbShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxicj4KJmd0OyZndDsmZ3Q7
wqAgwqAgwqAgwqAgb2Zvbm9fY2FsbF9tZXRlcl9jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9k
ZW0mcXVvdDssIGRhdGEtJmd0O2FwcCk7PGJyPgomZ3Q7Jmd0OyZndDvCoCDCoCDCoCDCoCBvZm9u
b19jYWxsX2JhcnJpbmdfY3JlYXRlKG1vZGVtLCAwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRh
LSZndDthcHApOzxicj4KJmd0OyZndDsmZ3Q7PGJyPgomZ3Q7Jmd0OyZndDsgLcKgIMKgIMKgaWYg
KCFnX3N0cmNtcDAobW9kZWwsIEdFTUFMVE9fTU9ERUxfQUxTM19QTFM4eCkpPGJyPgomZ3Q7Jmd0
OyZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgb2Zvbm9fbHRlX2NyZWF0ZShtb2RlbSwgT0ZPTk9f
VkVORE9SX0NJTlRFUklPTiw8YnI+CiZndDsmZ3Q7Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDthdG1v
ZGVtJnF1b3Q7LCBkYXRhLSZndDthcHApOzxicj4KJmd0OyZndDsmZ3Q7ICvCoCDCoCDCoGlmICgh
Z19zdHJjbXAwKG1vZGVsLCBHRU1BTFRPX01PREVMX0FMUzNfUExTOHgpKSB7PGJyPgomZ3Q7Jmd0
OyZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgb2Zvbm9fbW9kZW1fc2V0X2ludGVnZXIobW9kZW0s
ICZxdW90O0dlbWFsdG9BdXRoVHlwZSZxdW90Oyw8YnI+CiZndDsmZ3Q7Jmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBHRU1BTFRPX0FVVEhfVVNFX1NHQVVUSCB8PGJyPgomZ3Q7Jmd0OyZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
R0VNQUxUT19BVVRIX09SREVSX1BXRF9VU1IpOzxicj4KJmd0OyZndDsmZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoG9mb25vX2x0ZV9jcmVhdGUobW9kZW0sIDAsICZxdW90O2dlbWFsdG9tb2RlbSZx
dW90OywgZGF0YS0mZ3Q7YXBwKTs8YnI+CiZndDsmZ3Q7PGJyPgomZ3Q7Jmd0OyBXaHkgbm90IGNh
bGwgb2Zvbm9fbW9kZW1fZ2V0X3N0cmluZyhtb2RlbSwgJnF1b3Q7TW9kZWwmcXVvdDspIGRpcmVj
dGx5IGluIHRoZSBMVEU8YnI+CiZndDsmZ3Q7IGF0b20gaW4gb3JkZXIgdG8gZ2V0IHRoZSBmbGFn
cz88YnI+CiZndDsgPGJyPgomZ3Q7IEJlY2F1c2UgaXQgaXMgbm90IHRoZSBhdG9tJiMzOTtzIGpv
Yi48YnI+CiZndDsgVGhlcmUgYXJlIG90aGVyIGZsYWdzIHBsYW5uZWQsIGFuZCBub3QgYWxsIHdp
bGwgYmUgZGV0ZXJtaW5lZCBieSBtb2RlbC48YnI+CiZndDsgQmVzaWRlLCByZW1lbWJlcmluZyB0
byB1cGRhdGUgZWFjaCBhdG9tIGZvciBlYWNoIG5ldyBtb2RlbSBpcyBlcnJvci1wcm9uZS48YnI+
Cjxicj4KSXQmIzM5O3MgZGlmZmljdWx0IHRvIHByb3ZpZGUgcGF0Y2ggcmV2aWV3IHdoZW4gcGFy
dCBvZiB0aGUgam9iIGludm9sdmVzIDxicj4KcmVhZGluZyB0aGUgYXV0aG9yJiMzOTtzIG1pbmQg
dG8ga25vdyB3aGl0aGVyIHRoZXkgYXJlIGdvaW5nLi4uIDopPGJyPgo8YnI+CkFzIHRoaW5ncyBj
dXJyZW50bHkgc3RhbmQsIHRoZSBmbGFncyBhcmUgZGV0ZXJtaW5lZCBfb25seV8gYnkgbW9kZWwg
YW5kIDxicj4KYXJlIGFjY2Vzc2VkIG9ubHkgYnkgZ2VtYWx0b3V0aWwuYy7CoCBUaGVyZSYjMzk7
cyBubyByZWFzb24gdG8gZ28gZnJvbSBtb2RlbCA8YnI+CnRvIGZsYWdzIGF0IHN1Y2ggYSBoaWdo
IGxldmVsLsKgIFB1dCBhIG1vZGVsX3RvX2ZsYWdzKCkgZnVuY3Rpb24gaW4gPGJyPgpnZW1hbHRv
dXRpbCBhbmQga2VlcCBldmVyeXRoaW5nIGluIG9uZSBwbGFjZS48YnI+PC9ibG9ja3F1b3RlPjwv
ZGl2PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPkkgdGhp
bmsgSSB3aWxsIHJlbW92ZSB0aGVzZSBsYXN0IHR3byBwYXRjaGVzIGZyb20gdGhlIHNlcmllcyBm
b3IgdG9kYXkuPC9kaXY+PGRpdiBkaXI9ImF1dG8iPkkgc2VlIGlmIEkgY2FuIHN0YXJ0IHN1Ym1p
dHRpbmcgdGhlIEdlbWFsdG8gcGx1Z2luIG92ZXIgdGhlIHdlZWtlbmQuPC9kaXY+PGRpdiBkaXI9
ImF1dG8iPkl0IGlzIHBsYW5uZWQgYW55d2F5LCBhbmQgZXZlbiBpZiBzZXZlcmFsIGZlYXR1cmVz
IGRlcGVuZCBvbiBhdG9tIHN1cHBvcnQgbm90IHlldCB0aGVyZSwgSSBjYW4gYXQgbGVhc3QgZ2l2
ZSB0aGUgbmV3IHN0cnVjdHVyZS48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYg
ZGlyPSJhdXRvIj5UaGVuIEkgd2lsbCByZS1zdWJtaXQgdGhlIGx0ZSBnZW1hbHRvIGFmdGVyd2Fy
ZHMuPC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVm
dDoxZXgiPgo8YnI+Ci9Kb25hczxicj48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PGRpdiBkaXI9
ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+R2lhY2ludG88L2Rpdj48ZGl2IGRpcj0i
YXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CjwvYmxvY2txdW90
ZT48L2Rpdj48L2Rpdj48L2Rpdj4K

--===============2396466989852507252==--


Content-Type: multipart/mixed; boundary="===============0160172958352232797=="
MIME-Version: 1.0
From: JongSeok Won <wjs890204@gmail.com>
Subject: Re: [PATCH 1/2] netmon: support cell type LTE
Date: Mon, 27 Jul 2020 11:30:07 +0900
Message-ID: <CAKnLNuSrJ6pjqc6x8oChmLzgGHtG6AWYyzez7544dLUvdTg3MA@mail.gmail.com>
In-Reply-To: <48cced5a-a5dd-04cd-b942-65f16a2a263a@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0160172958352232797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

This breaks the NetworkMonitor API since the signature for that particular
> property is documented as a 'byte'.  From what I recall this value has a
> range
> of 0..63 ?
>
I was confused about the value of TimingAdvance. In the description of
RIL_LTE_SignalStrength_v8, the range of timingAdvance is 0 to 0x7FFFFFFE
and 0x7FFFFFFF is invalid.
But, you are correct. In the 3GPP 36.321 section 6.1.3.5, Ta value is from
0 to 63.

 These should also be documented in doc/networkmonitor-api.txt.
>
Okay, I'll update and upload re-patch with description in
doc/networkmonitor-api.txt.

Best Regards,
JongSeok

2020=EB=85=84 7=EC=9B=94 21=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:55, =
Denis Kenzior <denkenz@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi JongSeok,
>
> On 7/20/20 3:40 AM, JongSeok Won wrote:
> > ---
> >   include/netmon.h |  3 +++
> >   src/netmon.c     | 24 +++++++++++++++++++++++-
> >   2 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/netmon.h b/include/netmon.h
> > index a99d6ca9..53f9d393 100644
> > --- a/include/netmon.h
> > +++ b/include/netmon.h
> > @@ -72,6 +72,9 @@ enum ofono_netmon_info {
> >       OFONO_NETMON_INFO_EARFCN, /* int */
> >       OFONO_NETMON_INFO_EBAND, /* int */
> >       OFONO_NETMON_INFO_CQI, /* int */
> > +     OFONO_NETMON_INFO_PCI, /* int */
> > +     OFONO_NETMON_INFO_TAC, /* int */
> > +     OFONO_NETMON_INFO_SNR, /* int */
> >       OFONO_NETMON_INFO_INVALID,
> >   };
> >
> > diff --git a/src/netmon.c b/src/netmon.c
> > index 9eacb3ca..320c8425 100644
> > --- a/src/netmon.c
> > +++ b/src/netmon.c
> > @@ -138,7 +138,7 @@ static void
> netmon_cell_info_dict_append(DBusMessageIter *dict,
> >                       intval =3D va_arg(*arglist, int);
> >
> >                       CELL_INFO_DICT_APPEND(dict, "TimingAdvance",
> > -                                     intval, uint8_t, DBUS_TYPE_BYTE);
> > +                                     intval, uint32_t,
> DBUS_TYPE_UINT32);
>
> This breaks the NetworkMonitor API since the signature for that particular
> property is documented as a 'byte'.  From what I recall this value has a
> range
> of 0..63 ?
>
> >                       break;
> >
> >               case OFONO_NETMON_INFO_PSC:
> > @@ -213,6 +213,28 @@ static void
> netmon_cell_info_dict_append(DBusMessageIter *dict,
> >                                       intval, uint8_t, DBUS_TYPE_BYTE);
> >                       break;
> >
> > +             case OFONO_NETMON_INFO_PCI:
> > +                     intval =3D va_arg(*arglist, int);
> > +
> > +                     CELL_INFO_DICT_APPEND(dict, "PhysicalCellId",
> > +                                     intval, uint16_t,
> DBUS_TYPE_UINT16);
> > +                     break;
> > +
> > +             case OFONO_NETMON_INFO_TAC:
> > +                     intval =3D va_arg(*arglist, int);
> > +
> > +                     CELL_INFO_DICT_APPEND(dict, "TrackingAreaCode",
> > +                                     intval, uint16_t,
> DBUS_TYPE_UINT16);
> > +                     break;
> > +
> > +             case OFONO_NETMON_INFO_SNR:
> > +                     intval =3D va_arg(*arglist, int);
> > +
> > +                     ofono_dbus_dict_append(dict, "SingalToNoiseRatio",
> > +                                     DBUS_TYPE_INT32, &intval);
> > +
> > +                     break;
> > +
> >               case OFONO_NETMON_INFO_INVALID:
> >                       break;
> >               }
> >
>
> These should also be documented in doc/networkmonitor-api.txt.
>
> Regards,
> -Denis
>

--===============0160172958352232797==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pczwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48
ZGl2PlRoaXMgYnJlYWtzIHRoZSBOZXR3b3JrTW9uaXRvciBBUEkgc2luY2UgdGhlIHNpZ25hdHVy
ZSBmb3IgdGhhdCBwYXJ0aWN1bGFyIDxicj4KcHJvcGVydHkgaXMgZG9jdW1lbnRlZCBhcyBhICYj
Mzk7Ynl0ZSYjMzk7LsKgIEZyb20gd2hhdCBJIHJlY2FsbCB0aGlzIHZhbHVlIGhhcyBhIHJhbmdl
IDxicj4Kb2YgMC4uNjMgPzwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pkkgd2FzIGNvbmZ1c2VkIGFi
b3V0IHRoZSB2YWx1ZSBvZiBUaW1pbmdBZHZhbmNlLiBJbiB0aGUgZGVzY3JpcHRpb24gb2YgUklM
X0xURV9TaWduYWxTdHJlbmd0aF92OCwgdGhlIHJhbmdlIG9mIHRpbWluZ0FkdmFuY2UgaXMgMCB0
byAweDdGRkZGRkZFIGFuZCAweDdGRkZGRkZGIGlzIGludmFsaWQuPC9kaXY+PGRpdj5CdXQsIHlv
dSBhcmUgY29ycmVjdC4gSW4gdGhlIDNHUFAgMzYuMzIxIHNlY3Rpb24gNi4xLjMuNSwgVGEgdmFs
dWUgaXMgZnJvbSAwIHRvIDYzLjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdj7C
oFRoZXNlIHNob3VsZCBhbHNvIGJlIGRvY3VtZW50ZWQgaW4gZG9jL25ldHdvcmttb25pdG9yLWFw
aS50eHQuPC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+T2theSwgSSYjMzk7bGwgdXBkYXRlIGFuZCB1
cGxvYWQgcmUtcGF0Y2ggd2l0aCBkZXNjcmlwdGlvbiBpbiBkb2MvbmV0d29ya21vbml0b3ItYXBp
LnR4dC4gPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QmVzdCBSZWdhcmRzLDxicj48L2Rp
dj48ZGl2PkpvbmdTZW9rPGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90
ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPjIwMjDrhYQgN+yblCAyMeydvCAo
7ZmUKSDsmKTtm4QgMTA6NTUsIERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5r
ZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0O+uLmOydtCDsnpHshLE6PGJy
PjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRk
aW5nLWxlZnQ6MWV4Ij5IaSBKb25nU2Vvayw8YnI+Cjxicj4KT24gNy8yMC8yMCAzOjQwIEFNLCBK
b25nU2VvayBXb24gd3JvdGU6PGJyPgomZ3Q7IC0tLTxicj4KJmd0O8KgIMKgaW5jbHVkZS9uZXRt
b24uaCB8wqAgMyArKys8YnI+CiZndDvCoCDCoHNyYy9uZXRtb24uY8KgIMKgIMKgfCAyNCArKysr
KysrKysrKysrKysrKysrKysrKy08YnI+CiZndDvCoCDCoDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKTxicj4KJmd0OyA8YnI+CiZndDsgZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbmV0bW9uLmggYi9pbmNsdWRlL25ldG1vbi5oPGJyPgomZ3Q7IGluZGV4IGE5OWQ2
Y2E5Li41M2Y5ZDM5MyAxMDA2NDQ8YnI+CiZndDsgLS0tIGEvaW5jbHVkZS9uZXRtb24uaDxicj4K
Jmd0OyArKysgYi9pbmNsdWRlL25ldG1vbi5oPGJyPgomZ3Q7IEBAIC03Miw2ICs3Miw5IEBAIGVu
dW0gb2Zvbm9fbmV0bW9uX2luZm8gezxicj4KJmd0O8KgIMKgIMKgIMKgT0ZPTk9fTkVUTU9OX0lO
Rk9fRUFSRkNOLCAvKiBpbnQgKi88YnI+CiZndDvCoCDCoCDCoCDCoE9GT05PX05FVE1PTl9JTkZP
X0VCQU5ELCAvKiBpbnQgKi88YnI+CiZndDvCoCDCoCDCoCDCoE9GT05PX05FVE1PTl9JTkZPX0NR
SSwgLyogaW50ICovPGJyPgomZ3Q7ICvCoCDCoCDCoE9GT05PX05FVE1PTl9JTkZPX1BDSSwgLyog
aW50ICovPGJyPgomZ3Q7ICvCoCDCoCDCoE9GT05PX05FVE1PTl9JTkZPX1RBQywgLyogaW50ICov
PGJyPgomZ3Q7ICvCoCDCoCDCoE9GT05PX05FVE1PTl9JTkZPX1NOUiwgLyogaW50ICovPGJyPgom
Z3Q7wqAgwqAgwqAgwqBPRk9OT19ORVRNT05fSU5GT19JTlZBTElELDxicj4KJmd0O8KgIMKgfTs8
YnI+CiZndDvCoCDCoDxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvc3JjL25ldG1vbi5jIGIvc3JjL25l
dG1vbi5jPGJyPgomZ3Q7IGluZGV4IDllYWNiM2NhLi4zMjBjODQyNSAxMDA2NDQ8YnI+CiZndDsg
LS0tIGEvc3JjL25ldG1vbi5jPGJyPgomZ3Q7ICsrKyBiL3NyYy9uZXRtb24uYzxicj4KJmd0OyBA
QCAtMTM4LDcgKzEzOCw3IEBAIHN0YXRpYyB2b2lkIG5ldG1vbl9jZWxsX2luZm9fZGljdF9hcHBl
bmQoREJ1c01lc3NhZ2VJdGVyICpkaWN0LDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaW50dmFsID0gdmFfYXJnKCphcmdsaXN0LCBpbnQpOzxicj4KJmd0O8KgIMKg
PGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBDRUxMX0lORk9fRElD
VF9BUFBFTkQoZGljdCwgJnF1b3Q7VGltaW5nQWR2YW5jZSZxdW90Oyw8YnI+CiZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW50dmFs
LCB1aW50OF90LCBEQlVTX1RZUEVfQllURSk7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludHZhbCwgdWludDMyX3QsIERC
VVNfVFlQRV9VSU5UMzIpOzxicj4KPGJyPgpUaGlzIGJyZWFrcyB0aGUgTmV0d29ya01vbml0b3Ig
QVBJIHNpbmNlIHRoZSBzaWduYXR1cmUgZm9yIHRoYXQgcGFydGljdWxhciA8YnI+CnByb3BlcnR5
IGlzIGRvY3VtZW50ZWQgYXMgYSAmIzM5O2J5dGUmIzM5Oy7CoCBGcm9tIHdoYXQgSSByZWNhbGwg
dGhpcyB2YWx1ZSBoYXMgYSByYW5nZSA8YnI+Cm9mIDAuLjYzID88YnI+Cjxicj4KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPgomZ3Q7wqAgwqA8YnI+CiZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgT0ZPTk9fTkVUTU9OX0lORk9fUFNDOjxicj4K
Jmd0OyBAQCAtMjEzLDYgKzIxMywyOCBAQCBzdGF0aWMgdm9pZCBuZXRtb25fY2VsbF9pbmZvX2Rp
Y3RfYXBwZW5kKERCdXNNZXNzYWdlSXRlciAqZGljdCw8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludHZhbCwgdWludDhf
dCwgREJVU19UWVBFX0JZVEUpOzxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgYnJlYWs7PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
Y2FzZSBPRk9OT19ORVRNT05fSU5GT19QQ0k6PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGludHZhbCA9IHZhX2FyZygqYXJnbGlzdCwgaW50KTs8YnI+CiZndDsgKzxi
cj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBDRUxMX0lORk9fRElDVF9B
UFBFTkQoZGljdCwgJnF1b3Q7UGh5c2ljYWxDZWxsSWQmcXVvdDssPGJyPgomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludHZhbCwg
dWludDE2X3QsIERCVVNfVFlQRV9VSU5UMTYpOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBicmVhazs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqBjYXNlIE9GT05PX05FVE1PTl9JTkZPX1RBQzo8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaW50dmFsID0gdmFfYXJnKCphcmdsaXN0LCBpbnQpOzxicj4KJmd0
OyArPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENFTExfSU5GT19E
SUNUX0FQUEVORChkaWN0LCAmcXVvdDtUcmFja2luZ0FyZWFDb2RlJnF1b3Q7LDxicj4KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
bnR2YWwsIHVpbnQxNl90LCBEQlVTX1RZUEVfVUlOVDE2KTs8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgY2FzZSBPRk9OT19ORVRNT05fSU5GT19TTlI6PGJyPgomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludHZhbCA9IHZhX2FyZygqYXJnbGlzdCwgaW50KTs8
YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvZm9u
b19kYnVzX2RpY3RfYXBwZW5kKGRpY3QsICZxdW90O1NpbmdhbFRvTm9pc2VSYXRpbyZxdW90Oyw8
YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgREJVU19UWVBFX0lOVDMyLCAmYW1wO2ludHZhbCk7PGJyPgomZ3Q7ICs8YnI+CiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPgomZ3Q7ICs8YnI+
CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgT0ZPTk9fTkVUTU9OX0lORk9fSU5WQUxJ
RDo8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4KJmd0OyA8YnI+Cjxicj4KVGhlc2Ugc2hv
dWxkIGFsc28gYmUgZG9jdW1lbnRlZCBpbiBkb2MvbmV0d29ya21vbml0b3ItYXBpLnR4dC48YnI+
Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============0160172958352232797==--


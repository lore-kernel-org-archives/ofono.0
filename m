Content-Type: multipart/mixed; boundary="===============5756022419960011856=="
MIME-Version: 1.0
From: Tonny Tzeng <tonny.tzeng@gmail.com>
Subject: Re: [PATCH v2] Skip unsolicied CREG/CGREG correctly while checking
 GPRS attach status
Date: Sat, 11 Dec 2010 22:09:03 +0800
Message-ID: <AANLkTimrnKDQTyN8DudYiBVpc51Ca2S2nbEu_JuHVz6j@mail.gmail.com>
In-Reply-To: <4CFDACEE.9080807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5756022419960011856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>
> > diff --git a/gatchat/gatresult.c b/gatchat/gatresult.c
> > index 8a6dfae..c919305 100644
> > --- a/gatchat/gatresult.c
> > +++ b/gatchat/gatresult.c
> > @@ -39,6 +39,11 @@ void g_at_result_iter_init(GAtResultIter *iter,
> > GAtResult *result)
> >       iter->line_pos =3D 0;
> >  }
> >
> > +gboolean g_at_result_iter_eol(GAtResultIter *iter)
> > +{
> > +     return iter->line_pos >=3D strlen(iter->l->data);
> > +}
> > +
>
> And I pretty much don't see the need for this.  It doesn't really help
> you here.


No, this function can help to ignore unsolicited response properly.
I think the difference between solicited and unsolicited CGREG is the number
of parameters after +CGREG:, so it would be nice if we have a utility
function to know we are at the end of AT return string.

This is what we want to parse the state info from the solicited response:
+CGREG: <n>, <state>, <lac>, <ci>
but in a race condition, we received this unsolicited response from Huawei
modem:
+CGREG: <state>, <lac>, <ci>

In your proposed patch, it bypass the unsolicited response only if the 2nd
number after +CGREG: is not single digit, however if the lac is single
digit, we will still get the wrong state number.

So I still believe we should check whether we are at the end of the return
string before parsing the unquoted lac and ci.  If we are at the end of the
string, then this is a unsolicited code and we should ignore it.  How do you
think?


> >  gboolean g_at_result_iter_next(GAtResultIter *iter, const char *prefix)
> >  {
> >       char *line;
> > diff --git a/gatchat/gatresult.h b/gatchat/gatresult.h
> > index a74741f..33c0b2c 100644
> > --- a/gatchat/gatresult.h
> > +++ b/gatchat/gatresult.h
> > @@ -46,6 +46,7 @@ struct _GAtResultIter {
> >  typedef struct _GAtResultIter GAtResultIter;
> >
> >  void g_at_result_iter_init(GAtResultIter *iter, GAtResult *result);
> > +gboolean g_at_result_iter_eol(GAtResultIter *iter);
> >
> >  gboolean g_at_result_iter_next(GAtResultIter *iter, const char
> > *prefix);
> >  gboolean g_at_result_iter_open_list(GAtResultIter *iter);
>
> Anyhow, can you please try the attached patch and see if it solves your
> problems.
>
> Regards,
> -Denis
>

--===============5756022419960011856==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRp
bmctbGVmdDoxZXg7Ij48ZGl2IGNsYXNzPSJpbSI+Jmd0OyBkaWZmIC0tZ2l0IGEvZ2F0Y2hhdC9n
YXRyZXN1bHQuYyBiL2dhdGNoYXQvZ2F0cmVzdWx0LmM8YnI+CiZndDsgaW5kZXggOGE2ZGZhZS4u
YzkxOTMwNSAxMDA2NDQ8YnI+CiZndDsgLS0tIGEvZ2F0Y2hhdC9nYXRyZXN1bHQuYzxicj4KJmd0
OyArKysgYi9nYXRjaGF0L2dhdHJlc3VsdC5jPGJyPgomZ3Q7IEBAIC0zOSw2ICszOSwxMSBAQCB2
b2lkIGdfYXRfcmVzdWx0X2l0ZXJfaW5pdChHQXRSZXN1bHRJdGVyICppdGVyLDxicj4KJmd0OyBH
QXRSZXN1bHQgKnJlc3VsdCk8YnI+CiZndDsgoCCgIKAgaXRlci0mZ3Q7bGluZV9wb3MgPSAwOzxi
cj4KJmd0OyCgfTxicj4KJmd0Ozxicj4KJmd0OyArZ2Jvb2xlYW4gZ19hdF9yZXN1bHRfaXRlcl9l
b2woR0F0UmVzdWx0SXRlciAqaXRlcik8YnI+CiZndDsgK3s8YnI+CiZndDsgKyCgIKAgcmV0dXJu
IGl0ZXItJmd0O2xpbmVfcG9zICZndDs9IHN0cmxlbihpdGVyLSZndDtsLSZndDtkYXRhKTs8YnI+
CiZndDsgK308YnI+CiZndDsgKzxicj4KPGJyPgo8L2Rpdj5BbmQgSSBwcmV0dHkgbXVjaCBkb24m
IzM5O3Qgc2VlIHRoZSBuZWVkIGZvciB0aGlzLiCgSXQgZG9lc24mIzM5O3QgcmVhbGx5IGhlbHA8
YnI+CnlvdSBoZXJlLjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pk5vLCB0aGlzIGZ1
bmN0aW9uIGNhbiBoZWxwIHRvIGlnbm9yZSB1bnNvbGljaXRlZCByZXNwb25zZSBwcm9wZXJseS48
L2Rpdj48ZGl2PkkgdGhpbmsgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBzb2xpY2l0ZWQgYW5kIHVu
c29saWNpdGVkIENHUkVHIGlzIHRoZSBudW1iZXIgb2YgcGFyYW1ldGVycyBhZnRlciArQ0dSRUc6
LCBzbyBpdCB3b3VsZCBiZSBuaWNlIGlmIHdlIGhhdmUgYSB1dGlsaXR5IGZ1bmN0aW9uIHRvIGtu
b3cgd2UgYXJlIGF0IHRoZSBlbmQgb2YgQVQgcmV0dXJuIHN0cmluZy48L2Rpdj4KPGRpdj48YnI+
PC9kaXY+PGRpdj5UaGlzIGlzIHdoYXQgd2Ugd2FudCB0byBwYXJzZSB0aGUgc3RhdGUgaW5mbyBm
cm9tIHRoZSBzb2xpY2l0ZWQgcmVzcG9uc2U6PC9kaXY+PGRpdj4rQ0dSRUc6ICZsdDtuJmd0Oywg
Jmx0O3N0YXRlJmd0OywgJmx0O2xhYyZndDssICZsdDtjaSZndDs8L2Rpdj48ZGl2PmJ1dCBpbiBh
IHJhY2UgY29uZGl0aW9uLCB3ZSByZWNlaXZlZCB0aGlzIHVuc29saWNpdGVkIHJlc3BvbnNlIGZy
b20gSHVhd2VpIG1vZGVtOjwvZGl2Pgo8ZGl2PitDR1JFRzogJmx0O3N0YXRlJmd0OywgJmx0O2xh
YyZndDssICZsdDtjaSZndDs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkluIHlvdXIgcHJvcG9z
ZWQgcGF0Y2gsIGl0IGJ5cGFzcyB0aGUgdW5zb2xpY2l0ZWQgcmVzcG9uc2Ugb25seaBpZiB0aGUg
Mm5kIG51bWJlciBhZnRlciArQ0dSRUc6IGlzIG5vdCBzaW5nbGUgZGlnaXQsIGhvd2V2ZXIgaWYg
dGhlIGxhYyBpcyBzaW5nbGUgZGlnaXQsIHdlIHdpbGwgc3RpbGwgZ2V0IHRoZSB3cm9uZyBzdGF0
ZSBudW1iZXIuPC9kaXY+CjxkaXY+PGJyPjwvZGl2PjxkaXY+U28gSSBzdGlsbCBiZWxpZXZlIHdl
IHNob3VsZCBjaGVjayB3aGV0aGVyIHdlIGFyZSBhdCB0aGUgZW5kIG9mIHRoZSByZXR1cm4gc3Ry
aW5nIGJlZm9yZSBwYXJzaW5nIHRoZSB1bnF1b3RlZCBsYWMgYW5kIGNpLiCgSWYgd2UgYXJlIGF0
IHRoZSBlbmQgb2YgdGhlIHN0cmluZywgdGhlbiB0aGlzIGlzIGEgdW5zb2xpY2l0ZWQgY29kZSBh
bmQgd2Ugc2hvdWxkIGlnbm9yZSBpdC4goEhvdyBkbyB5b3UgdGhpbms/PC9kaXY+CjxkaXY+oDwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAu
OGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXg7Ij48ZGl2IGNs
YXNzPSJpbSI+CiZndDsgoGdib29sZWFuIGdfYXRfcmVzdWx0X2l0ZXJfbmV4dChHQXRSZXN1bHRJ
dGVyICppdGVyLCBjb25zdCBjaGFyICpwcmVmaXgpPGJyPgomZ3Q7IKB7PGJyPgomZ3Q7IKAgoCCg
IGNoYXIgKmxpbmU7PGJyPgomZ3Q7IGRpZmYgLS1naXQgYS9nYXRjaGF0L2dhdHJlc3VsdC5oIGIv
Z2F0Y2hhdC9nYXRyZXN1bHQuaDxicj4KJmd0OyBpbmRleCBhNzQ3NDFmLi4zM2MwYjJjIDEwMDY0
NDxicj4KJmd0OyAtLS0gYS9nYXRjaGF0L2dhdHJlc3VsdC5oPGJyPgomZ3Q7ICsrKyBiL2dhdGNo
YXQvZ2F0cmVzdWx0Lmg8YnI+CiZndDsgQEAgLTQ2LDYgKzQ2LDcgQEAgc3RydWN0IF9HQXRSZXN1
bHRJdGVyIHs8YnI+CiZndDsgoHR5cGVkZWYgc3RydWN0IF9HQXRSZXN1bHRJdGVyIEdBdFJlc3Vs
dEl0ZXI7PGJyPgomZ3Q7PGJyPgomZ3Q7IKB2b2lkIGdfYXRfcmVzdWx0X2l0ZXJfaW5pdChHQXRS
ZXN1bHRJdGVyICppdGVyLCBHQXRSZXN1bHQgKnJlc3VsdCk7PGJyPgomZ3Q7ICtnYm9vbGVhbiBn
X2F0X3Jlc3VsdF9pdGVyX2VvbChHQXRSZXN1bHRJdGVyICppdGVyKTs8YnI+CiZndDs8YnI+CiZn
dDsgoGdib29sZWFuIGdfYXRfcmVzdWx0X2l0ZXJfbmV4dChHQXRSZXN1bHRJdGVyICppdGVyLCBj
b25zdCBjaGFyPGJyPgomZ3Q7ICpwcmVmaXgpOzxicj4KJmd0OyCgZ2Jvb2xlYW4gZ19hdF9yZXN1
bHRfaXRlcl9vcGVuX2xpc3QoR0F0UmVzdWx0SXRlciAqaXRlcik7PGJyPgo8YnI+CjwvZGl2PkFu
eWhvdywgY2FuIHlvdSBwbGVhc2UgdHJ5IHRoZSBhdHRhY2hlZCBwYXRjaCBhbmQgc2VlIGlmIGl0
IHNvbHZlcyB5b3VyPGJyPgpwcm9ibGVtcy48YnI+Cjxicj4KUmVnYXJkcyw8YnI+Cjxmb250IGNv
bG9yPSIjODg4ODg4Ij4tRGVuaXM8YnI+CjwvZm9udD48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============5756022419960011856==--


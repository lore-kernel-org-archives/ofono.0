Content-Type: multipart/mixed; boundary="===============1971109270469871485=="
MIME-Version: 1.0
From: Sankar <gsankar.gs@gmail.com>
Subject: Re: [PATCH v2 0/4] Query retry counters
Date: Tue, 04 Jan 2011 18:50:06 +0530
Message-ID: <AANLkTin0pt7fjJCWnH+ggyihC7PMTnDbAowoRLxy7mNY@mail.gmail.com>
In-Reply-To: <1294146379-30854-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1971109270469871485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On Tue, Jan 4, 2011 at 6:36 PM, Lucas De Marchi <
lucas.demarchi@profusion.mobi> wrote:

> Here is the second implementation for the retry counter task. The
> difference
> from the previous approach is that now a dict with all the available retry
> counters is returned. This way is possible to query the retry counter even
> when
> PinRequired =3D=3D None, what allows us to properly handle calls to Enter=
Pin(),
> LockPin(), UnlockPin() and so on.
>
> The dict has the form { pin =3D 3, puk =3D 10, ... }. The driver implemen=
tation
> for
> huawei modem is done using its proprietary command, which returns 4
> counters:
>
> {SimManager} [/huawei0] Retries =3D { pin2 =3D 3, puk2 =3D 10, pin =3D 3,=
 puk =3D 10
> }
>

How this information is retrieved at the oFono core. Is your solution to
maintain a counter or read the value from the sim elementary files?

Thanks,
Sankar.

>
> Lucas De Marchi (4):
>  include: add method to query pin Retries
>  sim: query remaining pin retries
>  doc: detail Retries property
>  atmodem: implement query for remaining pin retries
>
>  doc/sim-api.txt       |   12 ++++++
>  drivers/atmodem/sim.c |   99
> +++++++++++++++++++++++++++++++++++++++++++++++
>  include/sim.h         |   11 +++++
>  src/sim.c             |  102
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 224 insertions(+), 0 deletions(-)
>
> --
> 1.7.3.4
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============1971109270469871485==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgTHVjYXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVHVlLCBKYW4gNCwg
MjAxMSBhdCA2OjM2IFBNLCBMdWNhcyBEZSBNYXJjaGkgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBo
cmVmPSJtYWlsdG86bHVjYXMuZGVtYXJjaGlAcHJvZnVzaW9uLm1vYmkiPmx1Y2FzLmRlbWFyY2hp
QHByb2Z1c2lvbi5tb2JpPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIw
NCwgMjA0KTsgbWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4K
SGVyZSBpcyB0aGUgc2Vjb25kIGltcGxlbWVudGF0aW9uIGZvciB0aGUgcmV0cnkgY291bnRlciB0
YXNrLiBUaGUgZGlmZmVyZW5jZTxicj4KZnJvbSB0aGUgcHJldmlvdXMgYXBwcm9hY2ggaXMgdGhh
dCBub3cgYSBkaWN0IHdpdGggYWxsIHRoZSBhdmFpbGFibGUgcmV0cnk8YnI+CmNvdW50ZXJzIGlz
IHJldHVybmVkLiBUaGlzIHdheSBpcyBwb3NzaWJsZSB0byBxdWVyeSB0aGUgcmV0cnkgY291bnRl
ciBldmVuIHdoZW48YnI+ClBpblJlcXVpcmVkID09IE5vbmUsIHdoYXQgYWxsb3dzIHVzIHRvIHBy
b3Blcmx5IGhhbmRsZSBjYWxscyB0byBFbnRlclBpbigpLDxicj4KTG9ja1BpbigpLCBVbmxvY2tQ
aW4oKSBhbmQgc28gb24uPGJyPgo8YnI+ClRoZSBkaWN0IGhhcyB0aGUgZm9ybSB7IHBpbiA9IDMs
IHB1ayA9IDEwLCAuLi4gfS4gVGhlIGRyaXZlciBpbXBsZW1lbnRhdGlvbiBmb3I8YnI+Cmh1YXdl
aSBtb2RlbSBpcyBkb25lIHVzaW5nIGl0cyBwcm9wcmlldGFyeSBjb21tYW5kLCB3aGljaCByZXR1
cm5zIDQgY291bnRlcnM6PGJyPgo8YnI+CntTaW1NYW5hZ2VyfSBbL2h1YXdlaTBdIFJldHJpZXMg
PSB7IHBpbjIgPSAzLCBwdWsyID0gMTAsIHBpbiA9IDMsIHB1ayA9IDEwIH08YnI+PC9ibG9ja3F1
b3RlPjxkaXY+PGJyPkhvdyB0aGlzIGluZm9ybWF0aW9uIGlzIHJldHJpZXZlZCBhdCB0aGUgb0Zv
bm8gY29yZS4gSXMgeW91ciBzb2x1dGlvbiB0byBtYWludGFpbiBhIGNvdW50ZXIgb3IgcmVhZCB0
aGUgdmFsdWUgZnJvbSB0aGUgc2ltIGVsZW1lbnRhcnkgZmlsZXM/PGJyPgo8YnI+VGhhbmtzLDxi
cj5TYW5rYXIuPGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBtYXJnaW46IDBwdCAw
cHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsiPgo8YnI+Ckx1Y2FzIERlIE1hcmNoaSAo
NCk6PGJyPgogoGluY2x1ZGU6IGFkZCBtZXRob2QgdG8gcXVlcnkgcGluIFJldHJpZXM8YnI+CiCg
c2ltOiBxdWVyeSByZW1haW5pbmcgcGluIHJldHJpZXM8YnI+CiCgZG9jOiBkZXRhaWwgUmV0cmll
cyBwcm9wZXJ0eTxicj4KIKBhdG1vZGVtOiBpbXBsZW1lbnQgcXVlcnkgZm9yIHJlbWFpbmluZyBw
aW4gcmV0cmllczxicj4KPGJyPgqgZG9jL3NpbS1hcGkudHh0IKAgoCCgIHwgoCAxMiArKysrKys8
YnI+CqBkcml2ZXJzL2F0bW9kZW0vc2ltLmMgfCCgIDk5ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrPGJyPgqgaW5jbHVkZS9zaW0uaCCgIKAgoCCgIHwgoCAx
MSArKysrKzxicj4KoHNyYy9zaW0uYyCgIKAgoCCgIKAgoCB8IKAxMDIgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKzxicj4KoDQgZmlsZXMgY2hhbmdlZCwg
MjI0IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pPGJyPgo8Zm9udCBjb2xvcj0iIzg4ODg4
OCI+PGJyPgotLTxicj4KMS43LjMuNDxicj4KPGJyPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVm
PSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVm
PSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+
aHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvZm9udD48L2Js
b2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============1971109270469871485==--


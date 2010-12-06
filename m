Content-Type: multipart/mixed; boundary="===============2609812641343353274=="
MIME-Version: 1.0
From: Sankar <gsankar.gs@gmail.com>
Subject: Re: [PATCH 4/4] TODO: Marking the Barred Dialing task as done
Date: Mon, 06 Dec 2010 18:07:48 +0530
Message-ID: <AANLkTimTu-kcCJRucVUfnZvLbZxsXB=6v6A+M_yFfmWk@mail.gmail.com>
In-Reply-To: <1288006457-5415-5-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2609812641343353274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

I have a few comments on the support of FDN and BDN in Ofono. Can you please
clarify.

Thanks,
Sankar.

On Mon, Oct 25, 2010 at 5:04 PM, Jeevaka Badrappan <
jeevaka.badrappan@elektrobit.com> wrote:

> ---
>  TODO             |    7 -------
>  doc/features.txt |    5 +++++
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/TODO b/TODO
> index d9a6580..ad96241 100644
> --- a/TODO
> +++ b/TODO
> @@ -110,13 +110,6 @@ SMS
>  SIM / SIM File system
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -- Barred Dialing numbers support.  BDN will not be supported by oFono.
> -  If BDN service enabled SIM is used, oFono will go into emergency mode.
> -
> -  Priority: Low
> -  Complexity: C2
> -  Owner: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
> -
>  - Read / Write EFcfis.  Call forwarding settings can be bootstrapped on
> the
>   SIM for faster notification of the user that call forwarding is active.
>   These settings are stored in EFcfis.  oFono should read these settings
> and
> diff --git a/doc/features.txt b/doc/features.txt
> index 3524e79..12be037 100644
> --- a/doc/features.txt
> +++ b/doc/features.txt
> @@ -135,3 +135,8 @@ SIM
>   check if FDN support is allocated and enabled in the SIM.  If enabled,
>   oFono halts the SIM initialization procedure and the modem remains in t=
he
>   PRESIM state.  In this state oFono will only allow emergency calls.
>

Is there a way for the clients to enable or disable the Fixed Dialling? I
assume they should be able to do this by using the dbus calls,
"LockPin/UnlockPin".  Is there a way to store the FDN numbers in the sim
card? How does ofono validate the request to be passed to the network when
FDN is enabled? Looks like as per the current implementation of FDN, only
emergency calls are allowed. But as per the 3GPP standards, calls shall be
allowed to any number (irrespective of emergency no) that is part of the FDN
list.

If the modem remains in PRESIM State, how does the mobile receive the
Incoming Calls or SMS? As per my understanding FDN applies in the uplink and
not in the downlink.
Please clarify if my understanding is wrong.

> +
> +- Barred Dialing support.  oFono reads the necessary bits from the SIM to
> +  check if BDN support is allocated and enabled in the SIM.  If enabled,
> +  oFono halts the SIM initialization procedure and the modem remains in
> the
> +  PRESIM state.  In this state oFono will only allow emergency calls.
>
I have similar doubts for BDN also.

> --
>

Best Regards,
Sankar.

> 1.7.0.4
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============2609812641343353274==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgSmVldmFrYSw8YnI+PGJyPkkgaGF2ZSBhIGZldyBjb21tZW50cyBvbiB0aGUgc3VwcG9ydCBv
ZiBGRE4gYW5kIEJETiBpbiBPZm9uby4gQ2FuIHlvdSBwbGVhc2UgY2xhcmlmeS48YnI+PGJyPlRo
YW5rcyw8YnI+U2Fua2FyLjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIE1vbiwg
T2N0IDI1LCAyMDEwIGF0IDU6MDQgUE0sIEplZXZha2EgQmFkcmFwcGFuIDxzcGFuIGRpcj0ibHRy
Ij4mbHQ7PGEgaHJlZj0ibWFpbHRvOmplZXZha2EuYmFkcmFwcGFuQGVsZWt0cm9iaXQuY29tIj5q
ZWV2YWthLmJhZHJhcHBhbkBlbGVrdHJvYml0LmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+
CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHgg
c29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRk
aW5nLWxlZnQ6IDFleDsiPi0tLTxicj4KoFRPRE8goCCgIKAgoCCgIKAgfCCgIKA3IC0tLS0tLS08
YnI+CqBkb2MvZmVhdHVyZXMudHh0IHwgoCCgNSArKysrKzxicj4KoDIgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKTxicj4KPGJyPgpkaWZmIC0tZ2l0IGEvVE9E
TyBiL1RPRE88YnI+CmluZGV4IGQ5YTY1ODAuLmFkOTYyNDEgMTAwNjQ0PGJyPgotLS0gYS9UT0RP
PGJyPgorKysgYi9UT0RPPGJyPgpAQCAtMTEwLDEzICsxMTAsNiBAQCBTTVM8YnI+CqBTSU0gLyBT
SU0gRmlsZSBzeXN0ZW08YnI+CqA9PT09PT09PT09PT09PT09PT09PT08YnI+Cjxicj4KLS0gQmFy
cmVkIERpYWxpbmcgbnVtYmVycyBzdXBwb3J0LiCgQkROIHdpbGwgbm90IGJlIHN1cHBvcnRlZCBi
eSBvRm9uby48YnI+Ci0goElmIEJETiBzZXJ2aWNlIGVuYWJsZWQgU0lNIGlzIHVzZWQsIG9Gb25v
IHdpbGwgZ28gaW50byBlbWVyZ2VuY3kgbW9kZS48YnI+Ci08YnI+Ci0goFByaW9yaXR5OiBMb3c8
YnI+Ci0goENvbXBsZXhpdHk6IEMyPGJyPgotIKBPd25lcjogSmVldmFrYSBCYWRyYXBwYW4gJmx0
OzxhIGhyZWY9Im1haWx0bzpqZWV2YWthLmJhZHJhcHBhbkBlbGVrdHJvYml0LmNvbSI+amVldmFr
YS5iYWRyYXBwYW5AZWxla3Ryb2JpdC5jb208L2E+Jmd0Ozxicj4KLTxicj4KoC0gUmVhZCAvIFdy
aXRlIEVGY2Zpcy4goENhbGwgZm9yd2FyZGluZyBzZXR0aW5ncyBjYW4gYmUgYm9vdHN0cmFwcGVk
IG9uIHRoZTxicj4KIKAgU0lNIGZvciBmYXN0ZXIgbm90aWZpY2F0aW9uIG9mIHRoZSB1c2VyIHRo
YXQgY2FsbCBmb3J3YXJkaW5nIGlzIGFjdGl2ZS48YnI+CiCgIFRoZXNlIHNldHRpbmdzIGFyZSBz
dG9yZWQgaW4gRUZjZmlzLiCgb0Zvbm8gc2hvdWxkIHJlYWQgdGhlc2Ugc2V0dGluZ3MgYW5kPGJy
PgpkaWZmIC0tZ2l0IGEvZG9jL2ZlYXR1cmVzLnR4dCBiL2RvYy9mZWF0dXJlcy50eHQ8YnI+Cmlu
ZGV4IDM1MjRlNzkuLjEyYmUwMzcgMTAwNjQ0PGJyPgotLS0gYS9kb2MvZmVhdHVyZXMudHh0PGJy
PgorKysgYi9kb2MvZmVhdHVyZXMudHh0PGJyPgpAQCAtMTM1LDMgKzEzNSw4IEBAIFNJTTxicj4K
IKAgY2hlY2sgaWYgRkROIHN1cHBvcnQgaXMgYWxsb2NhdGVkIGFuZCBlbmFibGVkIGluIHRoZSBT
SU0uIKBJZiBlbmFibGVkLDxicj4KIKAgb0Zvbm8gaGFsdHMgdGhlIFNJTSBpbml0aWFsaXphdGlv
biBwcm9jZWR1cmUgYW5kIHRoZSBtb2RlbSByZW1haW5zIGluIHRoZTxicj4KIKAgUFJFU0lNIHN0
YXRlLiCgSW4gdGhpcyBzdGF0ZSBvRm9ubyB3aWxsIG9ubHkgYWxsb3cgZW1lcmdlbmN5IGNhbGxz
Ljxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+SXMgdGhlcmUgYSB3YXkgZm9yIHRoZSBjbGllbnRz
IHRvIGVuYWJsZSBvciBkaXNhYmxlIHRoZSBGaXhlZCBEaWFsbGluZz8gSSBhc3N1bWUgdGhleSBz
aG91bGQgYmUgYWJsZSB0byBkbyB0aGlzIGJ5IHVzaW5nIHRoZSBkYnVzIGNhbGxzLCAmcXVvdDtM
b2NrUGluL1VubG9ja1BpbiZxdW90Oy6gIElzIHRoZXJlIGEgd2F5IHRvIHN0b3JlIHRoZSBGRE4g
bnVtYmVycyBpbiB0aGUgc2ltIGNhcmQ/IEhvdyBkb2VzIG9mb25vIHZhbGlkYXRlIHRoZSByZXF1
ZXN0IHRvIGJlIHBhc3NlZCB0byB0aGUgbmV0d29yayB3aGVuIEZETiBpcyBlbmFibGVkPyBMb29r
cyBsaWtlIGFzIHBlciB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiBGRE4sIG9ubHkgZW1l
cmdlbmN5IGNhbGxzIGFyZSBhbGxvd2VkLiBCdXQgYXMgcGVyIHRoZSAzR1BQIHN0YW5kYXJkcywg
Y2FsbHMgc2hhbGwgYmUgYWxsb3dlZCB0byBhbnkgbnVtYmVyIChpcnJlc3BlY3RpdmUgb2YgZW1l
cmdlbmN5IG5vKSB0aGF0IGlzIHBhcnQgb2YgdGhlIEZETiBsaXN0LqAgPGJyPgo8YnI+SWYgdGhl
IG1vZGVtIHJlbWFpbnMgaW4gUFJFU0lNIFN0YXRlLCBob3cgZG9lcyB0aGUgbW9iaWxlIHJlY2Vp
dmUgdGhlIEluY29taW5nIENhbGxzIG9yIFNNUz8gQXMgcGVyIG15IHVuZGVyc3RhbmRpbmcgRkRO
IGFwcGxpZXMgaW4gdGhlIHVwbGluayBhbmQgbm90IGluIHRoZSBkb3dubGluay6gIDxicj5QbGVh
c2UgY2xhcmlmeSBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIHdyb25nLjxicj4KPC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCBy
Z2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IHBhZGRpbmctbGVm
dDogMWV4OyI+Cis8YnI+CistIEJhcnJlZCBEaWFsaW5nIHN1cHBvcnQuIKBvRm9ubyByZWFkcyB0
aGUgbmVjZXNzYXJ5IGJpdHMgZnJvbSB0aGUgU0lNIHRvPGJyPgorIKBjaGVjayBpZiBCRE4gc3Vw
cG9ydCBpcyBhbGxvY2F0ZWQgYW5kIGVuYWJsZWQgaW4gdGhlIFNJTS4goElmIGVuYWJsZWQsPGJy
PgorIKBvRm9ubyBoYWx0cyB0aGUgU0lNIGluaXRpYWxpemF0aW9uIHByb2NlZHVyZSBhbmQgdGhl
IG1vZGVtIHJlbWFpbnMgaW4gdGhlPGJyPgorIKBQUkVTSU0gc3RhdGUuIKBJbiB0aGlzIHN0YXRl
IG9Gb25vIHdpbGwgb25seSBhbGxvdyBlbWVyZ2VuY3kgY2FsbHMuPGJyPjwvYmxvY2txdW90ZT48
ZGl2PkkgaGF2ZSBzaW1pbGFyIGRvdWJ0cyBmb3IgQkROIGFsc28uoCA8YnI+PC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCBy
Z2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IHBhZGRpbmctbGVm
dDogMWV4OyI+Cgo8Zm9udCBjb2xvcj0iIzg4ODg4OCI+LS08YnI+PC9mb250PjwvYmxvY2txdW90
ZT48ZGl2Pjxicj5CZXN0IFJlZ2FyZHMsPGJyPlNhbmthci4gPGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIw
NCwgMjA0LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFl
eDsiPgo8Zm9udCBjb2xvcj0iIzg4ODg4OCI+CjEuNy4wLjQ8YnI+Cjxicj4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlz
dDxicj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9h
Pjxicj4KPGEgaHJlZj0iaHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubyIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm88L2E+PGJy
Pgo8L2ZvbnQ+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============2609812641343353274==--


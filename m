Content-Type: multipart/mixed; boundary="===============5488137649203509852=="
MIME-Version: 1.0
From: Marit Sofie Henriksen <maritsofie.henriksen8@gmail.com>
Subject: Re: [PATCH] network: query signal strength when status changes to
 registered or roaming.
Date: Wed, 15 Dec 2010 15:01:23 +0100
Message-ID: <AANLkTimXEsryOpmEZQ-eP+Ma+Vdnhkgo2Qsjj=bn9G5f@mail.gmail.com>
In-Reply-To: <1291388441-16730-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5488137649203509852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/12/3 Marit Henriksen <maritsofie.henriksen8@gmail.com>

> From: Marit Henriksen <marit.henriksen@stericsson.com>
>
>
Hi. I was wondering if you have had the chance to look at this patch yet?

regards, Marit



> Signal strength is set to -1 whenever registration status changes
> and differs from registered or roaming. When registration status
> changes again to registered or roaming, the signal strength needs to
> be updated, so add query towards driver to get it.
> ---
>  src/network.c |   29 ++++++++++++++++-------------
>  1 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/src/network.c b/src/network.c
> index d5b42a1..80fa83d 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -1296,6 +1296,19 @@ emit:
>        notify_status_watches(netreg);
>  }
>
> +static void signal_strength_callback(const struct ofono_error *error,
> +                                       int strength, void *data)
> +{
> +       struct ofono_netreg *netreg =3D data;
> +
> +       if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +               DBG("Error during signal strength query");
> +               return;
> +       }
> +
> +       ofono_netreg_strength_notify(netreg, strength);
> +}
> +
>  void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
>                        int lac, int ci, int tech)
>  {
> @@ -1319,6 +1332,9 @@ void ofono_netreg_status_notify(struct ofono_netreg
> *netreg, int status,
>                if (netreg->driver->current_operator)
>                        netreg->driver->current_operator(netreg,
>                                        current_operator_callback, netreg);
> +               if (netreg->driver->strength)
> +                       netreg->driver->strength(netreg,
> +                                       signal_strength_callback, netreg);
>        } else {
>                struct ofono_error error;
>
> @@ -1345,19 +1361,6 @@ void ofono_netreg_time_notify(struct ofono_netreg
> *netreg,
>        __ofono_nettime_info_received(modem, info);
>  }
>
> -static void signal_strength_callback(const struct ofono_error *error,
> -                                       int strength, void *data)
> -{
> -       struct ofono_netreg *netreg =3D data;
> -
> -       if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -               DBG("Error during signal strength query");
> -               return;
> -       }
> -
> -       ofono_netreg_strength_notify(netreg, strength);
> -}
> -
>  static void init_registration_status(const struct ofono_error *error,
>                                        int status, int lac, int ci, int
> tech,
>                                        void *data)
> --
> 1.7.1
>
>

--===============5488137649203509852==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTAvMTIvMyBNYXJpdCBIZW5yaWtzZW4gPHNwYW4g
ZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWFyaXRzb2ZpZS5oZW5yaWtzZW44QGdtYWls
LmNvbSI+bWFyaXRzb2ZpZS5oZW5yaWtzZW44QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjxicj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0
IDAuOGV4OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFkZGlu
Zy1sZWZ0OiAxZXg7Ij4KPGRpdj48ZGl2PjwvZGl2PjxkaXYgY2xhc3M9Img1Ij5Gcm9tOiBNYXJp
dCBIZW5yaWtzZW4gJmx0OzxhIGhyZWY9Im1haWx0bzptYXJpdC5oZW5yaWtzZW5Ac3Rlcmljc3Nv
bi5jb20iPm1hcml0LmhlbnJpa3NlbkBzdGVyaWNzc29uLmNvbTwvYT4mZ3Q7PGJyPgo8YnI+PC9k
aXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+oDwvZGl2PjxkaXY+SGkuIEkgd2FzIHdvbmRlcmlu
ZyBpZiB5b3UgaGF2ZSBoYWQgdGhlIGNoYW5jZSB0byBsb29rIGF0IHRoaXMgcGF0Y2ggeWV0Pzxi
cj48YnI+cmVnYXJkcywgTWFyaXQ8YnI+PGJyPqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDog
MXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KPGRpdj48
ZGl2IGNsYXNzPSJoNSI+ClNpZ25hbCBzdHJlbmd0aCBpcyBzZXQgdG8gLTEgd2hlbmV2ZXIgcmVn
aXN0cmF0aW9uIHN0YXR1cyBjaGFuZ2VzPGJyPgphbmQgZGlmZmVycyBmcm9tIHJlZ2lzdGVyZWQg
b3Igcm9hbWluZy4gV2hlbiByZWdpc3RyYXRpb24gc3RhdHVzPGJyPgpjaGFuZ2VzIGFnYWluIHRv
IHJlZ2lzdGVyZWQgb3Igcm9hbWluZywgdGhlIHNpZ25hbCBzdHJlbmd0aCBuZWVkcyB0bzxicj4K
YmUgdXBkYXRlZCwgc28gYWRkIHF1ZXJ5IHRvd2FyZHMgZHJpdmVyIHRvIGdldCBpdC48YnI+Ci0t
LTxicj4KoHNyYy9uZXR3b3JrLmMgfCCgIDI5ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
PGJyPgqgMSBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSk8
YnI+Cjxicj4KZGlmZiAtLWdpdCBhL3NyYy9uZXR3b3JrLmMgYi9zcmMvbmV0d29yay5jPGJyPgpp
bmRleCBkNWI0MmExLi44MGZhODNkIDEwMDY0NDxicj4KLS0tIGEvc3JjL25ldHdvcmsuYzxicj4K
KysrIGIvc3JjL25ldHdvcmsuYzxicj4KQEAgLTEyOTYsNiArMTI5NiwxOSBAQCBlbWl0Ojxicj4K
IKAgoCCgIKBub3RpZnlfc3RhdHVzX3dhdGNoZXMobmV0cmVnKTs8YnI+CqB9PGJyPgo8YnI+Citz
dGF0aWMgdm9pZCBzaWduYWxfc3RyZW5ndGhfY2FsbGJhY2soY29uc3Qgc3RydWN0IG9mb25vX2Vy
cm9yICplcnJvciw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBp
bnQgc3RyZW5ndGgsIHZvaWQgKmRhdGEpPGJyPgorezxicj4KKyCgIKAgoCBzdHJ1Y3Qgb2Zvbm9f
bmV0cmVnICpuZXRyZWcgPSBkYXRhOzxicj4KKzxicj4KKyCgIKAgoCBpZiAoZXJyb3ItJmd0O3R5
cGUgIT0gT0ZPTk9fRVJST1JfVFlQRV9OT19FUlJPUikgezxicj4KKyCgIKAgoCCgIKAgoCCgIERC
RygmcXVvdDtFcnJvciBkdXJpbmcgc2lnbmFsIHN0cmVuZ3RoIHF1ZXJ5JnF1b3Q7KTs8YnI+Cisg
oCCgIKAgoCCgIKAgoCByZXR1cm47PGJyPgorIKAgoCCgIH08YnI+Cis8YnI+CisgoCCgIKAgb2Zv
bm9fbmV0cmVnX3N0cmVuZ3RoX25vdGlmeShuZXRyZWcsIHN0cmVuZ3RoKTs8YnI+Cit9PGJyPgor
PGJyPgqgdm9pZCBvZm9ub19uZXRyZWdfc3RhdHVzX25vdGlmeShzdHJ1Y3Qgb2Zvbm9fbmV0cmVn
ICpuZXRyZWcsIGludCBzdGF0dXMsPGJyPgogoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKBpbnQgbGFj
LCBpbnQgY2ksIGludCB0ZWNoKTxicj4KoHs8YnI+CkBAIC0xMzE5LDYgKzEzMzIsOSBAQCB2b2lk
IG9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KHN0cnVjdCBvZm9ub19uZXRyZWcgKm5ldHJlZywg
aW50IHN0YXR1cyw8YnI+CiCgIKAgoCCgIKAgoCCgIKBpZiAobmV0cmVnLSZndDtkcml2ZXItJmd0
O2N1cnJlbnRfb3BlcmF0b3IpPGJyPgogoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKBuZXRyZWctJmd0
O2RyaXZlci0mZ3Q7Y3VycmVudF9vcGVyYXRvcihuZXRyZWcsPGJyPgogoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgY3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaywgbmV0cmVn
KTs8YnI+CisgoCCgIKAgoCCgIKAgoCBpZiAobmV0cmVnLSZndDtkcml2ZXItJmd0O3N0cmVuZ3Ro
KTxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgbmV0cmVnLSZndDtkcml2ZXItJmd0O3N0cmVu
Z3RoKG5ldHJlZyw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBz
aWduYWxfc3RyZW5ndGhfY2FsbGJhY2ssIG5ldHJlZyk7PGJyPgogoCCgIKAgoH0gZWxzZSB7PGJy
PgogoCCgIKAgoCCgIKAgoCCgc3RydWN0IG9mb25vX2Vycm9yIGVycm9yOzxicj4KPGJyPgpAQCAt
MTM0NSwxOSArMTM2MSw2IEBAIHZvaWQgb2Zvbm9fbmV0cmVnX3RpbWVfbm90aWZ5KHN0cnVjdCBv
Zm9ub19uZXRyZWcgKm5ldHJlZyw8YnI+CiCgIKAgoCCgX19vZm9ub19uZXR0aW1lX2luZm9fcmVj
ZWl2ZWQobW9kZW0sIGluZm8pOzxicj4KoH08YnI+Cjxicj4KLXN0YXRpYyB2b2lkIHNpZ25hbF9z
dHJlbmd0aF9jYWxsYmFjayhjb25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLDxicj4KLSCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGludCBzdHJlbmd0aCwgdm9pZCAq
ZGF0YSk8YnI+Ci17PGJyPgotIKAgoCCgIHN0cnVjdCBvZm9ub19uZXRyZWcgKm5ldHJlZyA9IGRh
dGE7PGJyPgotPGJyPgotIKAgoCCgIGlmIChlcnJvci0mZ3Q7dHlwZSAhPSBPRk9OT19FUlJPUl9U
WVBFX05PX0VSUk9SKSB7PGJyPgotIKAgoCCgIKAgoCCgIKAgREJHKCZxdW90O0Vycm9yIGR1cmlu
ZyBzaWduYWwgc3RyZW5ndGggcXVlcnkmcXVvdDspOzxicj4KLSCgIKAgoCCgIKAgoCCgIHJldHVy
bjs8YnI+Ci0goCCgIKAgfTxicj4KLTxicj4KLSCgIKAgoCBvZm9ub19uZXRyZWdfc3RyZW5ndGhf
bm90aWZ5KG5ldHJlZywgc3RyZW5ndGgpOzxicj4KLX08YnI+Ci08YnI+CqBzdGF0aWMgdm9pZCBp
bml0X3JlZ2lzdHJhdGlvbl9zdGF0dXMoY29uc3Qgc3RydWN0IG9mb25vX2Vycm9yICplcnJvciw8
YnI+CiCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKBpbnQgc3RhdHVzLCBp
bnQgbGFjLCBpbnQgY2ksIGludCB0ZWNoLDxicj4KIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoHZvaWQgKmRhdGEpPGJyPgotLTxicj4KMS43LjE8YnI+Cjxicj4KPC9kaXY+
PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============5488137649203509852==--


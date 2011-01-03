Content-Type: multipart/mixed; boundary="===============5788681535821701719=="
MIME-Version: 1.0
From: Marit Sofie Henriksen <maritsofie.henriksen8@gmail.com>
Subject: Re: [PATCHv2] network: query signal strength
Date: Mon, 03 Jan 2011 14:04:09 +0100
Message-ID: <AANLkTik5_F1mvZeU3euy_4QSuFEF8zJop7gHFVF00B5Q@mail.gmail.com>
In-Reply-To: <1292579164-24372-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5788681535821701719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/12/17 Marit Henriksen <maritsofie.henriksen8@gmail.com>

> From: Marit Henriksen <marit.henriksen@stericsson.com>
>
> Hi. I was wondering if you have had the chance to look at the second
version of the patch?

regards, Marit



> Signal strength is set to -1 whenever registration status changes
> and differs from registered or roaming. When registration status
> changes again to registered or roaming, the signal strength needs to
> be updated, added query towards driver to get it.
> ---
>  src/network.c |   28 ++++++++++++++++------------
>  1 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/src/network.c b/src/network.c
> index d203bee..50539a2 100644
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
> @@ -1345,18 +1361,6 @@ void ofono_netreg_time_notify(struct ofono_netreg
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
>
>  static void init_registration_status(const struct ofono_error *error,
>                                        int status, int lac, int ci, int
> tech,
> --
> 1.7.1
>
>

--===============5788681535821701719==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMC8xMi8xNyBNYXJpdCBIZW5yaWtz
ZW4gPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWFyaXRzb2ZpZS5oZW5yaWtz
ZW44QGdtYWlsLmNvbSI+bWFyaXRzb2ZpZS5oZW5yaWtzZW44QGdtYWlsLmNvbTwvYT4mZ3Q7PC9z
cGFuPjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBw
dCAwcHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0
KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KRnJvbTogTWFyaXQgSGVucmlrc2VuICZsdDs8YSBocmVm
PSJtYWlsdG86bWFyaXQuaGVucmlrc2VuQHN0ZXJpY3Nzb24uY29tIj5tYXJpdC5oZW5yaWtzZW5A
c3Rlcmljc3Nvbi5jb208L2E+Jmd0Ozxicj4KPGJyPjwvYmxvY2txdW90ZT48ZGl2PkhpLiBJIHdh
cyB3b25kZXJpbmcgaWYgeW91IGhhdmUgaGFkIHRoZSBjaGFuY2UgdG8gbG9vayBhdCB0aGUgc2Vj
b25kIHZlcnNpb24gb2YgdGhlIHBhdGNoPzxicj48YnI+cmVnYXJkcywgPHNwYW4gY2xhc3M9Imls
Ij5NYXJpdDxicj48YnI+PC9zcGFuPqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVyLWxlZnQ6IDFw
eCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+CgpTaWduYWwg
c3RyZW5ndGggaXMgc2V0IHRvIC0xIHdoZW5ldmVyIHJlZ2lzdHJhdGlvbiBzdGF0dXMgY2hhbmdl
czxicj4KYW5kIGRpZmZlcnMgZnJvbSByZWdpc3RlcmVkIG9yIHJvYW1pbmcuIFdoZW4gcmVnaXN0
cmF0aW9uIHN0YXR1czxicj4KY2hhbmdlcyBhZ2FpbiB0byByZWdpc3RlcmVkIG9yIHJvYW1pbmcs
IHRoZSBzaWduYWwgc3RyZW5ndGggbmVlZHMgdG88YnI+CmJlIHVwZGF0ZWQsIGFkZGVkIHF1ZXJ5
IHRvd2FyZHMgZHJpdmVyIHRvIGdldCBpdC48YnI+Ci0tLTxicj4KoHNyYy9uZXR3b3JrLmMgfCCg
IDI4ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS08YnI+CqAxIGZpbGVzIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKTxicj4KPGJyPgpkaWZmIC0tZ2l0IGEvc3Jj
L25ldHdvcmsuYyBiL3NyYy9uZXR3b3JrLmM8YnI+CmluZGV4IGQyMDNiZWUuLjUwNTM5YTIgMTAw
NjQ0PGJyPgotLS0gYS9zcmMvbmV0d29yay5jPGJyPgorKysgYi9zcmMvbmV0d29yay5jPGJyPgpA
QCAtMTI5Niw2ICsxMjk2LDE5IEBAIGVtaXQ6PGJyPgogoCCgIKAgoG5vdGlmeV9zdGF0dXNfd2F0
Y2hlcyhuZXRyZWcpOzxicj4KoH08YnI+Cjxicj4KK3N0YXRpYyB2b2lkIHNpZ25hbF9zdHJlbmd0
aF9jYWxsYmFjayhjb25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLDxicj4KKyCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGludCBzdHJlbmd0aCwgdm9pZCAqZGF0YSk8
YnI+Cit7PGJyPgorIKAgoCCgIHN0cnVjdCBvZm9ub19uZXRyZWcgKm5ldHJlZyA9IGRhdGE7PGJy
PgorPGJyPgorIKAgoCCgIGlmIChlcnJvci0mZ3Q7dHlwZSAhPSBPRk9OT19FUlJPUl9UWVBFX05P
X0VSUk9SKSB7PGJyPgorIKAgoCCgIKAgoCCgIKAgREJHKCZxdW90O0Vycm9yIGR1cmluZyBzaWdu
YWwgc3RyZW5ndGggcXVlcnkmcXVvdDspOzxicj4KKyCgIKAgoCCgIKAgoCCgIHJldHVybjs8YnI+
CisgoCCgIKAgfTxicj4KKzxicj4KKyCgIKAgoCBvZm9ub19uZXRyZWdfc3RyZW5ndGhfbm90aWZ5
KG5ldHJlZywgc3RyZW5ndGgpOzxicj4KK308YnI+Cis8YnI+CqB2b2lkIG9mb25vX25ldHJlZ19z
dGF0dXNfbm90aWZ5KHN0cnVjdCBvZm9ub19uZXRyZWcgKm5ldHJlZywgaW50IHN0YXR1cyw8YnI+
CiCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoGludCBsYWMsIGludCBjaSwgaW50IHRlY2gpPGJyPgqg
ezxicj4KQEAgLTEzMTksNiArMTMzMiw5IEBAIHZvaWQgb2Zvbm9fbmV0cmVnX3N0YXR1c19ub3Rp
Znkoc3RydWN0IG9mb25vX25ldHJlZyAqbmV0cmVnLCBpbnQgc3RhdHVzLDxicj4KIKAgoCCgIKAg
oCCgIKAgoGlmIChuZXRyZWctJmd0O2RyaXZlci0mZ3Q7Y3VycmVudF9vcGVyYXRvcik8YnI+CiCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoG5ldHJlZy0mZ3Q7ZHJpdmVyLSZndDtjdXJyZW50X29wZXJh
dG9yKG5ldHJlZyw8YnI+CiCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKBj
dXJyZW50X29wZXJhdG9yX2NhbGxiYWNrLCBuZXRyZWcpOzxicj4KKyCgIKAgoCCgIKAgoCCgIGlm
IChuZXRyZWctJmd0O2RyaXZlci0mZ3Q7c3RyZW5ndGgpPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCBuZXRyZWctJmd0O2RyaXZlci0mZ3Q7c3RyZW5ndGgobmV0cmVnLDxicj4KKyCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIHNpZ25hbF9zdHJlbmd0aF9jYWxsYmFjaywg
bmV0cmVnKTs8YnI+CiCgIKAgoCCgfSBlbHNlIHs8YnI+CiCgIKAgoCCgIKAgoCCgIKBzdHJ1Y3Qg
b2Zvbm9fZXJyb3IgZXJyb3I7PGJyPgo8YnI+CkBAIC0xMzQ1LDE4ICsxMzYxLDYgQEAgdm9pZCBv
Zm9ub19uZXRyZWdfdGltZV9ub3RpZnkoc3RydWN0IG9mb25vX25ldHJlZyAqbmV0cmVnLDxicj4K
IKAgoCCgIKBfX29mb25vX25ldHRpbWVfaW5mb19yZWNlaXZlZChtb2RlbSwgaW5mbyk7PGJyPgqg
fTxicj4KPGJyPgotc3RhdGljIHZvaWQgc2lnbmFsX3N0cmVuZ3RoX2NhbGxiYWNrKGNvbnN0IHN0
cnVjdCBvZm9ub19lcnJvciAqZXJyb3IsPGJyPgotIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgaW50IHN0cmVuZ3RoLCB2b2lkICpkYXRhKTxicj4KLXs8YnI+Ci0goCCgIKAg
c3RydWN0IG9mb25vX25ldHJlZyAqbmV0cmVnID0gZGF0YTs8YnI+Ci08YnI+Ci0goCCgIKAgaWYg
KGVycm9yLSZndDt0eXBlICE9IE9GT05PX0VSUk9SX1RZUEVfTk9fRVJST1IpIHs8YnI+Ci0goCCg
IKAgoCCgIKAgoCBEQkcoJnF1b3Q7RXJyb3IgZHVyaW5nIHNpZ25hbCBzdHJlbmd0aCBxdWVyeSZx
dW90Oyk7PGJyPgotIKAgoCCgIKAgoCCgIKAgcmV0dXJuOzxicj4KLSCgIKAgoCB9PGJyPgotPGJy
PgotIKAgoCCgIG9mb25vX25ldHJlZ19zdHJlbmd0aF9ub3RpZnkobmV0cmVnLCBzdHJlbmd0aCk7
PGJyPgotfTxicj4KPGJyPgqgc3RhdGljIHZvaWQgaW5pdF9yZWdpc3RyYXRpb25fc3RhdHVzKGNv
bnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJyb3IsPGJyPgogoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgaW50IHN0YXR1cywgaW50IGxhYywgaW50IGNpLCBpbnQgdGVjaCw8
YnI+Cjxmb250IGNvbG9yPSIjODg4ODg4Ij4tLTxicj4KMS43LjE8YnI+Cjxicj4KPC9mb250Pjwv
YmxvY2txdW90ZT48L2Rpdj48YnI+Cg==

--===============5788681535821701719==--


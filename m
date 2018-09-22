Content-Type: multipart/mixed; boundary="===============4579131914205374328=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/2] lte.h: added ofono_lte_get_modem global function
Date: Sat, 22 Sep 2018 13:49:37 +0200
Message-ID: <CAKSBH7E=Hb2xjN5QYhbyjUabsL0W-rB=PPJnOVqyZ5zY8EZxVQ@mail.gmail.com>
In-Reply-To: <20180922100401.14889-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4579131914205374328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

apologies, too hasty a submit. please disregard this. I will resubmit.

On Sat, Sep 22, 2018 at 12:04 PM Giacinto Cifelli <gciofono@gmail.com>
wrote:

> this function can be used in the drivers to query the functions
> ofono_modem_get_* to retrieve modem-specific properties
> ---
>  include/lte.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/lte.h b/include/lte.h
> index ef84ab99..0f2501c0 100644
> --- a/include/lte.h
> +++ b/include/lte.h
> @@ -61,6 +61,8 @@ void ofono_lte_set_data(struct ofono_lte *lte, void
> *data);
>
>  void *ofono_lte_get_data(const struct ofono_lte *lte);
>
> +struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *lte);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> --
> 2.17.1
>
>

--===============4579131914205374328==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+YXBvbG9naWVzLCB0b28gaGFzdHkgYSBzdWJtaXQuIHBsZWFzZSBkaXNy
ZWdhcmQgdGhpcy4gSSB3aWxsIHJlc3VibWl0LjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gU2F0LCBTZXAgMjIsIDIwMTggYXQgMTI6MDQgUE0gR2lh
Y2ludG8gQ2lmZWxsaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmdjaW9mb25vQGdtYWlsLmNvbSI+Z2Np
b2Zvbm9AZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPnRoaXMgZnVuY3Rpb24gY2FuIGJlIHVzZWQgaW4g
dGhlIGRyaXZlcnMgdG8gcXVlcnkgdGhlIGZ1bmN0aW9uczxicj4Kb2Zvbm9fbW9kZW1fZ2V0Xyog
dG8gcmV0cmlldmUgbW9kZW0tc3BlY2lmaWMgcHJvcGVydGllczxicj4KLS0tPGJyPgrCoGluY2x1
ZGUvbHRlLmggfCAyICsrPGJyPgrCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyk8YnI+
Cjxicj4KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbHRlLmggYi9pbmNsdWRlL2x0ZS5oPGJyPgppbmRl
eCBlZjg0YWI5OS4uMGYyNTAxYzAgMTAwNjQ0PGJyPgotLS0gYS9pbmNsdWRlL2x0ZS5oPGJyPgor
KysgYi9pbmNsdWRlL2x0ZS5oPGJyPgpAQCAtNjEsNiArNjEsOCBAQCB2b2lkIG9mb25vX2x0ZV9z
ZXRfZGF0YShzdHJ1Y3Qgb2Zvbm9fbHRlICpsdGUsIHZvaWQgKmRhdGEpOzxicj4KPGJyPgrCoHZv
aWQgKm9mb25vX2x0ZV9nZXRfZGF0YShjb25zdCBzdHJ1Y3Qgb2Zvbm9fbHRlICpsdGUpOzxicj4K
PGJyPgorc3RydWN0IG9mb25vX21vZGVtICpvZm9ub19sdGVfZ2V0X21vZGVtKGNvbnN0IHN0cnVj
dCBvZm9ub19sdGUgKmx0ZSk7PGJyPgorPGJyPgrCoCNpZmRlZiBfX2NwbHVzcGx1czxicj4KwqB9
PGJyPgrCoCNlbmRpZjxicj4KLS0gPGJyPgoyLjE3LjE8YnI+Cjxicj4KPC9ibG9ja3F1b3RlPjwv
ZGl2Pgo=

--===============4579131914205374328==--


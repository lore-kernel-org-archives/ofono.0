Content-Type: multipart/mixed; boundary="===============5455579740162076852=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 2/2] src/lte.c: added implementation for
 ofono_lte_get_modem
Date: Sat, 22 Sep 2018 13:49:46 +0200
Message-ID: <CAKSBH7GEzH-mot4UEQaQy88BJ_m+OJGTeaBZ+5USzE90mokbcw@mail.gmail.com>
In-Reply-To: <20180922100401.14889-2-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5455579740162076852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

apologies, too hasty a submit. please disregard this. I will resubmit.

On Sat, Sep 22, 2018 at 12:04 PM Giacinto Cifelli <gciofono@gmail.com>
wrote:

> ---
>  src/lte.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/lte.c b/src/lte.c
> index e16d9aab..23fe8e1c 100644
> --- a/src/lte.c
> +++ b/src/lte.c
> @@ -373,3 +373,8 @@ void *ofono_lte_get_data(const struct ofono_lte *lte)
>  {
>         return lte->driver_data;
>  }
> +
> +struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *lte)
> +{
> +       return __ofono_atom_get_modem(lte->atom);
> +}
> --
> 2.17.1
>
>

--===============5455579740162076852==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+YXBvbG9naWVzLCB0b28gaGFzdHkgYSBzdWJtaXQuIHBsZWFzZSBkaXNy
ZWdhcmQgdGhpcy4gSSB3aWxsIHJlc3VibWl0Ljxicj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21h
aWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFNhdCwgU2VwIDIyLCAyMDE4IGF0IDEyOjA0IFBN
IEdpYWNpbnRvIENpZmVsbGkgJmx0OzxhIGhyZWY9Im1haWx0bzpnY2lvZm9ub0BnbWFpbC5jb20i
PmdjaW9mb25vQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDox
cHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4tLS08YnI+CsKgc3JjL2x0ZS5jIHwgNSAr
KysrKzxicj4KwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspPGJyPgo8YnI+CmRpZmYg
LS1naXQgYS9zcmMvbHRlLmMgYi9zcmMvbHRlLmM8YnI+CmluZGV4IGUxNmQ5YWFiLi4yM2ZlOGUx
YyAxMDA2NDQ8YnI+Ci0tLSBhL3NyYy9sdGUuYzxicj4KKysrIGIvc3JjL2x0ZS5jPGJyPgpAQCAt
MzczLDMgKzM3Myw4IEBAIHZvaWQgKm9mb25vX2x0ZV9nZXRfZGF0YShjb25zdCBzdHJ1Y3Qgb2Zv
bm9fbHRlICpsdGUpPGJyPgrCoHs8YnI+CsKgIMKgIMKgIMKgIHJldHVybiBsdGUtJmd0O2RyaXZl
cl9kYXRhOzxicj4KwqB9PGJyPgorPGJyPgorc3RydWN0IG9mb25vX21vZGVtICpvZm9ub19sdGVf
Z2V0X21vZGVtKGNvbnN0IHN0cnVjdCBvZm9ub19sdGUgKmx0ZSk8YnI+Cit7PGJyPgorwqAgwqAg
wqAgwqByZXR1cm4gX19vZm9ub19hdG9tX2dldF9tb2RlbShsdGUtJmd0O2F0b20pOzxicj4KK308
YnI+Ci0tIDxicj4KMi4xNy4xPGJyPgo8YnI+CjwvYmxvY2txdW90ZT48L2Rpdj4K

--===============5455579740162076852==--


Content-Type: multipart/mixed; boundary="===============2375407848928914515=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: Re: [PATCH 2/6] emulator: Add removed notification mechanism
Date: Thu, 11 Apr 2013 18:50:14 -0300
Message-ID: <CAG7KCRFo0nkZu+BEf=MRzEmgJ-Uk3DO6eUDxW+6gY2WTMg9mUQ@mail.gmail.com>
In-Reply-To: <1365621887-16940-3-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2375407848928914515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2013 at 4:24 PM, Paulo Borges <paulo.borges@openbossa.org=
>wrote:

> ---
>  src/emulator.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/src/emulator.c b/src/emulator.c
> index 0817b5d..4a748f0 100644
> --- a/src/emulator.c
> +++ b/src/emulator.c
> @@ -37,6 +37,11 @@
>
>  #define RING_TIMEOUT 3
>
> +struct removed_cb {
> +       ofono_emulator_removed_cb_t cb;
> +       void *data;
> +};
> +
>  struct ofono_emulator {
>         struct ofono_atom *atom;
>         enum ofono_emulator_type type;
> @@ -53,6 +58,7 @@ struct ofono_emulator {
>         gboolean clip;
>         gboolean ccwa;
>         int pns_id;
> +       struct removed_cb *removed_cb;
>  };
>
>  struct indicator {
> @@ -952,6 +958,11 @@ static void emulator_remove(struct ofono_atom *atom)
>
>         DBG("atom: %p", atom);
>
> +       if (em->removed_cb) {
> +               em->removed_cb->cb(em->removed_cb->data);
> +               g_free(em->removed_cb);
> +       }
> +
>         g_free(em);
>  }
>
> @@ -995,6 +1006,21 @@ void ofono_emulator_remove(struct ofono_emulator *e=
m)
>         __ofono_atom_free(em->atom);
>  }
>
> +void ofono_emulator_set_removed_cb(struct ofono_emulator* em,
> +                               ofono_emulator_removed_cb_t cb, void *dat=
a)
> +{
> +       struct removed_cb *removed_cb;
> +
> +       if (em =3D=3D NULL)
> +               return;
> +
> +       removed_cb =3D g_try_new0(struct removed_cb, 1);
> +       removed_cb->cb =3D cb;
> +       removed_cb->data =3D data;
> +
> +       em->removed_cb =3D removed_cb;
> +}
> +
>  void ofono_emulator_send_final(struct ofono_emulator *em,
>                                 const struct ofono_error *final)
>  {
> --
> 1.7.9.5
>
>
Hi,

please ignore this patch. I'm now using cb_data from atutil.h to handle the
callback in a new series. I will send it again soon, but all other patchs
from this series remains the same.

Paulo

--===============2375407848928914515==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gV2VkLCBBcHIgMTAsIDIwMTMgYXQg
NDoyNCBQTSwgUGF1bG8gQm9yZ2VzIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRv
OnBhdWxvLmJvcmdlc0BvcGVuYm9zc2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+cGF1bG8uYm9yZ2Vz
QG9wZW5ib3NzYS5vcmc8L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgotLS08YnI+CqBzcmMvZW11bGF0b3IuYyB8IKAg
MjYgKysrKysrKysrKysrKysrKysrKysrKysrKys8YnI+CqAxIGZpbGUgY2hhbmdlZCwgMjYgaW5z
ZXJ0aW9ucygrKTxicj4KPGJyPgpkaWZmIC0tZ2l0IGEvc3JjL2VtdWxhdG9yLmMgYi9zcmMvZW11
bGF0b3IuYzxicj4KaW5kZXggMDgxN2I1ZC4uNGE3NDhmMCAxMDA2NDQ8YnI+Ci0tLSBhL3NyYy9l
bXVsYXRvci5jPGJyPgorKysgYi9zcmMvZW11bGF0b3IuYzxicj4KQEAgLTM3LDYgKzM3LDExIEBA
PGJyPgo8YnI+CqAjZGVmaW5lIFJJTkdfVElNRU9VVCAzPGJyPgo8YnI+CitzdHJ1Y3QgcmVtb3Zl
ZF9jYiB7PGJyPgorIKAgoCCgIG9mb25vX2VtdWxhdG9yX3JlbW92ZWRfY2JfdCBjYjs8YnI+Cisg
oCCgIKAgdm9pZCAqZGF0YTs8YnI+Cit9Ozxicj4KKzxicj4KoHN0cnVjdCBvZm9ub19lbXVsYXRv
ciB7PGJyPgqgIKAgoCCgIHN0cnVjdCBvZm9ub19hdG9tICphdG9tOzxicj4KoCCgIKAgoCBlbnVt
IG9mb25vX2VtdWxhdG9yX3R5cGUgdHlwZTs8YnI+CkBAIC01Myw2ICs1OCw3IEBAIHN0cnVjdCBv
Zm9ub19lbXVsYXRvciB7PGJyPgqgIKAgoCCgIGdib29sZWFuIGNsaXA7PGJyPgqgIKAgoCCgIGdi
b29sZWFuIGNjd2E7PGJyPgqgIKAgoCCgIGludCBwbnNfaWQ7PGJyPgorIKAgoCCgIHN0cnVjdCBy
ZW1vdmVkX2NiICpyZW1vdmVkX2NiOzxicj4KoH07PGJyPgo8YnI+CqBzdHJ1Y3QgaW5kaWNhdG9y
IHs8YnI+CkBAIC05NTIsNiArOTU4LDExIEBAIHN0YXRpYyB2b2lkIGVtdWxhdG9yX3JlbW92ZShz
dHJ1Y3Qgb2Zvbm9fYXRvbSAqYXRvbSk8YnI+Cjxicj4KoCCgIKAgoCBEQkcoJnF1b3Q7YXRvbTog
JXAmcXVvdDssIGF0b20pOzxicj4KPGJyPgorIKAgoCCgIGlmIChlbS0mZ3Q7cmVtb3ZlZF9jYikg
ezxicj4KKyCgIKAgoCCgIKAgoCCgIGVtLSZndDtyZW1vdmVkX2NiLSZndDtjYihlbS0mZ3Q7cmVt
b3ZlZF9jYi0mZ3Q7ZGF0YSk7PGJyPgorIKAgoCCgIKAgoCCgIKAgZ19mcmVlKGVtLSZndDtyZW1v
dmVkX2NiKTs8YnI+CisgoCCgIKAgfTxicj4KKzxicj4KoCCgIKAgoCBnX2ZyZWUoZW0pOzxicj4K
oH08YnI+Cjxicj4KQEAgLTk5NSw2ICsxMDA2LDIxIEBAIHZvaWQgb2Zvbm9fZW11bGF0b3JfcmVt
b3ZlKHN0cnVjdCBvZm9ub19lbXVsYXRvciAqZW0pPGJyPgqgIKAgoCCgIF9fb2Zvbm9fYXRvbV9m
cmVlKGVtLSZndDthdG9tKTs8YnI+CqB9PGJyPgo8YnI+Cit2b2lkIG9mb25vX2VtdWxhdG9yX3Nl
dF9yZW1vdmVkX2NiKHN0cnVjdCBvZm9ub19lbXVsYXRvciogZW0sPGJyPgorIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIG9mb25vX2VtdWxhdG9yX3JlbW92ZWRfY2JfdCBjYiwgdm9pZCAq
ZGF0YSk8YnI+Cit7PGJyPgorIKAgoCCgIHN0cnVjdCByZW1vdmVkX2NiICpyZW1vdmVkX2NiOzxi
cj4KKzxicj4KKyCgIKAgoCBpZiAoZW0gPT0gTlVMTCk8YnI+CisgoCCgIKAgoCCgIKAgoCByZXR1
cm47PGJyPgorPGJyPgorIKAgoCCgIHJlbW92ZWRfY2IgPSBnX3RyeV9uZXcwKHN0cnVjdCByZW1v
dmVkX2NiLCAxKTs8YnI+CisgoCCgIKAgcmVtb3ZlZF9jYi0mZ3Q7Y2IgPSBjYjs8YnI+CisgoCCg
IKAgcmVtb3ZlZF9jYi0mZ3Q7ZGF0YSA9IGRhdGE7PGJyPgorPGJyPgorIKAgoCCgIGVtLSZndDty
ZW1vdmVkX2NiID0gcmVtb3ZlZF9jYjs8YnI+Cit9PGJyPgorPGJyPgqgdm9pZCBvZm9ub19lbXVs
YXRvcl9zZW5kX2ZpbmFsKHN0cnVjdCBvZm9ub19lbXVsYXRvciAqZW0sPGJyPgqgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZmluYWwpPGJy
Pgqgezxicj4KPHNwYW4gY2xhc3M9IkhPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPi0tPGJy
PgoxLjcuOS41PGJyPgo8YnI+CjwvZm9udD48L3NwYW4+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48
ZGl2PkhpLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+cGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNo
LiBJJiMzOTttIG5vdyB1c2luZyBjYl9kYXRhIGZyb20gYXR1dGlsLmggdG8gaGFuZGxlIHRoZSBj
YWxsYmFjayBpbiBhIG5ldyBzZXJpZXMuIEkgd2lsbCBzZW5kIGl0IGFnYWluIHNvb24sIGJ1dCBh
bGwgb3RoZXIgcGF0Y2hzIGZyb20gdGhpcyBzZXJpZXMgcmVtYWlucyB0aGUgc2FtZS48L2Rpdj4K
PGRpdj48YnI+PC9kaXY+PGRpdj5QYXVsbzwvZGl2Pgo=

--===============2375407848928914515==--


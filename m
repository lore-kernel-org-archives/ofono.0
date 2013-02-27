Content-Type: multipart/mixed; boundary="===============6649098682029498233=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: Re: [PATCH 1/3] bluez5: Add role parameter to bt_register_profile
Date: Wed, 27 Feb 2013 18:48:26 -0300
Message-ID: <CAG7KCRG9ZuPxvcGY+C5-tqd4TGx=s2w8zZdss2OXkjaeJbvVyA@mail.gmail.com>
In-Reply-To: <1361824563-13618-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6649098682029498233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I will resend this patch due to a wrong commit message.

On Mon, Feb 25, 2013 at 5:36 PM, Paulo Borges <paulo.borges@openbossa.org=
>wrote:

> This commit allows asymmetric profiles that do not have UUIDs
> available to uniquely identify which role is been registered.
> ---
>  plugins/bluez5.c |    5 ++++-
>  plugins/bluez5.h |    2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/plugins/bluez5.c b/plugins/bluez5.c
> index 788f3a2..04dd39d 100644
> --- a/plugins/bluez5.c
> +++ b/plugins/bluez5.c
> @@ -110,7 +110,7 @@ done:
>
>  int bt_register_profile(DBusConnection *conn, const char *uuid,
>                                         uint16_t version, const char *nam=
e,
> -                                       const char *object)
> +                                       const char *object, const char*
> role)
>  {
>         DBusMessageIter iter, dict;
>         DBusPendingCall *c;
> @@ -129,6 +129,9 @@ int bt_register_profile(DBusConnection *conn, const
> char *uuid,
>         ofono_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING, &name);
>         ofono_dbus_dict_append(&dict, "Version", DBUS_TYPE_UINT16,
> &version);
>
> +       if (role)
> +               ofono_dbus_dict_append(&dict, "Role", DBUS_TYPE_STRING,
> &role);
> +
>         dbus_message_iter_close_container(&iter, &dict);
>
>         if (!dbus_connection_send_with_reply(conn, msg, &c, -1)) {
> diff --git a/plugins/bluez5.h b/plugins/bluez5.h
> index 1432068..17e925f 100644
> --- a/plugins/bluez5.h
> +++ b/plugins/bluez5.h
> @@ -71,7 +71,7 @@ int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2);
>
>  int bt_register_profile(DBusConnection *conn, const char *uuid,
>                                         uint16_t version, const char *nam=
e,
> -                                       const char *object);
> +                                       const char *object, const char
> *role);
>
>  void bt_unregister_profile(DBusConnection *conn, const char *object);
>
> --
> 1.7.9.5
>
>

--===============6649098682029498233==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SSB3aWxsIHJlc2VuZCB0aGlzIHBhdGNoIGR1ZSB0byBhIHdyb25nIGNvbW1pdCBtZXNzYWdlLjxi
cj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgRmViIDI1LCAyMDEzIGF0IDU6
MzYgUE0sIFBhdWxvIEJvcmdlcyA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpw
YXVsby5ib3JnZXNAb3BlbmJvc3NhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPnBhdWxvLmJvcmdlc0Bv
cGVuYm9zc2Eub3JnPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNj
Y2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+VGhpcyBjb21taXQgYWxsb3dzIGFzeW1tZXRyaWMg
cHJvZmlsZXMgdGhhdCBkbyBub3QgaGF2ZSBVVUlEczxicj4KYXZhaWxhYmxlIHRvIHVuaXF1ZWx5
IGlkZW50aWZ5IHdoaWNoIHJvbGUgaXMgYmVlbiByZWdpc3RlcmVkLjxicj4KLS0tPGJyPgqgcGx1
Z2lucy9ibHVlejUuYyB8IKAgoDUgKysrKy08YnI+CqBwbHVnaW5zL2JsdWV6NS5oIHwgoCCgMiAr
LTxicj4KoDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKTxi
cj4KPGJyPgpkaWZmIC0tZ2l0IGEvcGx1Z2lucy9ibHVlejUuYyBiL3BsdWdpbnMvYmx1ZXo1LmM8
YnI+CmluZGV4IDc4OGYzYTIuLjA0ZGQzOWQgMTAwNjQ0PGJyPgotLS0gYS9wbHVnaW5zL2JsdWV6
NS5jPGJyPgorKysgYi9wbHVnaW5zL2JsdWV6NS5jPGJyPgpAQCAtMTEwLDcgKzExMCw3IEBAIGRv
bmU6PGJyPgo8YnI+CqBpbnQgYnRfcmVnaXN0ZXJfcHJvZmlsZShEQnVzQ29ubmVjdGlvbiAqY29u
biwgY29uc3QgY2hhciAqdXVpZCw8YnI+CqAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCB1aW50MTZfdCB2ZXJzaW9uLCBjb25zdCBjaGFyICpuYW1lLDxicj4KLSCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGNvbnN0IGNoYXIgKm9iamVjdCk8YnI+Cisg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBjb25zdCBjaGFyICpvYmplY3Qs
IGNvbnN0IGNoYXIqIHJvbGUpPGJyPgqgezxicj4KoCCgIKAgoCBEQnVzTWVzc2FnZUl0ZXIgaXRl
ciwgZGljdDs8YnI+CqAgoCCgIKAgREJ1c1BlbmRpbmdDYWxsICpjOzxicj4KQEAgLTEyOSw2ICsx
MjksOSBAQCBpbnQgYnRfcmVnaXN0ZXJfcHJvZmlsZShEQnVzQ29ubmVjdGlvbiAqY29ubiwgY29u
c3QgY2hhciAqdXVpZCw8YnI+CqAgoCCgIKAgb2Zvbm9fZGJ1c19kaWN0X2FwcGVuZCgmYW1wO2Rp
Y3QsICZxdW90O05hbWUmcXVvdDssIERCVVNfVFlQRV9TVFJJTkcsICZhbXA7bmFtZSk7PGJyPgqg
IKAgoCCgIG9mb25vX2RidXNfZGljdF9hcHBlbmQoJmFtcDtkaWN0LCAmcXVvdDtWZXJzaW9uJnF1
b3Q7LCBEQlVTX1RZUEVfVUlOVDE2LCAmYW1wO3ZlcnNpb24pOzxicj4KPGJyPgorIKAgoCCgIGlm
IChyb2xlKTxicj4KKyCgIKAgoCCgIKAgoCCgIG9mb25vX2RidXNfZGljdF9hcHBlbmQoJmFtcDtk
aWN0LCAmcXVvdDtSb2xlJnF1b3Q7LCBEQlVTX1RZUEVfU1RSSU5HLCAmYW1wO3JvbGUpOzxicj4K
Kzxicj4KoCCgIKAgoCBkYnVzX21lc3NhZ2VfaXRlcl9jbG9zZV9jb250YWluZXIoJmFtcDtpdGVy
LCAmYW1wO2RpY3QpOzxicj4KPGJyPgqgIKAgoCCgIGlmICghZGJ1c19jb25uZWN0aW9uX3NlbmRf
d2l0aF9yZXBseShjb25uLCBtc2csICZhbXA7YywgLTEpKSB7PGJyPgpkaWZmIC0tZ2l0IGEvcGx1
Z2lucy9ibHVlejUuaCBiL3BsdWdpbnMvYmx1ZXo1Lmg8YnI+CmluZGV4IDE0MzIwNjguLjE3ZTky
NWYgMTAwNjQ0PGJyPgotLS0gYS9wbHVnaW5zL2JsdWV6NS5oPGJyPgorKysgYi9wbHVnaW5zL2Js
dWV6NS5oPGJyPgpAQCAtNzEsNyArNzEsNyBAQCBpbnQgYnRfYmFjbXAoY29uc3QgYmRhZGRyX3Qg
KmJhMSwgY29uc3QgYmRhZGRyX3QgKmJhMik7PGJyPgo8YnI+CqBpbnQgYnRfcmVnaXN0ZXJfcHJv
ZmlsZShEQnVzQ29ubmVjdGlvbiAqY29ubiwgY29uc3QgY2hhciAqdXVpZCw8YnI+CqAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCB1aW50MTZfdCB2ZXJzaW9uLCBjb25zdCBj
aGFyICpuYW1lLDxicj4KLSCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGNv
bnN0IGNoYXIgKm9iamVjdCk7PGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgY29uc3QgY2hhciAqb2JqZWN0LCBjb25zdCBjaGFyICpyb2xlKTs8YnI+Cjxicj4KoHZv
aWQgYnRfdW5yZWdpc3Rlcl9wcm9maWxlKERCdXNDb25uZWN0aW9uICpjb25uLCBjb25zdCBjaGFy
ICpvYmplY3QpOzxicj4KPHNwYW4gY2xhc3M9IkhPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgi
Pjxicj4KLS08YnI+CjEuNy45LjU8YnI+Cjxicj4KPC9mb250Pjwvc3Bhbj48L2Jsb2NrcXVvdGU+
PC9kaXY+PGJyPgo=

--===============6649098682029498233==--


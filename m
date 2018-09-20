Content-Type: multipart/mixed; boundary="===============6138826201237646439=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] src/gprs.c: make sure that the context is properly
 released
Date: Thu, 20 Sep 2018 17:46:19 +0200
Message-ID: <CAKSBH7HrOQ5fb12zaR3qcnXJ7eKHa_3UO7nSH0vtSQc3_ZJ3Ag@mail.gmail.com>
In-Reply-To: <d2732812-21f1-d5b1-cfc5-4189c26f7b6e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6138826201237646439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, 20 Sep 2018, 17:38 Denis Kenzior, <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> On 09/19/2018 11:42 PM, Giacinto Cifelli wrote:
> > ---
> >   src/gprs.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/src/gprs.c b/src/gprs.c
> > index 8f5d195..40f43e3 100644
> > --- a/src/gprs.c
> > +++ b/src/gprs.c
> > @@ -1642,6 +1642,9 @@ static void release_active_contexts(struct
> ofono_gprs *gprs)
> >
> >               if (gc->driver->detach_shutdown !=3D NULL)
> >                       gc->driver->detach_shutdown(gc, ctx->context.cid);
> > +
> > +             /* Make sure the context is properly cleared */
> > +             release_context(ctx);
> >       }
> >   }
> >
> > @@ -2241,6 +2244,7 @@ static DBusMessage
> *gprs_remove_context(DBusConnection *conn,
> >       }
> >
> >       DBG("Unregistering context: %s", ctx->path);
> > +     release_context(ctx);
>
> If we get here then the context isn't active and doesn't need to be
> released.  Active context release happens in gprs_deactivate_for_remove.
>   So I don't think this is needed?
>

I got this change from external branches.

I doubted it was needed anymore, but couldn't be sure that I had tested all
cases.

thank you for checking it, and it can then be left out.



> >       context_dbus_unregister(ctx);
> >       gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
> >
> >
>
> Regards,
> -Denis
>

Regards,
Giacinto

>

--===============6138826201237646439==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9ImF1dG8iPjxkaXY+SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCAyMCBTZXAgMjAxOCwgMTc6MzggRGVuaXMgS2Vu
emlvciwgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFp
bC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7
cGFkZGluZy1sZWZ0OjFleCI+SGkgR2lhY2ludG8sPGJyPgo8YnI+Ck9uIDA5LzE5LzIwMTggMTE6
NDIgUE0sIEdpYWNpbnRvIENpZmVsbGkgd3JvdGU6PGJyPgomZ3Q7IC0tLTxicj4KJmd0O8KgIMKg
c3JjL2dwcnMuYyB8IDQgKysrKzxicj4KJmd0O8KgIMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKTxicj4KJmd0OyA8YnI+CiZndDsgZGlmZiAtLWdpdCBhL3NyYy9ncHJzLmMgYi9zcmMv
Z3Bycy5jPGJyPgomZ3Q7IGluZGV4IDhmNWQxOTUuLjQwZjQzZTMgMTAwNjQ0PGJyPgomZ3Q7IC0t
LSBhL3NyYy9ncHJzLmM8YnI+CiZndDsgKysrIGIvc3JjL2dwcnMuYzxicj4KJmd0OyBAQCAtMTY0
Miw2ICsxNjQyLDkgQEAgc3RhdGljIHZvaWQgcmVsZWFzZV9hY3RpdmVfY29udGV4dHMoc3RydWN0
IG9mb25vX2dwcnMgKmdwcnMpPGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmIChnYy0mZ3Q7ZHJpdmVyLSZndDtkZXRhY2hfc2h1dGRvd24gIT0gTlVMTCk8YnI+
CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdjLSZndDtkcml2ZXItJmd0
O2RldGFjaF9zaHV0ZG93bihnYywgY3R4LSZndDtjb250ZXh0LmNpZCk7PGJyPgomZ3Q7ICs8YnI+
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLyogTWFrZSBzdXJlIHRoZSBjb250ZXh0IGlzIHBy
b3Blcmx5IGNsZWFyZWQgKi88YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmVsZWFzZV9j
b250ZXh0KGN0eCk7PGJyPgomZ3Q7wqAgwqAgwqAgwqB9PGJyPgomZ3Q7wqAgwqB9PGJyPgomZ3Q7
wqAgwqA8YnI+CiZndDsgQEAgLTIyNDEsNiArMjI0NCw3IEBAIHN0YXRpYyBEQnVzTWVzc2FnZSAq
Z3Byc19yZW1vdmVfY29udGV4dChEQnVzQ29ubmVjdGlvbiAqY29ubiw8YnI+CiZndDvCoCDCoCDC
oCDCoH08YnI+CiZndDvCoCDCoDxicj4KJmd0O8KgIMKgIMKgIMKgREJHKCZxdW90O1VucmVnaXN0
ZXJpbmcgY29udGV4dDogJXMmcXVvdDssIGN0eC0mZ3Q7cGF0aCk7PGJyPgomZ3Q7ICvCoCDCoCDC
oHJlbGVhc2VfY29udGV4dChjdHgpOzxicj4KPGJyPgpJZiB3ZSBnZXQgaGVyZSB0aGVuIHRoZSBj
b250ZXh0IGlzbiYjMzk7dCBhY3RpdmUgYW5kIGRvZXNuJiMzOTt0IG5lZWQgdG8gYmUgPGJyPgpy
ZWxlYXNlZC7CoCBBY3RpdmUgY29udGV4dCByZWxlYXNlIGhhcHBlbnMgaW4gZ3Byc19kZWFjdGl2
YXRlX2Zvcl9yZW1vdmUuIDxicj4KwqAgU28gSSBkb24mIzM5O3QgdGhpbmsgdGhpcyBpcyBuZWVk
ZWQ/PGJyPjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2
PjxkaXYgZGlyPSJhdXRvIj5JIGdvdCB0aGlzIGNoYW5nZSBmcm9tIGV4dGVybmFsIGJyYW5jaGVz
LjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPkkgZG91YnRl
ZCBpdCB3YXMgbmVlZGVkIGFueW1vcmUsIGJ1dCBjb3VsZG4mIzM5O3QgYmUgc3VyZSB0aGF0IEkg
aGFkIHRlc3RlZCBhbGwgY2FzZXMuPC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2
IGRpcj0iYXV0byI+dGhhbmsgeW91IGZvciBjaGVja2luZyBpdCwgYW5kIGl0IGNhbiB0aGVuIGJl
IGxlZnQgb3V0LjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8i
Pjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CiZndDvCoCDCoCDC
oCDCoGNvbnRleHRfZGJ1c191bnJlZ2lzdGVyKGN0eCk7PGJyPgomZ3Q7wqAgwqAgwqAgwqBncHJz
LSZndDtjb250ZXh0cyA9IGdfc2xpc3RfcmVtb3ZlKGdwcnMtJmd0O2NvbnRleHRzLCBjdHgpOzxi
cj4KJmd0O8KgIMKgPGJyPgomZ3Q7IDxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPjwv
YmxvY2txdW90ZT48L2Rpdj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYgZGly
PSJhdXRvIj5SZWdhcmRzLDwvZGl2PjxkaXYgZGlyPSJhdXRvIj5HaWFjaW50bzwvZGl2PjxkaXYg
ZGlyPSJhdXRvIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mg
c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48L2Rpdj4K

--===============6138826201237646439==--


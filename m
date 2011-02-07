Content-Type: multipart/mixed; boundary="===============8477338804326305446=="
MIME-Version: 1.0
From: andre matos <andre.matos.ste@gmail.com>
Subject: Re: [PATCH] voicecall: fix transfer
Date: Mon, 07 Feb 2011 21:37:50 +0100
Message-ID: <AANLkTik060s7RnKg3j-0XVx7P8NnTUg5v0gxFiexEgHx@mail.gmail.com>
In-Reply-To: <4D504C26.4030504@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8477338804326305446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, Feb 7, 2011 at 8:46 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Andre,
>
> > @@ -1350,11 +1351,12 @@ static DBusMessage
> *manager_transfer(DBusConnection *conn,
> >        * implementing the call transfer operation for a call that is
> >        * still dialing/alerting.
> >        */
> > -     numactive +=3D voicecalls_num_connecting(vc);
> > +     numconn =3D voicecalls_num_connecting(vc);
> >
> >       numheld =3D voicecalls_num_held(vc);
> >
> > -     if ((numactive !=3D 1) && (numheld !=3D 1))
>
> I don't get it, isn't the above condition taking care of this already?
> Its been a while but the precondition of ECT is:
>
> Held Call
> Outgoing or an Active call.  You cannot have an Outgoing and an Active
> call at the same time.  Hence numactive =3D=3D 1 && numheld =3D=3D 1 shou=
ld work
> just fine.
>

What you wrote is correct. transfer works when it supposed to work.

The changes i did takes care of the negative cases.
This means calling transfer should fail if we have:
multiparty call active and one held call
one active call and one held multiparty call
only one active call
only one held call
etc...


>
> > +     if ((numactive > 1 || numheld > 1) ||
>
this checks if there is multiparty

> +             ((numheld + numactive + numconn) !=3D 2))
>
this makes sure we have the the two call necessary for a transfer.

>               return __ofono_error_failed(msg);
> >
> >       if (vc->driver->transfer =3D=3D NULL)
>
> Regards,
> -Denis
>


With my change oFono doesn't send unnecessary queries to the modem.

Best regards,
Andr=C3=A9

--===============8477338804326305446==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gTW9uLCBGZWIgNywg
MjAxMSBhdCA4OjQ2IFBNLCBEZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJl
Zj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9z
cGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eDsiPgpIaSBBbmRyZSw8YnI+CjxkaXYgY2xhc3M9ImltIj48YnI+CiZndDsgQEAgLTEzNTAsMTEg
KzEzNTEsMTIgQEAgc3RhdGljIERCdXNNZXNzYWdlICptYW5hZ2VyX3RyYW5zZmVyKERCdXNDb25u
ZWN0aW9uICpjb25uLDxicj4KJmd0OyCgIKAgoCCgKiBpbXBsZW1lbnRpbmcgdGhlIGNhbGwgdHJh
bnNmZXIgb3BlcmF0aW9uIGZvciBhIGNhbGwgdGhhdCBpczxicj4KJmd0OyCgIKAgoCCgKiBzdGls
bCBkaWFsaW5nL2FsZXJ0aW5nLjxicj4KJmd0OyCgIKAgoCCgKi88YnI+CiZndDsgLSCgIKAgbnVt
YWN0aXZlICs9IHZvaWNlY2FsbHNfbnVtX2Nvbm5lY3RpbmcodmMpOzxicj4KJmd0OyArIKAgoCBu
dW1jb25uID0gdm9pY2VjYWxsc19udW1fY29ubmVjdGluZyh2Yyk7PGJyPgomZ3Q7PGJyPgomZ3Q7
IKAgoCCgIG51bWhlbGQgPSB2b2ljZWNhbGxzX251bV9oZWxkKHZjKTs8YnI+CiZndDs8YnI+CiZn
dDsgLSCgIKAgaWYgKChudW1hY3RpdmUgIT0gMSkgJmFtcDsmYW1wOyAobnVtaGVsZCAhPSAxKSk8
YnI+Cjxicj4KPC9kaXY+SSBkb24mIzM5O3QgZ2V0IGl0LCBpc24mIzM5O3QgdGhlIGFib3ZlIGNv
bmRpdGlvbiB0YWtpbmcgY2FyZSBvZiB0aGlzIGFscmVhZHk/PGJyPgpJdHMgYmVlbiBhIHdoaWxl
IGJ1dCB0aGUgcHJlY29uZGl0aW9uIG9mIEVDVCBpczo8YnI+Cjxicj4KSGVsZCBDYWxsPGJyPgpP
dXRnb2luZyBvciBhbiBBY3RpdmUgY2FsbC4goFlvdSBjYW5ub3QgaGF2ZSBhbiBPdXRnb2luZyBh
bmQgYW4gQWN0aXZlPGJyPgpjYWxsIGF0IHRoZSBzYW1lIHRpbWUuIKBIZW5jZSBudW1hY3RpdmUg
PT0gMSAmYW1wOyZhbXA7IG51bWhlbGQgPT0gMSBzaG91bGQgd29yazxicj4KanVzdCBmaW5lLjxi
cj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5XaGF0IHlvdSB3cm90ZSBpcyBjb3Jy
ZWN0LiB0cmFuc2ZlciB3b3JrcyB3aGVuIGl0IHN1cHBvc2VkIHRvIHdvcmsuPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5UaGUgY2hhbmdlcyBpIGRpZCB0YWtlcyBjYXJlIG9mIHRoZSBuZWdhdGl2
ZSBjYXNlcy4goDwvZGl2PjxkaXY+VGhpcyBtZWFucyBjYWxsaW5nIHRyYW5zZmVyIHNob3VsZCBm
YWlsIGlmIHdlIGhhdmU6PC9kaXY+CjxkaXY+bXVsdGlwYXJ0eSBjYWxsIGFjdGl2ZSBhbmQgb25l
IGhlbGQgY2FsbDwvZGl2PjxkaXY+b25lIGFjdGl2ZSBjYWxsIGFuZCBvbmUgaGVsZCBtdWx0aXBh
cnR5IGNhbGw8L2Rpdj48ZGl2Pm9ubHkgb25lIGFjdGl2ZSBjYWxsPC9kaXY+PGRpdj5vbmx5IG9u
ZSBoZWxkIGNhbGw8L2Rpdj48ZGl2PmV0Yy4uLjxicj48L2Rpdj48ZGl2PqA8L2Rpdj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXIt
bGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4OyI+Cgo8ZGl2IGNsYXNzPSJpbSI+
PGJyPgomZ3Q7ICsgoCCgIGlmICgobnVtYWN0aXZlICZndDsgMSB8fCBudW1oZWxkICZndDsgMSkg
fHw8YnI+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+dGhpcyBjaGVja3MgaWYgdGhlcmUgaXMgbXVs
dGlwYXJ0eaA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4OyI+CjxkaXYgY2xhc3M9ImltIj4KJmd0OyArIKAgoCCgIKAgoCCgICgo
bnVtaGVsZCArIG51bWFjdGl2ZSArIG51bWNvbm4pICE9IDIpKTxicj48L2Rpdj48L2Jsb2NrcXVv
dGU+PGRpdj50aGlzIG1ha2VzIHN1cmUgd2UgaGF2ZSB0aGUgdGhlIHR3byBjYWxsIG5lY2Vzc2Fy
eSBmb3IgYSB0cmFuc2Zlci6gPC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNj
Y2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPgo8ZGl2IGNsYXNzPSJpbSI+CiZndDsgoCCgIKAg
oCCgIKAgoCByZXR1cm4gX19vZm9ub19lcnJvcl9mYWlsZWQobXNnKTs8YnI+CiZndDs8YnI+CiZn
dDsgoCCgIKAgaWYgKHZjLSZndDtkcml2ZXItJmd0O3RyYW5zZmVyID09IE5VTEwpPGJyPgo8YnI+
CjwvZGl2PlJlZ2FyZHMsPGJyPgo8Zm9udCBjb2xvcj0iIzg4ODg4OCI+LURlbmlzPGJyPgo8L2Zv
bnQ+PC9ibG9ja3F1b3RlPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
V2l0aCBteSBjaGFuZ2Ugb0Zvbm8gZG9lc24mIzM5O3Qgc2VuZCB1bm5lY2Vzc2FyeSBxdWVyaWVz
IHRvIHRoZSBtb2RlbS48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IHJlZ2FyZHMs
PC9kaXY+PGRpdj5BbmRy6TwvZGl2Pgo=

--===============8477338804326305446==--


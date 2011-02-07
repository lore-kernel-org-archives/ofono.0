Content-Type: multipart/mixed; boundary="===============1119127293386764661=="
MIME-Version: 1.0
From: andre matos <andre.matos.ste@gmail.com>
Subject: Re: [PATCH] voicecall: fix transfer
Date: Mon, 07 Feb 2011 22:24:02 +0100
Message-ID: <AANLkTi=KSZWwgfqcVXGkirWVzAxt=cKA50affLix+-ZF@mail.gmail.com>
In-Reply-To: <4D505EA2.8020202@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1119127293386764661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


On Mon, Feb 7, 2011 at 10:05 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Andre,
>
> On 02/07/2011 02:37 PM, andre matos wrote:
> > Hi Denis,
> >
> > On Mon, Feb 7, 2011 at 8:46 PM, Denis Kenzior <denkenz@gmail.com
> > <mailto:denkenz@gmail.com>> wrote:
> >
> >     Hi Andre,
> >
> >     > @@ -1350,11 +1351,12 @@ static DBusMessage
> >     *manager_transfer(DBusConnection *conn,
> >     >        * implementing the call transfer operation for a call that
> is
> >     >        * still dialing/alerting.
> >     >        */
> >     > -     numactive +=3D voicecalls_num_connecting(vc);
> >     > +     numconn =3D voicecalls_num_connecting(vc);
> >     >
> >     >       numheld =3D voicecalls_num_held(vc);
> >     >
> >     > -     if ((numactive !=3D 1) && (numheld !=3D 1))
> >
> >     I don't get it, isn't the above condition taking care of this
> already?
> >     Its been a while but the precondition of ECT is:
> >
> >     Held Call
> >     Outgoing or an Active call.  You cannot have an Outgoing and an
> Active
> >     call at the same time.  Hence numactive =3D=3D 1 && numheld =3D=3D =
1 should
> work
> >     just fine.
> >
> >
> > What you wrote is correct. transfer works when it supposed to work.
> >
> > The changes i did takes care of the negative cases.
> > This means calling transfer should fail if we have:
> > multiparty call active and one held call
>
> if mpty is an active call, then numactive would be > 1 -> fail to invoke
> ECT
>

Are we reading the same code?

for this case we have:
numactive !=3D 1  =3D=3D> true
numheld !=3D 1  =3D=3D> false

(numactive !=3D 1) && (numheld !=3D 1)  =3D=3D>  false

in this case  "return __ofono_error_failed(msg);" is not called and the at
command is sent to modem.

I know the correct conditions for ECT. I am avoiding sending to the modem
unnecessary commands. Why should i ask the modem to invoke ECT if i already
know it is going to fail for a multiparty call.

Best regards,
Andr=C3=A9

--===============1119127293386764661==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdj5IaSBEZW5pcyw8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGJyPjxkaXYgY2xhc3M9Imdt
YWlsX3F1b3RlIj5PbiBNb24sIEZlYiA3LCAyMDExIGF0IDEwOjA1IFBNLCBEZW5pcyBLZW56aW9y
IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5k
ZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPgpIaSBBbmRyZSw8YnI+CjxkaXYgY2xhc3M9
ImltIj48YnI+Ck9uIDAyLzA3LzIwMTEgMDI6MzcgUE0sIGFuZHJlIG1hdG9zIHdyb3RlOjxicj4K
Jmd0OyBIaSBEZW5pcyw8YnI+CiZndDs8YnI+CiZndDsgT24gTW9uLCBGZWIgNywgMjAxMSBhdCA4
OjQ2IFBNLCBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5j
b20iPmRlbmtlbnpAZ21haWwuY29tPC9hPjxicj4KPC9kaXY+PGRpdiBjbGFzcz0iaW0iPiZndDsg
Jmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21h
aWwuY29tPC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4KJmd0Ozxicj4KJmd0OyCgIKAgSGkgQW5kcmUs
PGJyPgomZ3Q7PGJyPgomZ3Q7IKAgoCAmZ3Q7IEBAIC0xMzUwLDExICsxMzUxLDEyIEBAIHN0YXRp
YyBEQnVzTWVzc2FnZTxicj4KJmd0OyCgIKAgKm1hbmFnZXJfdHJhbnNmZXIoREJ1c0Nvbm5lY3Rp
b24gKmNvbm4sPGJyPgomZ3Q7IKAgoCAmZ3Q7IKAgoCCgIKAqIGltcGxlbWVudGluZyB0aGUgY2Fs
bCB0cmFuc2ZlciBvcGVyYXRpb24gZm9yIGEgY2FsbCB0aGF0IGlzPGJyPgomZ3Q7IKAgoCAmZ3Q7
IKAgoCCgIKAqIHN0aWxsIGRpYWxpbmcvYWxlcnRpbmcuPGJyPgomZ3Q7IKAgoCAmZ3Q7IKAgoCCg
IKAqLzxicj4KJmd0OyCgIKAgJmd0OyAtIKAgoCBudW1hY3RpdmUgKz0gdm9pY2VjYWxsc19udW1f
Y29ubmVjdGluZyh2Yyk7PGJyPgomZ3Q7IKAgoCAmZ3Q7ICsgoCCgIG51bWNvbm4gPSB2b2ljZWNh
bGxzX251bV9jb25uZWN0aW5nKHZjKTs8YnI+CiZndDsgoCCgICZndDs8YnI+CiZndDsgoCCgICZn
dDsgoCCgIKAgbnVtaGVsZCA9IHZvaWNlY2FsbHNfbnVtX2hlbGQodmMpOzxicj4KJmd0OyCgIKAg
Jmd0Ozxicj4KJmd0OyCgIKAgJmd0OyAtIKAgoCBpZiAoKG51bWFjdGl2ZSAhPSAxKSAmYW1wOyZh
bXA7IChudW1oZWxkICE9IDEpKTxicj4KJmd0Ozxicj4KJmd0OyCgIKAgSSBkb24mIzM5O3QgZ2V0
IGl0LCBpc24mIzM5O3QgdGhlIGFib3ZlIGNvbmRpdGlvbiB0YWtpbmcgY2FyZSBvZiB0aGlzIGFs
cmVhZHk/PGJyPgomZ3Q7IKAgoCBJdHMgYmVlbiBhIHdoaWxlIGJ1dCB0aGUgcHJlY29uZGl0aW9u
IG9mIEVDVCBpczo8YnI+CiZndDs8YnI+CiZndDsgoCCgIEhlbGQgQ2FsbDxicj4KJmd0OyCgIKAg
T3V0Z29pbmcgb3IgYW4gQWN0aXZlIGNhbGwuIKBZb3UgY2Fubm90IGhhdmUgYW4gT3V0Z29pbmcg
YW5kIGFuIEFjdGl2ZTxicj4KJmd0OyCgIKAgY2FsbCBhdCB0aGUgc2FtZSB0aW1lLiCgSGVuY2Ug
bnVtYWN0aXZlID09IDEgJmFtcDsmYW1wOyBudW1oZWxkID09IDEgc2hvdWxkIHdvcms8YnI+CiZn
dDsgoCCgIGp1c3QgZmluZS48YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDsgV2hhdCB5b3Ugd3Jv
dGUgaXMgY29ycmVjdC4gdHJhbnNmZXIgd29ya3Mgd2hlbiBpdCBzdXBwb3NlZCB0byB3b3JrLjxi
cj4KJmd0Ozxicj4KJmd0OyBUaGUgY2hhbmdlcyBpIGRpZCB0YWtlcyBjYXJlIG9mIHRoZSBuZWdh
dGl2ZSBjYXNlcy48YnI+CiZndDsgVGhpcyBtZWFucyBjYWxsaW5nIHRyYW5zZmVyIHNob3VsZCBm
YWlsIGlmIHdlIGhhdmU6PGJyPgomZ3Q7IG11bHRpcGFydHkgY2FsbCBhY3RpdmUgYW5kIG9uZSBo
ZWxkIGNhbGw8YnI+Cjxicj4KPC9kaXY+aWYgbXB0eSBpcyBhbiBhY3RpdmUgY2FsbCwgdGhlbiBu
dW1hY3RpdmUgd291bGQgYmUgJmd0OyAxIC0mZ3Q7IGZhaWwgdG8gaW52b2tlIEVDVDxicj48L2Js
b2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRp
dj5BcmUgd2UgcmVhZGluZyB0aGUgc2FtZSBjb2RlPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
Zm9yIHRoaXMgY2FzZSB3ZSBoYXZlOjwvZGl2Pgo8ZGl2Pm51bWFjdGl2ZSAhPSAxIKA9PSZndDsg
dHJ1ZTwvZGl2PjxkaXY+bnVtaGVsZCAhPSAxIKA9PSZndDsgZmFsc2U8YnI+PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj4obnVtYWN0aXZlICE9IDEpICZhbXA7JmFtcDsgKG51bWhlbGQgIT0gMSkg
oD09Jmd0OyCgZmFsc2U8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmluIHRoaXMgY2FzZaAgJnF1
b3Q7cmV0dXJuIF9fb2Zvbm9fZXJyb3JfZmFpbGVkKG1zZyk7JnF1b3Q7IGlzIG5vdCBjYWxsZWQg
YW5kIHRoZSBhdCBjb21tYW5kIGlzIHNlbnQgdG8gbW9kZW0uPC9kaXY+CjxkaXY+PGJyPjwvZGl2
PjwvZGl2PjwvZGl2PjxkaXY+SSBrbm93IHRoZSBjb3JyZWN0IGNvbmRpdGlvbnMgZm9yIEVDVC4g
SSBhbSBhdm9pZGluZyBzZW5kaW5nIHRvIHRoZSBtb2RlbSB1bm5lY2Vzc2FyeSBjb21tYW5kcy4g
V2h5IHNob3VsZCBpIGFzayB0aGUgbW9kZW0gdG8gaW52b2tlIEVDVCBpZiBpIGFscmVhZHkga25v
dyBpdCBpcyBnb2luZyB0byBmYWlsIGZvciBhIG11bHRpcGFydHkgY2FsbC48L2Rpdj4KPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IHJlZ2FyZHMsPGJyPjwvZGl2PjxkaXY+QW5kcuk8L2Rp
dj4K

--===============1119127293386764661==--


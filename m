Content-Type: multipart/mixed; boundary="===============3413365194715994453=="
MIME-Version: 1.0
From: andre matos <andre.matos.ste@gmail.com>
Subject: Re: [PATCH] voicecall: fix transfer
Date: Mon, 07 Feb 2011 23:12:08 +0100
Message-ID: <AANLkTin7-jU3z7nhLmfHBsVeBTZkRjQb5-zzKAc4uX0m@mail.gmail.com>
In-Reply-To: <AANLkTi=ATGSivr65py3FZ4wNEqOjivv7i7WPnSrdZ0q0@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3413365194715994453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 7, 2011 at 11:00 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Andre,
>
> On 02/07/2011 03:48 PM, andre matos wrote:
> > Hi Denis,
> >
> > On Mon, Feb 7, 2011 at 10:30 PM, Denis Kenzior <denkenz@gmail.com
> > <mailto:denkenz@gmail.com>> wrote:
> >
> >     Hi Andre,
> >
> >     > Are we reading the same code?
> >     >
> >     > for this case we have:
> >     > numactive !=3D 1  =3D=3D> true
> >     > numheld !=3D 1  =3D=3D> false
> >     >
> >     > (numactive !=3D 1) && (numheld !=3D 1)  =3D=3D>  false
> >     >
> >
> >     Then shouldn't the patch simply be modified to if (numactive !=3D 1=
 ||
> >     numheld !=3D 1)?
> >
> >
> > Yes, if you wish to sacrifice readability for simplicity.
> >
>
> Don't get too offended, the || was intended instead of && in the first
> place.  My brain just had wired crossed and I wasn't seeing why you
> needed a 6 line patch to fix this.
>

Not offended at all :) i will always have preference for my code :)
My code got more complicated because initially i thought that connect
counter was for incoming and outgoing calls.


>
> > I find my version self explanatory.
> >
>
> Sorry, but I do not find your style more readable, less actually. Also,
> when submitting patches please follow our coding style guidelines.  You
> had at least 1 style violation, namely rule M4.
>

That is strange i run checkpatch  on the code i did not get any warning. Is
there a  better script for the checking the patches before sending?

Best regards,
Andr=C3=A9

--===============3413365194715994453==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBjbGFzcz0iaW0iPk9uIE1v
biwgRmViIDcsIDIwMTEgYXQgMTE6MDAgUE0sIERlbmlzIEtlbnppb3IgPHNwYW4gZGlyPSJsdHIi
PiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5k
ZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CgpIaSBBbmRyZSw8YnI+CjxkaXY+PGJyPgpP
biAwMi8wNy8yMDExIDAzOjQ4IFBNLCBhbmRyZSBtYXRvcyB3cm90ZTo8YnI+CiZndDsgSGkgRGVu
aXMsPGJyPgomZ3Q7PGJyPgomZ3Q7IE9uIE1vbiwgRmViIDcsIDIwMTEgYXQgMTA6MzAgUE0sIERl
bmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0
PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29tPC9hPjxicj4KPC9kaXY+PGRpdj4mZ3Q7ICZsdDtt
YWlsdG86PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+
ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0OyZndDsgd3JvdGU6PGJyPgomZ3Q7PGJyPgomZ3Q7IKAg
oCBIaSBBbmRyZSw8YnI+CiZndDs8YnI+CiZndDsgoCCgICZndDsgQXJlIHdlIHJlYWRpbmcgdGhl
IHNhbWUgY29kZT88YnI+CiZndDsgoCCgICZndDs8YnI+CiZndDsgoCCgICZndDsgZm9yIHRoaXMg
Y2FzZSB3ZSBoYXZlOjxicj4KJmd0OyCgIKAgJmd0OyBudW1hY3RpdmUgIT0gMSCgPT0mZ3Q7IHRy
dWU8YnI+CiZndDsgoCCgICZndDsgbnVtaGVsZCAhPSAxIKA9PSZndDsgZmFsc2U8YnI+CiZndDsg
oCCgICZndDs8YnI+CiZndDsgoCCgICZndDsgKG51bWFjdGl2ZSAhPSAxKSAmYW1wOyZhbXA7IChu
dW1oZWxkICE9IDEpIKA9PSZndDsgoGZhbHNlPGJyPgomZ3Q7IKAgoCAmZ3Q7PGJyPgomZ3Q7PGJy
PgomZ3Q7IKAgoCBUaGVuIHNob3VsZG4mIzM5O3QgdGhlIHBhdGNoIHNpbXBseSBiZSBtb2RpZmll
ZCB0byBpZiAobnVtYWN0aXZlICE9IDEgfHw8YnI+CiZndDsgoCCgIG51bWhlbGQgIT0gMSk/PGJy
PgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IFllcywgaWYgeW91IHdpc2ggdG8gc2FjcmlmaWNlIHJl
YWRhYmlsaXR5IGZvciBzaW1wbGljaXR5Ljxicj4KJmd0Ozxicj4KPGJyPgo8L2Rpdj5Eb24mIzM5
O3QgZ2V0IHRvbyBvZmZlbmRlZCwgdGhlIHx8IHdhcyBpbnRlbmRlZCBpbnN0ZWFkIG9mICZhbXA7
JmFtcDsgaW4gdGhlIGZpcnN0PGJyPgpwbGFjZS4goE15IGJyYWluIGp1c3QgaGFkIHdpcmVkIGNy
b3NzZWQgYW5kIEkgd2FzbiYjMzk7dCBzZWVpbmcgd2h5IHlvdTxicj4KbmVlZGVkIGEgNiBsaW5l
IHBhdGNoIHRvIGZpeCB0aGlzLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PC9kaXY+
PGRpdj5Ob3Qgb2ZmZW5kZWQgYXQgYWxsIDopIGkgd2lsbCBhbHdheXMgaGF2ZSBwcmVmZXJlbmNl
IGZvciBteSBjb2RlIDopPC9kaXY+PGRpdj5NeSBjb2RlIGdvdCBtb3JlIGNvbXBsaWNhdGVkIGJl
Y2F1c2UgaW5pdGlhbGx5IGkgdGhvdWdodCB0aGF0IGNvbm5lY3QgY291bnRlciB3YXMgZm9yIGlu
Y29taW5nIGFuZCBvdXRnb2luZyBjYWxscy48L2Rpdj4KPGRpdiBjbGFzcz0iaW0iPgo8ZGl2PqA8
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAg
LjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGRpdj48
YnI+CiZndDsgSSBmaW5kIG15IHZlcnNpb24gc2VsZiBleHBsYW5hdG9yeS48YnI+CiZndDs8YnI+
Cjxicj4KPC9kaXY+U29ycnksIGJ1dCBJIGRvIG5vdCBmaW5kIHlvdXIgc3R5bGUgbW9yZSByZWFk
YWJsZSwgbGVzcyBhY3R1YWxseS4gQWxzbyw8YnI+CndoZW4gc3VibWl0dGluZyBwYXRjaGVzIHBs
ZWFzZSBmb2xsb3cgb3VyIGNvZGluZyBzdHlsZSBndWlkZWxpbmVzLiCgWW91PGJyPgpoYWQgYXQg
bGVhc3QgMSBzdHlsZSB2aW9sYXRpb24sIG5hbWVseSBydWxlIE00Ljxicj48L2Jsb2NrcXVvdGU+
PGRpdj48YnI+PC9kaXY+PC9kaXY+PGRpdj5UaGF0IGlzIHN0cmFuZ2UgaSBydW4gY2hlY2twYXRj
aCCgb24gdGhlIGNvZGUgaSBkaWQgbm90IGdldCBhbnkgd2FybmluZy4gSXMgdGhlcmUgYSCgYmV0
dGVyIHNjcmlwdCBmb3IgdGhlIGNoZWNraW5nIHRoZSBwYXRjaGVzIGJlZm9yZSBzZW5kaW5nPzwv
ZGl2PgoKPGRpdj48YnI+PC9kaXY+PC9kaXY+PGRpdj5CZXN0IHJlZ2FyZHMsPGJyPjwvZGl2Pjxk
aXY+QW5kcuk8L2Rpdj4KPGJyPgo=

--===============3413365194715994453==--


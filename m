Content-Type: multipart/mixed; boundary="===============3087460652769785193=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: Re: voicecall: behavior of ReleaseAndAnswere with held calls?
Date: Tue, 25 Jan 2011 22:43:04 +0100
Message-ID: <AANLkTi=9=p6+nxrpJra0R=FMCCXaCdyLt9iaZSLmjAFg@mail.gmail.com>
In-Reply-To: <4D3F34A2.1070805@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3087460652769785193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

2011/1/25 Denis Kenzior <denkenz@gmail.com>

> Hi Tomasz,
>
> > Shouldn=E2=80=99t ReleaseAndAnswere() release the active call and bring=
 back the
> > held one in such situation?
> >
>
> You shouldn't be using ReleaseAndAnswer in this case, instead you should
> use SwapCalls.  SwapCalls has the added benefit of allowing swapping of
> held and active calls even if there is a call waiting (if your modem
> hardware supports this.)
>

SwapCalls wont release active call. This would be a case when we finished
active call and we want to disconnect and get back to the held one.
Though this can also be done with Release on active call followed
by SwapCalls.

>
> > There also could be a little more description of behavior for a case
> > when we have held and waiting calls saying that the waiting call will be
> answered and
> > that held won=E2=80=99t be released.
> >
>
> The documentation says: "Releases currently active call and answers the
> currently waiting call".
>
> Is this not enough? Can you suggest better wording?
>

If we are not touching held calls with this function than it is enough.
I would only add "if any exist" as this function works when there are held
and waiting calls.

"Releases currently active call if any exists, and answers the
currently waiting call."


>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

Best regards
Tomasz

--===============3087460652769785193==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXM8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDExLzEvMjUgRGVuaXMg
S2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWls
LmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPgpIaSBUb21hc3osPGJyPgo8ZGl2IGNsYXNz
PSJpbSI+PGJyPgomZ3Q7IFNob3VsZG6SdCBSZWxlYXNlQW5kQW5zd2VyZSgpIHJlbGVhc2UgdGhl
IGFjdGl2ZSBjYWxsIGFuZCBicmluZyBiYWNrIHRoZTxicj4KJmd0OyBoZWxkIG9uZSBpbiBzdWNo
IHNpdHVhdGlvbj88YnI+CiZndDs8YnI+Cjxicj4KPC9kaXY+WW91IHNob3VsZG4mIzM5O3QgYmUg
dXNpbmcgUmVsZWFzZUFuZEFuc3dlciBpbiB0aGlzIGNhc2UsIGluc3RlYWQgeW91IHNob3VsZDxi
cj4KdXNlIFN3YXBDYWxscy4goFN3YXBDYWxscyBoYXMgdGhlIGFkZGVkIGJlbmVmaXQgb2YgYWxs
b3dpbmcgc3dhcHBpbmcgb2Y8YnI+CmhlbGQgYW5kIGFjdGl2ZSBjYWxscyBldmVuIGlmIHRoZXJl
IGlzIGEgY2FsbCB3YWl0aW5nIChpZiB5b3VyIG1vZGVtPGJyPgpoYXJkd2FyZSBzdXBwb3J0cyB0
aGlzLik8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPlN3YXBDYWxscyB3b250IHJlbGVhc2UgYWN0
aXZlIGNhbGwuIFRoaXMgd291bGQgYmUgYSBjYXNlIHdoZW4gd2UgZmluaXNoZWQ8YnI+YWN0aXZl
IGNhbGwgYW5kIHdlIHdhbnQgdG8gZGlzY29ubmVjdCBhbmQgZ2V0IGJhY2sgdG8gdGhlIGhlbGQg
b25lLjxicj5UaG91Z2ggdGhpcyBjYW4gYWxzbyBiZSBkb25lIHdpdGggUmVsZWFzZSBvbiBhY3Rp
dmUgY2FsbCBmb2xsb3dlZDxicj4KYnkgU3dhcENhbGxzLjxicj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQg
MHB0IDAuOGV4OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFk
ZGluZy1sZWZ0OiAxZXg7Ij48ZGl2IGNsYXNzPSJpbSI+CiZndDs8YnI+CiZndDsgVGhlcmUgYWxz
byBjb3VsZCBiZSBhIGxpdHRsZSBtb3JlIGRlc2NyaXB0aW9uIG9mIGJlaGF2aW9yIGZvciBhIGNh
c2U8YnI+CiZndDsgd2hlbiB3ZSBoYXZlIGhlbGQgYW5kIHdhaXRpbmcgY2FsbHMgc2F5aW5nIHRo
YXQgdGhlIHdhaXRpbmcgY2FsbCB3aWxsIGJlIGFuc3dlcmVkIGFuZDxicj4KJmd0OyB0aGF0IGhl
bGQgd29uknQgYmUgcmVsZWFzZWQuPGJyPgomZ3Q7PGJyPgo8YnI+CjwvZGl2PlRoZSBkb2N1bWVu
dGF0aW9uIHNheXM6ICZxdW90O1JlbGVhc2VzIGN1cnJlbnRseSBhY3RpdmUgY2FsbCBhbmQgYW5z
d2VycyB0aGU8YnI+CmN1cnJlbnRseSB3YWl0aW5nIGNhbGwmcXVvdDsuPGJyPgo8YnI+CklzIHRo
aXMgbm90IGVub3VnaD8gQ2FuIHlvdSBzdWdnZXN0IGJldHRlciB3b3JkaW5nPzxicj48L2Jsb2Nr
cXVvdGU+PGRpdj48YnI+SWYgd2UgYXJlIG5vdCB0b3VjaGluZyBoZWxkIGNhbGxzIHdpdGggdGhp
cyBmdW5jdGlvbiB0aGFuIGl0IGlzIGVub3VnaC48YnI+SSB3b3VsZCBvbmx5IGFkZCAmcXVvdDtp
ZiBhbnkgZXhpc3QmcXVvdDsgYXMgdGhpcyBmdW5jdGlvbiB3b3JrcyB3aGVuIHRoZXJlIGFyZSBo
ZWxkPGJyPgphbmQgd2FpdGluZyBjYWxscy48YnI+PGJyPiZxdW90O1JlbGVhc2VzIGN1cnJlbnRs
eSBhY3RpdmUgY2FsbCBpZiBhbnkgZXhpc3RzLCBhbmQgYW5zd2VycyB0aGU8YnI+CmN1cnJlbnRs
eSB3YWl0aW5nIGNhbGwuJnF1b3Q7PGJyPqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDogMXB4
IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KPGJyPgpSZWdh
cmRzLDxicj4KLURlbmlzPGJyPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zv
bm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwOi8vbGlz
dHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3Rz
Lm9mb25vLm9yZy9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+
QmVzdCByZWdhcmRzPGJyPlRvbWFzejxicj4K

--===============3087460652769785193==--


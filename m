Content-Type: multipart/mixed; boundary="===============7092601988844247432=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: Re: voicecall: behavior of ReleaseAndAnswere with held calls?
Date: Tue, 25 Jan 2011 23:18:50 +0100
Message-ID: <AANLkTinwec10=fv5sHM4+VeBEcJnQXMAtQva5FPBCV0E@mail.gmail.com>
In-Reply-To: <4D3F4851.8050609@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7092601988844247432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

2011/1/25 Denis Kenzior <denkenz@gmail.com>

> Hi Tomasz,
>
> On 01/25/2011 03:43 PM, Tomasz Gregorek wrote:
> > Hi Denis
> >
> > 2011/1/25 Denis Kenzior <denkenz(a)gmail.com <mailto:denkenz@gmail.co=
m>>
> >
> >     Hi Tomasz,
> >
> >     > Shouldn=E2=80=99t ReleaseAndAnswere() release the active call and=
 bring
> >     back the
> >     > held one in such situation?
> >     >
> >
> >     You shouldn't be using ReleaseAndAnswer in this case, instead you
> should
> >     use SwapCalls.  SwapCalls has the added benefit of allowing swapping
> of
> >     held and active calls even if there is a call waiting (if your modem
> >     hardware supports this.)
> >
> >
> > SwapCalls wont release active call. This would be a case when we finish=
ed
> > active call and we want to disconnect and get back to the held one.
> > Though this can also be done with Release on active call followed
> > by SwapCalls.
> >
>
> Yep, Hangup or HangupMultiparty then SwapCalls.  If you feel that a
> single operation to accomplish hangup + swap is required we can
> certainly consider it.  For now it didn't pass our API is Minimal +
> Complete test.  Perhaps ReleaseAndSwap()...?
>

I would go with easy solution by just changing src/voicecall.c line 1418

static DBusMessage *manager_release_and_answer(DBusConnection *conn,
                        DBusMessage *msg, void *data)
{
...

1418:
-    if (!voicecalls_have_waiting(vc))
+    if (!voicecalls_have_waiting(vc) && !voicecalls_have_with_status(vc,
CALL_STATUS_HELD))
        return __ofono_error_failed(msg);

...
    vc->driver->release_all_active(vc, generic_callback, vc);

    return NULL;
}

This would give ReleaseAndAnswer full functionality of +CHLD=3D1.

(sorry for pseudo-patch, working temporary on windows machine)


>
> >     >
> >     > There also could be a little more description of behavior for a
> case
> >     > when we have held and waiting calls saying that the waiting call
> >     will be answered and
> >     > that held won=E2=80=99t be released.
> >     >
> >
> >     The documentation says: "Releases currently active call and answers
> the
> >     currently waiting call".
> >
> >     Is this not enough? Can you suggest better wording?
> >
> >
> > If we are not touching held calls with this function than it is enough.
> > I would only add "if any exist" as this function works when there are
> held
> > and waiting calls.
> >
> > "Releases currently active call if any exists, and answers the
> > currently waiting call."
> >
>
> Fair enough, fixed with commit b937d99791abc8c33ef968be40f193f3985bca8d.
>
Thanks.


>
> Regards,
> -Denis
>

Br
Tomasz

--===============7092601988844247432==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXM8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDExLzEvMjUgRGVuaXMg
S2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWls
LmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPgpIaSBUb21hc3osPGJyPgo8ZGl2IGNsYXNz
PSJpbSI+PGJyPgpPbiAwMS8yNS8yMDExIDAzOjQzIFBNLCBUb21hc3ogR3JlZ29yZWsgd3JvdGU6
PGJyPgomZ3Q7IEhpIERlbmlzPGJyPgomZ3Q7PGJyPgo8L2Rpdj4mZ3Q7IDIwMTEvMS8yNSBEZW5p
cyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpA
Z21haWwuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNv
bSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0OyZndDs8YnI+CjxkaXYgY2xhc3M9ImltIj4mZ3Q7
PGJyPgomZ3Q7IKAgoCBIaSBUb21hc3osPGJyPgomZ3Q7PGJyPgomZ3Q7IKAgoCAmZ3Q7IFNob3Vs
ZG6SdCBSZWxlYXNlQW5kQW5zd2VyZSgpIHJlbGVhc2UgdGhlIGFjdGl2ZSBjYWxsIGFuZCBicmlu
Zzxicj4KJmd0OyCgIKAgYmFjayB0aGU8YnI+CiZndDsgoCCgICZndDsgaGVsZCBvbmUgaW4gc3Vj
aCBzaXR1YXRpb24/PGJyPgomZ3Q7IKAgoCAmZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IKAgoCBZb3Ug
c2hvdWxkbiYjMzk7dCBiZSB1c2luZyBSZWxlYXNlQW5kQW5zd2VyIGluIHRoaXMgY2FzZSwgaW5z
dGVhZCB5b3Ugc2hvdWxkPGJyPgomZ3Q7IKAgoCB1c2UgU3dhcENhbGxzLiCgU3dhcENhbGxzIGhh
cyB0aGUgYWRkZWQgYmVuZWZpdCBvZiBhbGxvd2luZyBzd2FwcGluZyBvZjxicj4KJmd0OyCgIKAg
aGVsZCBhbmQgYWN0aXZlIGNhbGxzIGV2ZW4gaWYgdGhlcmUgaXMgYSBjYWxsIHdhaXRpbmcgKGlm
IHlvdXIgbW9kZW08YnI+CiZndDsgoCCgIGhhcmR3YXJlIHN1cHBvcnRzIHRoaXMuKTxicj4KJmd0
Ozxicj4KJmd0Ozxicj4KJmd0OyBTd2FwQ2FsbHMgd29udCByZWxlYXNlIGFjdGl2ZSBjYWxsLiBU
aGlzIHdvdWxkIGJlIGEgY2FzZSB3aGVuIHdlIGZpbmlzaGVkPGJyPgomZ3Q7IGFjdGl2ZSBjYWxs
IGFuZCB3ZSB3YW50IHRvIGRpc2Nvbm5lY3QgYW5kIGdldCBiYWNrIHRvIHRoZSBoZWxkIG9uZS48
YnI+CiZndDsgVGhvdWdoIHRoaXMgY2FuIGFsc28gYmUgZG9uZSB3aXRoIFJlbGVhc2Ugb24gYWN0
aXZlIGNhbGwgZm9sbG93ZWQ8YnI+CiZndDsgYnkgU3dhcENhbGxzLjxicj4KJmd0Ozxicj4KPGJy
Pgo8L2Rpdj5ZZXAsIEhhbmd1cCBvciBIYW5ndXBNdWx0aXBhcnR5IHRoZW4gU3dhcENhbGxzLiCg
SWYgeW91IGZlZWwgdGhhdCBhPGJyPgpzaW5nbGUgb3BlcmF0aW9uIHRvIGFjY29tcGxpc2ggaGFu
Z3VwICsgc3dhcCBpcyByZXF1aXJlZCB3ZSBjYW48YnI+CmNlcnRhaW5seSBjb25zaWRlciBpdC4g
oEZvciBub3cgaXQgZGlkbiYjMzk7dCBwYXNzIG91ciBBUEkgaXMgTWluaW1hbCArPGJyPgpDb21w
bGV0ZSB0ZXN0LiCgUGVyaGFwcyBSZWxlYXNlQW5kU3dhcCgpLi4uPzxicj48L2Jsb2NrcXVvdGU+
PGRpdj48YnI+SSB3b3VsZCBnbyB3aXRoIGVhc3kgc29sdXRpb24gYnkganVzdCBjaGFuZ2luZyBz
cmMvdm9pY2VjYWxsLmMgbGluZSAxNDE4PGJyPjxicj5zdGF0aWMgREJ1c01lc3NhZ2UgKm1hbmFn
ZXJfcmVsZWFzZV9hbmRfYW5zd2VyKERCdXNDb25uZWN0aW9uICpjb25uLDxicj4KoKCgIKCgoCCg
oKAgoKCgIKCgoCCgoKAgREJ1c01lc3NhZ2UgKm1zZywgdm9pZCAqZGF0YSk8YnI+ezxicj4uLi48
YnI+PGJyPjE0MTg6PGJyPi2goKAgaWYgKCF2b2ljZWNhbGxzX2hhdmVfd2FpdGluZyh2YykpPGJy
PiugoKAgaWYgKCF2b2ljZWNhbGxzX2hhdmVfd2FpdGluZyh2YykgJmFtcDsmYW1wOyAhdm9pY2Vj
YWxsc19oYXZlX3dpdGhfc3RhdHVzKHZjLCBDQUxMX1NUQVRVU19IRUxEKSk8YnI+CqCgoCCgoKAg
cmV0dXJuIF9fb2Zvbm9fZXJyb3JfZmFpbGVkKG1zZyk7PGJyPjxicj4uLi48YnI+oKCgIHZjLSZn
dDtkcml2ZXItJmd0O3JlbGVhc2VfYWxsX2FjdGl2ZSh2YywgZ2VuZXJpY19jYWxsYmFjaywgdmMp
Ozxicj48YnI+oKCgIHJldHVybiBOVUxMOzxicj59PGJyPjxicj5UaGlzIHdvdWxkIGdpdmUgUmVs
ZWFzZUFuZEFuc3dlciBmdWxsIGZ1bmN0aW9uYWxpdHkgb2YgK0NITEQ9MS48YnI+Cjxicj4oc29y
cnkgZm9yIHBzZXVkby1wYXRjaCwgd29ya2luZyB0ZW1wb3Jhcnkgb24gd2luZG93cyBtYWNoaW5l
KTxicj6gPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQs
IDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+CjxkaXYgY2xhc3M9ImltIj48YnI+CiZndDsgoCCg
ICZndDs8YnI+CiZndDsgoCCgICZndDsgVGhlcmUgYWxzbyBjb3VsZCBiZSBhIGxpdHRsZSBtb3Jl
IGRlc2NyaXB0aW9uIG9mIGJlaGF2aW9yIGZvciBhIGNhc2U8YnI+CiZndDsgoCCgICZndDsgd2hl
biB3ZSBoYXZlIGhlbGQgYW5kIHdhaXRpbmcgY2FsbHMgc2F5aW5nIHRoYXQgdGhlIHdhaXRpbmcg
Y2FsbDxicj4KJmd0OyCgIKAgd2lsbCBiZSBhbnN3ZXJlZCBhbmQ8YnI+CiZndDsgoCCgICZndDsg
dGhhdCBoZWxkIHdvbpJ0IGJlIHJlbGVhc2VkLjxicj4KJmd0OyCgIKAgJmd0Ozxicj4KJmd0Ozxi
cj4KJmd0OyCgIKAgVGhlIGRvY3VtZW50YXRpb24gc2F5czogJnF1b3Q7UmVsZWFzZXMgY3VycmVu
dGx5IGFjdGl2ZSBjYWxsIGFuZCBhbnN3ZXJzIHRoZTxicj4KJmd0OyCgIKAgY3VycmVudGx5IHdh
aXRpbmcgY2FsbCZxdW90Oy48YnI+CiZndDs8YnI+CiZndDsgoCCgIElzIHRoaXMgbm90IGVub3Vn
aD8gQ2FuIHlvdSBzdWdnZXN0IGJldHRlciB3b3JkaW5nPzxicj4KJmd0Ozxicj4KJmd0Ozxicj4K
Jmd0OyBJZiB3ZSBhcmUgbm90IHRvdWNoaW5nIGhlbGQgY2FsbHMgd2l0aCB0aGlzIGZ1bmN0aW9u
IHRoYW4gaXQgaXMgZW5vdWdoLjxicj4KJmd0OyBJIHdvdWxkIG9ubHkgYWRkICZxdW90O2lmIGFu
eSBleGlzdCZxdW90OyBhcyB0aGlzIGZ1bmN0aW9uIHdvcmtzIHdoZW4gdGhlcmUgYXJlIGhlbGQ8
YnI+CiZndDsgYW5kIHdhaXRpbmcgY2FsbHMuPGJyPgomZ3Q7PGJyPgomZ3Q7ICZxdW90O1JlbGVh
c2VzIGN1cnJlbnRseSBhY3RpdmUgY2FsbCBpZiBhbnkgZXhpc3RzLCBhbmQgYW5zd2VycyB0aGU8
YnI+CiZndDsgY3VycmVudGx5IHdhaXRpbmcgY2FsbC4mcXVvdDs8YnI+CiZndDs8YnI+Cjxicj4K
PC9kaXY+RmFpciBlbm91Z2gsIGZpeGVkIHdpdGggY29tbWl0IGI5MzdkOTk3OTFhYmM4YzMzZWY5
NjhiZTQwZjE5M2YzOTg1YmNhOGQuPGJyPjwvYmxvY2txdW90ZT48ZGl2PlRoYW5rcy48YnI+oDxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBw
dCAwcHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0
KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KCjxicj4KUmVnYXJkcyw8YnI+Cjxmb250IGNvbG9yPSIj
ODg4ODg4Ij4tRGVuaXM8YnI+PC9mb250PjwvYmxvY2txdW90ZT48ZGl2PqA8L2Rpdj48L2Rpdj5C
cjxicj5Ub21hc3o8YnI+Cg==

--===============7092601988844247432==--


Content-Type: multipart/mixed; boundary="===============4788620915751037348=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: Re: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Wed, 23 Feb 2011 11:13:16 +0100
Message-ID: <AANLkTinshCCWMqKhgJocjHArKHOy9son=B0=bkzE37tw@mail.gmail.com>
In-Reply-To: <4D63E5C7.9010804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4788620915751037348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

2011/2/22 Denis Kenzior <denkenz@gmail.com>

> Hi,
>
> On 02/22/2011 10:08 AM, Soum, RedouaneX wrote:
> > Hi guys,
> >
> >
> >>> I agree with you , both bearers are almost similar.Minor difference i
> >>> see are context managment (especially default context creation) and
> some
> >>> eps related spill over on other existing atoms (For ex SIM would not
> >>> contain some ISIM (IMPU/IMPI)related stuff).My idea is seperate atoms
> >>> solution would even work for legacy switch back(CSFB) too with a
> minimal
> >>> impact on exiting architecture.Your comments on these ideas would also
> >>> very valuable here as i assume you have real modem unlike me.
> >>>
> >> My main concern is about LTE only modems, these ones would not register
> gprs
> >> atom so all stuff from gprs atom needs to be done in eps atom, plus
> CEREG
> >> and initial PDN. Than if you have a mix modem with 3G and LTE than all
> this "stuff"
> >> would be done twice without some additional logic. Sounds complicated =
to
> me.
> >> About initial PDN, acually I think it can be placed in gprs atom
> >> too, it won't influence 3G modems at all and we have +CGEV: handling
> there already
> >> (maybe not the strongest argument but would make things easier).
> >
> > I agree, the differences between 2G/3G and LTE are not so big so it'll =
be
> better if we keep the logic in the existing atoms.
> > A lot of LTE AT commands were extended from 2G/3G to support LTE.
> >
> > A good approach would be to extend netreg and gprs atoms to handle lte
> including initial default bearer (as part of attach procedure) and dedica=
ted
> bearers( secondary context in 2G/2G).
> >
> > For the concepts that are not present in 2G and 3G, such as IMS related
> concepts then we can use a dedicated atom.
>
> One thing to keep in mind about LTE is that we're not only looking to
> support GSM style networks.  There are hybrid networks such as Verizon
> which have CDMA/LTE mix.  From an API point of view it might not make
> sense to expose unneeded GSM details in such situations.
>
> There are also plenty of implementation details inside gprs atom
> specific to gprs.  So for ease of implementation it might be sensible to
> have a separate LTE atom anyway, even if it still implements the exact
> same API.  We can factor out common context / bearer management into a
> separate utility / atom if needed.
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

Common gprs atom would be able to handle all situation: 3G only, 3G / LTE,
LTE only,
marking technology in Bearer property. Though it might be difficult to
handle double
registration of 3G and LTE at the same time for mix modems, if this is
allowed.

3G only stuff in gprs seems to be only gprs_suspend during callback as in
LTE
call won't suspend connection, and attached property as LTE is always
attached.
Most of this atom is context related which is common.

Fast look gives me this division of gprs:
- gprs atom: suspend, attached, status handling
- lte atom: status handling
- context atom (common part for 3G and LTE): whole context handling,
    cid map, ~80% of current src/gprs.c, + some IMS stuff
all would probably need to use netreg_watch

In my opinion, combined gprs atom would be easier to do and probably enough,
separate atoms would be more "looking into the future" like but I am not
sure if this division is necessary.

Br
Tomasz

--===============4788620915751037348==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXM8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDExLzIvMjIgRGVuaXMg
S2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWls
LmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVy
LWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+
CkhpLDxicj4KPGRpdiBjbGFzcz0iaW0iPjxicj4KT24gMDIvMjIvMjAxMSAxMDowOCBBTSwgU291
bSwgUmVkb3VhbmVYIHdyb3RlOjxicj4KJmd0OyBIaSBndXlzLDxicj4KJmd0Ozxicj4KJmd0Ozxi
cj4KJmd0OyZndDsmZ3Q7IEkgYWdyZWUgd2l0aCB5b3UgLCBib3RoIGJlYXJlcnMgYXJlIGFsbW9z
dCBzaW1pbGFyLk1pbm9yIGRpZmZlcmVuY2UgaTxicj4KJmd0OyZndDsmZ3Q7IHNlZSBhcmUgY29u
dGV4dCBtYW5hZ21lbnQgKGVzcGVjaWFsbHkgZGVmYXVsdCBjb250ZXh0IGNyZWF0aW9uKSBhbmQg
c29tZTxicj4KJmd0OyZndDsmZ3Q7IGVwcyByZWxhdGVkIHNwaWxsIG92ZXIgb24gb3RoZXIgZXhp
c3RpbmcgYXRvbXMgKEZvciBleCBTSU0gd291bGQgbm90PGJyPgomZ3Q7Jmd0OyZndDsgY29udGFp
biBzb21lIElTSU0gKElNUFUvSU1QSSlyZWxhdGVkIHN0dWZmKS5NeSBpZGVhIGlzIHNlcGVyYXRl
IGF0b21zPGJyPgomZ3Q7Jmd0OyZndDsgc29sdXRpb24gd291bGQgZXZlbiB3b3JrIGZvciBsZWdh
Y3kgc3dpdGNoIGJhY2soQ1NGQikgdG9vIHdpdGggYSBtaW5pbWFsPGJyPgomZ3Q7Jmd0OyZndDsg
aW1wYWN0IG9uIGV4aXRpbmcgYXJjaGl0ZWN0dXJlLllvdXIgY29tbWVudHMgb24gdGhlc2UgaWRl
YXMgd291bGQgYWxzbzxicj4KJmd0OyZndDsmZ3Q7IHZlcnkgdmFsdWFibGUgaGVyZSBhcyBpIGFz
c3VtZSB5b3UgaGF2ZSByZWFsIG1vZGVtIHVubGlrZSBtZS48YnI+CiZndDsmZ3Q7Jmd0Ozxicj4K
Jmd0OyZndDsgTXkgbWFpbiBjb25jZXJuIGlzIGFib3V0IExURSBvbmx5IG1vZGVtcywgdGhlc2Ug
b25lcyB3b3VsZCBub3QgcmVnaXN0ZXIgZ3Byczxicj4KJmd0OyZndDsgYXRvbSBzbyBhbGwgc3R1
ZmYgZnJvbSBncHJzIGF0b20gbmVlZHMgdG8gYmUgZG9uZSBpbiBlcHMgYXRvbSwgcGx1cyBDRVJF
Rzxicj4KJmd0OyZndDsgYW5kIGluaXRpYWwgUEROLiBUaGFuIGlmIHlvdSBoYXZlIGEgbWl4IG1v
ZGVtIHdpdGggM0cgYW5kIExURSB0aGFuIGFsbCB0aGlzICZxdW90O3N0dWZmJnF1b3Q7PGJyPgom
Z3Q7Jmd0OyB3b3VsZCBiZSBkb25lIHR3aWNlIHdpdGhvdXQgc29tZSBhZGRpdGlvbmFsIGxvZ2lj
LiBTb3VuZHMgY29tcGxpY2F0ZWQgdG8gbWUuPGJyPgomZ3Q7Jmd0OyBBYm91dCBpbml0aWFsIFBE
TiwgYWN1YWxseSBJIHRoaW5rIGl0IGNhbiBiZSBwbGFjZWQgaW4gZ3BycyBhdG9tPGJyPgomZ3Q7
Jmd0OyB0b28sIGl0IHdvbiYjMzk7dCBpbmZsdWVuY2UgM0cgbW9kZW1zIGF0IGFsbCBhbmQgd2Ug
aGF2ZSArQ0dFVjogaGFuZGxpbmcgdGhlcmUgYWxyZWFkeTxicj4KJmd0OyZndDsgKG1heWJlIG5v
dCB0aGUgc3Ryb25nZXN0IGFyZ3VtZW50IGJ1dCB3b3VsZCBtYWtlIHRoaW5ncyBlYXNpZXIpLjxi
cj4KJmd0Ozxicj4KJmd0OyBJIGFncmVlLCB0aGUgZGlmZmVyZW5jZXMgYmV0d2VlbiAyRy8zRyBh
bmQgTFRFIGFyZSBub3Qgc28gYmlnIHNvIGl0JiMzOTtsbCBiZSBiZXR0ZXIgaWYgd2Uga2VlcCB0
aGUgbG9naWMgaW4gdGhlIGV4aXN0aW5nIGF0b21zLjxicj4KJmd0OyBBIGxvdCBvZiBMVEUgQVQg
Y29tbWFuZHMgd2VyZSBleHRlbmRlZCBmcm9tIDJHLzNHIHRvIHN1cHBvcnQgTFRFLjxicj4KJmd0
Ozxicj4KJmd0OyBBIGdvb2QgYXBwcm9hY2ggd291bGQgYmUgdG8gZXh0ZW5kIG5ldHJlZyBhbmQg
Z3BycyBhdG9tcyB0byBoYW5kbGUgbHRlIGluY2x1ZGluZyBpbml0aWFsIGRlZmF1bHQgYmVhcmVy
IChhcyBwYXJ0IG9mIGF0dGFjaCBwcm9jZWR1cmUpIGFuZCBkZWRpY2F0ZWQgYmVhcmVycyggc2Vj
b25kYXJ5IGNvbnRleHQgaW4gMkcvMkcpLjxicj4KJmd0Ozxicj4KJmd0OyBGb3IgdGhlIGNvbmNl
cHRzIHRoYXQgYXJlIG5vdCBwcmVzZW50IGluIDJHIGFuZCAzRywgc3VjaCBhcyBJTVMgcmVsYXRl
ZCBjb25jZXB0cyB0aGVuIHdlIGNhbiB1c2UgYSBkZWRpY2F0ZWQgYXRvbS48YnI+Cjxicj4KPC9k
aXY+T25lIHRoaW5nIHRvIGtlZXAgaW4gbWluZCBhYm91dCBMVEUgaXMgdGhhdCB3ZSYjMzk7cmUg
bm90IG9ubHkgbG9va2luZyB0bzxicj4Kc3VwcG9ydCBHU00gc3R5bGUgbmV0d29ya3MuIKBUaGVy
ZSBhcmUgaHlicmlkIG5ldHdvcmtzIHN1Y2ggYXMgVmVyaXpvbjxicj4Kd2hpY2ggaGF2ZSBDRE1B
L0xURSBtaXguIKBGcm9tIGFuIEFQSSBwb2ludCBvZiB2aWV3IGl0IG1pZ2h0IG5vdCBtYWtlPGJy
PgpzZW5zZSB0byBleHBvc2UgdW5uZWVkZWQgR1NNIGRldGFpbHMgaW4gc3VjaCBzaXR1YXRpb25z
Ljxicj4KPGJyPgpUaGVyZSBhcmUgYWxzbyBwbGVudHkgb2YgaW1wbGVtZW50YXRpb24gZGV0YWls
cyBpbnNpZGUgZ3BycyBhdG9tPGJyPgpzcGVjaWZpYyB0byBncHJzLiCgU28gZm9yIGVhc2Ugb2Yg
aW1wbGVtZW50YXRpb24gaXQgbWlnaHQgYmUgc2Vuc2libGUgdG88YnI+CmhhdmUgYSBzZXBhcmF0
ZSBMVEUgYXRvbSBhbnl3YXksIGV2ZW4gaWYgaXQgc3RpbGwgaW1wbGVtZW50cyB0aGUgZXhhY3Q8
YnI+CnNhbWUgQVBJLiCgV2UgY2FuIGZhY3RvciBvdXQgY29tbW9uIGNvbnRleHQgLyBiZWFyZXIg
bWFuYWdlbWVudCBpbnRvIGE8YnI+CnNlcGFyYXRlIHV0aWxpdHkgLyBhdG9tIGlmIG5lZWRlZC48
YnI+Cjxicj4KUmVnYXJkcyw8YnI+Cjxmb250IGNvbG9yPSIjODg4ODg4Ij4tRGVuaXM8YnI+Cjwv
Zm9udD48ZGl2PjxkaXY+PC9kaXY+PGRpdiBjbGFzcz0iaDUiPl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+Cjxh
IGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9yZzwvYT48YnI+Cjxh
IGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0iX2Js
YW5rIj5odHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9kaXY+
PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj5Db21tb24gZ3BycyBhdG9tIHdvdWxkIGJlIGFi
bGUgdG8gaGFuZGxlIGFsbCBzaXR1YXRpb246IDNHIG9ubHksIDNHIC8gTFRFLCBMVEUgb25seSw8
YnI+bWFya2luZyB0ZWNobm9sb2d5IGluIEJlYXJlciBwcm9wZXJ0eS4gVGhvdWdoIGl0IG1pZ2h0
IGJlIGRpZmZpY3VsdCB0byBoYW5kbGUgZG91YmxlPGJyPnJlZ2lzdHJhdGlvbiBvZiAzRyBhbmQg
TFRFIGF0IHRoZSBzYW1lIHRpbWUgZm9yIG1peCBtb2RlbXMsIGlmIHRoaXMgaXMgYWxsb3dlZC48
YnI+Cjxicj4zRyBvbmx5IHN0dWZmIGluIGdwcnMgc2VlbXMgdG8gYmUgb25seSBncHJzX3N1c3Bl
bmQgZHVyaW5nIGNhbGxiYWNrIGFzIGluIExURTxicj5jYWxsIHdvbiYjMzk7dCBzdXNwZW5kIGNv
bm5lY3Rpb24sIGFuZCBhdHRhY2hlZCBwcm9wZXJ0eSBhcyBMVEUgaXMgYWx3YXlzIGF0dGFjaGVk
Ljxicj5Nb3N0IG9mIHRoaXMgYXRvbSBpcyBjb250ZXh0IHJlbGF0ZWQgd2hpY2ggaXMgY29tbW9u
Ljxicj4KPGJyPkZhc3QgbG9vayBnaXZlcyBtZSB0aGlzIGRpdmlzaW9uIG9mIGdwcnM6PGJyPi0g
Z3BycyBhdG9tOiBzdXNwZW5kLCBhdHRhY2hlZCwgc3RhdHVzIGhhbmRsaW5nPGJyPi0gbHRlIGF0
b206IHN0YXR1cyBoYW5kbGluZzxicj4tIGNvbnRleHQgYXRvbSAoY29tbW9uIHBhcnQgZm9yIDNH
IGFuZCBMVEUpOiB3aG9sZSBjb250ZXh0IGhhbmRsaW5nLDxicj6goKAgY2lkIG1hcCwgfjgwJSBv
ZiBjdXJyZW50IHNyYy9ncHJzLmMsICsgc29tZSBJTVMgc3R1ZmY8YnI+CmFsbCB3b3VsZCBwcm9i
YWJseSBuZWVkIHRvIHVzZSBuZXRyZWdfd2F0Y2g8YnI+PGJyPkluIG15IG9waW5pb24sIGNvbWJp
bmVkIGdwcnMgYXRvbSB3b3VsZCBiZSBlYXNpZXIgdG8gZG8gYW5kIHByb2JhYmx5IGVub3VnaCw8
YnI+c2VwYXJhdGUgYXRvbXMgd291bGQgYmUgbW9yZSAmcXVvdDtsb29raW5nIGludG8gdGhlIGZ1
dHVyZSZxdW90OyBsaWtlIGJ1dCBJIGFtIG5vdDxicj5zdXJlIGlmIHRoaXMgZGl2aXNpb24gaXMg
bmVjZXNzYXJ5Ljxicj4KPGJyPkJyPGJyPlRvbWFzejxicj4K

--===============4788620915751037348==--


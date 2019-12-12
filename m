Content-Type: multipart/mixed; boundary="===============6192573581294621485=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] gprs: Update attach state on context deactivation for LTE
Date: Thu, 12 Dec 2019 07:47:39 +0100
Message-ID: <CAHB-Pj=6WZsiTOAKS8A9Jkkq+OXrRmzCNG3vV-73npc3ritJNA@mail.gmail.com>
In-Reply-To: <8bc90037-fa9f-9f49-335c-aedceb01efac@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6192573581294621485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den ons 11 dec. 2019 kl 22:09 skrev Denis Kenzior <denkenz@gmail.com>:

> >
> > It looked like this:
> > 12:03:18 ofonod[547]: Aux: < \r\n+CIEV: 2,3\r\n
> > 12:03:23 ofonod[547]: Aux: < \r\n+CIEV: 2,2\r\n
> >
> > Deactivated
>
> Shouldn't we get a CREG actually?  That tells us we're not connected at
> all?  Or does the modem somehow still have another default bearer active?
>

This ublox modem does not indicate change of registration. And its seems
like its not running on another
bearer because then I would assume CGATT would work(?).
But in all cases I have seen it either fixes the situation (activates)
within ~20s or it changes
bearer.
If the modem changes bearer ofono would be considered attached again and the
connection manager is free to activate the context. So I think this is
tight.



> Anyhow, I'll go ahead and take this.  Applied, thanks.
>

Thanks

-- Richard

--===============6192573581294621485==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gb25zIDExIGRlYy4g
MjAxOSBrbCAyMjowOSBza3JldiBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVu
a2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs6PGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij4mZ3Q7IDxicj4KJmd0OyBJdCBsb29rZWQgbGlrZSB0aGlzOjxicj4KJmd0OyAxMjowMzoxOCBv
Zm9ub2RbNTQ3XTogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogMiwzXHJcbjxicj4KJmd0OyAxMjowMzoy
MyBvZm9ub2RbNTQ3XTogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogMiwyXHJcbjxicj4KJmd0OyA8YnI+
CiZndDsgRGVhY3RpdmF0ZWQ8YnI+Cjxicj4KU2hvdWxkbiYjMzk7dCB3ZSBnZXQgYSBDUkVHIGFj
dHVhbGx5P8KgIFRoYXQgdGVsbHMgdXMgd2UmIzM5O3JlIG5vdCBjb25uZWN0ZWQgYXQgPGJyPgph
bGw/wqAgT3IgZG9lcyB0aGUgbW9kZW0gc29tZWhvdyBzdGlsbCBoYXZlIGFub3RoZXIgZGVmYXVs
dCBiZWFyZXIgYWN0aXZlPzxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGlz
IHVibG94IG1vZGVtIGRvZXMgbm90IGluZGljYXRlIGNoYW5nZSBvZiByZWdpc3RyYXRpb24uIEFu
ZCBpdHMgc2VlbXMgbGlrZSBpdHMgbm90IHJ1bm5pbmcgb24gYW5vdGhlcjwvZGl2PjxkaXY+YmVh
cmVyIGJlY2F1c2UgdGhlbiBJIHdvdWxkIGFzc3VtZSBDR0FUVCB3b3VsZCB3b3JrKD8pLjwvZGl2
PjxkaXY+QnV0IGluIGFsbCBjYXNlcyBJIGhhdmUgc2VlbiBpdCBlaXRoZXIgZml4ZXMgdGhlIHNp
dHVhdGlvbiAoYWN0aXZhdGVzKSB3aXRoaW4gfjIwcyBvciBpdCBjaGFuZ2VzPC9kaXY+PGRpdj5i
ZWFyZXIuPC9kaXY+PGRpdj5JZiB0aGUgbW9kZW0gY2hhbmdlcyBiZWFyZXIgb2Zvbm8gd291bGQg
YmUgY29uc2lkZXJlZCBhdHRhY2hlZCBhZ2FpbiBhbmQgdGhlPGJyPjwvZGl2PjxkaXY+Y29ubmVj
dGlvbiBtYW5hZ2VyIGlzIGZyZWUgdG8gYWN0aXZhdGUgdGhlIGNvbnRleHQuIFNvIEkgdGhpbmsg
dGhpcyBpcyB0aWdodC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2Jv
cmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpB
bnlob3csIEkmIzM5O2xsIGdvIGFoZWFkIGFuZCB0YWtlIHRoaXMuwqAgQXBwbGllZCwgdGhhbmtz
Ljxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3M8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pi0tIFJpY2hhcmTCoDwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============6192573581294621485==--


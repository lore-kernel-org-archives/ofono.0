Content-Type: multipart/mixed; boundary="===============9219248765944183305=="
MIME-Version: 1.0
From: Naveen Kumar Danturi <naveendanturi@gmail.com>
Subject: Re: Regarding multiple APN support in ofono/connman
Date: Wed, 11 Jan 2017 18:02:26 -0600
Message-ID: <CAN3FBZatwY0vhnu9W0+LQajxSnen+gNBbwWgWf+G4fiW79Y29w@mail.gmail.com>
In-Reply-To: <733ce497-2a7f-d345-0263-e7f33187dfd8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9219248765944183305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks for the responses Denis !!

On Jan 11, 2017 5:53 PM, "Denis Kenzior" <denkenz@gmail.com> wrote:

Hi Naveen,


On 01/11/2017 01:39 PM, Naveen Kumar Danturi wrote:

> Hi Ofono team,
> Is there a support in ofono for multiple PDN connections in parallel ?
> If so what interfaces/API's it exposes to connman to manage multiple
> APN's ? If so, I have these 2 questions :
>

Yes, oFono can activate multiple active contexts, assuming the hardware &
driver supports this.  See doc/connman-api.txt.  This is the same interface
ConnMan is using currently.  However, ConnMan only manages a single context
of type=3D"internet".  I think there were some patches for ConnMan to suppo=
rt
multiple active internet contexts, but I'm not sure if they ever were
accepted upstream.



> a)  How ofono/connman able to construct / destruct routing tables on
> data connections for multiple APNs and makes sure that IP traffic goes
> to the right IP interface/APN ?
>

All routing table management is outside of oFono's area of responsibility.
Typically an application would use direct interface binding to use contexts
that are not managed by ConnMan.



> b)How ofono/connman ensures that domain name searches are performed via
> right IP interface/APN to the right name server. Provide mechanism to
> keep track of name servers associated with each APN ? I believe Linux
> only provides a mechanism for a single APN via /etc/resolv.con
>

Again, this is outside of oFono's area of responsibility.  We only provide
the DNS information for each context.



> c) Is it configurable from upper layers to ensure that if IPV6 is
> available then IPV6 routing and name discovery is used ?
>

Not oFono's responsibility either.

Regards,
-Denis

--===============9219248765944183305==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9ImF1dG8iPjxkaXY+VGhhbmtzIGZvciB0aGUgcmVzcG9uc2VzIERlbmlzICEhPGJy
PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9u
IEphbiAxMSwgMjAxNyA1OjUzIFBNLCAmcXVvdDtEZW5pcyBLZW56aW9yJnF1b3Q7ICZsdDs8YSBo
cmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDsg
d3JvdGU6PGJyIHR5cGU9ImF0dHJpYnV0aW9uIj48YmxvY2txdW90ZSBjbGFzcz0icXVvdGUiIHN0
eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5n
LWxlZnQ6MWV4Ij5IaSBOYXZlZW4sPGRpdiBjbGFzcz0icXVvdGVkLXRleHQiPjxicj4KPGJyPgpP
biAwMS8xMS8yMDE3IDAxOjM5IFBNLCBOYXZlZW4gS3VtYXIgRGFudHVyaSB3cm90ZTo8YnI+Cjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2Jv
cmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgpIaSBPZm9ubyB0ZWFt
LDxicj4KSXMgdGhlcmUgYSBzdXBwb3J0IGluIG9mb25vIGZvciBtdWx0aXBsZSBQRE4gY29ubmVj
dGlvbnMgaW4gcGFyYWxsZWwgPzxicj4KSWYgc28gd2hhdCBpbnRlcmZhY2VzL0FQSSYjMzk7cyBp
dCBleHBvc2VzIHRvIGNvbm5tYW4gdG8gbWFuYWdlIG11bHRpcGxlPGJyPgpBUE4mIzM5O3MgPyBJ
ZiBzbywgSSBoYXZlIHRoZXNlIDIgcXVlc3Rpb25zIDo8YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwv
ZGl2PgpZZXMsIG9Gb25vIGNhbiBhY3RpdmF0ZSBtdWx0aXBsZSBhY3RpdmUgY29udGV4dHMsIGFz
c3VtaW5nIHRoZSBoYXJkd2FyZSAmYW1wOyBkcml2ZXIgc3VwcG9ydHMgdGhpcy7CoCBTZWUgZG9j
L2Nvbm5tYW4tYXBpLnR4dC7CoCBUaGlzIGlzIHRoZSBzYW1lIGludGVyZmFjZSBDb25uTWFuIGlz
IHVzaW5nIGN1cnJlbnRseS7CoCBIb3dldmVyLCBDb25uTWFuIG9ubHkgbWFuYWdlcyBhIHNpbmds
ZSBjb250ZXh0IG9mIHR5cGU9JnF1b3Q7aW50ZXJuZXQmcXVvdDsuwqAgSSB0aGluayB0aGVyZSB3
ZXJlIHNvbWUgcGF0Y2hlcyBmb3IgQ29ubk1hbiB0byBzdXBwb3J0IG11bHRpcGxlIGFjdGl2ZSBp
bnRlcm5ldCBjb250ZXh0cywgYnV0IEkmIzM5O20gbm90IHN1cmUgaWYgdGhleSBldmVyIHdlcmUg
YWNjZXB0ZWQgdXBzdHJlYW0uPGRpdiBjbGFzcz0icXVvdGVkLXRleHQiPjxicj4KPGJyPgo8Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3Jk
ZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgphKcKgIEhvdyBv
Zm9uby9jb25ubWFuIGFibGUgdG8gY29uc3RydWN0IC8gZGVzdHJ1Y3Qgcm91dGluZyB0YWJsZXMg
b248YnI+CmRhdGEgY29ubmVjdGlvbnMgZm9yIG11bHRpcGxlIEFQTnMgYW5kIG1ha2VzIHN1cmUg
dGhhdCBJUCB0cmFmZmljIGdvZXM8YnI+CnRvIHRoZSByaWdodCBJUCBpbnRlcmZhY2UvQVBOID88
YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2PgpBbGwgcm91dGluZyB0YWJsZSBtYW5hZ2VtZW50
IGlzIG91dHNpZGUgb2Ygb0Zvbm8mIzM5O3MgYXJlYSBvZiByZXNwb25zaWJpbGl0eS7CoCBUeXBp
Y2FsbHkgYW4gYXBwbGljYXRpb24gd291bGQgdXNlIGRpcmVjdCBpbnRlcmZhY2UgYmluZGluZyB0
byB1c2UgY29udGV4dHMgdGhhdCBhcmUgbm90IG1hbmFnZWQgYnkgQ29ubk1hbi48ZGl2IGNsYXNz
PSJxdW90ZWQtdGV4dCI+PGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRp
bmctbGVmdDoxZXgiPgo8YnI+CmIpSG93IG9mb25vL2Nvbm5tYW4gZW5zdXJlcyB0aGF0IGRvbWFp
biBuYW1lIHNlYXJjaGVzIGFyZSBwZXJmb3JtZWQgdmlhPGJyPgpyaWdodCBJUCBpbnRlcmZhY2Uv
QVBOIHRvIHRoZSByaWdodCBuYW1lIHNlcnZlci4gUHJvdmlkZSBtZWNoYW5pc20gdG88YnI+Cmtl
ZXAgdHJhY2sgb2YgbmFtZSBzZXJ2ZXJzIGFzc29jaWF0ZWQgd2l0aCBlYWNoIEFQTiA/IEkgYmVs
aWV2ZSBMaW51eDxicj4Kb25seSBwcm92aWRlcyBhIG1lY2hhbmlzbSBmb3IgYSBzaW5nbGUgQVBO
IHZpYSAvZXRjL3Jlc29sdi5jb248YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2PgpBZ2Fpbiwg
dGhpcyBpcyBvdXRzaWRlIG9mIG9Gb25vJiMzOTtzIGFyZWEgb2YgcmVzcG9uc2liaWxpdHkuwqAg
V2Ugb25seSBwcm92aWRlIHRoZSBETlMgaW5mb3JtYXRpb24gZm9yIGVhY2ggY29udGV4dC48ZGl2
IGNsYXNzPSJxdW90ZWQtdGV4dCI+PGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CmMpIElzIGl0IGNvbmZpZ3VyYWJsZSBmcm9tIHVwcGVy
IGxheWVycyB0byBlbnN1cmUgdGhhdCBpZiBJUFY2IGlzPGJyPgphdmFpbGFibGUgdGhlbiBJUFY2
IHJvdXRpbmcgYW5kIG5hbWUgZGlzY292ZXJ5IGlzIHVzZWQgPzxicj4KPC9ibG9ja3F1b3RlPgo8
YnI+PC9kaXY+Ck5vdCBvRm9ubyYjMzk7cyByZXNwb25zaWJpbGl0eSBlaXRoZXIuPGJyPgo8YnI+
ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PC9k
aXY+PC9kaXY+Cg==

--===============9219248765944183305==--


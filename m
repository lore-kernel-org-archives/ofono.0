Content-Type: multipart/mixed; boundary="===============1000520104016684144=="
MIME-Version: 1.0
From: Frederik Lotter <frederik.lotter@mixtelematics.com>
Subject: Re: Controlling GPRS connections through Ofono in the presence of
 Connman
Date: Wed, 16 Jul 2014 16:37:39 +0200
Message-ID: <CAEM=xjg0_ejkSPuOP+fNmaOFtD8w7y-JtYopJn8+abK_RM1GzA@mail.gmail.com>
In-Reply-To: <53C52C4F.4010708@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1000520104016684144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thank you very much for the reply.

I have one question remaining, which comes back to detection when my ppp
connection is up in the Linux network stack.

Will the "ConnectionContext.Active" property not only indicate the Ofono
side is done? I was under the understanding that Connman still has to
assign the IP and modify the routing table before I can open a socket for
comms? Is this something I need to check against a Connman property?

Kind Regards,
Fred


On 15 July 2014 15:27, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Frederik,
>
> On 07/15/2014 02:03 AM, Frederik Lotter wrote:
> > Hi,
> >
> > I am working on uBlox support in Ofono. My aim is further than the
> > traditional desktop type use case, so I am extending Ofono with a custom
> > APN provisioning service.
> >
> > I want to get some tips on how I should proceed because I do not wish to
> > go into an unintentional direction.
> >
> > We have 3rd party software that needs to finely control the GPRS
> > session, constantly monitoring and switching APN's as the network
> changes.
> >
> > I need a way for our software to know when the context has successfully
> > been activated, for example a post_context_activate() in the driver
>
> The driver is already performing the "callback" into the core.  So what
> you're looking for is probably something.  Perhaps something similar to
> __ofono_netreg_add_status_watch.  Before you go there though...
>
> > would be great, so that I could add a DBUS message in our custom driver
> > which send states to our software in order to know when a socket could
> > be opened (not only the post_context_activate() but I also need the
> > other states the driver will enter).
>
> Since you are sending a D-Bus message anyway, is it not possible for the
> 3rd party software to monitor the oFono context state directly?  E.g.
> the org.ofono.ConnectionContext.Active Property seems to do exactly what
> you need.  What other states do you require?
>
> >
> > Is there a better approach than adding a callback for successful context
> > activation in the driver, in Ofono? I feel like Connman is too distant
> > and unaware of detailed Ofono states to manage this on the Connman side.
> >
> > Secondly, I have tested changing states on the Ofono side with the
> > Python scripts (enable -> online ) and visa versa and connman seems OK
> > with me doing this. I plan to do this from my 3rd party application to
> > manage APNs and sockets. Is this an acceptable use case with Connman, it
> > seems like it has been designed so that Connman always gets updates on
> > Ofono state changes.
>
> All clients of oFono are notified of state changes regardless of which
> client initiated a particular state change.  So ConnMan should be just
> fine with you manipulating the context states from other clients.  You
> might interfere with some auto-connect / reconnect behavior there, but
> sounds like you don't want that behavior active anyway.
>
> Regards,
> -Denis
>

--===============1000520104016684144==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGRpdj48YnI+PC9kaXY+PGRpdj5UaGFuayB5b3UgdmVy
eSBtdWNoIGZvciB0aGUgcmVwbHkuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUgb25l
IHF1ZXN0aW9uIHJlbWFpbmluZywgd2hpY2ggY29tZXMgYmFjayB0byBkZXRlY3Rpb24gd2hlbiBt
eSBwcHAgY29ubmVjdGlvbiBpcyB1cCBpbiB0aGUgTGludXggbmV0d29yayBzdGFjay7CoDwvZGl2
Pgo8ZGl2Pjxicj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsc2Fucy1zZXJpZjtmb250
LXNpemU6MTNweCI+V2lsbCB0aGUgJnF1b3Q7Q29ubmVjdGlvbkNvbnRleHQuPC9zcGFuPjxzcGFu
IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxM3B4Ij5BY3Rp
dmUmcXVvdDsgcHJvcGVydHkgbm90IG9ubHkgaW5kaWNhdGUgdGhlIE9mb25vIHNpZGUgaXMgZG9u
ZT8gSSB3YXMgdW5kZXIgdGhlIHVuZGVyc3RhbmRpbmcgdGhhdCBDb25ubWFuIHN0aWxsIGhhcyB0
byBhc3NpZ24gdGhlIElQIGFuZCBtb2RpZnkgdGhlIHJvdXRpbmcgdGFibGUgYmVmb3JlIEkgY2Fu
IG9wZW4gYSBzb2NrZXQgZm9yIGNvbW1zPyBJcyB0aGlzIHNvbWV0aGluZyBJIG5lZWQgdG8gY2hl
Y2sgYWdhaW5zdCBhIENvbm5tYW4gcHJvcGVydHk/wqA8L3NwYW4+PGJyPgo8L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxM3B4Ij48
YnI+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLHNhbnMt
c2VyaWY7Zm9udC1zaXplOjEzcHgiPktpbmQgUmVnYXJkcyw8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
biBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTNweCI+RnJl
ZDwvc3Bhbj48L2Rpdj4KPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48YnI+PGRp
diBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIDE1IEp1bHkgMjAxNCAxNToyNywgRGVuaXMgS2Vuemlv
ciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIg
dGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxi
cj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhl
eDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KSGkgRnJlZGVy
aWssPGJyPgo8ZGl2IGNsYXNzPSIiPjxicj4KT24gMDcvMTUvMjAxNCAwMjowMyBBTSwgRnJlZGVy
aWsgTG90dGVyIHdyb3RlOjxicj4KJmd0OyBIaSw8YnI+CiZndDs8YnI+CiZndDsgSSBhbSB3b3Jr
aW5nIG9uIHVCbG94IHN1cHBvcnQgaW4gT2Zvbm8uIE15IGFpbSBpcyBmdXJ0aGVyIHRoYW4gdGhl
PGJyPgomZ3Q7IHRyYWRpdGlvbmFsIGRlc2t0b3AgdHlwZSB1c2UgY2FzZSwgc28gSSBhbSBleHRl
bmRpbmcgT2Zvbm8gd2l0aCBhIGN1c3RvbTxicj4KJmd0OyBBUE4gcHJvdmlzaW9uaW5nIHNlcnZp
Y2UuPGJyPgomZ3Q7PGJyPgomZ3Q7IEkgd2FudCB0byBnZXQgc29tZSB0aXBzIG9uIGhvdyBJIHNo
b3VsZCBwcm9jZWVkIGJlY2F1c2UgSSBkbyBub3Qgd2lzaCB0bzxicj4KJmd0OyBnbyBpbnRvIGFu
IHVuaW50ZW50aW9uYWwgZGlyZWN0aW9uLjxicj4KJmd0Ozxicj4KJmd0OyBXZSBoYXZlIDNyZCBw
YXJ0eSBzb2Z0d2FyZSB0aGF0IG5lZWRzIHRvIGZpbmVseSBjb250cm9sIHRoZSBHUFJTPGJyPgom
Z3Q7IHNlc3Npb24sIGNvbnN0YW50bHkgbW9uaXRvcmluZyBhbmQgc3dpdGNoaW5nIEFQTiYjMzk7
cyBhcyB0aGUgbmV0d29yayBjaGFuZ2VzLjxicj4KJmd0Ozxicj4KJmd0OyBJIG5lZWQgYSB3YXkg
Zm9yIG91ciBzb2Z0d2FyZSB0byBrbm93IHdoZW4gdGhlIGNvbnRleHQgaGFzIHN1Y2Nlc3NmdWxs
eTxicj4KJmd0OyBiZWVuIGFjdGl2YXRlZCwgZm9yIGV4YW1wbGUgYSBwb3N0X2NvbnRleHRfYWN0
aXZhdGUoKSBpbiB0aGUgZHJpdmVyPGJyPgo8YnI+CjwvZGl2PlRoZSBkcml2ZXIgaXMgYWxyZWFk
eSBwZXJmb3JtaW5nIHRoZSAmcXVvdDtjYWxsYmFjayZxdW90OyBpbnRvIHRoZSBjb3JlLiDCoFNv
IHdoYXQ8YnI+CnlvdSYjMzk7cmUgbG9va2luZyBmb3IgaXMgcHJvYmFibHkgc29tZXRoaW5nLiDC
oFBlcmhhcHMgc29tZXRoaW5nIHNpbWlsYXIgdG88YnI+Cl9fb2Zvbm9fbmV0cmVnX2FkZF9zdGF0
dXNfd2F0Y2guIMKgQmVmb3JlIHlvdSBnbyB0aGVyZSB0aG91Z2guLi48YnI+CjxkaXYgY2xhc3M9
IiI+PGJyPgomZ3Q7IHdvdWxkIGJlIGdyZWF0LCBzbyB0aGF0IEkgY291bGQgYWRkIGEgREJVUyBt
ZXNzYWdlIGluIG91ciBjdXN0b20gZHJpdmVyPGJyPgomZ3Q7IHdoaWNoIHNlbmQgc3RhdGVzIHRv
IG91ciBzb2Z0d2FyZSBpbiBvcmRlciB0byBrbm93IHdoZW4gYSBzb2NrZXQgY291bGQ8YnI+CiZn
dDsgYmUgb3BlbmVkIChub3Qgb25seSB0aGUgcG9zdF9jb250ZXh0X2FjdGl2YXRlKCkgYnV0IEkg
YWxzbyBuZWVkIHRoZTxicj4KJmd0OyBvdGhlciBzdGF0ZXMgdGhlIGRyaXZlciB3aWxsIGVudGVy
KS48YnI+Cjxicj4KPC9kaXY+U2luY2UgeW91IGFyZSBzZW5kaW5nIGEgRC1CdXMgbWVzc2FnZSBh
bnl3YXksIGlzIGl0IG5vdCBwb3NzaWJsZSBmb3IgdGhlPGJyPgozcmQgcGFydHkgc29mdHdhcmUg
dG8gbW9uaXRvciB0aGUgb0Zvbm8gY29udGV4dCBzdGF0ZSBkaXJlY3RseT8gwqBFLmcuPGJyPgp0
aGUgb3JnLm9mb25vLkNvbm5lY3Rpb25Db250ZXh0LkFjdGl2ZSBQcm9wZXJ0eSBzZWVtcyB0byBk
byBleGFjdGx5IHdoYXQ8YnI+CnlvdSBuZWVkLiDCoFdoYXQgb3RoZXIgc3RhdGVzIGRvIHlvdSBy
ZXF1aXJlPzxicj4KPGRpdiBjbGFzcz0iIj48YnI+CiZndDs8YnI+CiZndDsgSXMgdGhlcmUgYSBi
ZXR0ZXIgYXBwcm9hY2ggdGhhbiBhZGRpbmcgYSBjYWxsYmFjayBmb3Igc3VjY2Vzc2Z1bCBjb250
ZXh0PGJyPgomZ3Q7IGFjdGl2YXRpb24gaW4gdGhlIGRyaXZlciwgaW4gT2Zvbm8/IEkgZmVlbCBs
aWtlIENvbm5tYW4gaXMgdG9vIGRpc3RhbnQ8YnI+CiZndDsgYW5kIHVuYXdhcmUgb2YgZGV0YWls
ZWQgT2Zvbm8gc3RhdGVzIHRvIG1hbmFnZSB0aGlzIG9uIHRoZSBDb25ubWFuIHNpZGUuPGJyPgom
Z3Q7PGJyPgomZ3Q7IFNlY29uZGx5LCBJIGhhdmUgdGVzdGVkIGNoYW5naW5nIHN0YXRlcyBvbiB0
aGUgT2Zvbm8gc2lkZSB3aXRoIHRoZTxicj4KJmd0OyBQeXRob24gc2NyaXB0cyAoZW5hYmxlIC0m
Z3Q7IG9ubGluZSApIGFuZCB2aXNhIHZlcnNhIGFuZCBjb25ubWFuIHNlZW1zIE9LPGJyPgomZ3Q7
IHdpdGggbWUgZG9pbmcgdGhpcy4gSSBwbGFuIHRvIGRvIHRoaXMgZnJvbSBteSAzcmQgcGFydHkg
YXBwbGljYXRpb24gdG88YnI+CiZndDsgbWFuYWdlIEFQTnMgYW5kIHNvY2tldHMuIElzIHRoaXMg
YW4gYWNjZXB0YWJsZSB1c2UgY2FzZSB3aXRoIENvbm5tYW4sIGl0PGJyPgomZ3Q7IHNlZW1zIGxp
a2UgaXQgaGFzIGJlZW4gZGVzaWduZWQgc28gdGhhdCBDb25ubWFuIGFsd2F5cyBnZXRzIHVwZGF0
ZXMgb248YnI+CiZndDsgT2Zvbm8gc3RhdGUgY2hhbmdlcy48YnI+Cjxicj4KPC9kaXY+QWxsIGNs
aWVudHMgb2Ygb0Zvbm8gYXJlIG5vdGlmaWVkIG9mIHN0YXRlIGNoYW5nZXMgcmVnYXJkbGVzcyBv
ZiB3aGljaDxicj4KY2xpZW50IGluaXRpYXRlZCBhIHBhcnRpY3VsYXIgc3RhdGUgY2hhbmdlLiDC
oFNvIENvbm5NYW4gc2hvdWxkIGJlIGp1c3Q8YnI+CmZpbmUgd2l0aCB5b3UgbWFuaXB1bGF0aW5n
IHRoZSBjb250ZXh0IHN0YXRlcyBmcm9tIG90aGVyIGNsaWVudHMuIMKgWW91PGJyPgptaWdodCBp
bnRlcmZlcmUgd2l0aCBzb21lIGF1dG8tY29ubmVjdCAvIHJlY29ubmVjdCBiZWhhdmlvciB0aGVy
ZSwgYnV0PGJyPgpzb3VuZHMgbGlrZSB5b3UgZG9uJiMzOTt0IHdhbnQgdGhhdCBiZWhhdmlvciBh
Y3RpdmUgYW55d2F5Ljxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Jsb2NrcXVv
dGU+PC9kaXY+PGJyPjwvZGl2Pgo=

--===============1000520104016684144==--


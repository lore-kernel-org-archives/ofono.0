Content-Type: multipart/mixed; boundary="===============6480871376080267051=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 2/7] extended support for LTE and NR. Some minor fixes.
 part 2 of 7
Date: Thu, 20 Sep 2018 19:03:53 +0200
Message-ID: <CAKSBH7HG2AD4J9_AGGyTHFd-Nu2ennemZkyF+KFr2Ko=tqkN2A@mail.gmail.com>
In-Reply-To: <ad8cc686-16ea-5c20-a95a-4e452cb632cc@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6480871376080267051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi Denis,

On Thu, 20 Sep 2018, 18:31 Denis Kenzior, <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> > The idea would be to just store the values in the driver but not in the
> > module,
> > and then send them before attaching, so that the verification can be
> > consistent and all,
> > just like for the gprs-context atom.
>
> Yes, but that is not what you outlined in the code.  You were watching
> for SIM_STATE_READY which only means just that.
>
> Also note that we can bring the modem online even in pre_sim state (e.g.
> for emergency calls), in which case the lte atom doesn't exist yet.
>

where should a hook be placed then?
this looked to me a good place, just before bringing it online.
if there is no atom, no config and everything is ok anyway.

>
> > so the idea would be to check if a new method, that I have tentatively
> > called set_property(),
> > exists. If so, use the reviewed stile above, otherwise fallback to the
> > current function.
> >
>
> I don't see what set_property is buying you.  Anyway, feel free to come
> up with a more detailed proposal, but my impression is that this
> approach will quickly become way too complicated.
>

I think now i got you. The existing function could be used, but the driver
only stores the values internally because it knows it will ve called later
for sending the commands.


> Regards,
> -Denis
>

--===============6480871376080267051==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9ImF1dG8iPjxkaXY+aGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCAyMCBTZXAgMjAxOCwgMTg6MzEgRGVuaXMgS2Vu
emlvciwgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFp
bC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7
cGFkZGluZy1sZWZ0OjFleCI+SGkgR2lhY2ludG8sPGJyPgo8YnI+CiZndDsgVGhlIGlkZWEgd291
bGQgYmUgdG8ganVzdCBzdG9yZSB0aGUgdmFsdWVzIGluIHRoZSBkcml2ZXIgYnV0IG5vdCBpbiB0
aGUgPGJyPgomZ3Q7IG1vZHVsZSw8YnI+CiZndDsgYW5kIHRoZW4gc2VuZCB0aGVtIGJlZm9yZSBh
dHRhY2hpbmcsIHNvIHRoYXQgdGhlIHZlcmlmaWNhdGlvbiBjYW4gYmUgPGJyPgomZ3Q7IGNvbnNp
c3RlbnQgYW5kIGFsbCw8YnI+CiZndDsganVzdCBsaWtlIGZvciB0aGUgZ3Bycy1jb250ZXh0IGF0
b20uPGJyPgo8YnI+ClllcywgYnV0IHRoYXQgaXMgbm90IHdoYXQgeW91IG91dGxpbmVkIGluIHRo
ZSBjb2RlLsKgIFlvdSB3ZXJlIHdhdGNoaW5nIDxicj4KZm9yIFNJTV9TVEFURV9SRUFEWSB3aGlj
aCBvbmx5IG1lYW5zIGp1c3QgdGhhdC48YnI+Cjxicj4KQWxzbyBub3RlIHRoYXQgd2UgY2FuIGJy
aW5nIHRoZSBtb2RlbSBvbmxpbmUgZXZlbiBpbiBwcmVfc2ltIHN0YXRlIChlLmcuIDxicj4KZm9y
IGVtZXJnZW5jeSBjYWxscyksIGluIHdoaWNoIGNhc2UgdGhlIGx0ZSBhdG9tIGRvZXNuJiMzOTt0
IGV4aXN0IHlldC48YnI+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48
YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPndoZXJlIHNob3VsZCBhIGhvb2sgYmUgcGxhY2VkIHRo
ZW4/PC9kaXY+PGRpdiBkaXI9ImF1dG8iPnRoaXMgbG9va2VkIHRvIG1lIGEgZ29vZCBwbGFjZSwg
anVzdCBiZWZvcmUgYnJpbmdpbmcgaXQgb25saW5lLjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5pZiB0
aGVyZSBpcyBubyBhdG9tLCBubyBjb25maWcgYW5kIGV2ZXJ5dGhpbmcgaXMgb2sgYW55d2F5Ljwv
ZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij4mZ3Q7IDxicj4KJmd0OyBzbyB0aGUgaWRlYSB3b3VsZCBiZSB0byBjaGVjayBpZiBhIG5ldyBt
ZXRob2QsIHRoYXQgSSBoYXZlIHRlbnRhdGl2ZWx5IDxicj4KJmd0OyBjYWxsZWQgc2V0X3Byb3Bl
cnR5KCksPGJyPgomZ3Q7IGV4aXN0cy4gSWYgc28sIHVzZSB0aGUgcmV2aWV3ZWQgc3RpbGUgYWJv
dmUsIG90aGVyd2lzZSBmYWxsYmFjayB0byB0aGUgPGJyPgomZ3Q7IGN1cnJlbnQgZnVuY3Rpb24u
PGJyPgomZ3Q7IDxicj4KPGJyPgpJIGRvbiYjMzk7dCBzZWUgd2hhdCBzZXRfcHJvcGVydHkgaXMg
YnV5aW5nIHlvdS7CoCBBbnl3YXksIGZlZWwgZnJlZSB0byBjb21lIDxicj4KdXAgd2l0aCBhIG1v
cmUgZGV0YWlsZWQgcHJvcG9zYWwsIGJ1dCBteSBpbXByZXNzaW9uIGlzIHRoYXQgdGhpcyA8YnI+
CmFwcHJvYWNoIHdpbGwgcXVpY2tseSBiZWNvbWUgd2F5IHRvbyBjb21wbGljYXRlZC48YnI+PC9i
bG9ja3F1b3RlPjwvZGl2PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9
ImF1dG8iPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PGRpdiBkaXI9ImF1
dG8iPkkgdGhpbmsgbm93IGkgZ290IHlvdS4gVGhlIGV4aXN0aW5nIGZ1bmN0aW9uIGNvdWxkIGJl
IHVzZWQsIGJ1dCB0aGUgZHJpdmVyIG9ubHkgc3RvcmVzIHRoZSB2YWx1ZXMgaW50ZXJuYWxseSBi
ZWNhdXNlIGl0IGtub3dzIGl0IHdpbGwgdmUgY2FsbGVkIGxhdGVyIGZvciBzZW5kaW5nIHRoZSBj
b21tYW5kcy48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48
ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KPC9ibG9ja3F1b3RlPjwv
ZGl2PjwvZGl2PjwvZGl2Pgo=

--===============6480871376080267051==--


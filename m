Content-Type: multipart/mixed; boundary="===============7913196901217736727=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH 2/4] gprs: Always call gprs_attached_update on context
 deactivation.
Date: Sun, 18 Aug 2019 15:26:34 +0200
Message-ID: <CAHB-PjmAQy5g7e1VuXtKTJHwsSnse+V6vRrYgmHbZAjBDaGEKg@mail.gmail.com>
In-Reply-To: <cb676015-45dc-be57-397d-7deb1503b087@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7913196901217736727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den fre 16 aug. 2019 kl 17:42 skrev Denis Kenzior <denkenz@gmail.com>:

> Hi Richard,
>
> >      > attached, and connection managers (at least connman) start
> >      > to hammer us to connect a context, eventhough it happens
> >      > automatically in LTE.
> >
> >     What happens automatically?  Yes, it is true that you need a default
> >     context to attach to LTE.  So activating a context is basically a
> part
> >     of the LTE attach procedure.
> >
> >     But that default context does not need to be an internet context
> (e.g.
> >     Verizon uses (or used to) use an ims context for this). So ConnMan
> >     still
> >     might need to activate an Internet context even if we're on LTE.
> >
> >
> > To do that wouldn't we need to be able to flag attached even without
> > registered context for LTE?
> > Or will the modem not attach to 4G until the context is configured?
> > I can not test that case with my modems.
>
> It sort of depends on the configuration.  But basically we will not get
> on LTE without a default bearer.  The default bearer configuration can
> come from the modem itself, or actually from the network.  That default
> bearer is essentially an active context.  This is why gprs.c goes to the
> trouble of matching it against existing contexts, but if it isn't found,
> then adds a new one (which is supposed to be transient/temporary).
>
> Typically, on a well-configured system, you'll have the default bearer
> setup via LongTermEvolution.DefaultAccessPointName and also provisioned
> in the provisioning database.  But as I mentioned earlier, the default
> context doesn't have to be an internet one.
>

For the modem I use, it would be a bit messy to update the default APN on
the fly,
because it requires to turn off the radio to change that. We have written
it into
non volatile memory beforehand.

But anyway, you have convinced me so I think we can skip this patch,
I guess its just the matter of the order things happen and the time span
will be very short.

--Richard

--===============7913196901217736727==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPC9kaXY+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+RGVuIGZy
ZSAxNiBhdWcuIDIwMTkga2wgMTc6NDIgc2tyZXYgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7Ojxicj48
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+SGkgUmljaGFyZCw8YnI+Cjxicj4KJmd0O8KgIMKgIMKgICZndDsgYXR0YWNo
ZWQsIGFuZCBjb25uZWN0aW9uIG1hbmFnZXJzIChhdCBsZWFzdCBjb25ubWFuKSBzdGFydDxicj4K
Jmd0O8KgIMKgIMKgICZndDsgdG8gaGFtbWVyIHVzIHRvIGNvbm5lY3QgYSBjb250ZXh0LCBldmVu
dGhvdWdoIGl0IGhhcHBlbnM8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7IGF1dG9tYXRpY2FsbHkgaW4g
TFRFLjxicj4KJmd0OyA8YnI+CiZndDvCoCDCoCDCoFdoYXQgaGFwcGVucyBhdXRvbWF0aWNhbGx5
P8KgIFllcywgaXQgaXMgdHJ1ZSB0aGF0IHlvdSBuZWVkIGEgZGVmYXVsdDxicj4KJmd0O8KgIMKg
IMKgY29udGV4dCB0byBhdHRhY2ggdG8gTFRFLsKgIFNvIGFjdGl2YXRpbmcgYSBjb250ZXh0IGlz
IGJhc2ljYWxseSBhIHBhcnQ8YnI+CiZndDvCoCDCoCDCoG9mIHRoZSBMVEUgYXR0YWNoIHByb2Nl
ZHVyZS48YnI+CiZndDsgPGJyPgomZ3Q7wqAgwqAgwqBCdXQgdGhhdCBkZWZhdWx0IGNvbnRleHQg
ZG9lcyBub3QgbmVlZCB0byBiZSBhbiBpbnRlcm5ldCBjb250ZXh0IChlLmcuPGJyPgomZ3Q7wqAg
wqAgwqBWZXJpem9uIHVzZXMgKG9yIHVzZWQgdG8pIHVzZSBhbiBpbXMgY29udGV4dCBmb3IgdGhp
cykuIFNvIENvbm5NYW48YnI+CiZndDvCoCDCoCDCoHN0aWxsPGJyPgomZ3Q7wqAgwqAgwqBtaWdo
dCBuZWVkIHRvIGFjdGl2YXRlIGFuIEludGVybmV0IGNvbnRleHQgZXZlbiBpZiB3ZSYjMzk7cmUg
b24gTFRFLjxicj4KJmd0OyA8YnI+CiZndDsgPGJyPgomZ3Q7IFRvIGRvIHRoYXQgd291bGRuJiMz
OTt0IHdlIG5lZWQgdG8gYmUgYWJsZSB0byBmbGFnIGF0dGFjaGVkIGV2ZW4gd2l0aG91dDxicj4K
Jmd0OyByZWdpc3RlcmVkIGNvbnRleHQgZm9yIExURT88YnI+CiZndDsgT3Igd2lsbCB0aGUgbW9k
ZW0gbm90IGF0dGFjaCB0byA0RyB1bnRpbCB0aGUgY29udGV4dCBpcyBjb25maWd1cmVkPzxicj4K
Jmd0OyBJIGNhbiBub3QgdGVzdCB0aGF0IGNhc2Ugd2l0aCBteSBtb2RlbXMuPGJyPgo8YnI+Ckl0
IHNvcnQgb2YgZGVwZW5kcyBvbiB0aGUgY29uZmlndXJhdGlvbi7CoCBCdXQgYmFzaWNhbGx5IHdl
IHdpbGwgbm90IGdldCA8YnI+Cm9uIExURSB3aXRob3V0IGEgZGVmYXVsdCBiZWFyZXIuwqAgVGhl
IGRlZmF1bHQgYmVhcmVyIGNvbmZpZ3VyYXRpb24gY2FuIDxicj4KY29tZSBmcm9tIHRoZSBtb2Rl
bSBpdHNlbGYsIG9yIGFjdHVhbGx5IGZyb20gdGhlIG5ldHdvcmsuwqAgVGhhdCBkZWZhdWx0IDxi
cj4KYmVhcmVyIGlzIGVzc2VudGlhbGx5IGFuIGFjdGl2ZSBjb250ZXh0LsKgIFRoaXMgaXMgd2h5
IGdwcnMuYyBnb2VzIHRvIHRoZSA8YnI+CnRyb3VibGUgb2YgbWF0Y2hpbmcgaXQgYWdhaW5zdCBl
eGlzdGluZyBjb250ZXh0cywgYnV0IGlmIGl0IGlzbiYjMzk7dCBmb3VuZCwgPGJyPgp0aGVuIGFk
ZHMgYSBuZXcgb25lICh3aGljaCBpcyBzdXBwb3NlZCB0byBiZSB0cmFuc2llbnQvdGVtcG9yYXJ5
KS48YnI+Cjxicj4KVHlwaWNhbGx5LCBvbiBhIHdlbGwtY29uZmlndXJlZCBzeXN0ZW0sIHlvdSYj
Mzk7bGwgaGF2ZSB0aGUgZGVmYXVsdCBiZWFyZXIgPGJyPgpzZXR1cCB2aWEgTG9uZ1Rlcm1Fdm9s
dXRpb24uRGVmYXVsdEFjY2Vzc1BvaW50TmFtZSBhbmQgYWxzbyBwcm92aXNpb25lZCA8YnI+Cmlu
IHRoZSBwcm92aXNpb25pbmcgZGF0YWJhc2UuwqAgQnV0IGFzIEkgbWVudGlvbmVkIGVhcmxpZXIs
IHRoZSBkZWZhdWx0IDxicj4KY29udGV4dCBkb2VzbiYjMzk7dCBoYXZlIHRvIGJlIGFuIGludGVy
bmV0IG9uZS48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+Rm9yIHRoZSBtb2Rl
bSBJIHVzZSwgaXQgd291bGQgYmUgYSBiaXQgbWVzc3kgdG8gdXBkYXRlIHRoZSBkZWZhdWx0IEFQ
TiBvbiB0aGUgZmx5LDwvZGl2PjxkaXY+YmVjYXVzZSBpdCByZXF1aXJlcyB0byB0dXJuIG9mZiB0
aGUgcmFkaW8gdG8gY2hhbmdlIHRoYXQuIFdlIGhhdmUgd3JpdHRlbiBpdCBpbnRvPC9kaXY+PGRp
dj5ub24gdm9sYXRpbGUgbWVtb3J5IGJlZm9yZWhhbmQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5CdXQgYW55d2F5LCB5b3UgaGF2ZSBjb252aW5jZWQgbWUgc28gSSB0aGluayB3ZSBjYW4gc2tp
cCB0aGlzIHBhdGNoLDwvZGl2PjxkaXY+SSBndWVzcyBpdHMganVzdCB0aGUgbWF0dGVyIG9mIHRo
ZSBvcmRlciB0aGluZ3MgaGFwcGVuIGFuZCB0aGUgdGltZSBzcGFuIHdpbGwgYmUgdmVyeSBzaG9y
dC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pi0tUmljaGFyZDwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============7913196901217736727==--


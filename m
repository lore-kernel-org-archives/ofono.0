Content-Type: multipart/mixed; boundary="===============0822813559128397852=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 2/7] extended support for LTE and NR. Some minor fixes.
 part 2 of 7
Date: Thu, 20 Sep 2018 19:25:51 +0200
Message-ID: <CAKSBH7EMFmd0jwmzq9yUCsZOaZTFRem6mFMAH=NHc9S+JP=Fqg@mail.gmail.com>
In-Reply-To: <46d7e1eb-dd42-75ca-e5ef-d36d1d2cb8bc@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0822813559128397852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2018 at 7:18 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> On 09/20/2018 12:03 PM, Giacinto Cifelli wrote:
> > hi Denis,
> >
> > On Thu, 20 Sep 2018, 18:31 Denis Kenzior, <denkenz@gmail.com
> > <mailto:denkenz@gmail.com>> wrote:
> >
> >     Hi Giacinto,
> >
> >      > The idea would be to just store the values in the driver but not
> >     in the
> >      > module,
> >      > and then send them before attaching, so that the verification can
> be
> >      > consistent and all,
> >      > just like for the gprs-context atom.
> >
> >     Yes, but that is not what you outlined in the code.  You were
> watching
> >     for SIM_STATE_READY which only means just that.
> >
> >     Also note that we can bring the modem online even in pre_sim state
> >     (e.g.
> >     for emergency calls), in which case the lte atom doesn't exist yet.
> >
> >
> > where should a hook be placed then?
> > this looked to me a good place, just before bringing it online.
> > if there is no atom, no config and everything is ok anyway.
>
> That's kind of the problem, there is no good place.  The only thing you
> can do is have the core apply settings, if available, just prior to the
> set_online driver call.  However, it is tricky to do so:
>
> - We're in pre-sim state and go online for emergency calls.  This is
> okay as no LTE atom is created.  If a SIM is initialized / inserted at
> this point, the modem can re-connect with a proper default settings.
> The LTE atom creation and modem performing a re-connect is now a race.
> Admittedly the solution we have today also suffers from this problem, so
> maybe there's not much we can do here.
>
> - We're offline and going online.  You need to perform the online
> operation as a transaction.  First setting the default attach details
> and then actually setting the modem online.  We can't do it
> simultaneously, as again we cannot assume the multiplexing / queueing
> behavior of the driver.  This could perhaps be made to work, but there
> may be additional issues that are discovered as we go along.  Only way
> to find out is to prototype it.
>

ok, the AT driver is piping the commands, and I am going to implement it
for it.
Admittedly, for another driver could be more difficult (MBIM also pipes
them),
but there is still the possibility to set directly the parameters as they
are today,
not implementing this function in the atom (NULL function or simply
returning).


> >
> >      >
> >      > so the idea would be to check if a new method, that I have
> >     tentatively
> >      > called set_property(),
> >      > exists. If so, use the reviewed stile above, otherwise fallback
> >     to the
> >      > current function.
> >      >
> >
> >     I don't see what set_property is buying you.  Anyway, feel free to
> come
> >     up with a more detailed proposal, but my impression is that this
> >     approach will quickly become way too complicated.
> >
> >
> > I think now i got you. The existing function could be used, but the
> > driver only stores the values internally because it knows it will ve
> > called later for sending the commands.
> >
>
> Or we simply cache the values in the lte atom and call the driver method
> only when appropriate.
>

I believe it is better to call the atom and let it decide what to do, in
part to mitigate the issues above.


> Regards,
> -Denis
>

with this, I am good to go, I will try to prototype this new behavior.

Regards.
Giacinto

--===============0822813559128397852==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9
Imx0ciI+T24gVGh1LCBTZXAgMjAsIDIwMTggYXQgNzoxOCBQTSBEZW5pcyBLZW56aW9yICZsdDs8
YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZn
dDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVm
dDoxZXgiPkhpIEdpYWNpbnRvLDxicj4KPGJyPgpPbiAwOS8yMC8yMDE4IDEyOjAzIFBNLCBHaWFj
aW50byBDaWZlbGxpIHdyb3RlOjxicj4KJmd0OyBoaSBEZW5pcyw8YnI+CiZndDsgPGJyPgomZ3Q7
IE9uIFRodSwgMjAgU2VwIDIwMTgsIDE4OjMxIERlbmlzIEtlbnppb3IsICZsdDs8YSBocmVmPSJt
YWlsdG86ZGVua2VuekBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNv
bTwvYT4gPGJyPgomZ3Q7ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0OyZndDsgd3JvdGU6
PGJyPgomZ3Q7IDxicj4KJmd0O8KgIMKgIMKgSGkgR2lhY2ludG8sPGJyPgomZ3Q7IDxicj4KJmd0
O8KgIMKgIMKgICZndDsgVGhlIGlkZWEgd291bGQgYmUgdG8ganVzdCBzdG9yZSB0aGUgdmFsdWVz
IGluIHRoZSBkcml2ZXIgYnV0IG5vdDxicj4KJmd0O8KgIMKgIMKgaW4gdGhlPGJyPgomZ3Q7wqAg
wqAgwqAgJmd0OyBtb2R1bGUsPGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyBhbmQgdGhlbiBzZW5kIHRo
ZW0gYmVmb3JlIGF0dGFjaGluZywgc28gdGhhdCB0aGUgdmVyaWZpY2F0aW9uIGNhbiBiZTxicj4K
Jmd0O8KgIMKgIMKgICZndDsgY29uc2lzdGVudCBhbmQgYWxsLDxicj4KJmd0O8KgIMKgIMKgICZn
dDsganVzdCBsaWtlIGZvciB0aGUgZ3Bycy1jb250ZXh0IGF0b20uPGJyPgomZ3Q7IDxicj4KJmd0
O8KgIMKgIMKgWWVzLCBidXQgdGhhdCBpcyBub3Qgd2hhdCB5b3Ugb3V0bGluZWQgaW4gdGhlIGNv
ZGUuwqAgWW91IHdlcmUgd2F0Y2hpbmc8YnI+CiZndDvCoCDCoCDCoGZvciBTSU1fU1RBVEVfUkVB
RFkgd2hpY2ggb25seSBtZWFucyBqdXN0IHRoYXQuPGJyPgomZ3Q7IDxicj4KJmd0O8KgIMKgIMKg
QWxzbyBub3RlIHRoYXQgd2UgY2FuIGJyaW5nIHRoZSBtb2RlbSBvbmxpbmUgZXZlbiBpbiBwcmVf
c2ltIHN0YXRlPGJyPgomZ3Q7wqAgwqAgwqAoZS5nLjxicj4KJmd0O8KgIMKgIMKgZm9yIGVtZXJn
ZW5jeSBjYWxscyksIGluIHdoaWNoIGNhc2UgdGhlIGx0ZSBhdG9tIGRvZXNuJiMzOTt0IGV4aXN0
IHlldC48YnI+CiZndDsgPGJyPgomZ3Q7IDxicj4KJmd0OyB3aGVyZSBzaG91bGQgYSBob29rIGJl
IHBsYWNlZCB0aGVuPzxicj4KJmd0OyB0aGlzIGxvb2tlZCB0byBtZSBhIGdvb2QgcGxhY2UsIGp1
c3QgYmVmb3JlIGJyaW5naW5nIGl0IG9ubGluZS48YnI+CiZndDsgaWYgdGhlcmUgaXMgbm8gYXRv
bSwgbm8gY29uZmlnIGFuZCBldmVyeXRoaW5nIGlzIG9rIGFueXdheS48YnI+Cjxicj4KVGhhdCYj
Mzk7cyBraW5kIG9mIHRoZSBwcm9ibGVtLCB0aGVyZSBpcyBubyBnb29kIHBsYWNlLsKgIFRoZSBv
bmx5IHRoaW5nIHlvdSA8YnI+CmNhbiBkbyBpcyBoYXZlIHRoZSBjb3JlIGFwcGx5IHNldHRpbmdz
LCBpZiBhdmFpbGFibGUsIGp1c3QgcHJpb3IgdG8gdGhlIDxicj4Kc2V0X29ubGluZSBkcml2ZXIg
Y2FsbC7CoCBIb3dldmVyLCBpdCBpcyB0cmlja3kgdG8gZG8gc286PGJyPgo8YnI+Ci0gV2UmIzM5
O3JlIGluIHByZS1zaW0gc3RhdGUgYW5kIGdvIG9ubGluZSBmb3IgZW1lcmdlbmN5IGNhbGxzLsKg
IFRoaXMgaXMgPGJyPgpva2F5IGFzIG5vIExURSBhdG9tIGlzIGNyZWF0ZWQuwqAgSWYgYSBTSU0g
aXMgaW5pdGlhbGl6ZWQgLyBpbnNlcnRlZCBhdCA8YnI+CnRoaXMgcG9pbnQsIHRoZSBtb2RlbSBj
YW4gcmUtY29ubmVjdCB3aXRoIGEgcHJvcGVyIGRlZmF1bHQgc2V0dGluZ3MuIDxicj4KVGhlIExU
RSBhdG9tIGNyZWF0aW9uIGFuZCBtb2RlbSBwZXJmb3JtaW5nIGEgcmUtY29ubmVjdCBpcyBub3cg
YSByYWNlLiA8YnI+CkFkbWl0dGVkbHkgdGhlIHNvbHV0aW9uIHdlIGhhdmUgdG9kYXkgYWxzbyBz
dWZmZXJzIGZyb20gdGhpcyBwcm9ibGVtLCBzbyA8YnI+Cm1heWJlIHRoZXJlJiMzOTtzIG5vdCBt
dWNoIHdlIGNhbiBkbyBoZXJlLjxicj4KPGJyPgotIFdlJiMzOTtyZSBvZmZsaW5lIGFuZCBnb2lu
ZyBvbmxpbmUuwqAgWW91IG5lZWQgdG8gcGVyZm9ybSB0aGUgb25saW5lIDxicj4Kb3BlcmF0aW9u
IGFzIGEgdHJhbnNhY3Rpb24uwqAgRmlyc3Qgc2V0dGluZyB0aGUgZGVmYXVsdCBhdHRhY2ggZGV0
YWlscyA8YnI+CmFuZCB0aGVuIGFjdHVhbGx5IHNldHRpbmcgdGhlIG1vZGVtIG9ubGluZS7CoCBX
ZSBjYW4mIzM5O3QgZG8gaXQgPGJyPgpzaW11bHRhbmVvdXNseSwgYXMgYWdhaW4gd2UgY2Fubm90
IGFzc3VtZSB0aGUgbXVsdGlwbGV4aW5nIC8gcXVldWVpbmcgPGJyPgpiZWhhdmlvciBvZiB0aGUg
ZHJpdmVyLsKgIFRoaXMgY291bGQgcGVyaGFwcyBiZSBtYWRlIHRvIHdvcmssIGJ1dCB0aGVyZSA8
YnI+Cm1heSBiZSBhZGRpdGlvbmFsIGlzc3VlcyB0aGF0IGFyZSBkaXNjb3ZlcmVkIGFzIHdlIGdv
IGFsb25nLsKgIE9ubHkgd2F5IDxicj4KdG8gZmluZCBvdXQgaXMgdG8gcHJvdG90eXBlIGl0Ljxi
cj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5vaywgdGhlIEFUIGRyaXZlciBpcyBw
aXBpbmcgdGhlIGNvbW1hbmRzLCBhbmQgSSBhbSBnb2luZyB0byBpbXBsZW1lbnQgaXQgZm9yIGl0
LjwvZGl2PjxkaXY+QWRtaXR0ZWRseSwgZm9yIGFub3RoZXIgZHJpdmVyIGNvdWxkIGJlIG1vcmUg
ZGlmZmljdWx0IChNQklNIGFsc28gcGlwZXMgdGhlbSksPC9kaXY+PGRpdj5idXQgdGhlcmUgaXMg
c3RpbGwgdGhlIHBvc3NpYmlsaXR5IHRvIHNldCBkaXJlY3RseSB0aGUgcGFyYW1ldGVycyBhcyB0
aGV5IGFyZSB0b2RheSw8L2Rpdj48ZGl2Pm5vdCBpbXBsZW1lbnRpbmcgdGhpcyBmdW5jdGlvbiBp
biB0aGUgYXRvbSAoTlVMTCBmdW5jdGlvbiBvciBzaW1wbHkgcmV0dXJuaW5nKS48L2Rpdj48ZGl2
PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CiZn
dDsgPGJyPgomZ3Q7wqAgwqAgwqAgJmd0Ozxicj4KJmd0O8KgIMKgIMKgICZndDsgc28gdGhlIGlk
ZWEgd291bGQgYmUgdG8gY2hlY2sgaWYgYSBuZXcgbWV0aG9kLCB0aGF0IEkgaGF2ZTxicj4KJmd0
O8KgIMKgIMKgdGVudGF0aXZlbHk8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7IGNhbGxlZCBzZXRfcHJv
cGVydHkoKSw8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7IGV4aXN0cy4gSWYgc28sIHVzZSB0aGUgcmV2
aWV3ZWQgc3RpbGUgYWJvdmUsIG90aGVyd2lzZSBmYWxsYmFjazxicj4KJmd0O8KgIMKgIMKgdG8g
dGhlPGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyBjdXJyZW50IGZ1bmN0aW9uLjxicj4KJmd0O8KgIMKg
IMKgICZndDs8YnI+CiZndDsgPGJyPgomZ3Q7wqAgwqAgwqBJIGRvbiYjMzk7dCBzZWUgd2hhdCBz
ZXRfcHJvcGVydHkgaXMgYnV5aW5nIHlvdS7CoCBBbnl3YXksIGZlZWwgZnJlZSB0byBjb21lPGJy
PgomZ3Q7wqAgwqAgwqB1cCB3aXRoIGEgbW9yZSBkZXRhaWxlZCBwcm9wb3NhbCwgYnV0IG15IGlt
cHJlc3Npb24gaXMgdGhhdCB0aGlzPGJyPgomZ3Q7wqAgwqAgwqBhcHByb2FjaCB3aWxsIHF1aWNr
bHkgYmVjb21lIHdheSB0b28gY29tcGxpY2F0ZWQuPGJyPgomZ3Q7IDxicj4KJmd0OyA8YnI+CiZn
dDsgSSB0aGluayBub3cgaSBnb3QgeW91LiBUaGUgZXhpc3RpbmcgZnVuY3Rpb24gY291bGQgYmUg
dXNlZCwgYnV0IHRoZSA8YnI+CiZndDsgZHJpdmVyIG9ubHkgc3RvcmVzIHRoZSB2YWx1ZXMgaW50
ZXJuYWxseSBiZWNhdXNlIGl0IGtub3dzIGl0IHdpbGwgdmUgPGJyPgomZ3Q7IGNhbGxlZCBsYXRl
ciBmb3Igc2VuZGluZyB0aGUgY29tbWFuZHMuPGJyPgomZ3Q7IDxicj4KPGJyPgpPciB3ZSBzaW1w
bHkgY2FjaGUgdGhlIHZhbHVlcyBpbiB0aGUgbHRlIGF0b20gYW5kIGNhbGwgdGhlIGRyaXZlciBt
ZXRob2QgPGJyPgpvbmx5IHdoZW4gYXBwcm9wcmlhdGUuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2PkkgYmVsaWV2ZSBpdCBpcyBiZXR0ZXIgdG8gY2FsbCB0aGUgYXRvbSBhbmQg
bGV0IGl0IGRlY2lkZSB3aGF0IHRvIGRvLCBpbiBwYXJ0IHRvIG1pdGlnYXRlIHRoZSBpc3N1ZXMg
YWJvdmUuPC9kaXY+PGRpdj7CoDxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij5SZWdhcmRzLDxicj4KLURlbmlzPGJyPjwvYmxvY2txdW90ZT48ZGl2
Pjxicj48L2Rpdj48ZGl2PndpdGggdGhpcywgSSBhbSBnb29kIHRvIGdvLCBJIHdpbGwgdHJ5IHRv
IHByb3RvdHlwZSB0aGlzIG5ldyBiZWhhdmlvci48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJl
Z2FyZHMuPC9kaXY+PGRpdj5HaWFjaW50b8KgPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9k
aXY+Cg==

--===============0822813559128397852==--


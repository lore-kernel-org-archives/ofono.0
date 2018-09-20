Content-Type: multipart/mixed; boundary="===============1859191680653664069=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 2/7] extended support for LTE and NR. Some minor fixes.
 part 2 of 7
Date: Thu, 20 Sep 2018 09:57:18 +0200
Message-ID: <CAKSBH7HkxiEySdhB1diB=+KvDiyEe5iz0SyFg=0xdRUiq0MPgw@mail.gmail.com>
In-Reply-To: <99acf5e5-ee78-216b-4651-e9aff31cb839@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1859191680653664069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Sep 19, 2018 at 8:24 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> > I had a look at this all, and I have a problem. I cannot check the
> > parameters as they are entered one by one.
> > Example: if I blank user/pwd when the authentication is changed to NONE,
> > then if changed again to CHAP, the module will reject it.
> > Shall I store the parameters, or keep them also in case of error?
>
> So in the case of ConnectionContext the parameters are not sent out to
> the driver until context activation is attempted.  Hence all the
> settings are immediate and the activation fails or it succeeds.
>
> However, in the LongTermEvolution driver setup the settings are
> immediate.  Thus the D-Bus API you propose is thus not really suitable
> and needs to be modified. Since we're kind of stuck with the
> 'DefaultAccessPointName' property at this point, the only two ways out
> of this I can think of are:
>
> - Have the driver handle this.  So if PAP/CHAP is selected but username
> or password are invalid, default to no authentication.  The assumption
> will be that eventually valid parameters are given.
>
> Or perhaps we only call out into the driver method once the parameters
> in their entirety are valid, accepting whatever the user puts in as long
> as the individual property input is valid according to core validity
> checks.
>

We cannot change the external API, but internally we are free to rearrange
the code.

how do you feel about the proposal below for a second set of functions, to
override the existing ones
for newer lte atoms?

in src/lte.c

static DBusMessage *lte_set_property(DBusConnection *conn,
DBusMessage *msg, void *data)
{
[...]
if (lte->driver->set_property)
lte->driver->set_property(...);
else if (lte->driver->set_default_attach_info)
lte->driver->set_default_attach_info(...);
else
return __ofono_error_not_implemented(msg);
[...]

in src/modem.c:

static void sim_state_watch(enum ofono_sim_state new_state, void *user)
{
[...]
case OFONO_SIM_STATE_READY:
modem_change_state(modem, MODEM_STATE_OFFLINE);

ofono_lte_set_reginfo(modem);

/* Modem is always online, proceed to online state. */
if (modem_is_always_online(modem) =3D=3D TRUE)
set_online(modem, TRUE);

if (modem->online =3D=3D TRUE)
modem_change_state(modem, MODEM_STATE_ONLINE);
else if (modem->get_online)
modem->driver->set_online(modem, 1, common_online_cb,
modem);

modem->get_online =3D FALSE;

break;
}

I see that if(modem_is_always_online) maybe it will come too late, but in
that case also the current solution
with set_default_attach_info suffers from the same limitation, so no
regression.

Of course then, again in src/lte.c, the function ofono_lte_set_reginfo will
look for an lte atom, if present will call it without parameter for sending
the AT+CGDCONT and AT+CGAUTH to the modem.

Would this work for you?



> ....
>
> >
> > Another way would be to have a SetParameters() function, and set them
> > all together, including the APN, and not allowing writing them
> > separately, apart from the APN which already exists.
> > I don't really like it, either.
> >
>
> As you point out, this is the second alternative.  AuthenticationMethod,
> Username & Password would need to be set via a method call and
> optionally exposed as [readonly] properties.  Protocol could still be
> handled as per DefaultAccessPointName or inside the aforementioned
> method call.
>
> > Or introduce an atom function that is called before
> modem->set_online(true)?
> >
>
> This might be trickier, but could also work...
>
> Regards,
> -Denis
>

Regards,
Giacinto

--===============1859191680653664069==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0
ciI+T24gV2VkLCBTZXAgMTksIDIwMTggYXQgODoyNCBQTSBEZW5pcyBLZW56aW9yICZsdDs8YSBo
cmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdt
YWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNv
bGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+SGkgR2lhY2ludG8sPGJyPgo8
YnI+CiZndDsgSSBoYWQgYSBsb29rIGF0IHRoaXMgYWxsLCBhbmQgSSBoYXZlIGEgcHJvYmxlbS4g
SSBjYW5ub3QgY2hlY2sgdGhlIDxicj4KJmd0OyBwYXJhbWV0ZXJzIGFzIHRoZXkgYXJlIGVudGVy
ZWQgb25lIGJ5IG9uZS48YnI+CiZndDsgRXhhbXBsZTogaWYgSSBibGFuayB1c2VyL3B3ZCB3aGVu
IHRoZSBhdXRoZW50aWNhdGlvbiBpcyBjaGFuZ2VkIHRvIE5PTkUsIDxicj4KJmd0OyB0aGVuIGlm
IGNoYW5nZWQgYWdhaW4gdG8gQ0hBUCwgdGhlIG1vZHVsZSB3aWxsIHJlamVjdCBpdC48YnI+CiZn
dDsgU2hhbGwgSSBzdG9yZSB0aGUgcGFyYW1ldGVycywgb3Iga2VlcCB0aGVtIGFsc28gaW4gY2Fz
ZSBvZiBlcnJvcj88YnI+Cjxicj4KU28gaW4gdGhlIGNhc2Ugb2YgQ29ubmVjdGlvbkNvbnRleHQg
dGhlIHBhcmFtZXRlcnMgYXJlIG5vdCBzZW50IG91dCB0byA8YnI+CnRoZSBkcml2ZXIgdW50aWwg
Y29udGV4dCBhY3RpdmF0aW9uIGlzIGF0dGVtcHRlZC7CoCBIZW5jZSBhbGwgdGhlIDxicj4Kc2V0
dGluZ3MgYXJlIGltbWVkaWF0ZSBhbmQgdGhlIGFjdGl2YXRpb24gZmFpbHMgb3IgaXQgc3VjY2Vl
ZHMuPGJyPgo8YnI+Ckhvd2V2ZXIsIGluIHRoZSBMb25nVGVybUV2b2x1dGlvbiBkcml2ZXIgc2V0
dXAgdGhlIHNldHRpbmdzIGFyZSA8YnI+CmltbWVkaWF0ZS7CoCBUaHVzIHRoZSBELUJ1cyBBUEkg
eW91IHByb3Bvc2UgaXMgdGh1cyBub3QgcmVhbGx5IHN1aXRhYmxlIDxicj4KYW5kIG5lZWRzIHRv
IGJlIG1vZGlmaWVkLiBTaW5jZSB3ZSYjMzk7cmUga2luZCBvZiBzdHVjayB3aXRoIHRoZSA8YnI+
CiYjMzk7RGVmYXVsdEFjY2Vzc1BvaW50TmFtZSYjMzk7IHByb3BlcnR5IGF0IHRoaXMgcG9pbnQs
IHRoZSBvbmx5IHR3byB3YXlzIG91dCA8YnI+Cm9mIHRoaXMgSSBjYW4gdGhpbmsgb2YgYXJlOjxi
cj4KPGJyPgotIEhhdmUgdGhlIGRyaXZlciBoYW5kbGUgdGhpcy7CoCBTbyBpZiBQQVAvQ0hBUCBp
cyBzZWxlY3RlZCBidXQgdXNlcm5hbWUgPGJyPgpvciBwYXNzd29yZCBhcmUgaW52YWxpZCwgZGVm
YXVsdCB0byBubyBhdXRoZW50aWNhdGlvbi7CoCBUaGUgYXNzdW1wdGlvbiA8YnI+CndpbGwgYmUg
dGhhdCBldmVudHVhbGx5IHZhbGlkIHBhcmFtZXRlcnMgYXJlIGdpdmVuLjxicj4KPGJyPgpPciBw
ZXJoYXBzIHdlIG9ubHkgY2FsbCBvdXQgaW50byB0aGUgZHJpdmVyIG1ldGhvZCBvbmNlIHRoZSBw
YXJhbWV0ZXJzIDxicj4KaW4gdGhlaXIgZW50aXJldHkgYXJlIHZhbGlkLCBhY2NlcHRpbmcgd2hh
dGV2ZXIgdGhlIHVzZXIgcHV0cyBpbiBhcyBsb25nIDxicj4KYXMgdGhlIGluZGl2aWR1YWwgcHJv
cGVydHkgaW5wdXQgaXMgdmFsaWQgYWNjb3JkaW5nIHRvIGNvcmUgdmFsaWRpdHkgY2hlY2tzLjxi
cj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5XZSBjYW5ub3QgY2hhbmdlIHRoZSBl
eHRlcm5hbCBBUEksIGJ1dCBpbnRlcm5hbGx5IHdlIGFyZSBmcmVlIHRvIHJlYXJyYW5nZSB0aGUg
Y29kZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmhvdyBkbyB5b3UgZmVlbCBhYm91dCB0aGUg
cHJvcG9zYWwgYmVsb3cgZm9yIGEgc2Vjb25kIHNldCBvZiBmdW5jdGlvbnMsIHRvIG92ZXJyaWRl
IHRoZSBleGlzdGluZyBvbmVzPC9kaXY+PGRpdj5mb3IgbmV3ZXIgbHRlIGF0b21zPzwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+aW4gc3JjL2x0ZS5jPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48
ZGl2PnN0YXRpYyBEQnVzTWVzc2FnZSAqbHRlX3NldF9wcm9wZXJ0eShEQnVzQ29ubmVjdGlvbiAq
Y29ubiw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CQkJCQkJ
PC9zcGFuPkRCdXNNZXNzYWdlICptc2csIHZvaWQgKmRhdGEpPC9kaXY+PGRpdj57PC9kaXY+PGRp
dj5bLi4uXTwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9z
cGFuPmlmIChsdGUtJmd0O2RyaXZlci0mZ3Q7c2V0X3Byb3BlcnR5KTxicj48L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CQk8L3NwYW4+bHRlLSZndDtkcml2ZXIt
Jmd0O3NldF9wcm9wZXJ0eSguLi4pOzwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNl
OnByZS13cmFwIj4JPC9zcGFuPmVsc2UgaWYgKGx0ZS0mZ3Q7ZHJpdmVyLSZndDtzZXRfZGVmYXVs
dF9hdHRhY2hfaW5mbyk8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3Jh
cCI+CQk8L3NwYW4+bHRlLSZndDtkcml2ZXItJmd0O3NldF9kZWZhdWx0X2F0dGFjaF9pbmZvKC4u
Lik7PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+
ZWxzZTwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JCTwvc3Bh
bj5yZXR1cm4gX19vZm9ub19lcnJvcl9ub3RfaW1wbGVtZW50ZWQobXNnKTs8L2Rpdj48L2Rpdj48
ZGl2PlsuLi5dPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5pbiBzcmMvbW9kZW0uYzo8L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PnN0YXRpYyB2b2lkIHNpbV9zdGF0ZV93YXRjaChlbnVtIG9mb25v
X3NpbV9zdGF0ZSBuZXdfc3RhdGUsIHZvaWQgKnVzZXIpPGJyPjwvZGl2PjxkaXY+PGRpdj57PC9k
aXY+PC9kaXY+PGRpdj5bLi4uXTwvZGl2PjxkaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPmNhc2UgT0ZPTk9fU0lNX1NUQVRFX1JFQURZOjwvZGl2PjxkaXY+PHNw
YW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+bW9kZW1fY2hhbmdlX3N0YXRlKG1v
ZGVtLCBNT0RFTV9TVEFURV9PRkZMSU5FKTs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFu
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJPC9zcGFuPm9mb25vX2x0ZV9zZXRfcmVnaW5mbyht
b2RlbSk7PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JCTwvc3Bhbj4vKiBNb2RlbSBpcyBhbHdheXMgb25saW5lLCBwcm9jZWVkIHRvIG9ubGlu
ZSBzdGF0ZS4gKi88L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJPC9z
cGFuPmlmIChtb2RlbV9pc19hbHdheXNfb25saW5lKG1vZGVtKSA9PSBUUlVFKTwvZGl2PjxkaXY+
PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQkJPC9zcGFuPnNldF9vbmxpbmUobW9kZW0s
IFRSVUUpOzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CQk8L3NwYW4+aWYgKG1vZGVtLSZndDtvbmxpbmUgPT0gVFJVRSk8L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJCTwvc3Bhbj5tb2RlbV9jaGFuZ2Vfc3RhdGUo
bW9kZW0sIE1PREVNX1NUQVRFX09OTElORSk7PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JCTwvc3Bhbj5lbHNlIGlmIChtb2RlbS0mZ3Q7Z2V0X29ubGluZSk8L2Rpdj48
ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJCTwvc3Bhbj5tb2RlbS0mZ3Q7ZHJp
dmVyLSZndDtzZXRfb25saW5lKG1vZGVtLCAxLCBjb21tb25fb25saW5lX2NiLDwvZGl2PjxkaXY+
PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQkJCQkJCTwvc3Bhbj5tb2RlbSk7PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bh
bj5tb2RlbS0mZ3Q7Z2V0X29ubGluZSA9IEZBTFNFOzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+YnJlYWs7PC9kaXY+PGRpdj48
c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08L2Rpdj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pkkgc2VlIHRoYXQgaWYobW9kZW1faXNfYWx3YXlzX29ubGluZSkgbWF5YmUg
aXQgd2lsbCBjb21lIHRvbyBsYXRlLCBidXQgaW4gdGhhdCBjYXNlIGFsc28gdGhlIGN1cnJlbnQg
c29sdXRpb248L2Rpdj48ZGl2PndpdGggc2V0X2RlZmF1bHRfYXR0YWNoX2luZm8gc3VmZmVycyBm
cm9tIHRoZSBzYW1lIGxpbWl0YXRpb24sIHNvIG5vIHJlZ3Jlc3Npb24uPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5PZiBjb3Vyc2UgdGhlbiwgYWdhaW4gaW4gc3JjL2x0ZS5jLCB0aGUgZnVuY3Rp
b24gb2Zvbm9fbHRlX3NldF9yZWdpbmZvIHdpbGwgbG9vayBmb3IgYW4gbHRlIGF0b20sIGlmIHBy
ZXNlbnQgd2lsbCBjYWxsIGl0IHdpdGhvdXQgcGFyYW1ldGVyIGZvciBzZW5kaW5nIHRoZSBBVCtD
R0RDT05UIGFuZCBBVCtDR0FVVEggdG8gdGhlIG1vZGVtLjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+V291bGQgdGhpcyB3b3JrIGZvciB5b3U/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoDxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFk
ZGluZy1sZWZ0OjFleCI+Ci4uLi48YnI+Cjxicj4KJmd0OyA8YnI+CiZndDsgQW5vdGhlciB3YXkg
d291bGQgYmUgdG8gaGF2ZSBhIFNldFBhcmFtZXRlcnMoKSBmdW5jdGlvbiwgYW5kIHNldCB0aGVt
IDxicj4KJmd0OyBhbGwgdG9nZXRoZXIsIGluY2x1ZGluZyB0aGUgQVBOLCBhbmQgbm90IGFsbG93
aW5nIHdyaXRpbmcgdGhlbSA8YnI+CiZndDsgc2VwYXJhdGVseSwgYXBhcnQgZnJvbSB0aGUgQVBO
IHdoaWNoIGFscmVhZHkgZXhpc3RzLjxicj4KJmd0OyBJIGRvbiYjMzk7dCByZWFsbHkgbGlrZSBp
dCwgZWl0aGVyLjxicj4KJmd0OyA8YnI+Cjxicj4KQXMgeW91IHBvaW50IG91dCwgdGhpcyBpcyB0
aGUgc2Vjb25kIGFsdGVybmF0aXZlLsKgIEF1dGhlbnRpY2F0aW9uTWV0aG9kLCA8YnI+ClVzZXJu
YW1lICZhbXA7IFBhc3N3b3JkIHdvdWxkIG5lZWQgdG8gYmUgc2V0IHZpYSBhIG1ldGhvZCBjYWxs
IGFuZCA8YnI+Cm9wdGlvbmFsbHkgZXhwb3NlZCBhcyBbcmVhZG9ubHldIHByb3BlcnRpZXMuwqAg
UHJvdG9jb2wgY291bGQgc3RpbGwgYmUgPGJyPgpoYW5kbGVkIGFzIHBlciBEZWZhdWx0QWNjZXNz
UG9pbnROYW1lIG9yIGluc2lkZSB0aGUgYWZvcmVtZW50aW9uZWQgPGJyPgptZXRob2QgY2FsbC48
YnI+Cjxicj4KJmd0OyBPciBpbnRyb2R1Y2UgYW4gYXRvbSBmdW5jdGlvbiB0aGF0IGlzIGNhbGxl
ZCBiZWZvcmUgbW9kZW0tJmd0O3NldF9vbmxpbmUodHJ1ZSk/PGJyPgomZ3Q7IDxicj4KPGJyPgpU
aGlzIG1pZ2h0IGJlIHRyaWNraWVyLCBidXQgY291bGQgYWxzbyB3b3JrLi4uPGJyPgo8YnI+ClJl
Z2FyZHMsPGJyPgotRGVuaXM8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVn
YXJkcyw8L2Rpdj48ZGl2PkdpYWNpbnRvPC9kaXY+PGRpdj7CoDwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2PjwvZGl2PjwvZGl2Pgo=

--===============1859191680653664069==--


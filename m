Content-Type: multipart/mixed; boundary="===============8252103092152209380=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 2/7] extended support for LTE and NR. Some minor fixes.
 part 2 of 7
Date: Wed, 19 Sep 2018 19:53:20 +0200
Message-ID: <CAKSBH7H+iSZu6OUq56+EAY-kQ3o=fwMDSWTHz49PHBxCq6jHhA@mail.gmail.com>
In-Reply-To: <6991808a-8090-ef91-eef3-1d0e8b9f0789@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8252103092152209380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2018 at 6:30 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> > so, first the documentation?
>
> Correct.  Whenever you touch something that affects the D-Bus API, it is
> really preferable to have the D-Bus API changes in the preceding commit.
>   That way the reviewers can cross-reference what is being proposed to
> the actual implementation.  Anything that breaks the D-Bus API can also
> be spotted much earlier.
>
> oFono's D-Bus API is stable.  That means we can add new things, but we
> cannot change existing ones as that will break existing clients.
>
> We also cannot break existing settings, as that would break oFono
> installations on existing devices if they are upgraded.
>
> This is a handicap that we have to live with right now.
>
> <snip>
>
> >
> > So there can be no unification with the GPRS naming now that the D-Bus
> > API is set?
>
> I'm afraid not.  But I'm not sure why this is a problem?
>
> >
> >      > +#define LTE_PROTO "Protocol"
> >      > +#define LTE_USERNAME "Username"
> >      > +#define LTE_PASSWORD "Password"
> >      > +#define LTE_AUTH_METHOD "AuthenticationMethod"
> >      >
> >      >   struct ofono_lte {
> >      >       const struct ofono_lte_driver *driver;
> >      > @@ -50,13 +55,82 @@ struct ofono_lte {
> >      >       DBusMessage *pending;
> >      >       struct ofono_lte_default_attach_info pending_info;
> >      >       struct ofono_lte_default_attach_info info;
> >      > +     const char *prop_changed;
> >
> >     ??  What memory location is this const char pointing to?
> >
> >
> > it is initialized to null with the containing structure.
>
> That is not what I'm asking.  This pointer points into data owned by
> DBusMessage and the semantics of whether it is valid or not are not
> enforced.  Avoid that at all cost...
>
> >
> > What about reading also the previous key?
>
> Ideally you shouldn't change the key in the first place.  But if you
> are, then yes you need to be able to read legacy settings versions in
> order to be backwards-compatible.
>
> >
> >     You do realize you're never actually calling into the driver method,
> >     right?  So none of these changes actually go out to the modem.  Have
> >     you
> >     actually tested any of this?
> >
> >
> > Yes, it works. Actually the only call is when the APN is set, as
> > mentioned in the lte-api.txt.
>
> No, it really doesn't...
>
> > And at that point all parameters are also set in the module.
> > It is not possible to set separately protocol and apn, and auth_method,
> > username, and password.
> > For ublox modules, the auth_method is also part of the APN name.
> >
> > So we kept the call into the module when the APN is set, and previously
> > to it all other parameters are set.
>
> You simply cannot do that.  You cannot assume that the client knows how
> your API is implemented underneath.  So if they set the APN first and
> then change the username, that has to work.  This is why the
> default_attach_info contains everything.  If anything is changed the
> entire structure is sent to the modem and every parameter is updated.
>

Hi Denis,

I had a look at this all, and I have a problem. I cannot check the
parameters as they are entered one by one.
Example: if I blank user/pwd when the authentication is changed to NONE,
then if changed again to CHAP, the module will reject it.
Shall I store the parameters, or keep them also in case of error?

Another way would be to have a SetParameters() function, and set them all
together, including the APN, and not allowing writing them separately,
apart from the APN which already exists.
I don't really like it, either.

Or introduce an atom function that is called before modem->set_online(true)?

thanks,
Giacinto


>
> >
> > You have also mentioned that somewhere we should also verify that with
> > AUTH_NONE there are no user/pwd.
> > This also can only be verified at the end.
> >
> > Any suggestions to improve this, given these limitations?
> >
>
> See above.  Any parameter change has to trigger
> set_default_attach_info() call.  If something is invalid, then you have
> to return a D-Bus error.
>
> For example, if my method is set to 'none' and I try to do
> LongTermEvolution.SetProperty("DefaultUsername", "foo") that should
> return an error.
>
> >
> >      > +     return dbus_message_ref(msg);;
> >      >   }
> >      >
> >      >   static DBusMessage *lte_set_property(DBusConnection *conn,
> >      > -                                     DBusMessage *msg, void
> *data)
> >      > +                                             DBusMessage *msg,
> >     void *data)
> >      >   {
> >      >       struct ofono_lte *lte =3D data;
> >      >       DBusMessageIter iter;
> >      >       DBusMessageIter var;
> >      >       const char *property;
> >      >       const char *str;
> >      > +     enum ofono_gprs_auth_method auth_method;
> >      > +     enum ofono_gprs_proto proto;
> >      > +
> >      > +     if (lte->driver->set_default_attach_info =3D=3D NULL)
> >      > +             return __ofono_error_not_implemented(msg);
> >      > +
> >      > +     if (lte->pending)
> >      > +             return __ofono_error_busy(msg);
> >      >
> >      >       if (!dbus_message_iter_init(msg, &iter))
> >      >               return __ofono_error_invalid_args(msg);
> >      > @@ -192,13 +428,58 @@ static DBusMessage
> >     *lte_set_property(DBusConnection *conn,
> >      >
> >      >       dbus_message_iter_recurse(&iter, &var);
> >      >
> >      > -     if (!strcmp(property, DEFAULT_APN_KEY)) {
> >      > +     lte->prop_changed=3Dproperty;
> >      > +
> >      > +     if (!strcmp(property, LTE_PROTO)) {
> >      > +
> >      > +             if (dbus_message_iter_get_arg_type(&var) !=3D
> >     DBUS_TYPE_STRING)
> >      > +                     return __ofono_error_invalid_args(msg);
> >      > +
> >      > +             dbus_message_iter_get_basic(&var, &str);
> >      > +
> >      > +             if (gprs_proto_from_string(str, &proto))
> >      > +                     return lte_set_proto(lte, conn, msg, proto=
);
> >
> >     The return from this callback is always supposed to be a
> method_return
> >     or NULL if the method_return will be done asynchronously (in your
> case
> >     always)  You're somehow returning the method_call itself...
> >
> >
> > I am not sure I follow you, but you suggested to restructure the code,
> > so I will come back on this later.
>
> You need to understand the semantics of GDBus.  GDBUS_ASYNC_METHOD()
> callback can only return the D-Bus method_return for message or NULL if
> the method return will be generated asynchronously.  You cannot return
> the message itself.  While this may 'work' the behavior is undefined.
>
> >      > +struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte
> *lte)
> >      > +{
> >      > +     return __ofono_atom_get_modem(lte->atom);
> >      > +}
> >      > \ No newline at end of file
> >
> >     Fix this.
> >
> >
> > ?
>
> You have no newline after the last '}' and git complains.  If git
> complains I cannot apply the patch...
>
> >
> > I agree it is unrelated, I will post a separate post, but I turn on
> > NEED_THREADS, and the build fails. Looking at the g_thread
> > documentations, nowadays it has to come out of the code:
> >
> > |g_thread_init| has been deprecated since version 2.32 and should not be
> > used in newly-written code.
> >
> > This function is no longer necessary. The GLib threading system is
> > automatically initialized at the start of your program.
> >
>
> Okay, please send this as a separate patch.  We might need to remove
> this configure option as well.
>
> Regards,
> -Denis
>

--===============8252103092152209380==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9
Imx0ciI+T24gV2VkLCBTZXAgMTksIDIwMTggYXQgNjozMCBQTSBEZW5pcyBLZW56aW9yICZsdDs8
YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZn
dDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVm
dDoxZXgiPkhpIEdpYWNpbnRvLDxicj4KPGJyPgomZ3Q7IHNvLCBmaXJzdCB0aGUgZG9jdW1lbnRh
dGlvbj88YnI+Cjxicj4KQ29ycmVjdC7CoCBXaGVuZXZlciB5b3UgdG91Y2ggc29tZXRoaW5nIHRo
YXQgYWZmZWN0cyB0aGUgRC1CdXMgQVBJLCBpdCBpcyA8YnI+CnJlYWxseSBwcmVmZXJhYmxlIHRv
IGhhdmUgdGhlIEQtQnVzIEFQSSBjaGFuZ2VzIGluIHRoZSBwcmVjZWRpbmcgY29tbWl0LiA8YnI+
CsKgIFRoYXQgd2F5IHRoZSByZXZpZXdlcnMgY2FuIGNyb3NzLXJlZmVyZW5jZSB3aGF0IGlzIGJl
aW5nIHByb3Bvc2VkIHRvIDxicj4KdGhlIGFjdHVhbCBpbXBsZW1lbnRhdGlvbi7CoCBBbnl0aGlu
ZyB0aGF0IGJyZWFrcyB0aGUgRC1CdXMgQVBJIGNhbiBhbHNvIDxicj4KYmUgc3BvdHRlZCBtdWNo
IGVhcmxpZXIuPGJyPgo8YnI+Cm9Gb25vJiMzOTtzIEQtQnVzIEFQSSBpcyBzdGFibGUuwqAgVGhh
dCBtZWFucyB3ZSBjYW4gYWRkIG5ldyB0aGluZ3MsIGJ1dCB3ZSA8YnI+CmNhbm5vdCBjaGFuZ2Ug
ZXhpc3Rpbmcgb25lcyBhcyB0aGF0IHdpbGwgYnJlYWsgZXhpc3RpbmcgY2xpZW50cy48YnI+Cjxi
cj4KV2UgYWxzbyBjYW5ub3QgYnJlYWsgZXhpc3Rpbmcgc2V0dGluZ3MsIGFzIHRoYXQgd291bGQg
YnJlYWsgb0Zvbm8gPGJyPgppbnN0YWxsYXRpb25zIG9uIGV4aXN0aW5nIGRldmljZXMgaWYgdGhl
eSBhcmUgdXBncmFkZWQuPGJyPgo8YnI+ClRoaXMgaXMgYSBoYW5kaWNhcCB0aGF0IHdlIGhhdmUg
dG8gbGl2ZSB3aXRoIHJpZ2h0IG5vdy48YnI+Cjxicj4KJmx0O3NuaXAmZ3Q7PGJyPgo8YnI+CiZn
dDsgPGJyPgomZ3Q7IFNvIHRoZXJlIGNhbiBiZSBubyB1bmlmaWNhdGlvbiB3aXRoIHRoZSBHUFJT
IG5hbWluZyBub3cgdGhhdCB0aGUgRC1CdXMgPGJyPgomZ3Q7IEFQSSBpcyBzZXQ/PGJyPgo8YnI+
CkkmIzM5O20gYWZyYWlkIG5vdC7CoCBCdXQgSSYjMzk7bSBub3Qgc3VyZSB3aHkgdGhpcyBpcyBh
IHByb2JsZW0/PGJyPgo8YnI+CiZndDsgPGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyArI2RlZmluZSBM
VEVfUFJPVE8gJnF1b3Q7UHJvdG9jb2wmcXVvdDs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICsjZGVm
aW5lIExURV9VU0VSTkFNRSAmcXVvdDtVc2VybmFtZSZxdW90Ozxicj4KJmd0O8KgIMKgIMKgICZn
dDsgKyNkZWZpbmUgTFRFX1BBU1NXT1JEICZxdW90O1Bhc3N3b3JkJnF1b3Q7PGJyPgomZ3Q7wqAg
wqAgwqAgJmd0OyArI2RlZmluZSBMVEVfQVVUSF9NRVRIT0QgJnF1b3Q7QXV0aGVudGljYXRpb25N
ZXRob2QmcXVvdDs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7PGJyPgomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgc3RydWN0IG9mb25vX2x0ZSB7PGJyPgomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgIMKgY29u
c3Qgc3RydWN0IG9mb25vX2x0ZV9kcml2ZXIgKmRyaXZlcjs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7
IEBAIC01MCwxMyArNTUsODIgQEAgc3RydWN0IG9mb25vX2x0ZSB7PGJyPgomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgIMKgREJ1c01lc3NhZ2UgKnBlbmRpbmc7PGJyPgomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgIMKgc3RydWN0IG9mb25vX2x0ZV9kZWZhdWx0X2F0dGFjaF9pbmZvIHBlbmRpbmdf
aW5mbzs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqBzdHJ1Y3Qgb2Zvbm9fbHRlX2Rl
ZmF1bHRfYXR0YWNoX2luZm8gaW5mbzs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoGNv
bnN0IGNoYXIgKnByb3BfY2hhbmdlZDs8YnI+CiZndDsgPGJyPgomZ3Q7wqAgwqAgwqA/P8KgIFdo
YXQgbWVtb3J5IGxvY2F0aW9uIGlzIHRoaXMgY29uc3QgY2hhciBwb2ludGluZyB0bz88YnI+CiZn
dDsgPGJyPgomZ3Q7IDxicj4KJmd0OyBpdCBpcyBpbml0aWFsaXplZCB0byBudWxsIHdpdGggdGhl
IGNvbnRhaW5pbmcgc3RydWN0dXJlLjxicj4KPGJyPgpUaGF0IGlzIG5vdCB3aGF0IEkmIzM5O20g
YXNraW5nLsKgIFRoaXMgcG9pbnRlciBwb2ludHMgaW50byBkYXRhIG93bmVkIGJ5IDxicj4KREJ1
c01lc3NhZ2UgYW5kIHRoZSBzZW1hbnRpY3Mgb2Ygd2hldGhlciBpdCBpcyB2YWxpZCBvciBub3Qg
YXJlIG5vdCA8YnI+CmVuZm9yY2VkLsKgIEF2b2lkIHRoYXQgYXQgYWxsIGNvc3QuLi48YnI+Cjxi
cj4KJmd0OyA8YnI+CiZndDsgV2hhdCBhYm91dCByZWFkaW5nIGFsc28gdGhlIHByZXZpb3VzIGtl
eT88YnI+Cjxicj4KSWRlYWxseSB5b3Ugc2hvdWxkbiYjMzk7dCBjaGFuZ2UgdGhlIGtleSBpbiB0
aGUgZmlyc3QgcGxhY2UuwqAgQnV0IGlmIHlvdSA8YnI+CmFyZSwgdGhlbiB5ZXMgeW91IG5lZWQg
dG8gYmUgYWJsZSB0byByZWFkIGxlZ2FjeSBzZXR0aW5ncyB2ZXJzaW9ucyBpbiA8YnI+Cm9yZGVy
IHRvIGJlIGJhY2t3YXJkcy1jb21wYXRpYmxlLjxicj4KPGJyPgomZ3Q7IDxicj4KJmd0O8KgIMKg
IMKgWW91IGRvIHJlYWxpemUgeW91JiMzOTtyZSBuZXZlciBhY3R1YWxseSBjYWxsaW5nIGludG8g
dGhlIGRyaXZlciBtZXRob2QsPGJyPgomZ3Q7wqAgwqAgwqByaWdodD/CoCBTbyBub25lIG9mIHRo
ZXNlIGNoYW5nZXMgYWN0dWFsbHkgZ28gb3V0IHRvIHRoZSBtb2RlbS7CoCBIYXZlPGJyPgomZ3Q7
wqAgwqAgwqB5b3U8YnI+CiZndDvCoCDCoCDCoGFjdHVhbGx5IHRlc3RlZCBhbnkgb2YgdGhpcz88
YnI+CiZndDsgPGJyPgomZ3Q7IDxicj4KJmd0OyBZZXMsIGl0IHdvcmtzLiBBY3R1YWxseSB0aGUg
b25seSBjYWxsIGlzIHdoZW4gdGhlIEFQTiBpcyBzZXQsIGFzIDxicj4KJmd0OyBtZW50aW9uZWQg
aW4gdGhlIGx0ZS1hcGkudHh0Ljxicj4KPGJyPgpObywgaXQgcmVhbGx5IGRvZXNuJiMzOTt0Li4u
PGJyPgo8YnI+CiZndDsgQW5kIGF0IHRoYXQgcG9pbnQgYWxsIHBhcmFtZXRlcnMgYXJlIGFsc28g
c2V0IGluIHRoZSBtb2R1bGUuPGJyPgomZ3Q7IEl0IGlzIG5vdCBwb3NzaWJsZSB0byBzZXQgc2Vw
YXJhdGVseSBwcm90b2NvbCBhbmQgYXBuLCBhbmQgYXV0aF9tZXRob2QsIDxicj4KJmd0OyB1c2Vy
bmFtZSwgYW5kIHBhc3N3b3JkLjxicj4KJmd0OyBGb3IgdWJsb3ggbW9kdWxlcywgdGhlIGF1dGhf
bWV0aG9kIGlzIGFsc28gcGFydCBvZiB0aGUgQVBOIG5hbWUuPGJyPgomZ3Q7IDxicj4KJmd0OyBT
byB3ZSBrZXB0IHRoZSBjYWxsIGludG8gdGhlIG1vZHVsZSB3aGVuIHRoZSBBUE4gaXMgc2V0LCBh
bmQgcHJldmlvdXNseSA8YnI+CiZndDsgdG8gaXQgYWxsIG90aGVyIHBhcmFtZXRlcnMgYXJlIHNl
dC48YnI+Cjxicj4KWW91IHNpbXBseSBjYW5ub3QgZG8gdGhhdC7CoCBZb3UgY2Fubm90IGFzc3Vt
ZSB0aGF0IHRoZSBjbGllbnQga25vd3MgaG93IDxicj4KeW91ciBBUEkgaXMgaW1wbGVtZW50ZWQg
dW5kZXJuZWF0aC7CoCBTbyBpZiB0aGV5IHNldCB0aGUgQVBOIGZpcnN0IGFuZCA8YnI+CnRoZW4g
Y2hhbmdlIHRoZSB1c2VybmFtZSwgdGhhdCBoYXMgdG8gd29yay7CoCBUaGlzIGlzIHdoeSB0aGUg
PGJyPgpkZWZhdWx0X2F0dGFjaF9pbmZvIGNvbnRhaW5zIGV2ZXJ5dGhpbmcuwqAgSWYgYW55dGhp
bmcgaXMgY2hhbmdlZCB0aGUgPGJyPgplbnRpcmUgc3RydWN0dXJlIGlzIHNlbnQgdG8gdGhlIG1v
ZGVtIGFuZCBldmVyeSBwYXJhbWV0ZXIgaXMgdXBkYXRlZC48YnI+PC9ibG9ja3F1b3RlPjxkaXY+
PGJyPjwvZGl2PjxkaXY+SGkgRGVuaXMsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhZCBh
IGxvb2sgYXQgdGhpcyBhbGwsIGFuZCBJIGhhdmUgYSBwcm9ibGVtLiBJIGNhbm5vdCBjaGVjayB0
aGUgcGFyYW1ldGVycyBhcyB0aGV5IGFyZSBlbnRlcmVkIG9uZSBieSBvbmUuPC9kaXY+PGRpdj5F
eGFtcGxlOiBpZiBJIGJsYW5rIHVzZXIvcHdkIHdoZW4gdGhlIGF1dGhlbnRpY2F0aW9uIGlzIGNo
YW5nZWQgdG8gTk9ORSwgdGhlbiBpZiBjaGFuZ2VkIGFnYWluIHRvIENIQVAsIHRoZSBtb2R1bGUg
d2lsbCByZWplY3QgaXQuPC9kaXY+PGRpdj5TaGFsbCBJIHN0b3JlIHRoZSBwYXJhbWV0ZXJzLCBv
ciBrZWVwIHRoZW0gYWxzbyBpbiBjYXNlIG9mIGVycm9yPzwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+QW5vdGhlciB3YXkgd291bGQgYmUgdG8gaGF2ZSBhIFNldFBhcmFtZXRlcnMoKSBmdW5jdGlv
biwgYW5kIHNldCB0aGVtIGFsbCB0b2dldGhlciwgaW5jbHVkaW5nIHRoZSBBUE4sIGFuZCBub3Qg
YWxsb3dpbmcgd3JpdGluZyB0aGVtIHNlcGFyYXRlbHksIGFwYXJ0IGZyb20gdGhlIEFQTiB3aGlj
aCBhbHJlYWR5IGV4aXN0cy48L2Rpdj48ZGl2PkkgZG9uJiMzOTt0IHJlYWxseSBsaWtlIGl0LCBl
aXRoZXIuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5PciBpbnRyb2R1Y2UgYW4gYXRvbSBmdW5j
dGlvbiB0aGF0IGlzIGNhbGxlZCBiZWZvcmUgbW9kZW0tJmd0O3NldF9vbmxpbmUodHJ1ZSk/PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj50aGFua3MsPC9kaXY+PGRpdj5HaWFjaW50bzwvZGl2Pjxk
aXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4K
PGJyPgomZ3Q7IDxicj4KJmd0OyBZb3UgaGF2ZSBhbHNvIG1lbnRpb25lZCB0aGF0IHNvbWV3aGVy
ZSB3ZSBzaG91bGQgYWxzbyB2ZXJpZnkgdGhhdCB3aXRoIDxicj4KJmd0OyBBVVRIX05PTkUgdGhl
cmUgYXJlIG5vIHVzZXIvcHdkLjxicj4KJmd0OyBUaGlzIGFsc28gY2FuIG9ubHkgYmUgdmVyaWZp
ZWQgYXQgdGhlIGVuZC48YnI+CiZndDsgPGJyPgomZ3Q7IEFueSBzdWdnZXN0aW9ucyB0byBpbXBy
b3ZlIHRoaXMsIGdpdmVuIHRoZXNlIGxpbWl0YXRpb25zPzxicj4KJmd0OyA8YnI+Cjxicj4KU2Vl
IGFib3ZlLsKgIEFueSBwYXJhbWV0ZXIgY2hhbmdlIGhhcyB0byB0cmlnZ2VyIDxicj4Kc2V0X2Rl
ZmF1bHRfYXR0YWNoX2luZm8oKSBjYWxsLsKgIElmIHNvbWV0aGluZyBpcyBpbnZhbGlkLCB0aGVu
IHlvdSBoYXZlIDxicj4KdG8gcmV0dXJuIGEgRC1CdXMgZXJyb3IuPGJyPgo8YnI+CkZvciBleGFt
cGxlLCBpZiBteSBtZXRob2QgaXMgc2V0IHRvICYjMzk7bm9uZSYjMzk7IGFuZCBJIHRyeSB0byBk
byA8YnI+CkxvbmdUZXJtRXZvbHV0aW9uLlNldFByb3BlcnR5KCZxdW90O0RlZmF1bHRVc2VybmFt
ZSZxdW90OywgJnF1b3Q7Zm9vJnF1b3Q7KSB0aGF0IHNob3VsZCA8YnI+CnJldHVybiBhbiBlcnJv
ci48YnI+Cjxicj4KJmd0OyA8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoHJldHVybiBk
YnVzX21lc3NhZ2VfcmVmKG1zZyk7Ozxicj4KJmd0O8KgIMKgIMKgICZndDvCoCDCoH08YnI+CiZn
dDvCoCDCoCDCoCAmZ3Q7PGJyPgomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgc3RhdGljIERCdXNNZXNz
YWdlICpsdGVfc2V0X3Byb3BlcnR5KERCdXNDb25uZWN0aW9uICpjb25uLDxicj4KJmd0O8KgIMKg
IMKgICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgREJ1c01lc3NhZ2UgKm1zZywgdm9pZCAqZGF0YSk8YnI+CiZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoERCdXNNZXNzYWdlICptc2csPGJyPgomZ3Q7wqAgwqAgwqB2b2lkICpk
YXRhKTxicj4KJmd0O8KgIMKgIMKgICZndDvCoCDCoHs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgwqBzdHJ1Y3Qgb2Zvbm9fbHRlICpsdGUgPSBkYXRhOzxicj4KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCDCoERCdXNNZXNzYWdlSXRlciBpdGVyOzxicj4KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCDCoERCdXNNZXNzYWdlSXRlciB2YXI7PGJyPgomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgIMKgY29uc3QgY2hhciAqcHJvcGVydHk7PGJyPgomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
IMKgY29uc3QgY2hhciAqc3RyOzxicj4KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgZW51bSBv
Zm9ub19ncHJzX2F1dGhfbWV0aG9kIGF1dGhfbWV0aG9kOzxicj4KJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIMKgZW51bSBvZm9ub19ncHJzX3Byb3RvIHByb3RvOzxicj4KJmd0O8KgIMKgIMKgICZn
dDsgKzxicj4KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgaWYgKGx0ZS0mZ3Q7ZHJpdmVyLSZn
dDtzZXRfZGVmYXVsdF9hdHRhY2hfaW5mbyA9PSBOVUxMKTxicj4KJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJyb3Jfbm90X2ltcGxlbWVudGVk
KG1zZyk7PGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgwqBpZiAobHRlLSZndDtwZW5kaW5nKTxicj4KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJyb3JfYnVzeShtc2cpOzxicj4KJmd0O8KgIMKg
IMKgICZndDs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqBpZiAoIWRidXNfbWVzc2Fn
ZV9pdGVyX2luaXQobXNnLCAmYW1wO2l0ZXIpKTxicj4KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybiBfX29mb25vX2Vycm9yX2ludmFsaWRfYXJncyhtc2cpOzxi
cj4KJmd0O8KgIMKgIMKgICZndDsgQEAgLTE5MiwxMyArNDI4LDU4IEBAIHN0YXRpYyBEQnVzTWVz
c2FnZTxicj4KJmd0O8KgIMKgIMKgKmx0ZV9zZXRfcHJvcGVydHkoREJ1c0Nvbm5lY3Rpb24gKmNv
bm4sPGJyPgomZ3Q7wqAgwqAgwqAgJmd0Ozxicj4KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCDC
oGRidXNfbWVzc2FnZV9pdGVyX3JlY3Vyc2UoJmFtcDtpdGVyLCAmYW1wO3Zhcik7PGJyPgomZ3Q7
wqAgwqAgwqAgJmd0Ozxicj4KJmd0O8KgIMKgIMKgICZndDsgLcKgIMKgIMKgaWYgKCFzdHJjbXAo
cHJvcGVydHksIERFRkFVTFRfQVBOX0tFWSkpIHs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCDCoGx0ZS0mZ3Q7cHJvcF9jaGFuZ2VkPXByb3BlcnR5Ozxicj4KJmd0O8KgIMKgIMKgICZndDsg
Kzxicj4KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgaWYgKCFzdHJjbXAocHJvcGVydHksIExU
RV9QUk9UTykpIHs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChkYnVzX21lc3NhZ2VfaXRlcl9nZXRfYXJnX3R5cGUo
JmFtcDt2YXIpICE9PGJyPgomZ3Q7wqAgwqAgwqBEQlVTX1RZUEVfU1RSSU5HKTxicj4KJmd0O8Kg
IMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zv
bm9fZXJyb3JfaW52YWxpZF9hcmdzKG1zZyk7PGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPgom
Z3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBkYnVzX21lc3NhZ2VfaXRlcl9n
ZXRfYmFzaWMoJmFtcDt2YXIsICZhbXA7c3RyKTs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+
CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChncHJzX3Byb3RvX2Zy
b21fc3RyaW5nKHN0ciwgJmFtcDtwcm90bykpPGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gbHRlX3NldF9wcm90byhsdGUsIGNvbm4s
IG1zZywgcHJvdG8pOzxicj4KJmd0OyA8YnI+CiZndDvCoCDCoCDCoFRoZSByZXR1cm4gZnJvbSB0
aGlzIGNhbGxiYWNrIGlzIGFsd2F5cyBzdXBwb3NlZCB0byBiZSBhIG1ldGhvZF9yZXR1cm48YnI+
CiZndDvCoCDCoCDCoG9yIE5VTEwgaWYgdGhlIG1ldGhvZF9yZXR1cm4gd2lsbCBiZSBkb25lIGFz
eW5jaHJvbm91c2x5IChpbiB5b3VyIGNhc2U8YnI+CiZndDvCoCDCoCDCoGFsd2F5cynCoCBZb3Um
IzM5O3JlIHNvbWVob3cgcmV0dXJuaW5nIHRoZSBtZXRob2RfY2FsbCBpdHNlbGYuLi48YnI+CiZn
dDsgPGJyPgomZ3Q7IDxicj4KJmd0OyBJIGFtIG5vdCBzdXJlIEkgZm9sbG93IHlvdSwgYnV0IHlv
dSBzdWdnZXN0ZWQgdG8gcmVzdHJ1Y3R1cmUgdGhlIGNvZGUsIDxicj4KJmd0OyBzbyBJIHdpbGwg
Y29tZSBiYWNrIG9uIHRoaXMgbGF0ZXIuPGJyPgo8YnI+CllvdSBuZWVkIHRvIHVuZGVyc3RhbmQg
dGhlIHNlbWFudGljcyBvZiBHREJ1cy7CoCBHREJVU19BU1lOQ19NRVRIT0QoKSA8YnI+CmNhbGxi
YWNrIGNhbiBvbmx5IHJldHVybiB0aGUgRC1CdXMgbWV0aG9kX3JldHVybiBmb3IgbWVzc2FnZSBv
ciBOVUxMIGlmIDxicj4KdGhlIG1ldGhvZCByZXR1cm4gd2lsbCBiZSBnZW5lcmF0ZWQgYXN5bmNo
cm9ub3VzbHkuwqAgWW91IGNhbm5vdCByZXR1cm4gPGJyPgp0aGUgbWVzc2FnZSBpdHNlbGYuwqAg
V2hpbGUgdGhpcyBtYXkgJiMzOTt3b3JrJiMzOTsgdGhlIGJlaGF2aW9yIGlzIHVuZGVmaW5lZC48
YnI+Cjxicj4KJmd0O8KgIMKgIMKgICZndDsgK3N0cnVjdCBvZm9ub19tb2RlbSAqb2Zvbm9fbHRl
X2dldF9tb2RlbShjb25zdCBzdHJ1Y3Qgb2Zvbm9fbHRlICpsdGUpPGJyPgomZ3Q7wqAgwqAgwqAg
Jmd0OyArezxicj4KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fYXRv
bV9nZXRfbW9kZW0obHRlLSZndDthdG9tKTs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICt9PGJyPgom
Z3Q7wqAgwqAgwqAgJmd0OyBcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGU8YnI+CiZndDsgPGJy
PgomZ3Q7wqAgwqAgwqBGaXggdGhpcy48YnI+CiZndDsgPGJyPgomZ3Q7IDxicj4KJmd0OyA/PGJy
Pgo8YnI+CllvdSBoYXZlIG5vIG5ld2xpbmUgYWZ0ZXIgdGhlIGxhc3QgJiMzOTt9JiMzOTsgYW5k
IGdpdCBjb21wbGFpbnMuwqAgSWYgZ2l0IDxicj4KY29tcGxhaW5zIEkgY2Fubm90IGFwcGx5IHRo
ZSBwYXRjaC4uLjxicj4KPGJyPgomZ3Q7IDxicj4KJmd0OyBJIGFncmVlIGl0IGlzIHVucmVsYXRl
ZCwgSSB3aWxsIHBvc3QgYSBzZXBhcmF0ZSBwb3N0LCBidXQgSSB0dXJuIG9uIDxicj4KJmd0OyBO
RUVEX1RIUkVBRFMsIGFuZCB0aGUgYnVpbGQgZmFpbHMuIExvb2tpbmcgYXQgdGhlIGdfdGhyZWFk
IDxicj4KJmd0OyBkb2N1bWVudGF0aW9ucywgbm93YWRheXMgaXQgaGFzIHRvIGNvbWUgb3V0IG9m
IHRoZSBjb2RlOjxicj4KJmd0OyA8YnI+CiZndDsgfGdfdGhyZWFkX2luaXR8wqBoYXMgYmVlbiBk
ZXByZWNhdGVkIHNpbmNlIHZlcnNpb24gMi4zMiBhbmQgc2hvdWxkIG5vdCBiZSA8YnI+CiZndDsg
dXNlZCBpbiBuZXdseS13cml0dGVuIGNvZGUuPGJyPgomZ3Q7IDxicj4KJmd0OyBUaGlzIGZ1bmN0
aW9uIGlzIG5vIGxvbmdlciBuZWNlc3NhcnkuIFRoZSBHTGliIHRocmVhZGluZyBzeXN0ZW0gaXMg
PGJyPgomZ3Q7IGF1dG9tYXRpY2FsbHkgaW5pdGlhbGl6ZWQgYXQgdGhlIHN0YXJ0IG9mIHlvdXIg
cHJvZ3JhbS48YnI+CiZndDsgPGJyPgo8YnI+Ck9rYXksIHBsZWFzZSBzZW5kIHRoaXMgYXMgYSBz
ZXBhcmF0ZSBwYXRjaC7CoCBXZSBtaWdodCBuZWVkIHRvIHJlbW92ZSA8YnI+CnRoaXMgY29uZmln
dXJlIG9wdGlvbiBhcyB3ZWxsLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Js
b2NrcXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============8252103092152209380==--


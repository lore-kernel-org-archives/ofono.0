Content-Type: multipart/mixed; boundary="===============5716763028968884905=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [RFC] GPRS context setup and teardown
 (doc/dataconnectionmanager-api.txt)
Date: Sat, 24 Oct 2009 10:04:19 +0200
Message-ID: <fb249edb0910240104x3d994b16u39d8277a0c9a997e@mail.gmail.com>
In-Reply-To: <200910231722.29794.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5716763028968884905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2009/10/24 Denis Kenzior <denkenz@gmail.com>:
> Ok, so I took the patch and hacked on it for a while. =C2=A0I disagreed w=
ith how
> you split up responsibilities, so much of the logic got moved into the co=
re
> and the driver was simplified.

Yes, there were a couple of possible choices, I chose to align with
how the list of voice calls was managed in voicecall.c .

>
> I also decided to split up GPRS into two atoms to ease integration of har=
dware
> that supports dedicated network interfaces. =C2=A0This way the attach / G=
PRS
> network registration parameters can be reused from the generic 'atmodem'
> driver, while specific context handling can be customized.

That's a good idea.

>
> I'm happy to report that this actually sort of works with my MBM card. =
=C2=A0I can
> even define a GPRS context and activate it. =C2=A0Of course the card cras=
hes as soon
> as I do :)

I'm happy to report it still works on my Nokia phone, too, except for
one test: when you have active contexts and either tell ofono to power
gprs down or are detached by the network for whatever reason,
".active" is never reset and no event emitted, meaning that you can't
remove the context, can't re-activate it or deactivate it.

>
> Some parts I still don't understand:
>
> in set_registration_status:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0attached =3D (status !=3D NETWORK_REGISTRATION=
_STATUS_REGISTERED &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0status !=3D NETWORK_REGISTRATION_STATUS_ROAMING);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gprs->attached !=3D (int) attached &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0!(gprs->flags & GPRS_FLAG_ATTACHING)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gprs->attached =3D=
 (int) attached;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_dbus_signal_=
property_changed(conn, path,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DATA_CONNECTION_MANAGER_INTERFACE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Attached", DBUS_TYPE_BOOLEAN,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&attached);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gprs_netreg_update=
(gprs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> I do not understand this logic at all. =C2=A0Can't we always call
> gprs_netreg_update here?

Sure, but it won't do anything, if either "attached" state hasn't
changed at all or it's already busy executing +CGATT.

> In my opinion Attached should only be emitted once
> it really has changed (e.g. in the callback)

Often there's no other notification telling us that we were detached,
so we must take any sign of it into account (it might be broken modems
but I've seen such situations on both modems that I've tested it with)

>
> gprs_netreg_update:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Prevent further=
 attempts to attach */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!attach && gpr=
s->powered) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0gprs->powered =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0path =3D __ofono_atom_get_path(gprs->atom);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ofono_dbus_signal_property_changed(conn, path,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DATA_CONN=
ECTION_MANAGER_INTERFACE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Powered"=
, DBUS_TYPE_BOOLEAN, &value);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> This is just too evil. =C2=A0Can't we set another flag that attached cond=
itions have
> changed while we were attaching/detaching and that we should recheck those
> conditions when we return from attach/detach?

Is it evil because we change a property that is writable?

This is only for the case of RoamingAllowed =3D 0.  In my understanding
"Powered" being set means that we're attached or attempting to attach,
which is not the case after we detached because of roaming, so the
D-Bus client would be misled.

>
> In gprs_set_property:
>
> You should really ignore set property requests that set the value to the
> already set value. =C2=A0Simply return success and don't do anything else.

Good point, the attached patch checks for those cases.

Best regards

--===============5716763028968884905==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Just-return-success-when-value-already-set-in-SetPro.patch"

RnJvbSA2ZDQ0MzlmYzcwMWNhNDlhZDg4MTQ5ODMzYWMyZjRiNmQ2OGJhNGYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogU2F0LCAyNCBPY3QgMjAwOSAxMToyNzoyMyArMDIwMApTdWJqZWN0
OiBbUEFUQ0ggMS8yXSBKdXN0IHJldHVybiBzdWNjZXNzIHdoZW4gdmFsdWUgYWxyZWFkeSBzZXQg
aW4gU2V0UHJvcGVydHkuCgotLS0KIHNyYy9ncHJzLmMgfCAgICA2ICsrKysrKwogMSBmaWxlcyBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3Jj
L2dwcnMuYyBiL3NyYy9ncHJzLmMKaW5kZXggZmIwOGQ5YS4uMTgyN2NlYiAxMDA2NDQKLS0tIGEv
c3JjL2dwcnMuYworKysgYi9zcmMvZ3Bycy5jCkBAIC02NjEsNiArNjYxLDkgQEAgc3RhdGljIERC
dXNNZXNzYWdlICpncHJzX3NldF9wcm9wZXJ0eShEQnVzQ29ubmVjdGlvbiAqY29ubiwKIAogCQlk
YnVzX21lc3NhZ2VfaXRlcl9nZXRfYmFzaWMoJnZhciwgJnZhbHVlKTsKIAorCQlpZiAoZ3Bycy0+
cm9hbWluZ19hbGxvd2VkID09IChvZm9ub19ib29sX3QpIHZhbHVlKQorCQkJcmV0dXJuIGRidXNf
bWVzc2FnZV9uZXdfbWV0aG9kX3JldHVybihtc2cpOworCiAJCWdwcnMtPnJvYW1pbmdfYWxsb3dl
ZCA9IHZhbHVlOwogCQlncHJzX25ldHJlZ191cGRhdGUoZ3Bycyk7CiAJfSBlbHNlIGlmICghc3Ry
Y21wKHByb3BlcnR5LCAiUG93ZXJlZCIpKSB7CkBAIC02NzIsNiArNjc1LDkgQEAgc3RhdGljIERC
dXNNZXNzYWdlICpncHJzX3NldF9wcm9wZXJ0eShEQnVzQ29ubmVjdGlvbiAqY29ubiwKIAogCQlk
YnVzX21lc3NhZ2VfaXRlcl9nZXRfYmFzaWMoJnZhciwgJnZhbHVlKTsKIAorCQlpZiAoZ3Bycy0+
cG93ZXJlZCA9PSAob2Zvbm9fYm9vbF90KSB2YWx1ZSkKKwkJCXJldHVybiBkYnVzX21lc3NhZ2Vf
bmV3X21ldGhvZF9yZXR1cm4obXNnKTsKKwogCQlncHJzLT5wb3dlcmVkID0gdmFsdWU7CiAJCWdw
cnNfbmV0cmVnX3VwZGF0ZShncHJzKTsKIAl9IGVsc2UKLS0gCjEuNi4xCgo=

--===============5716763028968884905==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-Register-gprs-context-on-calypso-modem-phonesim.patch"

RnJvbSBlOTQ5OGQwNzBmMzU5M2MxZWY1YzI3YjkxZjU5Y2E4ZTJiZTk3MWFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogU2F0LCAyNCBPY3QgMjAwOSAxMToyODowNyArMDIwMApTdWJqZWN0
OiBbUEFUQ0ggMi8yXSBSZWdpc3RlciBncHJzLWNvbnRleHQgb24gY2FseXBzbyBtb2RlbS9waG9u
ZXNpbS4KCi0tLQogcGx1Z2lucy9waG9uZXNpbS5jIHwgICAgOSArKysrKysrKy0KIDEgZmlsZXMg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Bs
dWdpbnMvcGhvbmVzaW0uYyBiL3BsdWdpbnMvcGhvbmVzaW0uYwppbmRleCAxMTUxZGE0Li45NDYz
MjY1IDEwMDY0NAotLS0gYS9wbHVnaW5zL3Bob25lc2ltLmMKKysrIGIvcGx1Z2lucy9waG9uZXNp
bS5jCkBAIC01NSw2ICs1NSw3IEBACiAjaW5jbHVkZSA8b2Zvbm8vdXNzZC5oPgogI2luY2x1ZGUg
PG9mb25vL3ZvaWNlY2FsbC5oPgogI2luY2x1ZGUgPG9mb25vL2dwcnMuaD4KKyNpbmNsdWRlIDxv
Zm9uby9ncHJzLWNvbnRleHQuaD4KIAogI2luY2x1ZGUgPGRyaXZlcnMvYXRtb2RlbS92ZW5kb3Iu
aD4KIApAQCAtMjg5LDYgKzI5MCw4IEBAIHN0YXRpYyB2b2lkIHBob25lc2ltX3Bvc3Rfc2ltKHN0
cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pCiB7CiAJc3RydWN0IHBob25lc2ltX2RhdGEgKmRhdGEg
PSBvZm9ub19tb2RlbV9nZXRfZGF0YShtb2RlbSk7CiAJc3RydWN0IG9mb25vX21lc3NhZ2Vfd2Fp
dGluZyAqbXc7CisJc3RydWN0IG9mb25vX2dwcnMgKmdwcnM7CisJc3RydWN0IG9mb25vX2dwcnNf
Y29udGV4dCAqZ2M7CiAKIAlEQkcoIiVwIiwgbW9kZW0pOwogCkBAIC0zMTMsNyArMzE2LDExIEBA
IHN0YXRpYyB2b2lkIHBob25lc2ltX3Bvc3Rfc2ltKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0p
CiAJCW9mb25vX2Nic19jcmVhdGUobW9kZW0sIDAsICJhdG1vZGVtIiwgZGF0YS0+Y2hhdCk7CiAJ
fQogCi0Jb2Zvbm9fZ3Byc19jcmVhdGUobW9kZW0sIDAsICJhdG1vZGVtIiwgZGF0YS0+Y2hhdCk7
CisJZ3BycyA9IG9mb25vX2dwcnNfY3JlYXRlKG1vZGVtLCAwLCAiYXRtb2RlbSIsIGRhdGEtPmNo
YXQpOworCWdjID0gb2Zvbm9fZ3Byc19jb250ZXh0X2NyZWF0ZShtb2RlbSwgMCwgImF0bW9kZW0i
LCBkYXRhLT5jaGF0KTsKKworCWlmIChncHJzICYmIGdjKQorCQlvZm9ub19ncHJzX2FkZF9jb250
ZXh0KGdwcnMsIGdjKTsKIAogCW13ID0gb2Zvbm9fbWVzc2FnZV93YWl0aW5nX2NyZWF0ZShtb2Rl
bSk7CiAJaWYgKG13KQotLSAKMS42LjEKCg==

--===============5716763028968884905==--


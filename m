Content-Type: multipart/mixed; boundary="===============6768429163146424159=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH] Add call-volume interface to allow user adjust speaker
 and mic volume
Date: Sun, 27 Sep 2009 16:19:45 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089B65947F@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <1253886095.2931.42.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6768429163146424159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Marcel Holtmann wrote:
> Hi Zhenhua,
> =

>> +#define CALL_VOLUME_INTERFACE "org.ofono.CallVolume"
> =

> we have to stop doing this. Start using this:
> =

> #define FOO_INTERFACE  OFONO_SERVICE ".FooInterface"
> =

>> +static void call_volume_unregister(struct ofono_atom *atom);
> =

> That forward declaration seems pointless unless I actually missed
> something. No forward declaration unless they are really needed. Just
> shuffle the code around.
> =

> Coding style. Actually twice. No space behind if and single if
> statements need no { }.
> =

>> +
>> +       if (!strcmp(property, "MicrophoneVolume")) {
>> +               cv->microphone_volume =3D percent;
>> +       }
> =

> No  { } needed.
> =

> What is this variable non-sense for. You can use cv->speaker_volume
> directly from D-Bus message append functions. Only for certain strings
> you need this.
> =

>> +
>> +       if (cv->pending)
>> +               return __ofono_error_busy(msg);
>> +
>> +       cv->pending =3D dbus_message_ref(msg);
>> +
>> +       reply =3D dbus_message_new_method_return(cv->pending); +
>> +       if (!reply)
>> +               return NULL;
> =

> What is this empty line for? Just don't do that. The error check
> logically belongs to the function creating reply.
> =

> Also who unrefs cv->pending in this case?
> =

>> +       dbus_message_iter_init_append(reply, &iter); +
>> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
>> +                                      =

>> OFONO_PROPERTIES_ARRAY_SIGNATURE, +                                 =

>> &dict); +
>> +       ofono_dbus_dict_append(&dict, "SpeakerVolume",
>> DBUS_TYPE_UINT32, +                                      =

>> &speaker_volume); + +       ofono_dbus_dict_append(&dict,
>> "MicrophoneVolume", +                                      =

>> DBUS_TYPE_UINT32, &microphone_volume); =

> =

> Why do we use UINT32 for percentage values? A BYTE would be clearly
> enough.
> =

>> +static void mv_set_callback(const struct ofono_error *error, void
>> *data) +{ +       struct ofono_call_volume *cv =3D data;
>> +
>> +       if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>> +               ofono_debug("Error occurred during Microphone Volume
>> set: %s", +                                              =

>> telephony_error_to_str(error)); +       } else { +              =

>> cv->microphone_volume =3D cv->temp_volume; +       } +
>> +       generic_callback(error, data);
>> +}
> =

> So personally I think the ofono_debug() call makes these two function
> hard to read and more complicated than needed. If we really want to
> display this error then either use ofono_error() or just don't bother
> at all with any kind of output.
> =

>> +static DBusMessage *cv_set_call_volume(DBusMessage *msg, struct
>> ofono_call_volume *cv, +                                       =

>> const char *property, unsigned int percent) +{ +       if (percent >
>> 100) +               return __ofono_error_invalid_format(msg); +
>> +       DBG("set %s volume to %d percent", property, percent); +
>> +       cv->flags |=3D CALL_VOLUME_FLAG_PENDING;
>> +       cv->temp_volume =3D percent;
>> +
>> +       if (msg)
>> +               cv->pending =3D dbus_message_ref(msg); +
>> +       if(!strcmp(property, "SpeakerVolume")) {
>> +               if (!cv->driver->speaker_volume) {
>> +                       return (msg !=3D
>> NULL)?__ofono_error_not_implemented(msg):NULL; +               } +  =

>> cv->driver->speaker_volume(cv, percent, sv_set_callback, cv); +     =

>> } =

> =

> So the space after if is missing again. And this return statement is
> not readable at all. It violates coding style and makes my brain
> hurt. Redo this it becomes readable. Cramping everything in one line
> is just no helpful.
> =

>> +static GDBusMethodTable cv_methods[] =3D {
>> +       { "GetProperties",      "",     "a{sv}",       =

>> cv_get_properties, +                                                =

>> G_DBUS_METHOD_FLAG_ASYNC}, +       { "SetProperty",        "sv",  =

>> "",             cv_set_property, +                                  =

>> G_DBUS_METHOD_FLAG_ASYNC }, +       { } +};
> =

> I am missing the point why GetProperties has to be done async. That
> looks like too much overhead for something just returning stored
> values. =

> =

>> +
>> +       if (driver =3D=3D NULL)
>> +               return NULL;
>> +
>> +       cv =3D g_try_new0(struct ofono_call_volume, 1);
>> +       cv->speaker_volume =3D 100;
>> +       cv->microphone_volume =3D 100;
>> +
>> +       if (cv =3D=3D NULL)
>> +               return NULL;
> =

> How do you expect this to work actually? If cv =3D=3D NULL, then your
> assignment are NULL pointer dereferences and the daemon will crash.
> Your error handling is not protecting it.
> =

>> +int ofono_call_volume_driver_register(const struct
>> ofono_call_volume_driver *d) +{ +       DBG("driver: %p, name: %s",
>> d, d->name); +
>> +       if (d->probe =3D=3D NULL)
>> +               return -EINVAL;
>> +
>> +       g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
> =

> I really hate these casts only because of const driver declaration.
> =

> Personally I am against it, but I see some value behind having this
> const. However there has to be a space between the cast and the
> variable.
> =

>> +
>> +       return 0;
>> +}
>> +
>> +void ofono_call_volume_driver_unregister(const struct
>> ofono_call_volume_driver *d) +{ +       DBG("driver: %p, name: %s",
>> d, d->name); +
>> +       g_drivers =3D g_slist_remove(g_drivers, (void *)d);
>> +}
> =

> See comment above.
> =


Thank you for your valuable comments. The new patch fixed the code style
problem and I want to highlight some points here:

1. SpeakerVolume and MicrophoneVolume changes from DBUS_TYPE_UINT32 to
DBUS_TYPE_BYTE. The internal presentation is 'unsigned char' now.

2. In ofono_call_volume_create(), the initial speaker_volume and =

microphone_volume set to 50% instead of 100%. Each driver is responsible to =

probe modem and get the volume from mobile. Then it should use =

ofono_call_volume_notify() to overwrite default values.

3. However, in HFP spec v1.5, it's alway use HF side volume value to sync w=
ith
AG volume by using +VGS=3D, +VGM=3D. I don't see the AT command to query mo=
bile
volume from the HF side. I expose ofono_set_call_volume() to lower driver t=
o allow =

HFP driver sync volume with AG in the probe stage.

Please review it.

> =

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
Zhenhua

--===============6768429163146424159==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-Add-call-volume-interface-to-adjust-speaker-and-mic.patch"

RnJvbSA3OTA4MThiMTQ3MGM4ZjE4ZDM5MjAzZmNjMjExOTA1ZTYzMzY3YzIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGVuaHVhIFpoYW5nIDx6aGVuaHVhLnpoYW5nQGludGVsLmNv
bT4KRGF0ZTogU2F0LCAyNiBTZXAgMjAwOSAyMzoyNzoyNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IEFkZCBjYWxsIHZvbHVtZSBpbnRlcmZhY2UgdG8gYWRqdXN0IHNwZWFrZXIgYW5kIG1pYyB2b2x1
bWUKCi0tLQogTWFrZWZpbGUuYW0gICAgICAgICAgIHwgICAgNCArLQogaW5jbHVkZS9jYWxsLXZv
bHVtZS5oIHwgICA3NCArKysrKysrKysrCiBzcmMvY2FsbC12b2x1bWUuYyAgICAgfCAgMzY2ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHNyYy9vZm9u
by5oICAgICAgICAgICB8ICAgIDEgKwogNCBmaWxlcyBjaGFuZ2VkLCA0NDMgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2NhbGwtdm9sdW1l
LmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzcmMvY2FsbC12b2x1bWUuYwoKZGlmZiAtLWdpdCBhL01h
a2VmaWxlLmFtIGIvTWFrZWZpbGUuYW0KaW5kZXggNTVjZWRkOC4uYWI2YzNiYSAxMDA2NDQKLS0t
IGEvTWFrZWZpbGUuYW0KKysrIGIvTWFrZWZpbGUuYW0KQEAgLTEwLDcgKzEwLDcgQEAgaW5jbHVk
ZV9IRUFERVJTID0gaW5jbHVkZS9sb2cuaCBpbmNsdWRlL3BsdWdpbi5oIGluY2x1ZGUvaGlzdG9y
eS5oIFwKIAkJCWluY2x1ZGUvcGhvbmVib29rLmggaW5jbHVkZS9zc24uaCBpbmNsdWRlL3Vzc2Qu
aCBcCiAJCQlpbmNsdWRlL3Ntcy5oIGluY2x1ZGUvc2ltLmggaW5jbHVkZS9tZXNzYWdlLXdhaXRp
bmcuaCBcCiAJCQlpbmNsdWRlL25ldHJlZy5oIGluY2x1ZGUvdm9pY2VjYWxsLmggaW5jbHVkZS9k
ZXZpbmZvLmggXAotCQkJaW5jbHVkZS9jYnMuaAorCQkJaW5jbHVkZS9jYnMuaCBpbmNsdWRlL2Nh
bGwtdm9sdW1lLmgKIAogbm9kaXN0X2luY2x1ZGVfSEVBREVSUyA9IGluY2x1ZGUvdmVyc2lvbi5o
CiAKQEAgLTE2Myw3ICsxNjMsNyBAQCBzcmNfb2Zvbm9kX1NPVVJDRVMgPSAkKGdkYnVzX3NvdXJj
ZXMpICQoYnVpbHRpbl9zb3VyY2VzKSBcCiAJCQlzcmMvc3NuLmMgc3JjL2NhbGwtYmFycmluZy5j
IHNyYy9zaW0uYyBcCiAJCQlzcmMvcGhvbmVib29rLmMgc3JjL2hpc3RvcnkuYyBzcmMvbWVzc2Fn
ZS13YWl0aW5nLmMgXAogCQkJc3JjL3NpbXV0aWwuaCBzcmMvc2ltdXRpbC5jIHNyYy9zdG9yYWdl
LmggXAotCQkJc3JjL3N0b3JhZ2UuYyBzcmMvY2JzLmMgc3JjL3dhdGNoLmMKKwkJCXNyYy9zdG9y
YWdlLmMgc3JjL2Nicy5jIHNyYy93YXRjaC5jIHNyYy9jYWxsLXZvbHVtZS5jCiAKIHNyY19vZm9u
b2RfTERBREQgPSAkKGJ1aWx0aW5fbGliYWRkKSBcCiAJCQlAR0xJQl9MSUJTQCBAR1RIUkVBRF9M
SUJTQCBAREJVU19MSUJTQCAtbGRsCmRpZmYgLS1naXQgYS9pbmNsdWRlL2NhbGwtdm9sdW1lLmgg
Yi9pbmNsdWRlL2NhbGwtdm9sdW1lLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MC4uYmEyNzU4ZgotLS0gL2Rldi9udWxsCisrKyBiL2luY2x1ZGUvY2FsbC12b2x1bWUuaApAQCAt
MCwwICsxLDc0IEBACisvKgorICoKKyAqICBvRm9ubyAtIE9wZW4gU291cmNlIFRlbGVwaG9ueQor
ICoKKyAqICBDb3B5cmlnaHQgKEMpIDIwMDgtMjAwOSAgSW50ZWwgQ29ycG9yYXRpb24uIEFsbCBy
aWdodHMgcmVzZXJ2ZWQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5
b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRl
cm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqICBw
dWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiAgVGhpcyBw
cm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWws
CisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQg
d2FycmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNV
TEFSIFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9y
IG1vcmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBv
ZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJv
Z3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQorICogIEZvdW5kYXRpb24s
IEluYy4sIDUxIEZyYW5rbGluIFN0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAgMDIxMTAtMTMw
MSAgVVNBCisgKgorICovCisKKyNpZm5kZWYgX19PRk9OT19DQUxMX1ZPTFVNRV9ICisjZGVmaW5l
IF9fT0ZPTk9fQ0FMTF9WT0xVTUVfSAorCisjaWZkZWYgX19jcGx1c3BsdXMKK2V4dGVybiAiQyIg
eworI2VuZGlmCisKKyNpbmNsdWRlIDxvZm9uby90eXBlcy5oPgorI2luY2x1ZGUgPG9mb25vL2Ri
dXMuaD4KKworc3RydWN0IG9mb25vX2NhbGxfdm9sdW1lOworCit0eXBlZGVmIHZvaWQgKCpvZm9u
b19jYWxsX3ZvbHVtZV9jYl90KShjb25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLAorCQkJ
CQl2b2lkICpkYXRhKTsKKworc3RydWN0IG9mb25vX2NhbGxfdm9sdW1lX2RyaXZlciB7CisJY29u
c3QgY2hhciAqbmFtZTsKKwlpbnQgKCpwcm9iZSkoc3RydWN0IG9mb25vX2NhbGxfdm9sdW1lICpj
diwgdW5zaWduZWQgaW50IHZlbmRvciwKKwkJCXZvaWQgKmRhdGEpOworCXZvaWQgKCpyZW1vdmUp
KHN0cnVjdCBvZm9ub19jYWxsX3ZvbHVtZSAqY3YpOworCXZvaWQgKCpzcGVha2VyX3ZvbHVtZSko
c3RydWN0IG9mb25vX2NhbGxfdm9sdW1lICpjdiwKKwkJCXVuc2lnbmVkIGNoYXIgcGVyY2VudCwK
KwkJCW9mb25vX2NhbGxfdm9sdW1lX2NiX3QgY2IsIHZvaWQgKmRhdGEpOworCXZvaWQgKCptaWNy
b3Bob25lX3ZvbHVtZSkoc3RydWN0IG9mb25vX2NhbGxfdm9sdW1lICpjdiwKKwkJCXVuc2lnbmVk
IGNoYXIgcGVyY2VudCwKKwkJCW9mb25vX2NhbGxfdm9sdW1lX2NiX3QgY2IsIHZvaWQgKmRhdGEp
OworfTsKKwordm9pZCBvZm9ub19jYWxsX3ZvbHVtZV9ub3RpZnkoc3RydWN0IG9mb25vX2NhbGxf
dm9sdW1lICpjdiwKKwkJCWNvbnN0IGNoYXIgKnByb3BlcnR5LCB1bnNpZ25lZCBjaGFyIHBlcmNl
bnQpOworREJ1c01lc3NhZ2UgKm9mb25vX3NldF9jYWxsX3ZvbHVtZShEQnVzTWVzc2FnZSAqbXNn
LAorCQkJc3RydWN0IG9mb25vX2NhbGxfdm9sdW1lICpjdiwKKwkJCWNvbnN0IGNoYXIgKnByb3Bl
cnR5LAorCQkJdW5zaWduZWQgY2hhciBwZXJjZW50KTsKKworaW50IG9mb25vX2NhbGxfdm9sdW1l
X2RyaXZlcl9yZWdpc3Rlcihjb25zdCBzdHJ1Y3Qgb2Zvbm9fY2FsbF92b2x1bWVfZHJpdmVyICpk
KTsKK3ZvaWQgb2Zvbm9fY2FsbF92b2x1bWVfZHJpdmVyX3VucmVnaXN0ZXIoCisJCQljb25zdCBz
dHJ1Y3Qgb2Zvbm9fY2FsbF92b2x1bWVfZHJpdmVyICpkKTsKKworc3RydWN0IG9mb25vX2NhbGxf
dm9sdW1lICpvZm9ub19jYWxsX3ZvbHVtZV9jcmVhdGUoc3RydWN0IG9mb25vX21vZGVtICptb2Rl
bSwKKwkJCXVuc2lnbmVkIGludCB2ZW5kb3IsIGNvbnN0IGNoYXIgKmRyaXZlciwgdm9pZCAqZGF0
YSk7CisKK3ZvaWQgb2Zvbm9fY2FsbF92b2x1bWVfcmVnaXN0ZXIoc3RydWN0IG9mb25vX2NhbGxf
dm9sdW1lICpjdik7Cit2b2lkIG9mb25vX2NhbGxfdm9sdW1lX3JlbW92ZShzdHJ1Y3Qgb2Zvbm9f
Y2FsbF92b2x1bWUgKmN2KTsKKwordm9pZCBvZm9ub19jYWxsX3ZvbHVtZV9zZXRfZGF0YShzdHJ1
Y3Qgb2Zvbm9fY2FsbF92b2x1bWUgKmN2LCB2b2lkICpkYXRhKTsKK3ZvaWQgKm9mb25vX2NhbGxf
dm9sdW1lX2dldF9kYXRhKHN0cnVjdCBvZm9ub19jYWxsX3ZvbHVtZSAqY3YpOworCisjaWZkZWYg
X19jcGx1c3BsdXMKK30KKyNlbmRpZgorCisjZW5kaWYgLyogX19PRk9OT19DQUxMX1ZPTFVNRV9I
ICovCmRpZmYgLS1naXQgYS9zcmMvY2FsbC12b2x1bWUuYyBiL3NyYy9jYWxsLXZvbHVtZS5jCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjlhY2VlMmIKLS0tIC9kZXYvbnVsbAor
KysgYi9zcmMvY2FsbC12b2x1bWUuYwpAQCAtMCwwICsxLDM2NiBAQAorLyoKKyAqCisgKiAgb0Zv
bm8gLSBPcGVuIFNvdXJjZSBUZWxlcGhvbnkKKyAqCisgKiAgQ29weXJpZ2h0IChDKSAyMDA4LTIw
MDkgIEludGVsIENvcnBvcmF0aW9uLiBBbGwgcmlnaHRzIHJlc2VydmVkLgorICoKKyAqICBUaGlz
IHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29y
IG1vZGlmeQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgdmVyc2lvbiAyIGFzCisgKiAgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJl
IEZvdW5kYXRpb24uCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUg
aG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5U
WTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklM
SVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBz
aG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlCisgKiAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZy
ZWUgU29mdHdhcmUKKyAqICBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdCwgRmlmdGgg
Rmxvb3IsIEJvc3RvbiwgTUEgIDAyMTEwLTEzMDEgIFVTQQorICoKKyAqLworCisjaWZkZWYgSEFW
RV9DT05GSUdfSAorI2luY2x1ZGUgPGNvbmZpZy5oPgorI2VuZGlmCisKKyNkZWZpbmUgX0dOVV9T
T1VSQ0UKKyNpbmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlIDxzdGRsaWIuaD4KKyNpbmNsdWRl
IDxzdGRpby5oPgorI2luY2x1ZGUgPGVycm5vLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisKKyNp
bmNsdWRlIDxnbGliLmg+CisKKyNpbmNsdWRlIDxvZm9uby9sb2cuaD4KKyNpbmNsdWRlIDxvZm9u
by9tb2RlbS5oPgorI2luY2x1ZGUgPG9mb25vL2NhbGwtdm9sdW1lLmg+CisKKyNpbmNsdWRlIDxn
ZGJ1cy5oPgorI2luY2x1ZGUgIm9mb25vLmgiCisjaW5jbHVkZSAiY29tbW9uLmgiCisKKyNkZWZp
bmUgQ0FMTF9WT0xVTUVfSU5URVJGQUNFIE9GT05PX1NFUlZJQ0UgIi5DYWxsVm9sdW1lIgorCisj
ZGVmaW5lIENBTExfVk9MVU1FX0ZMQUdfUEVORElORyAweDEKKworc3RhdGljIEdTTGlzdCAqZ19k
cml2ZXJzID0gTlVMTDsKKworc3RydWN0IG9mb25vX2NhbGxfdm9sdW1lIHsKKwlEQnVzTWVzc2Fn
ZSAqcGVuZGluZzsKKwljb25zdCBzdHJ1Y3Qgb2Zvbm9fY2FsbF92b2x1bWVfZHJpdmVyICpkcml2
ZXI7CisJaW50IGZsYWdzOworCXZvaWQgKmRyaXZlcl9kYXRhOworCXN0cnVjdCBvZm9ub19hdG9t
ICphdG9tOworCisJdW5zaWduZWQgY2hhciBzcGVha2VyX3ZvbHVtZTsKKwl1bnNpZ25lZCBjaGFy
IG1pY3JvcGhvbmVfdm9sdW1lOworCisJLyogdGVtcCB2b2x1bWUgYmVmb3JlIGl0IGlzIGFjY2Vw
dGVkIGJ5IHJlbW90ZSAqLworCXVuc2lnbmVkIGNoYXIgdGVtcF92b2x1bWU7Cit9OworCit2b2lk
IG9mb25vX2NhbGxfdm9sdW1lX25vdGlmeShzdHJ1Y3Qgb2Zvbm9fY2FsbF92b2x1bWUgKmN2LAor
CQkJCQkJY29uc3QgY2hhciAqcHJvcGVydHksCisJCQkJCQl1bnNpZ25lZCBjaGFyIHBlcmNlbnQp
Cit7CisJREJ1c0Nvbm5lY3Rpb24gKmNvbm4gPSBvZm9ub19kYnVzX2dldF9jb25uZWN0aW9uKCk7
CisJY29uc3QgY2hhciAqcGF0aCA9IF9fb2Zvbm9fYXRvbV9nZXRfcGF0aChjdi0+YXRvbSk7CisK
KwlpZiAoIXN0cmNtcChwcm9wZXJ0eSwgIlNwZWFrZXJWb2x1bWUiKSkKKwkJY3YtPnNwZWFrZXJf
dm9sdW1lID0gcGVyY2VudDsKKworCWlmICghc3RyY21wKHByb3BlcnR5LCAiTWljcm9waG9uZVZv
bHVtZSIpKQorCQljdi0+bWljcm9waG9uZV92b2x1bWUgPSBwZXJjZW50OworCisJb2Zvbm9fZGJ1
c19zaWduYWxfcHJvcGVydHlfY2hhbmdlZChjb25uLCBwYXRoLCBDQUxMX1ZPTFVNRV9JTlRFUkZB
Q0UsCisJCQkJCXByb3BlcnR5LCBEQlVTX1RZUEVfQllURSwKKwkJCQkJJnBlcmNlbnQpOworfQor
CitzdGF0aWMgREJ1c01lc3NhZ2UgKmN2X2dldF9wcm9wZXJ0aWVzKERCdXNDb25uZWN0aW9uICpj
b25uLAorCQkJCQkJREJ1c01lc3NhZ2UgKm1zZywgdm9pZCAqZGF0YSkKK3sKKwlzdHJ1Y3Qgb2Zv
bm9fY2FsbF92b2x1bWUgKmN2ID0gZGF0YTsKKwlEQnVzTWVzc2FnZSAqcmVwbHk7CisJREJ1c01l
c3NhZ2VJdGVyIGl0ZXIsIGRpY3Q7CisKKwlyZXBseSA9IGRidXNfbWVzc2FnZV9uZXdfbWV0aG9k
X3JldHVybihtc2cpOworCisJaWYgKCFyZXBseSkKKwkJcmV0dXJuIE5VTEw7CisKKwlkYnVzX21l
c3NhZ2VfaXRlcl9pbml0X2FwcGVuZChyZXBseSwgJml0ZXIpOworCisJZGJ1c19tZXNzYWdlX2l0
ZXJfb3Blbl9jb250YWluZXIoJml0ZXIsIERCVVNfVFlQRV9BUlJBWSwKKwkJCQkJT0ZPTk9fUFJP
UEVSVElFU19BUlJBWV9TSUdOQVRVUkUsCisJCQkJCSZkaWN0KTsKKworCW9mb25vX2RidXNfZGlj
dF9hcHBlbmQoJmRpY3QsICJTcGVha2VyVm9sdW1lIiwgREJVU19UWVBFX0JZVEUsCisJCQkJCSZj
di0+c3BlYWtlcl92b2x1bWUpOworCisJb2Zvbm9fZGJ1c19kaWN0X2FwcGVuZCgmZGljdCwgIk1p
Y3JvcGhvbmVWb2x1bWUiLAorCQkJCQlEQlVTX1RZUEVfQllURSwgJmN2LT5taWNyb3Bob25lX3Zv
bHVtZSk7CisKKwlkYnVzX21lc3NhZ2VfaXRlcl9jbG9zZV9jb250YWluZXIoJml0ZXIsICZkaWN0
KTsKKworCXJldHVybiByZXBseTsKK30KKworc3RhdGljIHZvaWQgZ2VuZXJpY19jYWxsYmFjayhj
b25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLCB2b2lkICpkYXRhKQoreworCXN0cnVjdCBv
Zm9ub19jYWxsX3ZvbHVtZSAqY3YgPSBkYXRhOworCURCdXNDb25uZWN0aW9uICpjb25uID0gb2Zv
bm9fZGJ1c19nZXRfY29ubmVjdGlvbigpOworCURCdXNNZXNzYWdlICpyZXBseTsKKworCWN2LT5m
bGFncyAmPSB+Q0FMTF9WT0xVTUVfRkxBR19QRU5ESU5HOworCisJaWYgKCFjdi0+cGVuZGluZykK
KwkJcmV0dXJuOworCisJaWYgKGVycm9yLT50eXBlID09IE9GT05PX0VSUk9SX1RZUEVfTk9fRVJS
T1IpCisJCXJlcGx5ID0gZGJ1c19tZXNzYWdlX25ld19tZXRob2RfcmV0dXJuKGN2LT5wZW5kaW5n
KTsKKwllbHNlCisJCXJlcGx5ID0gX19vZm9ub19lcnJvcl9mYWlsZWQoY3YtPnBlbmRpbmcpOwor
CisJZ19kYnVzX3NlbmRfbWVzc2FnZShjb25uLCByZXBseSk7CisKKwlkYnVzX21lc3NhZ2VfdW5y
ZWYoY3YtPnBlbmRpbmcpOworCWN2LT5wZW5kaW5nID0gTlVMTDsKK30KKworc3RhdGljIHZvaWQg
c3Zfc2V0X2NhbGxiYWNrKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJyb3IsIHZvaWQgKmRh
dGEpCit7CisJc3RydWN0IG9mb25vX2NhbGxfdm9sdW1lICpjdiA9IGRhdGE7CisKKwlpZiAoZXJy
b3ItPnR5cGUgIT0gT0ZPTk9fRVJST1JfVFlQRV9OT19FUlJPUikgeworCQlvZm9ub19lcnJvcigi
RXJyb3Igb2NjdXJyZWQgZHVyaW5nIFNwZWFrZXIgVm9sdW1lIHNldDogJXMiLAorCQkJCQl0ZWxl
cGhvbnlfZXJyb3JfdG9fc3RyKGVycm9yKSk7CisJfSBlbHNlIHsKKwkJY3YtPnNwZWFrZXJfdm9s
dW1lID0gY3YtPnRlbXBfdm9sdW1lOworCX0KKworCWdlbmVyaWNfY2FsbGJhY2soZXJyb3IsIGRh
dGEpOworfQorCitzdGF0aWMgdm9pZCBtdl9zZXRfY2FsbGJhY2soY29uc3Qgc3RydWN0IG9mb25v
X2Vycm9yICplcnJvciwgdm9pZCAqZGF0YSkKK3sKKwlzdHJ1Y3Qgb2Zvbm9fY2FsbF92b2x1bWUg
KmN2ID0gZGF0YTsKKworCWlmIChlcnJvci0+dHlwZSAhPSBPRk9OT19FUlJPUl9UWVBFX05PX0VS
Uk9SKSB7CisJCW9mb25vX2Vycm9yKCJFcnJvciBvY2N1cnJlZCBkdXJpbmcgTWljcm9waG9uZSBW
b2x1bWUgc2V0OiAlcyIsCisJCQkJCXRlbGVwaG9ueV9lcnJvcl90b19zdHIoZXJyb3IpKTsKKwl9
IGVsc2UgeworCQljdi0+bWljcm9waG9uZV92b2x1bWUgPSBjdi0+dGVtcF92b2x1bWU7CisJfQor
CisJZ2VuZXJpY19jYWxsYmFjayhlcnJvciwgZGF0YSk7Cit9CisKK0RCdXNNZXNzYWdlICpvZm9u
b19zZXRfY2FsbF92b2x1bWUoREJ1c01lc3NhZ2UgKm1zZywKKwkJCQkJc3RydWN0IG9mb25vX2Nh
bGxfdm9sdW1lICpjdiwKKwkJCQkJY29uc3QgY2hhciAqcHJvcGVydHksCisJCQkJCXVuc2lnbmVk
IGNoYXIgcGVyY2VudCkKK3sKKwlpZiAocGVyY2VudCA+IDEwMCkKKwkJcmV0dXJuIF9fb2Zvbm9f
ZXJyb3JfaW52YWxpZF9mb3JtYXQobXNnKTsKKworCURCRygic2V0ICVzIHZvbHVtZSB0byAlZCBw
ZXJjZW50IiwgcHJvcGVydHksIHBlcmNlbnQpOworCisJY3YtPmZsYWdzIHw9IENBTExfVk9MVU1F
X0ZMQUdfUEVORElORzsKKwljdi0+dGVtcF92b2x1bWUgPSBwZXJjZW50OworCisJaWYgKG1zZykK
KwkJY3YtPnBlbmRpbmcgPSBkYnVzX21lc3NhZ2VfcmVmKG1zZyk7CisKKwlpZiAoIXN0cmNtcChw
cm9wZXJ0eSwgIlNwZWFrZXJWb2x1bWUiKSkgeworCQlpZiAoIWN2LT5kcml2ZXItPnNwZWFrZXJf
dm9sdW1lKSB7CisJCQlpZiAobXNnICE9IE5VTEwpCisJCQkJcmV0dXJuIF9fb2Zvbm9fZXJyb3Jf
bm90X2ltcGxlbWVudGVkKG1zZyk7CisJCQllbHNlCisJCQkJcmV0dXJuIE5VTEw7CisJCX0KKwkJ
Y3YtPmRyaXZlci0+c3BlYWtlcl92b2x1bWUoY3YsIHBlcmNlbnQsIHN2X3NldF9jYWxsYmFjaywg
Y3YpOworCX0KKworCWlmICghc3RyY21wKHByb3BlcnR5LCAiTWljcm9waG9uZVZvbHVtZSIpKSB7
CisJCWlmICghY3YtPmRyaXZlci0+bWljcm9waG9uZV92b2x1bWUpIHsKKwkJCWlmIChtc2cgIT0g
TlVMTCkKKwkJCQlyZXR1cm4gX19vZm9ub19lcnJvcl9ub3RfaW1wbGVtZW50ZWQobXNnKTsKKwkJ
CWVsc2UKKwkJCQlyZXR1cm4gTlVMTDsKKwkJfQorCQljdi0+ZHJpdmVyLT5taWNyb3Bob25lX3Zv
bHVtZShjdiwgcGVyY2VudCwgbXZfc2V0X2NhbGxiYWNrLCBjdik7CisJfQorCisJcmV0dXJuIE5V
TEw7Cit9CisKK3N0YXRpYyBEQnVzTWVzc2FnZSAqY3Zfc2V0X3Byb3BlcnR5KERCdXNDb25uZWN0
aW9uICpjb25uLCBEQnVzTWVzc2FnZSAqbXNnLAorCQkJCQl2b2lkICpkYXRhKQoreworCXN0cnVj
dCBvZm9ub19jYWxsX3ZvbHVtZSAqY3YgPSBkYXRhOworCURCdXNNZXNzYWdlSXRlciBpdGVyOwor
CURCdXNNZXNzYWdlSXRlciB2YXI7CisJY29uc3QgY2hhciAqcHJvcGVydHk7CisJdW5zaWduZWQg
Y2hhciBwZXJjZW50OworCisJaWYgKGN2LT5wZW5kaW5nKQorCQlyZXR1cm4gX19vZm9ub19lcnJv
cl9idXN5KG1zZyk7CisKKwlpZiAoIWRidXNfbWVzc2FnZV9pdGVyX2luaXQobXNnLCAmaXRlcikp
CisJCXJldHVybiBfX29mb25vX2Vycm9yX2ludmFsaWRfYXJncyhtc2cpOworCisJaWYgKGRidXNf
bWVzc2FnZV9pdGVyX2dldF9hcmdfdHlwZSgmaXRlcikgIT0gREJVU19UWVBFX1NUUklORykKKwkJ
cmV0dXJuIF9fb2Zvbm9fZXJyb3JfaW52YWxpZF9hcmdzKG1zZyk7CisKKwlkYnVzX21lc3NhZ2Vf
aXRlcl9nZXRfYmFzaWMoJml0ZXIsICZwcm9wZXJ0eSk7CisJZGJ1c19tZXNzYWdlX2l0ZXJfbmV4
dCgmaXRlcik7CisKKwlpZiAoZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X2FyZ190eXBlKCZpdGVyKSAh
PSBEQlVTX1RZUEVfVkFSSUFOVCkKKwkJcmV0dXJuIF9fb2Zvbm9fZXJyb3JfaW52YWxpZF9hcmdz
KG1zZyk7CisKKwlkYnVzX21lc3NhZ2VfaXRlcl9yZWN1cnNlKCZpdGVyLCAmdmFyKTsKKworCWlm
IChkYnVzX21lc3NhZ2VfaXRlcl9nZXRfYXJnX3R5cGUoJnZhcikgIT0gREJVU19UWVBFX0JZVEUp
CisJCXJldHVybiBfX29mb25vX2Vycm9yX2ludmFsaWRfYXJncyhtc2cpOworCisJZGJ1c19tZXNz
YWdlX2l0ZXJfZ2V0X2Jhc2ljKCZ2YXIsICZwZXJjZW50KTsKKworCXJldHVybiBvZm9ub19zZXRf
Y2FsbF92b2x1bWUobXNnLCBjdiwgcHJvcGVydHksIHBlcmNlbnQpOworfQorCitzdGF0aWMgR0RC
dXNNZXRob2RUYWJsZSBjdl9tZXRob2RzW10gPSB7CisJeyAiR2V0UHJvcGVydGllcyIsCSIiLAki
YXtzdn0iLAljdl9nZXRfcHJvcGVydGllcyB9LAorCXsgIlNldFByb3BlcnR5IiwJInN2IiwJIiIs
CQljdl9zZXRfcHJvcGVydHksCisJCQkJCUdfREJVU19NRVRIT0RfRkxBR19BU1lOQyB9LAorCXsg
fQorfTsKKworc3RhdGljIEdEQnVzU2lnbmFsVGFibGUgY3Zfc2lnbmFsc1tdID0geworCXsgIlBy
b3BlcnR5Q2hhbmdlZCIsCSJzdiIgfSwKKwl7IH0KK307CisKK3N0YXRpYyB2b2lkIGNhbGxfdm9s
dW1lX3JlbW92ZShzdHJ1Y3Qgb2Zvbm9fYXRvbSAqYXRvbSkKK3sKKwlzdHJ1Y3Qgb2Zvbm9fY2Fs
bF92b2x1bWUgKmN2ID0gX19vZm9ub19hdG9tX2dldF9kYXRhKGF0b20pOworCisJREJHKCJhdG9t
OiAlcCIsIGF0b20pOworCisJaWYgKGN2ID09IE5VTEwpCisJCXJldHVybjsKKworCWlmIChjdi0+
ZHJpdmVyICYmIGN2LT5kcml2ZXItPnJlbW92ZSkKKwkJY3YtPmRyaXZlci0+cmVtb3ZlKGN2KTsK
KworCWdfZnJlZShjdik7Cit9CisKK3N0cnVjdCBvZm9ub19jYWxsX3ZvbHVtZSAqb2Zvbm9fY2Fs
bF92b2x1bWVfY3JlYXRlKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sCisJCQkJCXVuc2lnbmVk
IGludCB2ZW5kb3IsCisJCQkJCWNvbnN0IGNoYXIgKmRyaXZlciwKKwkJCQkJdm9pZCAqZGF0YSkK
K3sKKwlzdHJ1Y3Qgb2Zvbm9fY2FsbF92b2x1bWUgKmN2OworCUdTTGlzdCAqbDsKKworCWlmIChk
cml2ZXIgPT0gTlVMTCkKKwkJcmV0dXJuIE5VTEw7CisKKwljdiA9IGdfdHJ5X25ldzAoc3RydWN0
IG9mb25vX2NhbGxfdm9sdW1lLCAxKTsKKwlpZiAoY3YgPT0gTlVMTCkKKwkJcmV0dXJuIE5VTEw7
CisKKwkvKiBhc3N1bWUgdm9sdW1lIGFzIGhhbGYgb2YgbWF4aXVtIHZvbHVtZSAqLworCWN2LT5z
cGVha2VyX3ZvbHVtZSA9IDUwOworCWN2LT5taWNyb3Bob25lX3ZvbHVtZSA9IDUwOworCWN2LT5h
dG9tID0gX19vZm9ub19tb2RlbV9hZGRfYXRvbShtb2RlbSwKKwkJCQkJT0ZPTk9fQVRPTV9UWVBF
U19DQUxMX1ZPTFVNRSwKKwkJCQkJY2FsbF92b2x1bWVfcmVtb3ZlLCBjdik7CisKKwlmb3IgKGwg
PSBnX2RyaXZlcnM7IGw7IGwgPSBsLT5uZXh0KSB7CisJCWNvbnN0IHN0cnVjdCBvZm9ub19jYWxs
X3ZvbHVtZV9kcml2ZXIgKmRydiA9IGwtPmRhdGE7CisKKwkJaWYgKGdfc3RyY21wMChkcnYtPm5h
bWUsIGRyaXZlcikpCisJCQljb250aW51ZTsKKworCQlpZiAoZHJ2LT5wcm9iZShjdiwgdmVuZG9y
LCBkYXRhKSA8IDApCisJCQljb250aW51ZTsKKworCQljdi0+ZHJpdmVyID0gZHJ2OworCQlicmVh
azsKKwl9CisKKwlyZXR1cm4gY3Y7Cit9CisKK3N0YXRpYyB2b2lkIGNhbGxfdm9sdW1lX3VucmVn
aXN0ZXIoc3RydWN0IG9mb25vX2F0b20gKmF0b20pCit7CisJREJ1c0Nvbm5lY3Rpb24gKmNvbm4g
PSBvZm9ub19kYnVzX2dldF9jb25uZWN0aW9uKCk7CisJc3RydWN0IG9mb25vX2NhbGxfdm9sdW1l
ICpjdiA9IF9fb2Zvbm9fYXRvbV9nZXRfZGF0YShhdG9tKTsKKwlzdHJ1Y3Qgb2Zvbm9fbW9kZW0g
Km1vZGVtID0gX19vZm9ub19hdG9tX2dldF9tb2RlbShhdG9tKTsKKwljb25zdCBjaGFyICpwYXRo
ID0gX19vZm9ub19hdG9tX2dldF9wYXRoKGF0b20pOworCUdTTGlzdCAqbDsKKworCW9mb25vX21v
ZGVtX3JlbW92ZV9pbnRlcmZhY2UobW9kZW0sIENBTExfVk9MVU1FX0lOVEVSRkFDRSk7CisJZ19k
YnVzX3VucmVnaXN0ZXJfaW50ZXJmYWNlKGNvbm4sIHBhdGgsCisJCQkJCUNBTExfVk9MVU1FX0lO
VEVSRkFDRSk7Cit9CisKK3ZvaWQgb2Zvbm9fY2FsbF92b2x1bWVfcmVnaXN0ZXIoc3RydWN0IG9m
b25vX2NhbGxfdm9sdW1lICpjdikKK3sKKwlEQnVzQ29ubmVjdGlvbiAqY29ubiA9IG9mb25vX2Ri
dXNfZ2V0X2Nvbm5lY3Rpb24oKTsKKwlzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtID0gX19vZm9u
b19hdG9tX2dldF9tb2RlbShjdi0+YXRvbSk7CisJY29uc3QgY2hhciAqcGF0aCA9IF9fb2Zvbm9f
YXRvbV9nZXRfcGF0aChjdi0+YXRvbSk7CisKKwlpZiAoIWdfZGJ1c19yZWdpc3Rlcl9pbnRlcmZh
Y2UoY29ubiwgcGF0aCwKKwkJCQkJQ0FMTF9WT0xVTUVfSU5URVJGQUNFLAorCQkJCQljdl9tZXRo
b2RzLCBjdl9zaWduYWxzLCBOVUxMLAorCQkJCQljdiwgTlVMTCkpIHsKKwkJb2Zvbm9fZXJyb3Io
IkNvdWxkIG5vdCBjcmVhdGUgJXMgaW50ZXJmYWNlIiwKKwkJCQkJQ0FMTF9WT0xVTUVfSU5URVJG
QUNFKTsKKworCQlyZXR1cm47CisJfQorCisJb2Zvbm9fbW9kZW1fYWRkX2ludGVyZmFjZShtb2Rl
bSwgQ0FMTF9WT0xVTUVfSU5URVJGQUNFKTsKKworCV9fb2Zvbm9fYXRvbV9yZWdpc3Rlcihjdi0+
YXRvbSwgY2FsbF92b2x1bWVfdW5yZWdpc3Rlcik7Cit9CisKK2ludCBvZm9ub19jYWxsX3ZvbHVt
ZV9kcml2ZXJfcmVnaXN0ZXIoY29uc3Qgc3RydWN0IG9mb25vX2NhbGxfdm9sdW1lX2RyaXZlciAq
ZCkKK3sKKwlEQkcoImRyaXZlcjogJXAsIG5hbWU6ICVzIiwgZCwgZC0+bmFtZSk7CisKKwlpZiAo
ZC0+cHJvYmUgPT0gTlVMTCkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlnX2RyaXZlcnMgPSBnX3Ns
aXN0X3ByZXBlbmQoZ19kcml2ZXJzLCAodm9pZCAqKSBkKTsKKworCXJldHVybiAwOworfQorCit2
b2lkIG9mb25vX2NhbGxfdm9sdW1lX2RyaXZlcl91bnJlZ2lzdGVyKAorCQkJCWNvbnN0IHN0cnVj
dCBvZm9ub19jYWxsX3ZvbHVtZV9kcml2ZXIgKmQpCit7CisJREJHKCJkcml2ZXI6ICVwLCBuYW1l
OiAlcyIsIGQsIGQtPm5hbWUpOworCisJZ19kcml2ZXJzID0gZ19zbGlzdF9yZW1vdmUoZ19kcml2
ZXJzLCAodm9pZCAqKSBkKTsKK30KKwordm9pZCBvZm9ub19jYWxsX3ZvbHVtZV9yZW1vdmUoc3Ry
dWN0IG9mb25vX2NhbGxfdm9sdW1lICpjdikKK3sKKwlfX29mb25vX2F0b21fZnJlZShjdi0+YXRv
bSk7Cit9CisKK3ZvaWQgb2Zvbm9fY2FsbF92b2x1bWVfc2V0X2RhdGEoc3RydWN0IG9mb25vX2Nh
bGxfdm9sdW1lICpjdiwgdm9pZCAqZGF0YSkKK3sKKwljdi0+ZHJpdmVyX2RhdGEgPSBkYXRhOwor
fQorCit2b2lkICpvZm9ub19jYWxsX3ZvbHVtZV9nZXRfZGF0YShzdHJ1Y3Qgb2Zvbm9fY2FsbF92
b2x1bWUgKmN2KQoreworCXJldHVybiBjdi0+ZHJpdmVyX2RhdGE7Cit9CisKZGlmZiAtLWdpdCBh
L3NyYy9vZm9uby5oIGIvc3JjL29mb25vLmgKaW5kZXggMDY1OTk4OS4uNDA5YTllMiAxMDA2NDQK
LS0tIGEvc3JjL29mb25vLmgKKysrIGIvc3JjL29mb25vLmgKQEAgLTEwNSw2ICsxMDUsNyBAQCBl
bnVtIG9mb25vX2F0b21fdHlwZSB7CiAJT0ZPTk9fQVRPTV9UWVBFX1NTTiA9IDEyLAogCU9GT05P
X0FUT01fVFlQRV9NRVNTQUdFX1dBSVRJTkcgPSAxMywKIAlPRk9OT19BVE9NX1RZUEVfQ0JTID0g
MTQsCisJT0ZPTk9fQVRPTV9UWVBFU19DQUxMX1ZPTFVNRSA9IDE1LAogfTsKIAogZW51bSBvZm9u
b19hdG9tX3dhdGNoX2NvbmRpdGlvbiB7Ci0tIAoxLjYuMS4zCgo=

--===============6768429163146424159==--


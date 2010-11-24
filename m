Content-Type: multipart/mixed; boundary="===============5495831621126079495=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH v2 4/7] text-telephony: implement interface/atom
Date: Wed, 24 Nov 2010 16:51:09 -0200
Message-ID: <AANLkTinOgx874zT-gixdYNYVO_-7u3gobscRsv4-4Xxz@mail.gmail.com>
In-Reply-To: <4CED3625.3020409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5495831621126079495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Nov 24, 2010 at 1:58 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Lucas,
>
> On 11/23/2010 12:04 PM, Lucas De Marchi wrote:
>> ---
>> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A0src/ofono.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +
>> =C2=A0src/text-telephony.c | =C2=A0341 +++++++++++++++++++++++++++++++++=
+++++++++++++++++
>> =C2=A03 files changed, 344 insertions(+), 1 deletions(-)
>> =C2=A0create mode 100644 src/text-telephony.c
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index fb075a0..ee1313d 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> +static DBusMessage *tt_get_properties_reply(DBusMessage *msg,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct ofono_text_telephony *tt)
>> +{
>> + =C2=A0 =C2=A0 DBusMessage *reply;
>> + =C2=A0 =C2=A0 DBusMessageIter iter;
>> + =C2=A0 =C2=A0 DBusMessageIter dict;
>> + =C2=A0 =C2=A0 dbus_bool_t value;
>> +
>> + =C2=A0 =C2=A0 reply =3D dbus_message_new_method_return(msg);
>> + =C2=A0 =C2=A0 if (!reply)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> +
>> + =C2=A0 =C2=A0 dbus_message_iter_init_append(reply, &iter);
>> + =C2=A0 =C2=A0 dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_PROPERTIES_AR=
RAY_SIGNATURE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &dict);
>> +
>> + =C2=A0 =C2=A0 value =3D tt->powered;
>> + =C2=A0 =C2=A0 ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLE=
AN, &value);
>
> As mentioned previously, please use "Enabled" here.

ok

>> +static void tt_send_properties_reply(struct ofono_text_telephony *tt)
>> +{
>> + =C2=A0 =C2=A0 DBusMessage *reply;
>> +
>> + =C2=A0 =C2=A0 tt->flags |=3D TEXT_TELEPHONY_FLAG_CACHED;
>> +
>> + =C2=A0 =C2=A0 reply =3D tt_get_properties_reply(tt->pending, tt);
>> + =C2=A0 =C2=A0 __ofono_dbus_pending_reply(&tt->pending, reply);
>
> I actually prefer to fold this function into powered_callback

ok

>
>> +}
>> +
>> +static void tt_query_powered_callback(const struct ofono_error *error,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ofono_bool_t enable, void *data)
>> +{
>> + =C2=A0 =C2=A0 struct ofono_text_telephony *tt =3D data;
>> +
>> + =C2=A0 =C2=A0 if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBusMessage *reply;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_debug("Error during po=
wered query");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reply =3D __ofono_error_fail=
ed(tt->pending);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __ofono_dbus_pending_reply(&=
tt->pending, reply);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 tt_set_powered(tt, enable);
>> + =C2=A0 =C2=A0 tt_send_properties_reply(tt);
>
> The oFono convention is to reply to the pending D-Bus method call and
> then signal the property changed signals.
>

The examples I found for query methods use exactly the opposite. See,
cw_ss_query_callback() in call-settings.c and
radio_fast_dormancy_query_callback() in radio-settings.c.

This is because when calling the "tt_get_properties_reply(tt->pending,
tt)" we need the new value in tt->powered in order to generate the
reply correctly. Otherwise, we would need to save the value elsewhere,
set with the new value, generate the message, restore the previous
value and then call tt_set_powered(tt, enable).

If we do this, maybe we have to change the other places too.

>
>> +int ofono_text_telephony_driver_register(const struct ofono_text_teleph=
ony_driver *d)
>> +{
>> + =C2=A0 =C2=A0 DBG("driver: %p, name: %s", d, d->name);
>> +
>> + =C2=A0 =C2=A0 if (!d || !d->probe)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> +
>> + =C2=A0 =C2=A0 g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +void ofono_text_telephony_driver_unregister(const struct ofono_text_tel=
ephony_driver *d)
>> +{
>> + =C2=A0 =C2=A0 DBG("driver: %p, name: %s", d, d->name);
>> +
>> + =C2=A0 =C2=A0 if (!d)
>
> The preferred style is to compare to NULL, e.g. if (d =3D=3D NULL)

Ok. I changed all the other places as well.

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 g_drivers =3D g_slist_remove(g_drivers, (void *)d);
>> +}
>> +
>
> <snip>
>
>> +struct ofono_text_telephony *ofono_text_telephony_create(struct ofono_m=
odem *modem,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int vendor,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *driver,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data)
>> +{
>> + =C2=A0 =C2=A0 struct ofono_text_telephony *tt;
>> + =C2=A0 =C2=A0 GSList *l;
>
> Please add a newline here

ok

>
>> + =C2=A0 =C2=A0 if (!driver)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> +
>> + =C2=A0 =C2=A0 tt =3D g_try_new0(struct ofono_text_telephony, 1);
>> + =C2=A0 =C2=A0 if (!tt)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> +
>> + =C2=A0 =C2=A0 tt->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TY=
PE_TEXT_TELEPHONY,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 text_telephony_remove, tt);
>> +
>> + =C2=A0 =C2=A0 tt->powered =3D -1;
>
> I think it is safe to default this to 0 (off).

ok

>
>> +
>> + =C2=A0 =C2=A0 for (l =3D g_drivers; l; l =3D l->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct ofono_text_tele=
phony_driver *drv =3D l->data;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strcmp0(drv->name, dri=
ver) !=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
continue;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drv->probe(tt, vendor, d=
ata) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
continue;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt->driver =3D drv;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return tt;
>> +}
>> +
>
> Otherwise, looks good.

regards,

Lucas De Marchi

--===============5495831621126079495==--


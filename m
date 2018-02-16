Content-Type: multipart/mixed; boundary="===============2596519710097707279=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: [PATCH] add syspath property to modem properties
Date: Fri, 16 Feb 2018 16:40:37 +0100
Message-ID: <cf9c2920-afde-36f0-6f8c-03bf8c4e45ed@kerlink.fr>
In-Reply-To: <1b604a58-6406-fa45-44f9-97260c4e8853@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2596519710097707279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I didn't think this patch could be something used on Upstream Ofono.
If it is, I also have remarks on my own patch:
 =C2=A0- shouldn't it be two patches (one for plugin directory, another for =

src directory)?
 =C2=A0- what is an acceptable name for the new DBUS property (currently it =

is ModemSyspath):
 =C2=A0=C2=A0 - ModemSysPath?
 =C2=A0=C2=A0 - ModemSystemPath?
 =C2=A0=C2=A0 - SystemPath?
 =C2=A0- what about modems that don't come from udevng plugin? Property is =

not set for these modems, is it ok? Do we want a generic property name =

to be able to also modify these plugins to give an information about =

hardware identification (something like: HardwareId, HardwarePath)? Or =

maybe SystemPath is also ok for these modems.

Let me know what you think about that and I will rework my patch to =

integrate your remarks,

Christophe

On 02/15/2018 04:59 PM, Denis Kenzior wrote:
> Hi Christophe,
>
> On 02/15/2018 02:50 AM, Christophe Ronco wrote:
>> ---
>> =C2=A0 plugins/udevng.c |=C2=A0 2 ++
>> =C2=A0 src/modem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 74 =

>> ++++++++++++++++++++++++++++++++------------------------
>> =C2=A0 2 files changed, 45 insertions(+), 31 deletions(-)
>>
>> diff --git a/plugins/udevng.c b/plugins/udevng.c
>> index 2279bbe9..d5139586 100644
>> --- a/plugins/udevng.c
>> +++ b/plugins/udevng.c
>> @@ -1330,6 +1330,8 @@ static gboolean create_modem(gpointer key, =

>> gpointer value, gpointer user_data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 continue;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (driver=
_list[i].setup(modem) =3D=3D TRUE) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofon=
o_modem_set_string(modem->modem, "Syspath",
>
> Use camel case, so "SysPath" or "SystemPath"
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syspath);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ofono_modem_register(modem->modem);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return FALSE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/src/modem.c b/src/modem.c
>> index b1e8d3e2..7759b567 100644
>> --- a/src/modem.c
>> +++ b/src/modem.c
>> @@ -773,6 +773,41 @@ ofono_bool_t ofono_modem_get_online(struct =

>> ofono_modem *modem)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return modem->online;
>> =C2=A0 }
>> =C2=A0 +static gboolean get_modem_property(struct ofono_modem *modem, =

>> const char *name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum property_type type,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *value)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct modem_property *property;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("modem %p property %s", modem, name);
>> +
>> +=C2=A0=C2=A0=C2=A0 property =3D g_hash_table_lookup(modem->properties, =
name);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (property =3D=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("property %s does not ex=
ist", name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (property->type !=3D type) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("property %s wrong type"=
, name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 switch (property->type) {
>> +=C2=A0=C2=A0=C2=A0 case PROPERTY_TYPE_STRING:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *((const char **) value) =3D=
 property->value;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return TRUE;
>> +=C2=A0=C2=A0=C2=A0 case PROPERTY_TYPE_INTEGER:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(value, property->valu=
e, sizeof(int));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return TRUE;
>> +=C2=A0=C2=A0=C2=A0 case PROPERTY_TYPE_BOOLEAN:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(value, property->valu=
e, sizeof(ofono_bool_t));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return TRUE;
>> +=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> =C2=A0 void __ofono_modem_append_properties(struct ofono_modem *modem,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 DBusMessageIter *dict)
>> =C2=A0 {
>> @@ -783,6 +818,7 @@ void __ofono_modem_append_properties(struct =

>> ofono_modem *modem,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ofono_devinfo *info;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dbus_bool_t emergency =3D ofono_modem_get=
_emergency_mode(modem);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *strtype;
>> +=C2=A0=C2=A0=C2=A0 char *value;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_dbus_dict_append(dict, "Onli=
ne", DBUS_TYPE_BOOLEAN,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &modem->online);
>> @@ -823,6 +859,13 @@ void __ofono_modem_append_properties(struct =

>> ofono_modem *modem,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &info->svn);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (get_modem_property(modem, "Syspath", PROP=
ERTY_TYPE_STRING,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &value) =3D=3D TRUE) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_dbus_dict_append(dict,=
 "ModemSyspath",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBUS_=
TYPE_STRING,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &valu=
e);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>
> There's no need for {}.=C2=A0 And why don't you make things much easier o=
n =

> yourself and simply use ofono_modem_get_string()
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfaces =3D g_new0(char *, =

>> g_slist_length(modem->interface_list) + 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0, l =3D modem->interface_list=
; l; l =3D l->next, i++)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interfaces[i] =3D=
 l->data;
>> @@ -1731,37 +1774,6 @@ static int set_modem_property(struct =

>> ofono_modem *modem, const char *name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 -static gboolean get_modem_property(struct ofono_modem *modem, =

>> const char *name,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum property_type type,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *value)
>> -{
>> -=C2=A0=C2=A0=C2=A0 struct modem_property *property;
>> -
>> -=C2=A0=C2=A0=C2=A0 DBG("modem %p property %s", modem, name);
>> -
>> -=C2=A0=C2=A0=C2=A0 property =3D g_hash_table_lookup(modem->properties, =
name);
>> -
>> -=C2=A0=C2=A0=C2=A0 if (property =3D=3D NULL)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> -
>> -=C2=A0=C2=A0=C2=A0 if (property->type !=3D type)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> -
>> -=C2=A0=C2=A0=C2=A0 switch (property->type) {
>> -=C2=A0=C2=A0=C2=A0 case PROPERTY_TYPE_STRING:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *((const char **) value) =3D=
 property->value;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return TRUE;
>> -=C2=A0=C2=A0=C2=A0 case PROPERTY_TYPE_INTEGER:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(value, property->valu=
e, sizeof(int));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return TRUE;
>> -=C2=A0=C2=A0=C2=A0 case PROPERTY_TYPE_BOOLEAN:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(value, property->valu=
e, sizeof(ofono_bool_t));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return TRUE;
>> -=C2=A0=C2=A0=C2=A0 default:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> -=C2=A0=C2=A0=C2=A0 }
>> -}
>> -
>> =C2=A0 int ofono_modem_set_string(struct ofono_modem *modem,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *key, const char *value)
>> =C2=A0 {
>>
>
> Regards,
> -Denis
>


--===============2596519710097707279==--


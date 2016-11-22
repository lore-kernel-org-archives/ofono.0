Content-Type: multipart/mixed; boundary="===============6788358043706657834=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: Re: [PATCH] gprs: lte: set attached after successful activation
Date: Tue, 22 Nov 2016 17:43:00 +0100
Message-ID: <CAMPxJtVcTRqYmZ86o5393HBSrmaAoaFqaY0vjoeYU45qmdZZhw@mail.gmail.com>
In-Reply-To: <58347449.10806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6788358043706657834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2016 at 5:37 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Dragos,
>
>
> On 11/22/2016 09:03 AM, Dragos Tatulea wrote:
>>
>> Otherwise the attached state gets to be set before the actual LTE
>> automatic context is ready. This triggers a race between connman
>> and ofono: connman sees status attached before the context is active
>> so connman will try to activate another context with same apn and will
>> fail over and over again.
>> ---
>>   src/gprs.c | 52 +++++++++++++++++++++++++++-------------------------
>>   1 file changed, 27 insertions(+), 25 deletions(-)
>>
>> diff --git a/src/gprs.c b/src/gprs.c
>> index 5f7620b..c5fda35 100644
>> --- a/src/gprs.c
>> +++ b/src/gprs.c
>> @@ -959,6 +959,24 @@ static void pri_deactivate_callback(const struct
>> ofono_error *error, void *data)
>>         }
>>   }
>>
>> +static void gprs_set_attached_property(struct ofono_gprs *gprs,
>> +                                       ofono_bool_t attached)
>> +{
>> +       const char *path;
>> +       DBusConnection *conn =3D ofono_dbus_get_connection();
>> +       dbus_bool_t value =3D attached;
>> +
>> +       if (gprs->attached =3D=3D attached)
>> +               return;
>> +
>> +       gprs->attached =3D attached;
>> +
>> +       path =3D __ofono_atom_get_path(gprs->atom);
>> +       ofono_dbus_signal_property_changed(conn, path,
>> +                               OFONO_CONNECTION_MANAGER_INTERFACE,
>> +                               "Attached", DBUS_TYPE_BOOLEAN, &value);
>> +}
>> +
>>   static void pri_read_settings_callback(const struct ofono_error *error,
>>                                         void *data)
>>   {
>> @@ -987,6 +1005,9 @@ static void pri_read_settings_callback(const struct
>> ofono_error *error,
>>         }
>>
>>         value =3D pri_ctx->active;
>> +
>> +       gprs_set_attached_property(pri_ctx->gprs, TRUE);
>> +
>>         ofono_dbus_signal_property_changed(conn, pri_ctx->path,
>>
>> OFONO_CONNECTION_CONTEXT_INTERFACE,
>>                                         "Active", DBUS_TYPE_BOOLEAN,
>> &value);
>> @@ -1596,24 +1617,6 @@ static void release_active_contexts(struct
>> ofono_gprs *gprs)
>>         }
>>   }
>>
>> -static void gprs_set_attached_property(struct ofono_gprs *gprs,
>> -                                       ofono_bool_t attached)
>> -{
>> -       const char *path;
>> -       DBusConnection *conn =3D ofono_dbus_get_connection();
>> -       dbus_bool_t value =3D attached;
>> -
>> -       if (gprs->attached =3D=3D attached)
>> -               return;
>> -
>> -       gprs->attached =3D attached;
>> -
>> -       path =3D __ofono_atom_get_path(gprs->atom);
>> -       ofono_dbus_signal_property_changed(conn, path,
>> -                               OFONO_CONNECTION_MANAGER_INTERFACE,
>> -                               "Attached", DBUS_TYPE_BOOLEAN, &value);
>> -}
>> -
>>   static void gprs_attached_update(struct ofono_gprs *gprs)
>>   {
>>         ofono_bool_t attached;
>> @@ -1644,8 +1647,6 @@ static void gprs_attached_update(struct ofono_gprs
>> *gprs)
>>                 gprs->flags |=3D GPRS_FLAG_ATTACHED_UPDATE;
>>                 return;
>>         }
>> -
>> -       gprs_set_attached_property(gprs, attached);
>
>
> This patch mostly makes sense to me, but this part here seems dangerous.
> Are you sure this is needed?
>
Wow, thanks! I made a mistake when solving the merge error of
cherry-picking this patch from my branch. I'll send another version.

Thanks,
Dragos

--===============6788358043706657834==--


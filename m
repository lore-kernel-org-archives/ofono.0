Content-Type: multipart/mixed; boundary="===============7469715134587352049=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] gprs: Use "internet" apn for auto-created context
Date: Thu, 16 Jan 2014 22:52:17 +0200
Message-ID: <52D84681.6000706@jolla.com>
In-Reply-To: <52D81138.5080708@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7469715134587352049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Sorry to bother you, but I don't quite get the logic. There's something =

that needs to be done in case if ALL provisioning plugins have run and =

failed. How could that be a part of a provisioning plugin? They all have =

already run and failed by definition of the problem.

And another thing. If context initialization belongs exclusively to the =

provisioning plugins then what is this add_context() call doing there? =

And why INTERNET context is created but, say, MMS is not? Isn't that a =

wild guess too? If so then I have found exactly the right place for =

another wild guess. Or am I missing something?

I don't want to waste your time as well as mine by submitting patches =

that get rejected but in order to do so I have to understand why patches =

get rejected.

Regards,
-Slava


> Hi Slava,
>
> On 01/16/2014 08:43 AM, Slava Monich wrote:
>> Such an access point has a pretty good chance to actually work.
>> ---
>>   src/gprs.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/gprs.c b/src/gprs.c
>> index e379f7b..01ff875 100644
>> --- a/src/gprs.c
>> +++ b/src/gprs.c
>> @@ -2992,8 +2992,13 @@ static void ofono_gprs_finish_register(struct =

>> ofono_gprs *gprs)
>>       struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
>>       const char *path =3D __ofono_atom_get_path(gprs->atom);
>>
>> -    if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
>> -        add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
>> +    if (gprs->contexts =3D=3D NULL) { /* Automatic provisioning failed =
*/
>> +        struct pri_context *context =3D add_context(gprs, NULL,
>> +                    OFONO_GPRS_CONTEXT_TYPE_INTERNET);
>> +        if (context) {
>> +            strcpy(context->context.apn, "internet");
>> +        }
>> +    }
>
> Nope.  This doesn't belong in the core.  If you want to guess wildly, =

> please do so in a provisioning plugin.  That is what they're there =

> for.  You can have multiple provisioning plugins by the way.
>
>>
>>       if (!g_dbus_register_interface(conn, path,
>>                       OFONO_CONNECTION_MANAGER_INTERFACE,
>>
>
> Regards,
> -Denis
>


--===============7469715134587352049==--


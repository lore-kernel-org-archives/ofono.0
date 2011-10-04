Content-Type: multipart/mixed; boundary="===============2876532526931148880=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv8 4/6] plugins: mobile-broadband-provider-info parser
 changes
Date: Tue, 04 Oct 2011 09:05:01 -0500
Message-ID: <4E8B128D.5060203@gmail.com>
In-Reply-To: <4E8AD307.8020401@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2876532526931148880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

>>> +static struct ofono_gprs_provision_data *mbpi_ap_new(const char *apn)
>>> +{
>>> +    struct ofono_gprs_provision_data *ap;
>>> +    gsize len;
>>> +
>>> +    ap =3D g_try_new0(struct ofono_gprs_provision_data, 1);
>>> +    if (ap =3D=3D NULL)
>>> +        return NULL;
>>> +
>>> +    len =3D strlen(apn) + 1;
>>> +
>>> +    ap->apn =3D g_try_new(char, len);
>>> +    if (ap->apn =3D=3D NULL) {
>>> +        g_free(ap);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    memcpy(ap->apn, apn, len);
>>
>> g_strdup would be way cleaner here.
> =

> g_strdup uses g_new, which aborts the program on failure. Since we
> gracefully handle access point allocation error with g_set_error(),
> would make sense?
> =


While you're strictly right, in practice this is not something to worry
about.  Our convention is to ignore the possibility of failure on small
allocations, these can't really happen on Linux anyway.  The OOM killer
will kill something before that happens, likely a system daemon that is
even more important than oFono ;)

The original code was actually fine...  If you want to be paranoid then
checking that the length of the APN is sane (e.g. within
OFONO_GPRS_MAX_APN_LENGTH) would be enough.

As a rule of thumb the only time you should worry about memory
allocations is when you're allocating more than a few pages worth of
memory.

>>>   static void text_handler(GMarkupParseContext *context,
>>> @@ -79,7 +136,27 @@ static void text_handler(GMarkupParseContext
>>> *context,
>>>   {
>>>       char **string =3D userdata;
>>>
>>> -    *string =3D g_strndup(text, text_len);
>>> +    if (*string !=3D NULL) {
>>> +        /*
>>> +         * For now, duplicate entries are just ignored. Since
>>> +         * this parser is also used by lookup-apn tool, ofono_warn()
>>> +         * can't be used here. As soon as the way is agreed,
>>> +         * it might be good to report this.
>>> +         */
>>> +        return;
>>> +    }
>>
>> Are you sure you need this, under what circumstances would *string be
>> not NULL?
> =

> In case there are multiple "name", "username", "password" entries per
> APN. In theory this can't happen with the proper validation of the
> database, in practice users can edit it manually and use without the
> validation, which would result in the memory leak. Does this make sense?
> =


I don't think it does, no user should be able to edit the provisioning
database.  oFono is running as root and expects this to be readable by
root only.  If you really want to handle this case then returning an
error (since that is what it is) would be way better.

>>> +    *string =3D g_try_new(char, text_len + 1);
>>> +    if (*string =3D=3D NULL) {
>>> +        mbpi_g_set_error(context, error, mbpi_error_quark(),
>>> +                MBPI_ERROR_ENOMEM,
>>> +                "Can't allocate memory, memory exhausted");
>>> +        return;
>>> +    }
>>> +
>>> +    memcpy(*string, text, text_len);
>>> +
>>> +    (*string)[text_len] =3D '\0';
>>
>> Why is g_strndup not good enough for you here?
> =

> g_strndup also uses g_new, which aborts program on failure, just in
> order to handle the memory allocation failure consistently gracefully.
> =

> However, silently ignoring the memory allocation failure here is
> probably not a good idea either, since this would lead to the incorrect
> settings and will confuse the user? Should we handle it gracefully here,
> bail out of parser and report the error?
> =


See above, checking that a string is not excessively long is enough.
Besides, g_set_error uses g_strdup anyway, so you're still going to
abort.  Simply put, don't over-complicate things.

Regards,
-Denis

--===============2876532526931148880==--


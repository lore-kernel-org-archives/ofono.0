Content-Type: multipart/mixed; boundary="===============1106371313318753746=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv5 3/3] Mobile broadband provider info plugin
Date: Tue, 30 Aug 2011 03:17:25 -0500
Message-ID: <4E5C9C95.1000105@gmail.com>
In-Reply-To: <4E660B22.3010909@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1106371313318753746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 09/06/2011 06:59 AM, Oleg Zhurakivskyy wrote:
> Hello Denis,
> =

> On 08/27/2011 03:12 PM, Denis Kenzior wrote:
>>> +struct provider_info {
> [...]
>>> +    gboolean provisioning_fail;
>>
>> I'm not particularly happy with this approach, can't we simply bail out
>> when we detect this condition?  Perhaps we should just invent our own
>> GError and report it when this condition occurs in e.g. start_element /
>> end_element functions.
> =

> Would GError itself just serve the purpose here?
> =

> struct provider_info {
> [...]
>     GError *err;
> };

Nope, not really.  The point is to bail out as soon as possible.  You
can also extend the error to intelligently report such conditions as
mcc/mnc not matching, duplicate detection, etc.

> =

>>> +static enum element_type element_type(const gchar *element)
> [...]
>> I like this optimization, but have you considered using
>> g_markup_parse_context_push / pop to simplify the logic even more?
> =

> In principal, this could potentially eliminate the need to re-parse the
> tag name to enum at the element_end handler, but I am not 100% sure
> before doing it actually.
> =

> On the contrary, using g_markup_parse_context_push / pop might do just
> exactly the opposite, i.e. to complicate the logic, exploding the amount
> of code. Will the error handling become more straightforward and obvious?
> =


Simpler code is not necessarily more compact, quite often it is more
verbose.  That is OK, the preference is always given to code forms that
are easier to follow, even if at the expense of 20-30% extra lines of code.

And yes, my impression is that it will make error handling way easier to
understand.

> Yet, providing we adopt the approach with GError to bail out, the
> re-parsing of the tag name at the element_end happens only within
> mcc/mnc match, so a few access points only.
> =

> Taking everything into account, is this really worth the time and the
> effort?
> =


oFono philosophy is: 'If you're going to do something, then do the best
you can'

>>> +static void element_network_id_parse(struct provider_info *data,
>>> +                    const gchar **attribute_names,
>>> +                    const gchar **attribute_values)
>>> +{
>>> +    const char *mcc =3D NULL, *mnc =3D NULL;
>>> +    int i;
>>> +
>>> +    for (i =3D 0; attribute_names[i]; i++) {
>>> +        if (g_str_equal(attribute_names[i], "mcc") =3D=3D TRUE)
>>> +            mcc =3D attribute_values[i];
>>> +        if (g_str_equal(attribute_names[i], "mnc") =3D=3D TRUE)
>>> +            mnc =3D attribute_values[i];
>>> +    }
>>> +
>>> +    if (g_strcmp0(mcc, data->match_mcc) =3D=3D 0&&
>>> +            g_strcmp0(mnc, data->match_mnc) =3D=3D 0) {
>>> +        if (data->match_spn =3D=3D NULL) {
>>> +            data->match_found =3D TRUE;
>>> +            return;
>>> +        }
>>> +
>>> +        if (g_strcmp0(data->spn, data->match_spn) =3D=3D 0)
>>> +            data->match_found =3D TRUE;
>>> +    }
>>
>> I just double checked serviceproviders.2.dtd and can't even find an
>> entry for the SPN.  I mentioned this before, but you can't treat the
>> provider name the same as the SPN.  The xml database is simply not setup
>> this way and the results you will get will be wrong.  Can we please drop
>> this check for now?
> =

> Of course, this check can be dropped for now. In the database, there's
> no entry for SPN, only provider name.
> =

> Why the provider name can't be used as SPN? If not using the provider
> name as SPN, how do you imagine this should work?

The mobile-broadband-provider-info database would probably need to be
extended with a fully-fledged SPN element to store this information.
The current database is simply not setup this way.  To give you an
example, in Australia most providers have the SPN structured something
like this:
'<ProviderName> AU'

So it is quite obvious why your logic above will fail ;)

Other times the SPN name is a shortened / stylized name of the provider,
e.g. Virgin Mobile -> Virgin

The current <name> tag under the <provider> tag is really for the user's
benefit.

> =

>>> +static gchar *body_text_parse(const gchar *text, gsize text_len)
>>> +{
>>> +    gchar *body =3D g_strndup(text, text_len);
>>> +    gchar *print =3D NULL;
>>> +    int i;
>>> +
>>> +    for (i =3D 0; body&&  body[i]; i++) {
>>> +        if (g_ascii_isprint(body[i])) {
>>> +            print =3D g_strescape(body, NULL);
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    g_free(body);
>>> +
>>> +    return print;
>>
>> What in the world is this doing?  Since the body can contain UTF8
>> characters, I don't think you should be escaping anything here.  If
>> you're trying to validate utf8, then you might need to do something else.
>>> +static char *body_to_hex(const gchar *text, gsize text_len)
> [...]
>> With the above comment in mind, I don't see the need for this at all...
> =

> For some tags, the parser calls body multiple times, first few times
> supplying just '\n' and '\t's. Also, some tags have such a body that
> DBG() has trouble to print without escaping. So, what's the method to
> protect against the latter?
> =


This might be easier if you only run the parser on the bodies of the
tags you really care about.  e.g. this problem might just go away when
you use g_markup_parse_context_push/pop.

>> You do realize you can set the GError **error argument here and the
>> parser will bail out properly ;)
> =

> Yes, that should save some CPU cycles, thanks for the idea.
> =

>> You call provider_info_aps_free and provider_info_free in the error
>> conditions above, but only provider_info_free here.  Is there a reason?
> =

> In case the provisioning was successful, the settings are passed to
> oFono and, later, freed in __ofono_gprs_provision_free_settings(), so
> the settings entries themselves must not be freed.
> =


Ok, fair enough.  However, this is non-obvious, so you might want to add
a comment to that effect.

> However, they shouldn't be freed in case the provisioning was requested
> multiple times, and the previous provisioning run was successful, that
> should be corrected.
> =


Regards,
-Denis

--===============1106371313318753746==--


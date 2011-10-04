Content-Type: multipart/mixed; boundary="===============4185806385730543790=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv8 4/6] plugins: mobile-broadband-provider-info parser
 changes
Date: Tue, 04 Oct 2011 12:33:59 +0300
Message-ID: <4E8AD307.8020401@intel.com>
In-Reply-To: <4E85DE59.2090403@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4185806385730543790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 09/30/2011 06:20 PM, Denis Kenzior wrote:
>>   enum MBPI_ERROR {
>>   	MBPI_ERROR_DUPLICATE,
>> +	MBPI_ERROR_ENOMEM,
>
> There's no point in introducing this one, just use
> g_file_error_from_errno(ENOMEM)

OK.

>> +const char *mbpi_ap_type(enum ofono_gprs_context_type type)
>> +{
>> +	switch (type) {
>> +		_(OFONO_GPRS_CONTEXT_TYPE_ANY);
>> +		_(OFONO_GPRS_CONTEXT_TYPE_INTERNET);
>> +		_(OFONO_GPRS_CONTEXT_TYPE_MMS);
>> +		_(OFONO_GPRS_CONTEXT_TYPE_WAP);
>> +		_(OFONO_GPRS_CONTEXT_TYPE_IMS);
>> +	}
>> +
>> +	return "OFONO_GPRS_CONTEXT_TYPE_<UNKNOWN>";
>> +}
>> +
>
> As previously mentioned, this part belongs in a separate patch

OK.

>> +static struct ofono_gprs_provision_data *mbpi_ap_new(const char *apn)
>> +{
>> +	struct ofono_gprs_provision_data *ap;
>> +	gsize len;
>> +
>> +	ap =3D g_try_new0(struct ofono_gprs_provision_data, 1);
>> +	if (ap =3D=3D NULL)
>> +		return NULL;
>> +
>> +	len =3D strlen(apn) + 1;
>> +
>> +	ap->apn =3D g_try_new(char, len);
>> +	if (ap->apn =3D=3D NULL) {
>> +		g_free(ap);
>> +		return NULL;
>> +	}
>> +
>> +	memcpy(ap->apn, apn, len);
>
> g_strdup would be way cleaner here.

g_strdup uses g_new, which aborts the program on failure. Since we graceful=
ly =

handle access point allocation error with g_set_error(), would make sense?

>>   static void text_handler(GMarkupParseContext *context,
>> @@ -79,7 +136,27 @@ static void text_handler(GMarkupParseContext *contex=
t,
>>   {
>>   	char **string =3D userdata;
>>
>> -	*string =3D g_strndup(text, text_len);
>> +	if (*string !=3D NULL) {
>> +		/*
>> +		 * For now, duplicate entries are just ignored. Since
>> +		 * this parser is also used by lookup-apn tool, ofono_warn()
>> +		 * can't be used here. As soon as the way is agreed,
>> +		 * it might be good to report this.
>> +		 */
>> +		return;
>> +	}
>
> Are you sure you need this, under what circumstances would *string be
> not NULL?

In case there are multiple "name", "username", "password" entries per APN. =
In =

theory this can't happen with the proper validation of the database, in pra=
ctice =

users can edit it manually and use without the validation, which would resu=
lt in =

the memory leak. Does this make sense?

>> +	*string =3D g_try_new(char, text_len + 1);
>> +	if (*string =3D=3D NULL) {
>> +		mbpi_g_set_error(context, error, mbpi_error_quark(),
>> +				MBPI_ERROR_ENOMEM,
>> +				"Can't allocate memory, memory exhausted");
>> +		return;
>> +	}
>> +
>> +	memcpy(*string, text, text_len);
>> +
>> +	(*string)[text_len] =3D '\0';
>
> Why is g_strndup not good enough for you here?

g_strndup also uses g_new, which aborts program on failure, just in order t=
o =

handle the memory allocation failure consistently gracefully.

However, silently ignoring the memory allocation failure here is probably n=
ot a =

good idea either, since this would lead to the incorrect settings and will =

confuse the user? Should we handle it gracefully here, bail out of parser a=
nd =

report the error?

> Separate patch please, something to the effect of mbpi: Split gsm_start
> for readability
>
> Add any new functionality after the refactoring patches.

OK.

> Fair enough, but separate patch please.  Something to the effect of:
>
> mbpi: Reflow gsm_end()

OK.

>>   static const GMarkupParser gsm_parser =3D {
>> @@ -358,7 +458,8 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
>>   	if (fd<  0) {
>>   		g_set_error(error, G_FILE_ERROR,
>>   				g_file_error_from_errno(errno),
>> -				"open failed: %s", g_strerror(errno));
>> +				"open(%s) failed: %s", MBPI_DATABASE,
>> +				g_strerror(errno));
>
> If you want to add filename information to the error, then please group
> this as a separate patch.

OK.

> Please fix all the comments above, then I can have another look.  It is
> too hard for me to tell what exactly you're changing when everything is
> in one huge patch.

Thanks for the comments, I will prepare another set.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============4185806385730543790==--


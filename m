Content-Type: multipart/mixed; boundary="===============0253106923433181430=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/12] atmodem: add gnss driver
Date: Fri, 18 Mar 2011 09:45:32 -0500
Message-ID: <4D83700C.1050301@gmail.com>
In-Reply-To: <1300452632.9383.33.camel@poutijar-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0253106923433181430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

>>> +static gboolean gnss_parse_report(GAtResult *result, const char *prefi=
x,
>>> +					const char **xml)
>>> +{
>>> +	GAtResultIter iter;
>>> +
>>> +	g_at_result_iter_init(&iter, result);
>>> +
>>> +	if (!g_at_result_iter_next(&iter, prefix))
>>> +		return FALSE;
>>> +
>>> +	if (!g_at_result_iter_next_unquoted_string(&iter, xml))
>>> +		return FALSE;
>>> +
>>> +	return TRUE;
>>
>> Do you really need a separate function?  This might belong in gnss_report
>>
> I just thought that it would be more logical to have separate function
> to parse the result rather than putting it all in to same function. Is
> that a big deal or do you want me to change that?

This is not really wrong, was just wondering.  Leave it as is for now.

Regards,
-Denis

--===============0253106923433181430==--


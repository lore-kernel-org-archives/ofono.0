Content-Type: multipart/mixed; boundary="===============4812401962196849665=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH v2 1/1] Add telephony_str_to_error to decode error code
Date: Thu, 13 May 2010 10:09:01 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351E8167A1@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201005121402.18171.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4812401962196849665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

>> +static gboolean search_entry(const char *str, struct error_entry
>> *e, +						int maxentries, +						enum
> ofono_error_type type,
>> +						struct
> ofono_error *error)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < maxentries; i++) {
>> +		if (!strcmp(e[i].str, str)) {
>> +			error->type =3D type;
>> +			error->error =3D e[i].error;
>> +			return TRUE;
>> +		}
>> +	}
>> +
>> +	return FALSE;
>> +}
> =

> This doesn't really make sense, the errors from the modem
> usually come in the form of +CMS ERROR: 123 assuming we
> enabled +CMEE=3D1.  If we enabled +CMEE=3D2 then the numeric error
> code gets converted to a string.  The former is preferable as
> the string might be different from what oFono has.  What
> you're matching here will always result in an unknown error.
> =

> Regards,
> -Denis

My wrong. I will resend the patch soon.

Regards,
Zhenhua


--===============4812401962196849665==--


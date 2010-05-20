Content-Type: multipart/mixed; boundary="===============7900305560989316400=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v4 2/3] Move report_signal_strength to atutil
Date: Thu, 20 May 2010 13:23:38 +0300
Message-ID: <87eih6oor9.fsf@potku.valot.fi>
In-Reply-To: <201005191936.23348.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7900305560989316400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Kalle,
>
>> =

>>  static void csq_notify(GAtResult *result, gpointer user_data)
>> @@ -490,7 +489,8 @@ static void csq_notify(GAtResult *result, gpointer
>>  user_data) if (!g_at_result_iter_next_number(&iter, &strength))
>>  		return;
>> =

>> -	report_signal_strength(netreg, strength);
>> +	ofono_netreg_strength_notify(netreg,
>> +				at_util_convert_signal_strength(strength));
>>  }
>
> How about fixing all other instances of report_signal_strength and removi=
ng it =

> from this file as well? ;)

Oops, I totally forgot to remove the function network-registration.c.
Fixed now.

-- =

Kalle Valo

--===============7900305560989316400==--


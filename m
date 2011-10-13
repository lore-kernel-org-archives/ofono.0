Content-Type: multipart/mixed; boundary="===============1269884268344340188=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv9 08/16] provision: Add provisioning plugin
Date: Thu, 13 Oct 2011 14:29:25 +0300
Message-ID: <4E96CB95.80103@intel.com>
In-Reply-To: <4E960D05.6020204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1269884268344340188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 10/13/2011 12:56 AM, Denis Kenzior wrote:
> Please use g_try_new0 instead of g_try_malloc_n.  The result will be a
> bit prettier.

OK.

> Please don't use this particular syntax, we prefer using memcpy for this.

OK.

>> +		memset(*settings + i, 0,
>> +			sizeof(struct ofono_gprs_provision_data));
>
> Do you mean to memset the contents of ap here?

Yes. Sorry, this has slipped from one of the previous versions, I will corr=
ect.

>> +		mbpi_provision_data_free(ap);
>
> using g_free(ap) might be the easier solution.

Sure, indeed.

Thanks for the review, I will correct and send another patch.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============1269884268344340188==--


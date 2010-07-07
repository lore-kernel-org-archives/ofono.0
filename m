Content-Type: multipart/mixed; boundary="===============1816599003488151237=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 08/23] export sms_assembly_encode_address
Date: Wed, 07 Jul 2010 18:36:26 -0500
Message-ID: <4C350F7A.2030205@gmail.com>
In-Reply-To: <1278545338.2327.134.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1816599003488151237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 07/07/2010 06:28 PM, Inaky Perez-Gonzalez wrote:
> On Wed, 2010-07-07 at 15:57 -0700, Denis Kenzior wrote: =

>> Hi Inaky,
>>
>>>  void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
>>> +gboolean sms_assembly_encode_address(const struct sms_address *in,
>>> +				     char *straddr);
>>>  =

>>>  struct status_report_assembly *status_report_assembly_new(const char *=
imsi);
>>>  void status_report_assembly_free(struct status_report_assembly *assemb=
ly);
>>
>> Can we rename this into sms_address_to_hex_string?  That seems to
>> reflect the intent a bit better.
> =

> Ok -- this will then touch a few more other sites in the code.
> =

> =


That is fine.

Regards,
-Denis

--===============1816599003488151237==--


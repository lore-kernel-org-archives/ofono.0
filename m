Content-Type: multipart/mixed; boundary="===============7643094294686434562=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] mmsd: get delivery_report setting
Date: Mon, 16 Jul 2012 21:00:29 -0500
Message-ID: <5004C73D.7090207@gmail.com>
In-Reply-To: <500520BB.8050107@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7643094294686434562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

On 07/17/2012 03:22 AM, Ronald Tessier wrote:
> Hi Denis,
>
> On 07/16/2012 09:25 AM, Denis Kenzior wrote:
>> Hi Ronald,
>>
>> On 07/06/2012 04:32 AM, Ronald Tessier wrote:
>>> This set of patches concerns mmsd and is related to delivery_report.
>>> Add delivery report flag and API (to set its value) to service.
>>> Get and track the delivery report setting used by oFono in the message
>>> manager
>>> and use it in mmsd.
>>
>> Maybe I'm not seeing something, but why are we tracking the delivery
>> report flag in oFono in mmsd? I'm guessing you want to synchronize the
>> two, but I do not see why you would want to?
>>
>> Regards,
>> -Denis
>>
>
> This flag is set by the application layer to request delivery report in
> oFono, since mmsd is an oFono plugin I want to use the same flag for all
> kind of messages (SMS and MMS) and not add a new flag in mmsd.
>
> If you prefer, I define a new flag (with almost the same API and file
> settings mechanism) in mmsd. Let me know.
>

I think that would be a good idea, the two delivery report settings are =

not really related and should be controlled separately.

Regards,
-Denis

--===============7643094294686434562==--


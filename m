Content-Type: multipart/mixed; boundary="===============7484844548837274879=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] common : bring back some details about technology
Date: Fri, 22 Oct 2010 09:37:33 -0500
Message-ID: <4CC1A1AD.7070705@gmail.com>
In-Reply-To: <20101022142530.178840@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7484844548837274879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Beno=C3=AEt,

On 10/22/2010 09:01 AM, "Beno=C3=AEt Monin" wrote:
> Hi Aki,
> =

>> De : Aki Niemi
>>
>> Hi,
>>
>> 2010/10/21 "Beno=C3=AEt Monin" <benoit.monin@gmx.fr>:
>>> diff --git a/src/common.c b/src/common.c
>>> index b5b9a6f..d571d81 100644
>>> --- a/src/common.c
>>> +++ b/src/common.c
>>> @@ -655,15 +655,15 @@ const char *registration_tech_to_string(int tech)
>>>         case ACCESS_TECHNOLOGY_GSM:
>>>                 return "gsm";
>>>         case ACCESS_TECHNOLOGY_GSM_COMPACT:
>>> -               return "gsm";
>>> +               return "gprs";
>>>         case ACCESS_TECHNOLOGY_UTRAN:
>>>                 return "umts";
>>>         case ACCESS_TECHNOLOGY_GSM_EGPRS:
>>>                 return "edge";
>>>         case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
>>> -               return "hspa";
>>> +               return "hsdpa";
>>>         case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
>>> -               return "hspa";
>>> +               return "hsupa";
>>>         case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
>>>                 return "hspa";
>>>         case ACCESS_TECHNOLOGY_EUTRAN:
>>
>> Do you need to know if the cell supports high speed uplink, downlink
>> or both; or in fact, when uplink or downlink is active (i.e., channel
>> allocated)? Currently the API is telling you the former, and
>> supporting the latter would require changes not only in the D-Bus API,
>> but also in the driver API.
>>
> The API is fine as-is, we just need a bit more details about the
> technology in use. It will be purely informative in our application
> anyway.
> =

>> As a side note, I think I was originally proposing using the
>> generation tags, but either way works for me. That is, I consider it
>> 3.5G when at least HSDPA is available.
>>
> I was just thinking out loud about a "generation" field, I don't have
> any need for it. And it can be obtained from the technology (correct
> me if I'm wrong) :
> =


The way AT modems report technology is totally bizarre.  Daniel Wagner
played quite extensively with HSO and technology reporting, but we
failed to come up with a nice solution due to the stupid firmware on
these devices.

This is when we then decided to use 2g/3g/4g information only in the
NetworkRegistration atom and give the currently active bearer technology
in the ConnectionManager atom.  Nobody has had time to do the latter.

Regards,
-Denis

--===============7484844548837274879==--


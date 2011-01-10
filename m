Content-Type: multipart/mixed; boundary="===============9044359855506728477=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] Bearer documentation
Date: Mon, 10 Jan 2011 10:20:58 -0600
Message-ID: <4D2B31EA.6090408@gmail.com>
In-Reply-To: <201101101441.23644.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9044359855506728477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 01/10/2011 06:41 AM, R=C3=A9mi Denis-Courmont wrote:
> On Friday 07 January 2011 18:23:25 ext Denis Kenzior, you wrote:
>> Hi R=C3=A9mi,
>>
>> On 01/07/2011 10:02 AM, R=C3=A9mi Denis-Courmont wrote:
>>> ---
>>>
>>>  doc/connman-api.txt |   10 ++++++++++
>>>  1 files changed, 10 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/doc/connman-api.txt b/doc/connman-api.txt
>>> index b13efd1..18185d7 100644
>>> --- a/doc/connman-api.txt
>>> +++ b/doc/connman-api.txt
>>> @@ -150,6 +150,16 @@ Properties	boolean Active [readwrite]
>>>
>>>  			Holds whether the context is activated.  This value
>>>  			can be set to activate / deactivate the context.
>>>
>>> +		string Bearer [readonly, optional]
>>> +
>>> +			Contains the current packet switched bearer of the
>>> +			connection context.
>>> +
>>> +			Possible values are the same as for the Technology
>>> +			property the NetworkRegistration object, plus
>>> +			"none" if no data activity is ongoing, or "unknown"
>>> +			if not known.
>>> +
>>
>> Please remove this "unknown" bit.  The property is already optional, so
>> if it is never reported by the driver we shouldn't report it up, even if
>> the context is active.
> =

> That would not work. We need some default value otherwise we cannot signa=
l the =

> change from known to unknown, at least not with the oFono property change =

> interface.
> =


When do you think that will ever happen?

Regards,
-Denis

--===============9044359855506728477==--


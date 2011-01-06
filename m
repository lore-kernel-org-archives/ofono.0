Content-Type: multipart/mixed; boundary="===============9121935075992553482=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH v3 7/7] cdmaphonesim: Add CDMA SMS Support
Date: Thu, 06 Jan 2011 09:47:38 -0800
Message-ID: <4D26003A.2040907@nokia.com>
In-Reply-To: <4D24B2EC.1000907@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9121935075992553482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 01/05/2011 10:05 AM, ext Denis Kenzior wrote:

>>>
>>> If we have both phonesim and cdmaphonesim plugins active, we need to
>>> make sure they don't interfere with each other.  Perhaps adding a
>>> Type=3Dcdma and having cdmaphonesim look for that Type tag and ignore t=
he
>>> rest would be a good idea?
>>>
>> I am a bit lost about the Type attribute. cdmaphonesim is currently
>> defined as a separate plugin and by the time cdmaphonesim's
>> parse_config() is invoked, it already knows that it is cdma. Thus, I
>> don't see why needing another flag indicating this. When you say ignore
>> the rest, could you pls be more specific about what to ignore and what's
>> the intention of doing that? Sorry, still learning... :-)
>>
>
> So correct me if I'm wrong, but there's a race between cdmaphonesim and
> phonesim plugins:
>
> if phonesim starts first it reads phonesim.conf and creates both
> phonesim and cdmaphonesim modems.  When cdmaphonesim starts, it tries to
> create the modems again, but fails.  Similar situation vice-versa.
>
> This is why I'm suggesting the Type attribute.  Maybe I'm blind and this
> race does not happen?
>

Now, I understand your point. I checked the log, in my setup, =

cdmaphonsim will run first and it will create cdmaphonsim plugin. Next, =

phonesim will run and try to create cdmaphonsim plugin with wrong type: =

"phonesim" but failed. I.e., we are lucky to have cdmaphonsim run first.

So, the way to fix this is to add a Type=3Dcdma flag under [cdmaphonsim] =

and let cdmaphonsim.c only create modem if type is set to cdma. In =

addition to this, we also need to modify phonesim.c to ignore any modem =

group that has type set to cdma.

Could you pls clarify whether above solution will work?

> Regards,
> -Denis

Regards,
Lei

--===============9121935075992553482==--


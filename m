Content-Type: multipart/mixed; boundary="===============0775599045463024477=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 11:34:13 -0500
Message-ID: <6883d3b6-0a7b-e985-1da8-96b580feb157@gmail.com>
In-Reply-To: <6245aa25-9400-1b3b-1c2b-266ab0067768@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0775599045463024477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 10/17/2018 11:30 AM, Jonas Bonn wrote:
> =

> =

> On 17/10/18 17:18, Denis Kenzior wrote:
>> Hi Jonas,
>>>> +
>>>> +extern void gemalto_voicecall_init();
>>>> +extern void gemalto_voicecall_exit();
>>>> +
>>>
>>> Why are these "extern"?
>>>
>>
>> Okay, I haven't had my coffee yet, but what is the actual problem?  =

>> All functions defined in the header are extern anyway, whether they're =

>> labeled extern or not.=C2=A0 So, dropping extern would have no actual =

>> effect besides style.
> =

> No, of course, it's stylistic... just interesting that this particular =

> style is used in these particular header files and nowhere else.=C2=A0 Wa=
s =

> there a reason for that once?=C2=A0 Something to do with modules/plugins?

That is a good question.  I'm not sure there was a reason.  But then =

that code is ~10 years old, so I wouldn't remember the reason anyway.

If it bothers you so much, feel free to remove the externs.

> =

> Grab a coffee.=C2=A0 The day is long!
> =


Yep, having it now.  :)

Regards,
-Denis

--===============0775599045463024477==--


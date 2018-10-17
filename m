Content-Type: multipart/mixed; boundary="===============1845367801685190817=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v4 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 18:30:17 +0200
Message-ID: <6245aa25-9400-1b3b-1c2b-266ab0067768@norrbonn.se>
In-Reply-To: <678e682a-6f85-6c42-e1eb-99923c9a6c4a@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1845367801685190817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 17/10/18 17:18, Denis Kenzior wrote:
> Hi Jonas,
>>> +
>>> +extern void gemalto_voicecall_init();
>>> +extern void gemalto_voicecall_exit();
>>> +
>>
>> Why are these "extern"?
>>
> =

> Okay, I haven't had my coffee yet, but what is the actual problem?=C2=A0 =
All =

> functions defined in the header are extern anyway, whether they're =

> labeled extern or not.=C2=A0 So, dropping extern would have no actual eff=
ect =

> besides style.

No, of course, it's stylistic... just interesting that this particular =

style is used in these particular header files and nowhere else.  Was =

there a reason for that once?  Something to do with modules/plugins?

Grab a coffee.  The day is long!

/Jonas


> =

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============1845367801685190817==--


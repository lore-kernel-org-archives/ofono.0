Content-Type: multipart/mixed; boundary="===============0152053616185192580=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: Plugin infrastructure
Date: Mon, 05 Feb 2018 22:04:16 +0300
Message-ID: <c580e77f-a968-59f4-5203-7ce758551d0a@jolla.com>
In-Reply-To: <08031d86-68a6-695d-81a2-d1cb69b7b46f@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0152053616185192580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/02/18 20:55, Jonas Bonn wrote:

> On 02/05/2018 05:25 PM, Slava Monich wrote:
>>> Hi Jonas,
>>>
>>> On 02/04/2018 11:19 AM, Jonas Bonn wrote:
>>>> Hi,
>>>>
>>>> I was reading through the ofono code and I see that there's a lot =

>>>> of code in place to support external plugins.=C2=A0 As things currentl=
y =

>>>> stand, however, ofono can only be built with _builtin_ modules, so =

>>>> all this plugin infrastructure is totally unused. So I had a couple =

>>>> of questions about this:
>>>>
>>>> i)=C2=A0 Is there any value in keeping the plugin infrastructure in =

>>>> place? ...or would an effort to remove it be valued?
>>>
>>> We did (still do?) have external plugins in use...
>>
>> Yes, we do!
>
> OK.=C2=A0 If you don't mind a stupid question:=C2=A0 why?=C2=A0 Why not j=
ust put =

> these in the ofono tree?

Those are of no interest to the general public and not even compatible =

with the upstream - our fork is slightly different.

We wanted those to only be installed (pulled in via rpm dependencies) if =

the corresponding functionality is installed on the phone and =

dynamically loadable plugins fit quite nicely into the picture.

-Slava


--===============0152053616185192580==--


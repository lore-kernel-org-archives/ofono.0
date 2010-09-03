Content-Type: multipart/mixed; boundary="===============6051569375837598485=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Enable alphabets in smsutils
Date: Fri, 03 Sep 2010 09:05:20 -0500
Message-ID: <4C8100A0.4010804@gmail.com>
In-Reply-To: <1283516151.25646.2.camel@tucson.research.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6051569375837598485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 09/03/2010 07:15 AM, Aki Niemi wrote:
> On Thu, 2010-09-02 at 18:55 +0200, ext Denis Kenzior wrote:
>>> -	if (offset !=3D 0)
>>> -		template.submit.udhi =3D FALSE;
>>> -
>>
>> This part doesn't look right.  The check should actually set udhi to
>> TRUE, since we can be issuing a return in the next if statement...
> =

> That's why it's removed. This was doing nothing before, as offset at
> this point was always zero, and the template had anyway been memset to
> zero.
> =


I see what you're doing now.  I'd rather you left out setting udhi in
the dialect switch/case labels and changed this line to set UDHI to TRUE.

Regards,
-Denis

--===============6051569375837598485==--


Content-Type: multipart/mixed; boundary="===============1097359336897758880=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Core support for packet switched bearer reporting
Date: Mon, 10 Jan 2011 10:19:53 -0600
Message-ID: <4D2B31A9.70202@gmail.com>
In-Reply-To: <201101101333.31577.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1097359336897758880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 01/10/2011 05:33 AM, R=C3=A9mi Denis-Courmont wrote:
> On Friday 07 January 2011 18:25:32 ext Denis Kenzior, you wrote:
>> Hi R=C3=A9mi,
>>
>> On 01/07/2011 10:02 AM, R=C3=A9mi Denis-Courmont wrote:
>>> ---
>>>
>>>  include/gprs.h |    2 ++
>>>  src/gprs.c     |   32 ++++++++++++++++++++++++++++++++
>>>  2 files changed, 34 insertions(+), 0 deletions(-)
>>
>> please see the 'Submitting patches' section in HACKING
> =

> The rules are self-contradictory. Either the patch spreads multiple =

> directories, or it breaks compilation.
> =


They are really not.  For 99% of the time you need to break up your
patches like this and it works out nicely.

> For the sake of git-bisect'ing, I'd rather not break compilation.
> =


What are you talking about?  Adding a function declaration that nobody
yet calls is not going to break compilation or git bisect.

Regards,
-Denis

--===============1097359336897758880==--


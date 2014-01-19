Content-Type: multipart/mixed; boundary="===============4376754512781304946=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] gprs: Use "internet" apn for auto-created context
Date: Sun, 19 Jan 2014 12:25:53 +0200
Message-ID: <52DBA831.20000@jolla.com>
In-Reply-To: <52D8A6EB.90506@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4376754512781304946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Hi Slava,
>
> A gentle reminder to please not top-post on this mailing list.
>
> On 01/16/2014 02:52 PM, Slava Monich wrote:
>> Hi Denis,
>>
>> Sorry to bother you, but I don't quite get the logic. There's something
>> that needs to be done in case if ALL provisioning plugins have run and
>> failed. How could that be a part of a provisioning plugin? They all have
>> already run and failed by definition of the problem.
>
> We do; we create an empty context to signify that provisioning has =

> failed.  I do realize you mean well, but you're trying to wildly guess =

> (at least that is how I read the commit description) and breaking =

> existing behavior.
>

How can you tell an empty context created by a provisioning plugin from =

an empty context created by gprs.c after all provisioning plugins have =

failed? Or from the access point edited by the user in such a way that =

it looks exactly like the empty context created in gprs.c? You can't. =

They are all identical. Empty context is not a reliable indication of a =

provisioning failure.

A better, unambiguous indication would be to not create any contexts at =

all. Actually, I was assuming that it was the case and was quite =

surprised to find out that it was ofono creating the default context.

It's surely not breaking anything for Jolla. It would only improve =

chances of GPRS access to work out of the box. But of course in theory =

it may break something on some other platform. Any change, even an =

obvious bug fix can break existing behavior.

Finally, about 15% of all GPRS Internet access points in the world are =

called "internet" and have no user name or password. It's by far the =

most common use case. So it's not a wild guess at all. It's real life =

experience.

Regards,
-Slava

--===============4376754512781304946==--


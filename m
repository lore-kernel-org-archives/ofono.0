Content-Type: multipart/mixed; boundary="===============4634876849643658185=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH qmi lte v3 3/6] qmi: activate default bearer context for
 LTE networks
Date: Mon, 17 Apr 2017 15:12:07 -0500
Message-ID: <bc978dc2-886d-a8d8-f8d5-0d73a52621ad@gmail.com>
In-Reply-To: <35560cf1-ac0a-6be8-785f-a173c0f7dc26@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4634876849643658185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>> No, please don't do this, the notification callback and the query
>> callback should be different functions.  If you need to perform some
>> common operations, then just extract those into a common function and
>> call it from both.
>
> drivers/rilmodem/gprs-context.c, as one example, uses this pattern.
> Personally, I find it rather elegant!

I don't see an example of such in there, but I didn't look hard enough. =

Do you mean the use of ril_gprs_context_deactivate_primary inside =

ril_gprs_context_deactivate_primary?

Regardless, we really prefer unsolicited notification and command =

execution result callbacks to be different.  Generally because the =

callback data is different and there's no nice way to hide the =

differences besides a bunch of if statements.  We prefer the code to be =

easier to read, even if longer.  Lots of if-else statements make the =

code harder to read.

Regards,
-Denis

--===============4634876849643658185==--


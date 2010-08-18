Content-Type: multipart/mixed; boundary="===============5180950398404156042=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Connecting with Huawei E226
Date: Wed, 18 Aug 2010 17:31:36 -0500
Message-ID: <4C6C5F48.7080103@gmail.com>
In-Reply-To: <AANLkTi=x_xNOK3FJx85tJte5bp_eywT4+azmbgaLQ1vj@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5180950398404156042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Thiago,

On 08/18/2010 05:26 PM, Thiago Cangussu de Castro Gomes wrote:
> On Wed, Aug 18, 2010 at 2:02 PM, Denis Kenzior <denkenz@gmail.com> wrot=
e:
>> Hi Thiago,
>>
>>>> The problem with the failed cases it that oFono / ConnMan combination =
is
>>>> simply too fast.  It tries to access the Modem before it had the chance
>>>> to properly initialize the SIM card.  We have pushed some fixes upstre=
am
>>>> after the 0.26 release that should alleviate this.
>>>
>>> Thanks for the response. You are right, I can reproduce the problem
>>> even with connman turned off, by calling the test scripts before the
>>> modem is ready.
>>>
>>> I'm using both ofono and connman from git, with all the available
>>> updates so far. Does it mean that the fixes didn't solved the issue in
>>> my case? Could you point me to the patches?
>>
>> For your particular case these patches from Kalle would be helpful:
>>
>> [PATCH 1/2] huawei: poll sim state
>> [PATCH 2/2] huawei: postpone post_sim until SIM is ready
>>
>> However, they weren't integrated upstream due to some concerns.  See the
>> entire thread for more details.
> =

> I've applied the patches but unfortunately it didn't fixed the issue.
> Still can't connect when the modem is plugged after ofonod is started.
> I can send the logs if anyone thinks it's useful.
> =


Sorry to hear you're having trouble.  Kalle reported similar issues were
fixed with his patches on the E1552.  Sending the logs would probably be
helpful.

Regards,
-Denis

--===============5180950398404156042==--


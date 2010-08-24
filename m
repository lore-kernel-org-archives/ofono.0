Content-Type: multipart/mixed; boundary="===============8751766547582142074=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Connecting with Huawei E226
Date: Tue, 24 Aug 2010 18:45:14 -0500
Message-ID: <4C74598A.9080304@gmail.com>
In-Reply-To: <AANLkTimGinjnPR2w1KV4UBz5YC-1WKqZR5DFQBrtRLx_@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8751766547582142074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Thiago,

On 08/24/2010 05:58 PM, Thiago Cangussu de Castro Gomes wrote:
> On Tue, Aug 24, 2010 at 7:16 PM, Denis Kenzior <denkenz@gmail.com> wrot=
e:
>> Hi Thiago,
>>
>> On 08/24/2010 03:25 PM, Thiago Cangussu de Castro Gomes wrote:
>>> On Wed, Aug 18, 2010 at 7:31 PM, Denis Kenzior <denkenz@gmail.com> wr=
ote:
>>>>>> For your particular case these patches from Kalle would be helpful:
>>>>>>
>>>>>> [PATCH 1/2] huawei: poll sim state
>>>>>> [PATCH 2/2] huawei: postpone post_sim until SIM is ready
>>>>>>
>>>>>> However, they weren't integrated upstream due to some concerns.  See=
 the
>>>>>> entire thread for more details.
>>>>>
>>>>> I've applied the patches but unfortunately it didn't fixed the issue.
>>>>> Still can't connect when the modem is plugged after ofonod is started.
>>>>> I can send the logs if anyone thinks it's useful.
>>>>>
>>>>
>>>> Sorry to hear you're having trouble.  Kalle reported similar issues we=
re
>>>> fixed with his patches on the E1552.  Sending the logs would probably =
be
>>>> helpful.
>>>
>>> Here are (attached) the logs. I turned off connman. The two tests scena=
rios are:
>>>
>>> Test A (connect-modem-after-fast.log)
>>>
>>> - start ofono
>>> - plug the modem
>>> - call enable-modem just after inserting the modem
>>>
>>> Test B (connect-modem-after-slow.log)
>>>
>>> - start ofono
>>> - plug the modem
>>> - wait until the modem led switches from green to blue
>>> - call enable-modem after some seconds
>>>
>>> The second scenario is what happens when connmand is running, and is
>>> the most common use case: someone plugs in the modem with the system
>>> running.
>>
>> It seems you forgot to include the actual logs.
> =

> Let me try again :)
> =

> I forgot also to mention that I used list-context to see if the
> enable-modem was successful. The test B is the one that fails.

From the logs it seems Test A is what fails since we never add any atoms
in that one.  Basically the problem is that your modem firmware never
tells us that the SIM has been initialized by sending us a ^SIMST
notification.

Kalle's patch relies on SIMST being delivered eventually.  Since it
never does, oFono is under the impression that your SIM is invalid.  We
probably need to query SYSINFO a few more times in this case, but it
seems all Huawei firmwares act slightly differently here.

Regards,
-Denis

--===============8751766547582142074==--


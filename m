Content-Type: multipart/mixed; boundary="===============8004652648691200658=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Connecting with Huawei E226
Date: Tue, 24 Aug 2010 17:16:39 -0500
Message-ID: <4C7444C7.3030109@gmail.com>
In-Reply-To: <AANLkTi=i1UsuvkmfmL5zPvp57_i-zHpSegA02r-d1N=f@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8004652648691200658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Thiago,

On 08/24/2010 03:25 PM, Thiago Cangussu de Castro Gomes wrote:
> On Wed, Aug 18, 2010 at 7:31 PM, Denis Kenzior <denkenz@gmail.com> wrot=
e:
>>>> For your particular case these patches from Kalle would be helpful:
>>>>
>>>> [PATCH 1/2] huawei: poll sim state
>>>> [PATCH 2/2] huawei: postpone post_sim until SIM is ready
>>>>
>>>> However, they weren't integrated upstream due to some concerns.  See t=
he
>>>> entire thread for more details.
>>>
>>> I've applied the patches but unfortunately it didn't fixed the issue.
>>> Still can't connect when the modem is plugged after ofonod is started.
>>> I can send the logs if anyone thinks it's useful.
>>>
>>
>> Sorry to hear you're having trouble.  Kalle reported similar issues were
>> fixed with his patches on the E1552.  Sending the logs would probably be
>> helpful.
> =

> Here are (attached) the logs. I turned off connman. The two tests scenari=
os are:
> =

> Test A (connect-modem-after-fast.log)
> =

> - start ofono
> - plug the modem
> - call enable-modem just after inserting the modem
> =

> Test B (connect-modem-after-slow.log)
> =

> - start ofono
> - plug the modem
> - wait until the modem led switches from green to blue
> - call enable-modem after some seconds
> =

> The second scenario is what happens when connmand is running, and is
> the most common use case: someone plugs in the modem with the system
> running.

It seems you forgot to include the actual logs.

Regards,
-Denis

--===============8004652648691200658==--


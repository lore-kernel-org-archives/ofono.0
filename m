Content-Type: multipart/mixed; boundary="===============2733252213829020419=="
MIME-Version: 1.0
From: Thiago Cangussu de Castro Gomes <thiagoc@syst.com.br>
Subject: Re: Connecting with Huawei E226
Date: Wed, 18 Aug 2010 19:26:53 -0300
Message-ID: <AANLkTi=x_xNOK3FJx85tJte5bp_eywT4+azmbgaLQ1vj@mail.gmail.com>
In-Reply-To: <4C6C1229.4090106@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2733252213829020419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 18, 2010 at 2:02 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Thiago,
>
>>> The problem with the failed cases it that oFono / ConnMan combination is
>>> simply too fast. =C2=A0It tries to access the Modem before it had the c=
hance
>>> to properly initialize the SIM card. =C2=A0We have pushed some fixes up=
stream
>>> after the 0.26 release that should alleviate this.
>>
>> Thanks for the response. You are right, I can reproduce the problem
>> even with connman turned off, by calling the test scripts before the
>> modem is ready.
>>
>> I'm using both ofono and connman from git, with all the available
>> updates so far. Does it mean that the fixes didn't solved the issue in
>> my case? Could you point me to the patches?
>
> For your particular case these patches from Kalle would be helpful:
>
> [PATCH 1/2] huawei: poll sim state
> [PATCH 2/2] huawei: postpone post_sim until SIM is ready
>
> However, they weren't integrated upstream due to some concerns. =C2=A0See=
 the
> entire thread for more details.

I've applied the patches but unfortunately it didn't fixed the issue.
Still can't connect when the modem is plugged after ofonod is started.
I can send the logs if anyone thinks it's useful.

Regards,
Thiago

--===============2733252213829020419==--


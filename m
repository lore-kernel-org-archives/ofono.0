Content-Type: multipart/mixed; boundary="===============0522840786796573027=="
MIME-Version: 1.0
From: Thiago Cangussu de Castro Gomes <thiagoc@syst.com.br>
Subject: Re: Connecting with Huawei E226
Date: Tue, 24 Aug 2010 17:25:21 -0300
Message-ID: <AANLkTi=i1UsuvkmfmL5zPvp57_i-zHpSegA02r-d1N=f@mail.gmail.com>
In-Reply-To: <4C6C5F48.7080103@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0522840786796573027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 18, 2010 at 7:31 PM, Denis Kenzior <denkenz@gmail.com> wrote:
>>> For your particular case these patches from Kalle would be helpful:
>>>
>>> [PATCH 1/2] huawei: poll sim state
>>> [PATCH 2/2] huawei: postpone post_sim until SIM is ready
>>>
>>> However, they weren't integrated upstream due to some concerns. =C2=A0S=
ee the
>>> entire thread for more details.
>>
>> I've applied the patches but unfortunately it didn't fixed the issue.
>> Still can't connect when the modem is plugged after ofonod is started.
>> I can send the logs if anyone thinks it's useful.
>>
>
> Sorry to hear you're having trouble. =C2=A0Kalle reported similar issues =
were
> fixed with his patches on the E1552. =C2=A0Sending the logs would probabl=
y be
> helpful.

Here are (attached) the logs. I turned off connman. The two tests scenarios=
 are:

Test A (connect-modem-after-fast.log)

- start ofono
- plug the modem
- call enable-modem just after inserting the modem

Test B (connect-modem-after-slow.log)

- start ofono
- plug the modem
- wait until the modem led switches from green to blue
- call enable-modem after some seconds

The second scenario is what happens when connmand is running, and is
the most common use case: someone plugs in the modem with the system
running.

Regards,
Thiago

--===============0522840786796573027==--


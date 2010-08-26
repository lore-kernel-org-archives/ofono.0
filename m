Content-Type: multipart/mixed; boundary="===============0895542031317036126=="
MIME-Version: 1.0
From: Thiago Cangussu de Castro Gomes <thiagoc@syst.com.br>
Subject: Re: Connecting with Huawei E226
Date: Thu, 26 Aug 2010 18:24:15 -0300
Message-ID: <AANLkTi=MnhCwboYS29E8Ut8c0D6FeFxLusndOnO4C3Jv@mail.gmail.com>
In-Reply-To: <4C74598A.9080304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0895542031317036126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 24, 2010 at 8:45 PM, Denis Kenzior <denkenz@gmail.com> wrote:
>> Let me try again :)
>>
>> I forgot also to mention that I used list-context to see if the
>> enable-modem was successful. The test B is the one that fails.
>
> From the logs it seems Test A is what fails since we never add any atoms
> in that one. =C2=A0Basically the problem is that your modem firmware never
> tells us that the SIM has been initialized by sending us a ^SIMST
> notification.
>
> Kalle's patch relies on SIMST being delivered eventually. =C2=A0Since it
> never does, oFono is under the impression that your SIM is invalid. =C2=
=A0We
> probably need to query SYSINFO a few more times in this case, but it
> seems all Huawei firmwares act slightly differently here.

Is there something else I can do to help solve this issue? I tried
another modem, a ZTE MF110, that is not working either. I installed
wvdial on my MeeGo machine and was able to connect using both the
Huawei and ZTE modems. I also tested the devices under Ubuntu Lucid
and Fedora 13 (both with Networkmanager) and they worked out of the
box.

Those devices are supplied by some of the major wireless carriers here
in Brazil, so it would be nice to have them working with ofono/MeeGo.

Thanks,
Thiago

--===============0895542031317036126==--


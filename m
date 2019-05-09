Content-Type: multipart/mixed; boundary="===============1091226863180233903=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Thu, 09 May 2019 12:17:22 +0300
Message-ID: <CAPsFW+SBq=8aHiK-X8dGhFE2HuvrLibvJyY31ew5Oaq5TGVYcQ@mail.gmail.com>
In-Reply-To: <CAHB-Pjmd+c-80fDJL6OFS71NUn3j8nFebZ_EK3ybk_n2SM2yeg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1091226863180233903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/05/2019, Richard R=C3=B6jfors <richard.rojfors@gmail.com> wrote:
> Den ons 8 maj 2019 kl 16:37 skrev Denis Kenzior <denkenz@gmail.com>:
>>
>> Hi Richard,
>> >
>> > Just wants to check your thoughts about CREG and LTE only...
>> > If the modem only has 4g coverage it might set the status to 4
>> > (unknown),
>> > but ureg would indicate LTE(7).
>> > I have done a local patch for this in gprs, do not go to de-attached
>> > state in that case.

Yes we ran into the same problem.

>> It seems a bunch of devices have this problem.  By my reading of 27.007,
>> CREG should not report status 4 unless there is no coverage whatsoever,
>> e.g.:
>>
>> "4      unknown (e.g. out of GERAN/UTRAN/E-UTRAN coverage)"
>>
>> >
>> > Just wondering if we should combine the CREG and UREG status
>> > in some way, the problem is that UREG is not indicating roaming or
>> > not...
>>
>> So that sounds like a bug in the firmware.  Does ublox support +CEREG?
>
> Yes they support CEREG according to the AT spec. I have not looked
> into the difference, do you have an executive, summary? ;)

We got it fixed through CEREG. This however has been a
long-standing/recurring issue
A few mails and threads in reference:

https://lists.ofono.org/pipermail/ofono/2018-September/018514.html
https://lists.ofono.org/pipermail/ofono/2019-February/019134.html
https://lists.ofono.org/pipermail/ofono/2019-February/019136.html

I'd like to see it fixed, and I have been spending some time on things
the last few days. but I have not understood yet where exactly this
now needs to be added and how.

> It might be a firmware issue. I have seen multiple cases where it
> reports unknown but UREG =3D 7... AND the LTE context still works.

We spotted the same thing.

Regards,

Philippe

--===============1091226863180233903==--


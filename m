Content-Type: multipart/mixed; boundary="===============3687930080021723143=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: connmand[186]: Online check failed but running dhclient manually
 fixes this issue
Date: Mon, 11 Dec 2017 07:51:50 +0100
Message-ID: <28b08f67-b161-56f0-76e3-0621a1a49687@southpole.se>
In-Reply-To: <CAKv0xJwRtHoYUV-APSy=0cW1xVJRa64G3huH=tbBDuwExQutEQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3687930080021723143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/11/2017 07:37 AM, Sean Nyekj=C3=A6r wrote:
> Hi
> Sorry if i'm reposting.
>
> I'm also having this issue with the Quectel EC20 (and maybe EC21).

The EC21 is "raw ip" only so shouldn't be affected by this.=C2=A0 I've got =

one and I've never seen this issue in any case.

/Jonas


>
> Any known fixes or workarounds i could try? Is the problem in connman or =
ofono?
>
> /Sean
>
> On 6 September 2017 at 17:40, Denis Kenzior <denkenz@gmail.com> wrote:
>> Hi Daniel,
>>>>
>>>> If this is true, then falling back to DHCP would seem to be required
>>>> for many Qualcomm based devices.  This seems to be a recently
>>>> introduced 'bug' as older QMI devices did not need this workaround.
>>>
>>> Do you think we should try to figure out which Qualcomm device is
>>> misbehaving or should the feature just be reverted?
>>
>> It would seem that this only affects devices introduced in the last seve=
ral
>> years.  The QMI code is from 2012, and the devices Marcel tested this wi=
th
>> worked fine.
>>
>> Perhaps we should have plugins/udevng.c maintain a database of all the
>> 'dhcp-required' devices and set this property accordingly.  Running DHCP
>> takes time, so if it can be avoided, you get online a bit faster...
>>
>>> The other option is to add some fallback mechanism in ConnMan and print
>>> a fat warning into the log. But I don't this idea.
>>>
>> Sounds like a least preferred option to me as well.
>>
>> Regards,
>> -Denis
>>
>> _______________________________________________
>> connman mailing list
>> connman(a)lists.01.org
>> https://lists.01.org/mailman/listinfo/connman
> _______________________________________________
> connman mailing list
> connman(a)lists.01.org
> https://lists.01.org/mailman/listinfo/connman


--===============3687930080021723143==--


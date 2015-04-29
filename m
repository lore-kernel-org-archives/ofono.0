Content-Type: multipart/mixed; boundary="===============0258418418105548763=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: Cinterion EHS6 support
Date: Wed, 29 Apr 2015 20:24:48 +0200
Message-ID: <554121F0.4010907@dynamicdevices.co.uk>
In-Reply-To: <55412050.7080504@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0258418418105548763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 29/04/2015 20:17, Denis Kenzior wrote:
> Hi Alex,
>
> On 04/29/2015 11:45 AM, Alex J Lennon wrote:
>> Hi,
>>
>> I've created a patch which adds support for the Cinterion EHS6 to Ofono.
>>
>> This is based on the TC65 source code with some changes to address an
>> issue with +CIND handling
>>
>
> Most likely TC65 has this issue as well.  Are there any other changes ?
>

Yes it does. I started out with the TC65, couldn't get it going and had
to apply that patch to it to get a connection up.

I didn't include the change as am focussed on EHS6 hardware here and
wasn't sure what the impact would be on TC65.
I can provide the TC65 patch easily enough too if you think it useful.

>> The patch is currently in a GitHub fork here
>>
>> https://github.com/DynamicDevices/ofono/commit/06c374b94bef2b3b23c9531c2=
2977976ab7f6e99.patch
>>
>>
>> This enables me to configure an "ehs6" rule in udev and bring up a GPRS
>> connection successfully with Connman.
>>
>> Would it be possible to contribute this to Ofono? If so could somebody
>> let me know what, if anything, needs to be done to the patch?
>>
>
> Generally, just send patches to the mailing list using git send-email.
> They will undergo the review process and will be applied to the
> upstream tree when/if they're ready.
>
> The general submission guidelines are described in git.
> toplevel/HACKING, 'Submitting Patches' section. =



I'll get on with it then.

Many thanks,

Alex


--===============0258418418105548763==--


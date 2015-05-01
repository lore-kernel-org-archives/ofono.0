Content-Type: multipart/mixed; boundary="===============1993084958383790391=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: [PATCH 2/2] cinterion: Replace tc65 plugin with vendor generic
 cinterion plugin
Date: Fri, 01 May 2015 23:11:07 +0200
Message-ID: <5543EBEB.5050802@dynamicdevices.co.uk>
In-Reply-To: <5543883E.4090900@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1993084958383790391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 01/05/2015 16:05, Denis Kenzior wrote:
> Hi Alex,
>
> On 04/30/2015 02:08 PM, Alex J Lennon wrote:
>> On the basis that cinterion tx6x, ehsx, other devices will likely
>> have similar firmware requirements, implement a generic cinterion
>> plugin.
>>
>> The udev implementation retains support for "tc65" device for
>> backwards compatibility, and adds support for  "ehs6" and generic
>> "cinterion" devices.
>> ---
>>   Makefile.am         |   4 +-
>>   plugins/cinterion.c | 249
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   plugins/tc65.c      | 245
>> ---------------------------------------------------
>
> Might be easier & cleaner to start off with this patch first.  Copying
> the virgin tc65.c to cinterion.c.
>
>>   plugins/udev.c      |  11 ++-
>
> Then add quirk handling in patch 1 and add ehs6 specific logic to
> plugins/udev.c in follow on commits.
>
>>   4 files changed, 259 insertions(+), 250 deletions(-)
>>   create mode 100644 plugins/cinterion.c
>>   delete mode 100644 plugins/tc65.c
>>
>

Hi Denis,

I did it this way around as there was a comment in the hacking document
about breaking down patches,
and also that patches should not break builds, so I added the
functionality before I did the renaming as
otherwise I would break the build. Are you happy to treat the multiple
patches as atomic?

I'm out of the office now until the 11th. I'll pick this up with you
then, if that's OK, to try to understand
what needs to change.

Thanks,

Alex









--===============1993084958383790391==--


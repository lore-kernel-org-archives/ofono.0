Content-Type: multipart/mixed; boundary="===============3157355069605963460=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PATCH: Enable udev-based autodetection of calypso modem on
 Freerunner
Date: Tue, 21 Dec 2010 12:16:18 -0600
Message-ID: <4D10EEF2.1050003@gmail.com>
In-Reply-To: <1292955183.2658.60.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3157355069605963460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 12/21/2010 12:13 PM, Marcel Holtmann wrote:
> Hi Denis,
> =

>>>> I think the better way would be to drop a udev rule directly into
>>>> /etc/udev.d or similar.  The rule should be as simple as:
>>>> KERNEL=3D=3D"ttySAC0", ENV{OFONO_DRIVER}=3D"calypso"
>>>
>>> Do you mean in another file than 97-ofono.rules?
>>
>> Yep.
> =

> I prefer not to have this inside ofono.git at all. We also leave the IFX
> specific ones out. It is really up to the package maintainers to get
> this sorted.
> =


That is actually what I had in mind.  Maybe I didn't communicate this
properly.

> We could document this as Freerunner specific notes to point people into
> the right direction. And we should maybe to the same for IFX since that
> is currently only documented in the GIT commit logs.

Documentation inside the individual modem driver is the way to go.  And
IFX isn't even documented in git commit logs.  I looked ;)

Regards,
-Denis

--===============3157355069605963460==--


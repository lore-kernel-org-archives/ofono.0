Content-Type: multipart/mixed; boundary="===============3161644485854602491=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 08/20] include: add set preferred ue mode api
Date: Tue, 12 Apr 2011 08:52:39 -0500
Message-ID: <4DA45927.2080507@gmail.com>
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F1EBB1FC@fioues08.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3161644485854602491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vijay,

>>> +void ofono_modem_set_preferred_ue_mode(struct ofono_modem =

>> *modem, int =

>>> +mode);
>>> +
>>
>> Are you assuming that the UE mode cannot be changed? If so, =

>> doesn't this map to +CEMODE AT command? Doesn't it allow a =

>> set operation to change the UE mode?
>>
> =

> We have made this currently read only as i don't see any usecase of this
> being set from user side(settings or any other).
> If a set provision need arises, this would bring in new API to driver
> side as well to do the job. Also this would be purly apply for LTE.

Then I don't see a need to even tell this information to the core then.

Regards,
-Denis

--===============3161644485854602491==--


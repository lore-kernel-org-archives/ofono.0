Content-Type: multipart/mixed; boundary="===============8744571942519862513=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH 4/5] cdmaphonesim: Add CDMA SMS Support
Date: Mon, 20 Dec 2010 13:53:07 -0800
Message-ID: <4D0FD043.90003@nokia.com>
In-Reply-To: <4D0FBFAC.1010701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8744571942519862513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 12/20/2010 12:42 PM, ext Denis Kenzior wrote:
> Hi Lei,
>
> On 12/08/2010 06:35 PM, Lei Yu wrote:
>> ---
>>   Makefile.am               |    9 ++
>>   configure.ac              |    6 +
>>   plugins/cdmaphonesim.c    |  344 +++++++++++++++++++++++++++++++++++++=
++++++++
>>   plugins/cdmaphonesim.conf |   14 ++
>>   4 files changed, 373 insertions(+), 0 deletions(-)
>>   create mode 100644 plugins/cdmaphonesim.c
>>   create mode 100644 plugins/cdmaphonesim.conf
>>
>
> Have you considered adding a CDMA/GSM selector to phonesim.conf instead?
>   So e.g. a new configuration key called 'Type' where type can be 'gsm'
> or 'cdma'.
>
> That way you can share much of the phonesim plugin plumbing and only
> populate the atoms differently...
>

We thought about this briefly but decided not pursuing that path at this =

stage of CDMA development mainly due to following reasons: a). We think =

it may make more sense to let CDMA development evolving a bit more on =

its own and then evaluate to see for which part it makes sense
to merge. We are afraid merging too early will make the phonesim.c code =

looking ugly with a lot of if/else down the road. We are planning to =

evaluate things like this when we have at least a few CDMA atoms =

implemented. b). We definitely would like to cause as little disruption =

to GSM as possible at this stage of CDMA development.

I am definitely looking forward to hearing more from you and other =

people and open for any changes.

> Regards,
> -Denis

Regards,
Lei

--===============8744571942519862513==--


Content-Type: multipart/mixed; boundary="===============7305532005887832948=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH v2, 7/7] cdmaphonesim: Add CDMA SMS Support
Date: Wed, 22 Dec 2010 08:23:41 -0800
Message-ID: <4D12260D.3070502@nokia.com>
In-Reply-To: <1293034154.2658.75.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7305532005887832948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 12/22/2010 08:09 AM, ext Marcel Holtmann wrote:
> Hi Lei,
>
>>>>    Makefile.am               |   10 ++
>>>>    plugins/cdmaphonesim.c    |  328 ++++++++++++++++++++++++++++++++++=
+++++++++++
>>>>    plugins/cdmaphonesim.conf |   14 ++
>>>>    3 files changed, 352 insertions(+), 0 deletions(-)
>>>>    create mode 100644 plugins/cdmaphonesim.c
>>>>    create mode 100644 plugins/cdmaphonesim.conf
>>>
>>> do we really want to do it this way? I am not so sure that this is the
>>> best way.
>>>
>>> I would prefer to just have one /etc/ofono/phonesim.conf configuration
>>> file. And maybe we need to start splitting phonesim plugin into a view
>>> pieces and move it to its own directory. It then could also contain its
>>> own atom driver implementations there.
>>>
>>> So my main concern here is really that phonesim support is just for
>>> engineering. It has nothing to do with real production hardware. And I
>>> don't wanna clutter the source or its installation with it.
>>
>> I do see your points. I agree having one phonesim.conf instead of
>> creating a separate installation/configuration file for cdmaphonesim.
>> In terms of whether having seperate cdmaphonesim plugin from phonesim,
>> Denis and myself has discussed in the mailing list, please see:
>>      http://lists.ofono.org/pipermail/ofono/2010-December/006629.html
>> To re-cap some of the points and what we have agreed in previous discuss=
ion:
>>      The benefit of having separate cdmaphonesim plugin is to not clutter
>> existing GSM based phonesim plugin with a lot of if/else to cover CDMA
>> and let CDMA evolve on its own path for a while, at least having most of
>> the atoms supported, we can then evaluate how much commonality we have
>> and whether it makes sense to merge cdmaphonesim.c with phonesim.c.
>>      Another benefit or point we have considered is to cause as little
>> disruption to GSM side as possible.
>>
>> Thus, I would propose followings:
>>       a). Remove cdmaphonesim.conf and add one additional entry within
>> phonesim.conf to support cdmaphonesim plugin.
>>       b). Keep cdmaphonesim.c and phonesim.c separated and let CDMA
>> evolving on its own for now.
>
> sounds good enough for me now. Have one /etc/ofono/phonesim.conf and
> each plugin picks the entries it cares about. And for now we keep two
> plugins, but at some point we have to revisit this.

Yes, we will need to revisit this and other part of the CDMA for =

similarities with GSM down the road. Will get going on v3 of the patch. :-)

>
> Regards
>
> Marcel
>
>

Regards
Lei

--===============7305532005887832948==--


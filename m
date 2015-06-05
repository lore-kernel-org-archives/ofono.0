Content-Type: multipart/mixed; boundary="===============2877112044711402397=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: Problems provisioning APN from SIMs
Date: Fri, 05 Jun 2015 10:29:15 +0200
Message-ID: <55715DDB.7090204@dynamicdevices.co.uk>
In-Reply-To: <5570E3EA.80904@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2877112044711402397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 05/06/2015 01:48, Denis Kenzior wrote:
> Hi Marcel,
>
> >
>> The actual MCC and MNC assignments are ITU T E.212 and the (U)SIM
>> Header of the ICCID is ITU T E.118 document.
>>
>> And as a side note, the (U)SIM Header is between 6 and 7 digits. The
>> MNC is between 2 and 3 digits.
>
> So in theory E212 should be enough.  Each operator (MVNO or otherwise)
> should have its own MCC/MNC identifier.  However, this practice came
> in too late to the game, so this is not true in reality.
>
> Many operators assigned MVNO SIMs out of their pool, resulting in
> chaos.  Hence why DBs resort to playing tricks with EFspn, EFgid1, etc.
>
> I suspect newly issues SIMs do not have this problem, but it might
> still be relevant for SIMs issued in the past.

Thanks Denis, Marcel. I appreciate the responses.

So, in essence there seems no good way to do this in the general case.
The core problem is that multiple operators have the same MCC/MNC, and
this is a result of virtual operators piggy-backing on top of
established operators and being given the same MCC/MNC.

The mobile-broadband-providers XML document accurately expresses this,
but as a result provides multiple providers with the same MCC/MNC code
and there needs to be a good way to distinguish between them.

Using the display name may work but strikes me as a potential can of
worms as this does not seem particularly controlled.

For now I may just have to remove the virtual operators from the copy of
mobile-broadband-providers I use.

Thanks/Regards, Alex


--===============2877112044711402397==--


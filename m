Content-Type: multipart/mixed; boundary="===============2167522947615611901=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] telit: notify sim inserted when sim ready
Date: Mon, 20 Aug 2012 10:42:29 -0500
Message-ID: <50325AE5.8090502@gmail.com>
In-Reply-To: <503255A5.7000403@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2167522947615611901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/20/2012 10:20 AM, Christopher Vogl wrote:
> Hi Denis,
>
> On 20/08/12 16:50, Denis Kenzior wrote:
>> Hi Christopher,
>>
>> <snip>
>>
>>>>
>>>> You might need to do the same thing as we did for e.g. IFX and STE.
>>>> notify sim insertion on #QSS: 1, and only return from CPIN once #QSS:
>>>> 3 has been sent. See drivers/atmodem/sim.c at_epev_notify() or
>>>> at_xsim_notify() for an example.
>>>
>>> This works fine in case the PIN is locked, but has the unpleasant side
>>> effect that I receive a timeout when calling the D-Bus method to enter
>>> the PIN because #QSS: 3 takes so long (e.g. 32 seconds from entering the
>>> PIN until a #QSS: 3).
>>
>> Feel free to extend the timeout on the enter-pin script. Also, you can
>> in theory wait until #QSS: 2 and not 3 right? From what I remember
>> QSS: 3 pertains to Phonebook and SMS being ready.
> That's right!
>
>> For those you can add a quirk that queries / waits for QSS:3 See how
>> we handled this in plugins/calypso.c and %CSTAT.
> Thanks for the hint! I was thinking about a solution like that but
> thought that I was not ment to move the creation of atoms elsewhere.
>
>> Alternatively we can try to do this inside the individual drivers
>> using a vendor quirk.
> I like the %CSTAT way because I think it is a clean and easy to follow
> solution.
> In that case I also don't have to work with QSS in drivers/atmodem/sim.c
> anymore.
>

Well you might still need to wait for #QSS: 2 in drivers/atmodem/sim.c. =

  Many modems have the nasty habit of returning SIM busy errors when the =

CPIN state is queried right after PIN entry.

Regards,
-Denis

--===============2167522947615611901==--


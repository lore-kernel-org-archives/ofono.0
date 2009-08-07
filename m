Content-Type: multipart/mixed; boundary="===============7819712539518901319=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Fri, 07 Aug 2009 05:25:10 +0200
Message-ID: <fb249edb0908062025y39be4855ub305387906d8ed92@mail.gmail.com>
In-Reply-To: <200908051436.00016.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7819712539518901319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/8/5 Denis Kenzior <denkenz@gmail.com>:
> Hi Andrew,
>
>> > For setting mailbox numbers, a working EF-MBDN is required since the o=
nly
>> > alternative would be to store them on the filesystem.
>>
>> mw_set_indicator does the right thing, I missed this fact. =C2=A0But whe=
n a
>> mailbox number is set or received from network all clients get a
>> PropertyChanged and the new number can be retrieved from the interface
>> but only when the store succeeded, previously it would be available
>> regardless of MBDN on the card and the writing to card was secondary.
>> The number is kind of important if you want to hear the messages.
>
> So you're right that even if we get an enhanced voice mail notification m=
essage
> the Mailbox number won't be signaled unless we have the SIM provisioned w=
ith
> EF-MBI & EF-MBDN.
>
> The problem is, if we don't have the SIM files available, then the next t=
ime
> oFono is restarted this information is lost anyway until the next MWI
> notification arrives. =C2=A0So you're back to not being able to dial the =
mailbox.
>
> This is also an issue with the indications themselves. =C2=A0If we don't =
have EF-
> MWIS provisioned, the information is lost when oFono is restarted. =C2=A0=
So we're
> now inconsistent between MBDN/MWIS, so maybe we shouldn't update them eit=
her
> in this case.

True.  (or update them both in this case)

It would make sense for the providers to resend the MWI information
everytime subscriber connects the network and then it would be less
problematic in case the information couldn't be written to SIM, but I
don't know if they ever do this.

Regards

--===============7819712539518901319==--


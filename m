Content-Type: multipart/mixed; boundary="===============4646335825193089168=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Wed, 19 Aug 2009 15:44:55 +0200
Message-ID: <fb249edb0908190644j577ea5b1ifbc58c1676fe92b3@mail.gmail.com>
In-Reply-To: <200908101135.30188.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4646335825193089168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2009/8/10 Denis Kenzior <denkenz@gmail.com>:
>> 2009/8/5 Denis Kenzior <denkenz@gmail.com>:
>> >> mw_set_indicator does the right thing, I missed this fact. =C2=A0But =
when a
>> >> mailbox number is set or received from network all clients get a
>> >> PropertyChanged and the new number can be retrieved from the interface
>> >> but only when the store succeeded, previously it would be available
>> >> regardless of MBDN on the card and the writing to card was secondary.
>> >> The number is kind of important if you want to hear the messages.
>> >
>> > So you're right that even if we get an enhanced voice mail notification
>> > message the Mailbox number won't be signaled unless we have the SIM
>> > provisioned with EF-MBI & EF-MBDN.
>> >
>> > The problem is, if we don't have the SIM files available, then the next
>> > time oFono is restarted this information is lost anyway until the next
>> > MWI notification arrives. =C2=A0So you're back to not being able to di=
al the
>> > mailbox.
>> >
>> > This is also an issue with the indications themselves. =C2=A0If we don=
't have
>> > EF- MWIS provisioned, the information is lost when oFono is restarted.
>> > =C2=A0So we're now inconsistent between MBDN/MWIS, so maybe we shouldn=
't
>> > update them either in this case.
>>
>> True. =C2=A0(or update them both in this case)
>>
>> It would make sense for the providers to resend the MWI information
>> everytime subscriber connects the network and then it would be less
>> problematic in case the information couldn't be written to SIM, but I
>> don't know if they ever do this.
>
> Probably they don't, there are also weird roaming cases to consider, wher=
e you
> receive MWI, turn phone off, step on a plane and turn phone on with some =
other
> network entirely.
>
> Can we make the MWI interface smarter somehow? =C2=A0Perhaps by not enabl=
ing it
> unless at least the EFmwis file is available, or by always storing the EF=
mwis
> contents on the filesystem?

We could re-use the "sim cache" functions to cheaply save the state of
notifications to filesystem, like in the attached patch (only an
example).  This is not ideal because the SIM might be used in a
different phone or with a different software stack between ofonod
runs, but seems better than not providing the information at all.
Really we don't lose anything even if we don't store the state and
provide the information (MWIS, MBDN) only for the duration of the
ofonod session.

Regards

--===============4646335825193089168==--


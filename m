Content-Type: multipart/mixed; boundary="===============0665195126935239313=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Wed, 12 Aug 2009 16:48:10 +0300
Message-ID: <a32762a20908120648q7d07800evb542b5ec253ae622@mail.gmail.com>
In-Reply-To: <200908101135.30188.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0665195126935239313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/8/10 Denis Kenzior <denkenz@gmail.com>:
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

There is another case to consider when the SIM is moved to a
completely different phone. In fact, I think this is the original
reason to store the MWI flag to the SIM.

> Can we make the MWI interface smarter somehow? =C2=A0Perhaps by not enabl=
ing it
> unless at least the EFmwis file is available, or by always storing the EF=
mwis
> contents on the filesystem?

I think this makes sense. There is another, related issue with some
Nokia modems, though. They might not support low-level, EF access
directly, but have some higher level API for accessing things like the
MWI flag, HPLMN list and SPN. We might need to think about adding such
high-level API support to the driver API as (optional) ops --
especially if other modems behave similarly -- otherwise the ISI modem
driver may need some kluge to handing EF writes.

Cheers,
Aki

--===============0665195126935239313==--


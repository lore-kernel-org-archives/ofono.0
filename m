Content-Type: multipart/mixed; boundary="===============7495336912167023719=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH 3/4] doc: detail PinRetries property
Date: Wed, 22 Dec 2010 16:54:22 -0200
Message-ID: <AANLkTi=7pveKexb8tpqJ2f3hWUFYdZvL9L+Tq1FFH9fF@mail.gmail.com>
In-Reply-To: <AANLkTik8MdXWCzokoHfo4PvC2kA0HEf0rBLfMXcrgKM2@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7495336912167023719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 21, 2010 at 5:48 AM, Sankar <gsankar.gs@gmail.com> wrote:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 byte PinRetries [read=
only]
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Contains the retry counter for the current
>> required
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pin. This counter is tipically decremented
>> whenever a
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 call to EnterPin() fails.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 E.g.: if PinRequired is equal "puk", this property
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 contains the number of times EnterPin can be
>> called
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 with a wrong puk.
>
> Does this property also mention how many retries are possible when the us=
er
> enters a wrong PUK for unblocking the sim pin.

Interesting, but it was not what I had in mint. If we want this
behavior, we might have to return all the counters instead of only
one. Then, what would be the user interface?

regards,

Lucas De Marchi

--===============7495336912167023719==--


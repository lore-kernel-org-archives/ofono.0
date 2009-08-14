Content-Type: multipart/mixed; boundary="===============0885267011139657994=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Fri, 14 Aug 2009 15:07:48 +0300
Message-ID: <a32762a20908140507w1564cabbw51faa79dd2e33c57@mail.gmail.com>
In-Reply-To: <200908121113.51953.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0885267011139657994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/8/12 Denis Kenzior <denkenz@gmail.com>:
> =C2=A0So there are two issues here:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- There is absolutely no standard data format =
for such vendor commands. =C2=A0So
> coming up with a higher level API that supports all modems might be trick=
y.

Agree, this might be a problem. And in the worst case, might force
drivers to do data format conversions anyway.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0- This presents the issue of having many more =
code paths to debug inside the
> core and potentially many more plugin functions to implement.
>
> I'd like to keep the core as clean and small as possible. =C2=A0What is y=
our
> feeling for the level of bloat such higher level APIs will introduce in
> comparison to a giant if-else statement inside the driver itself?

At least with the current set of EF types, I think we can manage
faking it in the driver code.

Cheers,
Aki

--===============0885267011139657994==--


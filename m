Content-Type: multipart/mixed; boundary="===============7419674107970050701=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Tue, 24 Sep 2019 20:09:13 +0200
Message-ID: <547d8842-d534-0406-448c-d490d9d17f11@geanix.com>
In-Reply-To: <7a839111-0ce5-65ae-af47-97b9d0234b13@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7419674107970050701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/09/2019 19.23, Denis Kenzior wrote:
>> Furthermore, there's not an AT command sent every 500 ms.=C2=A0 The comm=
and =

>> gets requeued after 500ms, but it doesn't actually go out until the =

>> modem responds to the first one... not quite sure why this works, to =

>> be honest.
>>
> =

> Funny.=C2=A0 But not real confidence inspiring :)
> =

> Martin, any ideas what could be going wrong here?

The code looks quite familiar :)

Jonas, do you have a log with OFONO_AT_DEBUG=3D1 set?

// Martin

--===============7419674107970050701==--


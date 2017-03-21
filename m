Content-Type: multipart/mixed; boundary="===============8496260702004924971=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Telit LE910V1 - LTE only modem
Date: Tue, 21 Mar 2017 13:57:15 -0500
Message-ID: <ed2ddd68-7c58-ab7a-981c-d15096746291@gmail.com>
In-Reply-To: <4d3d4e53-474b-55ec-b364-242c7e8b67d1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8496260702004924971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

> I am still a little bit confused about ofono_gprs_cid_activated(). As far=
 as I can see only atmodem calls it. No other driver does that.

That's because only the ublox devices have been properly enabled for LTE :)

> I am not sure if a context is automatically created. I can see that the s=
im card has a few profiles, and the user can select which APN to use, start=
/stop ip network, etc.

Yes, that's how LTE works.  An initial context (default bearer) is =

always activated on LTE.  The device can provide an initial attach APN =

(see doc/lte-api.txt) which is used to tell the modem which APN to =

attach to by default.  From what I recall, the device can provide an =

empty APN (in which case the network assigns one).

The default bearer varies by the carrier.  Some use it for IMS, some use =

it for the internet context.  So the modem/firmware behavior is often =

tweaked for a particular carrier.  Some modems might not report the =

default context at all in which case the device acts more like a 3G =

modem than an lte one.

Regards,
-Denis

--===============8496260702004924971==--


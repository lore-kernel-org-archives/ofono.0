Content-Type: multipart/mixed; boundary="===============5969432280856886272=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC at-export 0/2] Export AT-modem functions to other drivers
Date: Mon, 22 Apr 2019 10:52:02 -0500
Message-ID: <ed150a98-08f4-28c4-4fba-e3e1e316e46b@gmail.com>
In-Reply-To: <20190422074441.11854-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5969432280856886272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/22/2019 02:44 AM, Jonas Bonn wrote:
> Hi Denis,
> =

> I'm writing a custom network-registration driver for uBlox modems and
> I'd like to know if you will choke on the following approach:
> =

> i)  export method implementations from atmodem driver

This idea is really not new.  Every time I tried it the result was worse =

than maintaining a single netreg driver with the vendor logic.  netreg =

is by far the worst case scenario for this since 3GPP failed to =

standardize these commands (and voice management) until late in the game.

> ii) set up uBlox netreg vtable with custom probe method and exported
> atmodem implementations for rest

Except I hate your 'keep netreg data in sync' idea.  Not happening.  Use =

l_container_of instead and use composition by value for your driver =

specific structure.

> =

> If you can't accept this approach, please let me know of an alternative
> method that would be preferable that (hopefully) doesn't entail just
> copying all the code from one driver to the other (1000+ lines to keep
> in sync going forward).

What is actually different for uBlox that requires such a drastic =

approach?  Right now I'm seeing a duplication of CMER/CIEV and NITZ =

logic.  Not much else.

Regards,
-Denis

--===============5969432280856886272==--


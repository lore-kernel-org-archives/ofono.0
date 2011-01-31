Content-Type: multipart/mixed; boundary="===============4455350523628267681=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [PATCH 0/3] EF-SPN API to sim-atom
Date: Mon, 31 Jan 2011 08:13:29 +0200
Message-ID: <1296454409.2204.6.camel@jsaunama-desktop>
In-Reply-To: <1296134537-16133-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4455350523628267681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

On Thu, 2011-01-27 at 15:22 +0200, Jukka Saunamaki wrote:
> Here is an asynchronous implementation of SIM Service Provider Name (EF-S=
PN) getter API.
> The trick is to delay setting sim ready until spn reading is finished.

Any comments about this? =

So, yes, it slightly delays SIM initialisation (usually SPN value should
come from disk cache), but then netreg can use it immediately when it
registers. =

Alternative is still to create an asyncronous API now that there is a
patch for safe SIM file reading.

--Jukka



--===============4455350523628267681==--


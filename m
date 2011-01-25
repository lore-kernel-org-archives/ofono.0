Content-Type: multipart/mixed; boundary="===============5736784460929052663=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [gprs-provision RFCPATCHv6 0/4] Plugin API for provisioning of
 GPRS context settings
Date: Tue, 25 Jan 2011 14:47:44 +0200
Message-ID: <1295959664.6035.14.camel@jsaunama-desktop>
In-Reply-To: <1295958522.1520.40.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5736784460929052663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, 2011-01-25 at 13:28 +0100, ext Marcel Holtmann wrote:
> I think that our only leftover is how we handle the SPN detail.
> =

> Denis, what is your preference here? My take would be that we store it
> inside network registration and provide it to external modules. I don't
> see a point in reading it twice.

New SPN specific API in SIM atom? Asynchronous with callback, but SIM
would need to read it only once.
Unless there is some simple way to start reading it right after SIM is
ready/unlocked and netreg and gprs are registered only after SPN read
returns?

--Jukka





--===============5736784460929052663==--


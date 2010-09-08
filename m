Content-Type: multipart/mixed; boundary="===============3981740461417234724=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/2] Add Suspended property to GPRS
Date: Wed, 08 Sep 2010 15:52:02 +0200
Message-ID: <1283953922.6640.32.camel@localhost.localdomain>
In-Reply-To: <1283937421-19465-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3981740461417234724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> The following patches add the Suspended property to the
> GPRS atom and implement it in the isimodem driver. The
> property is opt-in for drivers that have the relevant
> information. The value is read-only and defaults to false.
> =

> GPRS class B modems are not able to support simultaneous
> GPRS data transfer with other services, such as voice call
> or SMS. GPRS services may also be suspended if the network
> does not support DTM, if the modem has poor network coverage,
> or because of signalling procedures such as location or
> routing area updates. While GPRS services are suspended,
> the modem remains attached to the cellular network and all
> PDP contexts remain established. Data transfer, however,
> is not possible.
> =

> Some discussion:
> =

> The isimodem driver will currently suppress changes in the
> property value for short-lived suspended states caused by SMS
> transmission or other signalling. It would also be possible
> to do the suppression in the oFono core in a generic way.
> Alternatively, all the state changes and their reasons could
> also be exposed to oFono clients. However, my feeling is
> that the information might not be available in a sufficiently
> coherent way from the different modems. Anyway, I'm open to
> suggestions.

we had a brief discussion about this some time ago. And I don't think
that we can do anything than give the clients (UI and ConnMan) and
indication that the suspend has happened right now. In general it is too
late anyway. Since making a voice call and sending a SMS are decisions
by the end user. And he/she wants to execute them right now. So it is
expected that GPRS gets suspended.

I do agree that we should not blindly tell the clients suspended if we
now that it is a short lived situation like SMS. My personal preference
here would be that this is done inside oFono core and the hardware just
signals suspend (if it actually supports such notifications).

So how much work would it take to do the delay in the core? I know, that
the ISI modem is more sophisticated protocol, but we do have AT modems
that have a bit harder time gathering all the information.

Regards

Marcel



--===============3981740461417234724==--


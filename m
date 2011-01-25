Content-Type: multipart/mixed; boundary="===============1011898786258177731=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [gprs-provision RFCPATCHv6 0/4] Plugin API for provisioning of
 GPRS context settings
Date: Tue, 25 Jan 2011 13:28:42 +0100
Message-ID: <1295958522.1520.40.camel@aeonflux>
In-Reply-To: <1295957714-21053-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1011898786258177731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> Another patchset about automatic provisioning of GPRS context settings.
> =

> This time, provisioning driver API is synchronous, and __ofono_gprs_provi=
sion_get_settings includes MCC,MNC and SPN as in parameters. =

> Per modem probing and all related complexity was removed, since there was=
 really no need for it. =

> =

> It is now the gprs-atom that queries SPN from SIM before calling provisio=
ning. Cases when gprs-atom is unregistered or removed while SPN query is in=
 progress, should be handled gracefully (unlike e.g. in netreg atom...)

I think that our only leftover is how we handle the SPN detail.

Denis, what is your preference here? My take would be that we store it
inside network registration and provide it to external modules. I don't
see a point in reading it twice.

Regards

Marcel



--===============1011898786258177731==--


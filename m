Content-Type: multipart/mixed; boundary="===============8813809279829736723=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] systemd: prevent duplicate logging messages in journal
Date: Thu, 25 Oct 2012 16:29:00 -0700
Message-ID: <1351207740.25783.1.camel@aeonflux>
In-Reply-To: <1351190250-15850-1-git-send-email-marti@juffo.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8813809279829736723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marti,

> By default, both stderr and syslog messages go to the systemd journal,
> which results in duplicate messages being logged.
> =

> Thanks to Vinicius Costa Gomes for pointing out this problem.
> ---
>  dundee/dundee.service.in | 1 +
>  src/ofono.service.in     | 1 +
>  2 files changed, 2 insertions(+)

patch has been applied.

Regards

Marcel



--===============8813809279829736723==--


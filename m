Content-Type: multipart/mixed; boundary="===============0622447440494142400=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] sim: add sim_ready_notify
Date: Tue, 24 Aug 2010 23:32:20 +0200
Message-ID: <1282685540.6841.23.camel@localhost.localdomain>
In-Reply-To: <1282659854-28097-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0622447440494142400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,
 =

> +#define SIM_STATUS_READY		1
> +#define SIM_STATUS_WAITING_FOR_PIN	(1 << 1)
> +

as a general rule, I prefer if you also do (1 << 0) instead of 1. Sounds
maybe a bit silly a first, but it make it easier to read and more
consistent. And we let the compiler do the actual optimization ;)

Regards

Marcel



--===============0622447440494142400==--


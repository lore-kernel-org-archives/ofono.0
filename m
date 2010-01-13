Content-Type: multipart/mixed; boundary="===============3288171197500459355=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Tue, 12 Jan 2010 17:44:44 -0800
Message-ID: <1263347084.922.1.camel@localhost.localdomain>
In-Reply-To: <201001121854.59479.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3288171197500459355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Initial impressions:
> =

> +static DBusConnection *connection;
> +static char *ofono_handsfree_path;
> +
> +
> +static int timeout;
> +
> =

> These globals seem to belong in per-modem user data unless you only want =
1 HFP =

> device per system?

the DBusConnection is fine as a global since it is shared for the whole
process anyway.

For the other two, I agree, they have to be per modem.

Regards

Marcel



--===============3288171197500459355==--


Content-Type: multipart/mixed; boundary="===============3942501465742694114=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] HACKING: Add ofono.conf file copy command required
Date: Wed, 01 Dec 2010 10:55:58 +0100
Message-ID: <20101201095558.GA7170@candlejack.bmw-carit.intra>
In-Reply-To: <20101130215623.GA22264@rafazurita.homelinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3942501465742694114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> +  Copy configuration file which specifies the required security policies
> +    # sudo cp ./src/ofono.conf /etc/dbus-1/system.d/
> +

Considered to add this too?

sudo killall -HUP dbus-daemon


daniel

--===============3942501465742694114==--


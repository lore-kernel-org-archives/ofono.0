Content-Type: multipart/mixed; boundary="===============6781905128346284770=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Cache EF-PNN, EF-OPL sim files on disk.
Date: Mon, 20 Jul 2009 16:24:17 +0200
Message-ID: <1248099857.4549.124.camel@violet>
In-Reply-To: <1248106322-5885-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6781905128346284770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej,

> This uses plain files in /var/cache/ofono for storing contents of the
> operator lists to avoid possibly numerous queries to the SIM on every
> startup.  Files are indexed with IMSI.  I'm not 100% sure about the
> autoconf magic.

please have a look into BlueZ or ConnMan and use STORAGEDIR for the base
path of /var/lib/ofono.

Can we just use GKeyFile to store these files? It would make reading and
adding them a lot easier.

Regards

Marcel



--===============6781905128346284770==--


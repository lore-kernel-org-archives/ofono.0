Content-Type: multipart/mixed; boundary="===============1372845598897555450=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] speedup: Check for supported modem capabilities first
Date: Sun, 08 Jan 2012 08:27:30 -0600
Message-ID: <4F09A7D2.5090500@gmail.com>
In-Reply-To: <4F0C5B39.5090107@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1372845598897555450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> We can have a private enum modem type into plugin, but we won't be able
> to use it into any atoms.
> Maybe by deduction we can add an enum sim_type into sim.h store the type
> into the plugin data and pass it at SIM atom creation.
> What do you think?

Inside the plugin you can do whatever you want for determining the cdma
vs gsm modem type.  I'm not quite sure I follow your comment about sim.h...

Regards,
-Denis

--===============1372845598897555450==--


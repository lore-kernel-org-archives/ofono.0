Content-Type: multipart/mixed; boundary="===============6184394302567206428=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Cache EF-PNN, EF-OPL sim files on disk.
Date: Tue, 14 Jul 2009 15:54:22 -0500
Message-ID: <200907141554.22706.denkenz@gmail.com>
In-Reply-To: <1246763672-17349-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6184394302567206428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> This uses plain files in /var/cache/ofono for storing contents of the
> operator lists to avoid possibly numerous queries to the SIM on every
> startup.  Files are indexed with IMSI.  I'm not 100% sure about the
> autoconf magic.
>
> Users need to rerun bootstrap-configure after applying this.

Can you rebase and resubmit this patch?  The changes to sim.c and network.c =

were a bit extensive.

Thanks,
-Denis

--===============6184394302567206428==--

